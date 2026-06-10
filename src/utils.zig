const std = @import("std");

pub const ContinuidadeStep = struct {
    comando: i32,
    tipo_campo: i32,
    tamanho_minimo: i16,
    tamanho_maximo: i16,
    retorno: i32,
    buffer: []const u8,
};

pub fn copyCStringToBuffer(buffer: [*c]u8, buffer_len: i32, value: []const u8) void {
    if (buffer_len <= 0 or buffer == null) return;

    const len: usize = @intCast(buffer_len);
    const writable_len = len - 1;
    const bytes_to_write = @min(value.len, writable_len);

    @memset(buffer[0..len], 0);
    @memcpy(buffer[0..bytes_to_write], value[0..bytes_to_write]);
}

pub fn getContinuidadeBuffer(config_ini: anytype, comando: i32, tipo_campo: i32) ?[]const u8 {
    var key_buffer: [64]u8 = undefined;

    const command_and_type_key = std.fmt.bufPrint(
        &key_buffer,
        "Comando{d}.Tipo{d}",
        .{ comando, tipo_campo },
    ) catch return null;
    if (config_ini.getString("BUFFER_CONTINUIDADE", command_and_type_key)) |value| return value;

    const command_key = std.fmt.bufPrint(&key_buffer, "Comando{d}", .{comando}) catch return null;
    if (config_ini.getString("BUFFER_CONTINUIDADE", command_key)) |value| return value;

    const type_key = std.fmt.bufPrint(&key_buffer, "Tipo{d}", .{tipo_campo}) catch return null;
    if (config_ini.getString("BUFFER_CONTINUIDADE", type_key)) |value| return value;

    return config_ini.getString("BUFFER_CONTINUIDADE", "Padrao");
}

pub fn hasContinuidadeSteps(config_ini: anytype) bool {
    return config_ini.getInt("CONTINUIDADE_PASSOS", "Passo1.Comando") != null;
}

pub fn getContinuidadeStep(config_ini: anytype, step_number: usize) ?ContinuidadeStep {
    var key_buffer: [64]u8 = undefined;

    const comando_key = std.fmt.bufPrint(&key_buffer, "Passo{d}.Comando", .{step_number}) catch return null;
    const comando = config_ini.getInt("CONTINUIDADE_PASSOS", comando_key) orelse return null;

    const tipo_key = std.fmt.bufPrint(&key_buffer, "Passo{d}.Tipo", .{step_number}) catch return null;
    const tipo_campo = config_ini.getInt("CONTINUIDADE_PASSOS", tipo_key) orelse 0;

    const min_key = std.fmt.bufPrint(&key_buffer, "Passo{d}.Min", .{step_number}) catch return null;
    const tamanho_minimo: i16 = @intCast(config_ini.getInt("CONTINUIDADE_PASSOS", min_key) orelse 0);

    const max_key = std.fmt.bufPrint(&key_buffer, "Passo{d}.Max", .{step_number}) catch return null;
    const tamanho_maximo: i16 = @intCast(config_ini.getInt("CONTINUIDADE_PASSOS", max_key) orelse 0);

    const retorno_key = std.fmt.bufPrint(&key_buffer, "Passo{d}.Retorno", .{step_number}) catch return null;
    const retorno = config_ini.getInt("CONTINUIDADE_PASSOS", retorno_key) orelse 10000;

    const buffer_key = std.fmt.bufPrint(&key_buffer, "Passo{d}.Buffer", .{step_number}) catch return null;
    const buffer = config_ini.getString("CONTINUIDADE_PASSOS", buffer_key) orelse
        getContinuidadeBuffer(config_ini, comando, tipo_campo) orelse "";

    return .{
        .comando = comando,
        .tipo_campo = tipo_campo,
        .tamanho_minimo = tamanho_minimo,
        .tamanho_maximo = tamanho_maximo,
        .retorno = retorno,
        .buffer = buffer,
    };
}

pub fn writeVersionBuffer(buffer: [*:0]u8, version: []const u8) void {
    @memset(buffer[0..5], ' ');
    const bytes_to_write = @min(version.len, 5);
    @memcpy(buffer[0..bytes_to_write], version[0..bytes_to_write]);
}
