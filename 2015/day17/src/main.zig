const std = @import("std");
const day17 = @import("day17");

pub fn main() !void {
    const containers = comptime parseInput();
    const num_combinations = std.math.pow(u32, 2, containers.len);

    var p1: i64 = 0;
    var per_size: [21]i64 = [_]i64{0} ** 21;

    var i: u32 = 0;
    while (i < num_combinations) : (i += 1) {
        var current_sum: i64 = 0;
        var size: u64 = 0;
        for (containers, 0..) |c, bit_index| {
            if ((i >> @intCast(bit_index)) & 1 == 1) {
                size += 1;
                current_sum += c;
            }
        }
        if (current_sum == 150) {
            per_size[size] += 1;
            p1 += 1;
        }
    }
    std.debug.print("Part 1: {d}\n", .{p1});
    for (per_size) |count| {
        if (count > 0) {
            std.debug.print("Part 2: {d}\n", .{count});
            break;
        }
    }
}

fn parseInput() [20]i64 {
    @setEvalBranchQuota(2000);
    const input = @embedFile("input.txt");
    var result: [20]i64 = undefined;
    var iter = std.mem.tokenizeAny(u8, input, " \n\r\t");

    var i: usize = 0;
    while (iter.next()) |token| : (i += 1) {
        result[i] = std.fmt.parseInt(i64, token, 10) catch unreachable;
    }
    return result;
}

test "fuzz example" {
    const Context = struct {
        fn testOne(context: @This(), input: []const u8) anyerror!void {
            _ = context;
            // Try passing `--fuzz` to `zig build test` and see if it manages to fail this test case!
            try std.testing.expect(!std.mem.eql(u8, "canyoufindme", input));
        }
    };
    try std.testing.fuzz(Context{}, Context.testOne, .{});
}
