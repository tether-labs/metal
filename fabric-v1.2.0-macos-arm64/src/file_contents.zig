const std = @import("std");

pub const CommandType = enum {
    Gen,
    Add,
};

pub const GenType = enum {
    Crud,
    Crudfull,
    Database,
    Client,
    Basic,
    Complex,
    Page,
    Null,
};

pub const Contents = @This();
allocator: *std.mem.Allocator,

fn basic(self: *const Contents, file_name: []const u8) ![]const u8 {
    const content =
        \\const std = @import("std");
        \\const Fabric = @import("Fabric.zig");
        \\
        \\// Styles.
        \\const Styles = Fabric.Styles;
        \\
        \\// Reactive Signals for updating state.
        \\const Signal = Fabric.Signal;
        \\
        \\// Style
        \\const Style = Fabric.Style;
        \\
        \\// Static components never rerender.
        \\const Static = Fabric.Static;
        \\
        \\// Animation Components.
        \\const Animation = Fabric.Animation;
        \\
        \\// Pure components only rerender when props change.
        \\const Pure = Fabric.Pure;
        \\
        \\// Dynamic components depend on signals and props.
        \\const Dynamic = Fabric.Dynamic;
        \\
        \\// Theme
        \\const Theme = Fabric.Theme;
        \\
        \\// Colors/Themes/Styling
        \\var styles: Styles = undefined;
        \\var primary: [4]f32 = undefined;
        \\var secondary: [4]f32 = undefined;
        \\var form_input_border_color: [4]f32 = undefined;
        \\var border_color: [4]f32 = undefined;
        \\var text_color: [4]f32 = undefined;
        \\var text_tint_color: [4]f32 = undefined;
        \\var tint: [4]f32 = undefined;
        \\
        \\// Component Instance
        \\const {s} = @This();
        \\
        \\// Initialization
        \\pub fn init(self: *{s}) void {{
        \\    primary = Theme.getAttribute("primary");
        \\    secondary = Theme.getAttribute("secondary");
        \\    border_color = Theme.getAttribute("border_color");
        \\    form_input_border_color = Theme.getAttribute("form_input_border_color");
        \\    text_color = Theme.getAttribute("text_color");
        \\    text_tint_color = Theme.getAttribute("text_tint_color");
        \\    tint = Theme.getAttribute("tint");
        \\
        \\    self.* = {s}{{}};
        \\}}
        \\
        \\// Deinitialization
        \\pub fn deinit(self: *{s}) void {{}}
        \\
        \\// Render
        \\pub fn render(self: *{s}) void {{}}
        \\
    ;

    return try std.fmt.allocPrint(self.allocator.*, content, .{ file_name, file_name, file_name, file_name, file_name });
}

fn page(self: *const Contents, file_name: []const u8) ![]const u8 {
    const content =
        \\const std = @import("std");
        \\const Fabric = @import("Fabric.zig");
        \\
        \\// Styles.
        \\const Styles = Fabric.Styles;
        \\
        \\// Reactive Signals for updating state.
        \\const Signal = Fabric.Signal;
        \\
        \\// Style
        \\const Style = Fabric.Style;
        \\
        \\// Static components never rerender.
        \\const Static = Fabric.Static;
        \\
        \\// Animation Components.
        \\const Animation = Fabric.Animation;
        \\
        \\// Pure components only rerender when props change.
        \\const Pure = Fabric.Pure;
        \\
        \\// Dynamic components depend on signals and props.
        \\const Dynamic = Fabric.Dynamic;
        \\
        \\// Theme
        \\const Theme = Fabric.Theme;
        \\
        \\// Colors/Themes/Styling
        \\var styles: Styles = undefined;
        \\var primary: [4]f32 = undefined;
        \\var secondary: [4]f32 = undefined;
        \\var form_input_border_color: [4]f32 = undefined;
        \\var border_color: [4]f32 = undefined;
        \\var text_color: [4]f32 = undefined;
        \\var text_tint_color: [4]f32 = undefined;
        \\var tint: [4]f32 = undefined;
        \\
        \\// Component Instance
        \\const {s} = @This();
        \\
        \\// Initialization
        \\pub fn init(self: *{s}) void {{
        \\    primary = Theme.getAttribute("primary");
        \\    secondary = Theme.getAttribute("secondary");
        \\    border_color = Theme.getAttribute("border_color");
        \\    form_input_border_color = Theme.getAttribute("form_input_border_color");
        \\    text_color = Theme.getAttribute("text_color");
        \\    text_tint_color = Theme.getAttribute("text_tint_color");
        \\    tint = Theme.getAttribute("tint");
        \\
        \\    self.* = {s}{{}};
        \\}}
        \\
        \\// Deinitialization
        \\pub fn deinit(self: *{s}) void {{}}
        \\
        \\// Render
        \\pub fn render(self: *{s}) void {{}}
        \\
        \\pub fn Page() void {{
        \\    Fabric.Page(@src(), render, null, .{{
        \\        .width = .percent(1),
        \\        .height = .percent(1),
        \\        .direction = .column,
        \\        .child_alignment = .{{ .y = .center, .x = .start }},
        \\    }});
        \\}}
    ;
    return try std.fmt.allocPrint(self.allocator.*, content, .{ file_name, file_name, file_name, file_name, file_name });
}
fn crud(_: *const Contents) []const u8 {
    return 
    \\const std = @import("std");
    \\const Context = @import("tether").Context;
    \\
    \\pub fn get(ctx: *Context) !void {
    \\}
    \\
    \\pub fn set(ctx: *Context) !void {
    \\}
    \\
    \\pub fn delete(ctx: *Context) !void {
    \\}
    \\
    \\pub fn update(ctx: *Context) !void {
    \\}
    \\
    \\pub fn lpush(ctx: *Context) !void {
    \\}
    \\
    \\pub fn lpushmany(ctx: *Context) !void {
    \\}
    \\
    \\pub fn lrange(ctx: *Context) !void {
    \\}
    \\
    ;
}

fn crudfull(_: *const Contents) []const u8 {
    return 
    \\const std = @import("std");
    \\const print = std.debug.print;
    \\const Context = @import("tether").Context;
    \\const ValueType = @import("treehouse").ValueType;
    \\const db = @import("Database.zig");
    \\
    \\pub fn get(ctx: *Context) !void {
    \\    const key = ctx.http_payload;
    \\    const response = db.default_cache.get(key) catch |err| {
    \\        ctx.ERROR(404, "VALUE NOT FOUND");
    \\        return err;
    \\    };
    \\    ctx.STRING(response) catch |err| {
    \\        ctx.ERROR(404, "SERVER ERROR");
    \\        return err;
    \\    };
    \\}
    \\
    \\pub fn set(ctx: *Context) !void {
    \\    const key = "";
    \\    const value = ValueType{};
    \\    const response = db.default_cache.set(key, value) catch |err| {
    \\        ctx.ERROR(404, "VALUE NOT FOUND");
    \\        return err;
    \\    };
    \\    ctx.STRING(response) catch |err| {
    \\        ctx.ERROR(404, "SERVER ERROR");
    \\        return err;
    \\    };
    \\}
    \\
    \\pub fn delete(ctx: *Context) !void {
    \\    const key = ctx.http_payload;
    \\    const response = db.default_cache.del(key) catch |err| {
    \\        ctx.ERROR(404, "VALUE COULD NOT BE DELETED");
    \\        return err;
    \\    };
    \\    ctx.STRING(response) catch |err| {
    \\        ctx.ERROR(404, "SERVER ERROR");
    \\        return err;
    \\    };
    \\}
    \\
    \\pub fn update(ctx: *Context) !void {
    \\    const key = "";
    \\    const value = ValueType{};
    \\    const response = db.default_cache.set(key, value) catch |err| {
    \\        ctx.ERROR(404, "VALUE NOT FOUND");
    \\        return err;
    \\    };
    \\    ctx.STRING(response) catch |err| {
    \\        ctx.ERROR(404, "SERVER ERROR");
    \\        return err;
    \\    };
    \\}
    \\
    \\pub fn lpush(ctx: *Context) !void {
    \\    const llname = "";
    \\    const item = ValueType{};
    \\    const response = db.default_cache.lpush(llname, item) catch |err| {
    \\        ctx.ERROR(404, "VALUE NOT FOUND");
    \\        return err;
    \\    };
    \\    ctx.STRING(response) catch |err| {
    \\        ctx.ERROR(404, "SERVER ERROR");
    \\        return err;
    \\    };
    \\}
    \\
    \\pub fn lpushmany(ctx: *Context) !void {
    \\    const llname = "";
    \\    const item = &.{ ValueType{} };
    \\    const response = db.default_cache.lpushmany(llname, item) catch |err| {
    \\        ctx.ERROR(404, "VALUE NOT FOUND");
    \\        return err;
    \\    };
    \\    ctx.STRING(response) catch |err| {
    \\        ctx.ERROR(404, "SERVER ERROR");
    \\        return err;
    \\    };
    \\}
    \\
    \\pub fn lrange(ctx: *Context) !void {
    \\    const llname = "";
    \\    const start = "0";
    \\    const end = "-1";
    \\
    \\    const response = db.default_cache.lrange(llname, start, end) catch |err| {
    \\        ctx.ERROR(404, "VALUE NOT FOUND");
    \\        return err;
    \\    };
    \\    ctx.STRING(response) catch |err| {
    \\        ctx.ERROR(404, "SERVER ERROR");
    \\        return err;
    \\    };
    \\}
    \\
    ;
}

fn database(_: *const Contents) []const u8 {
    return 
    \\const std = @import("std");
    \\const Allocator = std.mem.Allocator;
    \\const Treehouse = @import("treehouse.zig");
    \\var caches: std.StringHashMap(*Treehouse) = undefined;
    \\var local_allocator: Allocator = undefined;
    \\pub var default_cache: *Treehouse = undefined;
    \\
    \\pub fn init(allocator: *Allocator) void {
    \\    caches = std.StringHashMap(*Treehouse).init(allocator.*);
    \\    local_allocator = allocator.*;
    \\}
    \\
    \\pub fn deinit() void {
    \\    var cache_itr = caches.iterator();
    \\    defer caches.deinit();
    \\    while (cache_itr.next()) |cache| {
    \\        const treehouse_ptr = cache.value_ptr.*;
    \\        local_allocator.destroy(treehouse_ptr);
    \\    }
    \\}
    \\
    \\pub fn createCache(name: []const u8, port: u16) void {
    \\    const treehouse: *Treehouse = local_allocator.create(Treehouse) catch |err| {
    \\        std.log.err("{any}", .{err});
    \\        @panic("Failed to create Treehouse struct");
    \\    };
    \\    treehouse.* = Treehouse.createClient(port, &local_allocator) catch |err| {
    \\        std.log.err("{any}", .{err});
    \\        @panic("Failed to create client");
    \\    };
    \\    default_cache = treehouse;
    \\    caches.put(name, treehouse) catch {
    \\        @panic("Failed to stash cache in hashmap");
    \\    };
    \\}
    \\
    \\pub fn fetchCache(name: []const u8) ?*Treehouse {
    \\    return caches.get(name) orelse {
    \\        std.log.err("Failed to fetch cache from hashmap", .{});
    \\    };
    \\}
    ;
}

pub fn getGenType(_: *const Contents, file_name: []const u8) GenType {
    return std.meta.stringToEnum(GenType, file_name) orelse GenType.Null;
}

pub fn getContent(self: *const Contents, cmd_type: CommandType, gen_type: GenType, file_name: []const u8) ![]const u8 {
    switch (cmd_type) {
        .Gen => {
            switch (gen_type) {
                .Basic => {
                    return try self.basic(file_name);
                },
                .Page => {
                    return try self.page(file_name);
                },
                .Crudfull => {
                    return self.crudfull();
                },
                .Crud => {
                    return self.crud();
                },
                .Database => {
                    return self.database();
                },
                else => {},
            }
        },
        else => {},
    }
    return error.NoCommand;
}
