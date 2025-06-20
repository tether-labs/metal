const std = @import("std");
const Contents = @import("file_contents.zig").Contents;

const Command = enum {
    gen,
    help,
    unknown,
};

const GenOptions = struct {
    output_path: ?[]const u8 = null,
    quiet: bool = false,
    select: bool = false,
    template: ?[]const u8 = null,
    gen_type: []const u8 = "",
};

fn parseCommand(cmd: []const u8) Command {
    if (std.mem.eql(u8, cmd, "gen")) return .gen;
    if (std.mem.eql(u8, cmd, "help")) return .help;
    return .unknown;
}

fn parseGenOptions(args: [][:0]u8) GenOptions {
    var options = GenOptions{};

    var i: usize = 0;
    while (i < args.len) : (i += 1) {
        const arg = args[i];

        if (std.mem.startsWith(u8, arg, "-")) {
            // Handle flags
            if (std.mem.eql(u8, arg, "-o") or std.mem.eql(u8, arg, "--output")) {
                if (i + 1 < args.len) {
                    options.output_path = args[i + 1];
                    i += 1; // Skip next arg since we consumed it
                }
            } else if (std.mem.eql(u8, arg, "-q") or std.mem.eql(u8, arg, "--quiet")) {
                options.quiet = true;
            } else if (std.mem.eql(u8, arg, "--select")) {
                options.select = true;
            } else if (std.mem.eql(u8, arg, "-t") or std.mem.eql(u8, arg, "--template")) {
                if (i + 1 < args.len) {
                    options.template = args[i + 1];
                    i += 1; // Skip next arg since we consumed it
                }
            } else if (std.mem.startsWith(u8, arg, "-")) {
                // Handle combined flags like -opq
                var j: usize = 1;
                while (j < arg.len) : (j += 1) {
                    switch (arg[j]) {
                        'o' => {
                            // -o in combined flag, look for next separate arg
                            if (i + 1 < args.len and !std.mem.startsWith(u8, args[i + 1], "-")) {
                                options.output_path = args[i + 1];
                                i += 1;
                            }
                        },
                        'p' => {}, // placeholder for other flags
                        'q' => options.quiet = true,
                        else => {},
                    }
                }
            }
        } else {
            // Handle positional arguments
            if (std.mem.eql(u8, arg, "select")) {
                options.select = true;
            } else {
                options.gen_type = args[i];
            }
        }
    }

    return options;
}

fn runGenCommand(contents: *const Contents, options: GenOptions) !void {
    if (!options.quiet) {
        std.debug.print("Running gen command with options:\n", .{});
        std.debug.print("  Output path: {?s}\n", .{options.output_path});
        std.debug.print("  Quiet: {}\n", .{options.quiet});
        std.debug.print("  Select: {}\n", .{options.select});
        std.debug.print("  Template: {?s}\n", .{options.template});
    }

    // Your file generation logic here
    if (options.select) {
        try generateSelectFile(contents, options);
    } else {
        try generateDefaultFile(contents, options);
    }
}

fn generateSelectFile(contents: *const Contents, options: GenOptions) !void {
    var allocator = std.heap.c_allocator;
    const file_name: []const u8 = options.output_path orelse "Basic";
    var name: []const u8 = options.output_path orelse "Basic";

    // only if non-empty, build a new string with Upper(name[0]) + name[1..]
    if (name.len > 0) {
        const firstUpper = std.ascii.toUpper(name[0]);
        const rest = name[1..];
        // allocPrint will give you a new slice you can free later
        const capitalized = try std.fmt.allocPrint(allocator, "{c}{s}", .{ firstUpper, rest });
        // defer allocator.free(capitalized);

        // use `capitalized` from now on
        name = capitalized;
    }

    const output_path = try std.fmt.allocPrint(allocator, "{s}.zig", .{name});
    defer allocator.free(output_path);

    if (!options.quiet) {
        std.debug.print("Generating default file: {s}\n", .{output_path});
    }

    // Create the file
    var file = try std.fs.cwd().createFile(output_path, .{});
    defer file.close();

    const gen_type = contents.getGenType(name);
    std.debug.print("Generating file: {s}\n", .{file_name});
    const content = try contents.getContent(.Gen, gen_type, file_name);

    try file.writeAll(content);

    if (!options.quiet) {
        std.debug.print("✓ Generated {s}\n", .{output_path});
    }
}

fn generateDefaultFile(contents: *const Contents, options: GenOptions) !void {
    var allocator = std.heap.c_allocator;
    var name: []const u8 = options.gen_type;

    // only if non-empty, build a new string with Upper(name[0]) + name[1..]
    if (name.len > 0) {
        const firstUpper = std.ascii.toUpper(name[0]);
        const rest = name[1..];
        // allocPrint will give you a new slice you can free later
        const capitalized = try std.fmt.allocPrint(allocator, "{c}{s}", .{ firstUpper, rest });
        // defer allocator.free(capitalized);

        // use `capitalized` from now on
        name = capitalized;
    }


    const file_name: []const u8 = options.output_path orelse name;
    var struct_name: []const u8 = "";

    // only if non-empty, build a new string with Upper(name[0]) + name[1..]
    if (file_name.len > 0) {
        const firstUpper = std.ascii.toUpper(file_name[0]);
        const rest = file_name[1..];
        // allocPrint will give you a new slice you can free later
        const capitalized = try std.fmt.allocPrint(allocator, "{c}{s}", .{ firstUpper, rest });
        // defer allocator.free(capitalized);

        // use `capitalized` from now on
        struct_name = capitalized;
    }

    const output_path = try std.fmt.allocPrint(allocator, "{s}.zig", .{file_name});
    defer allocator.free(output_path);

    if (!options.quiet) {
        std.debug.print("Generating default file: {s}\n", .{output_path});
    }

    // Create the file
    var file = try std.fs.cwd().createFile(output_path, .{});
    defer file.close();

    const gen_type = contents.getGenType(name);
    std.debug.print("Generating file: {s}\n", .{file_name});
    const content = try contents.getContent(.Gen, gen_type, struct_name);

    try file.writeAll(content);

    if (!options.quiet) {
        std.debug.print("✓ Generated {s}\n", .{output_path});
    }
}

fn printHelp() void {
    const help_text =
        \\fabric - File generation CLI tool
        \\
        \\USAGE:
        \\    fabric <COMMAND> [OPTIONS] [ARGS]
        \\
        \\COMMANDS:
        \\    gen         Generate files
        \\    help        Show this help message
        \\
        \\GEN OPTIONS:
        \\    -o, --output <PATH>    Output file path
        \\    -q, --quiet           Suppress output
        \\    -t, --template <NAME> Template to use
        \\    --select              Generate select-specific file
        \\
        \\EXAMPLES:
        \\    fabric gen -o myfile.zig select
        \\    fabric gen -opq select
        \\    fabric gen basic 
        \\    fabric gen -o TestCrud crudfull 
        \\    fabric gen --quiet --output generated.zig
        \\
    ;
    std.debug.print("{s}", .{help_text});
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    var allocator = gpa.allocator();

    const contents = Contents{
        .allocator = &allocator,
    };

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    if (args.len < 2) {
        printHelp();
        return;
    }

    const command = parseCommand(args[1]);

    switch (command) {
        .gen => {
            const gen_args = args[2..];
            const options = parseGenOptions(gen_args);
            try runGenCommand(&contents, options);
        },
        .help => {
            printHelp();
        },
        .unknown => {
            std.debug.print("Unknown command: {s}\n", .{args[1]});
            std.debug.print("Run 'fabric help' for usage information.\n", .{});
            std.process.exit(1);
        },
    }
}
