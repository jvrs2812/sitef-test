const std = @import("std");
const config = @import("config.zig");
const utils = @import("utils.zig");

var continuidade_step: usize = 1;

export fn ConfiguraIntSitefInterativo(
    IPSiTef: [*:0]const u8,
    IdLoja: [*:0]const u8,
    IdTerminal: [*:0]const u8,
    Reservado: [*:0]const u8,
) c_int {
    std.debug.print("IP do Sitef: {s}\n", .{IPSiTef});
    std.debug.print("ID da Loja: {s}\n", .{IdLoja});
    std.debug.print("ID do Terminal: {s}\n", .{IdTerminal});
    std.debug.print("Reservado: {s}\n", .{Reservado});

    var configIni = config.loadConfig("config.ini") catch |err| {
        std.debug.print("Erro ao carregar configuração: {t}\n", .{err});
        return -1;
    };
    defer configIni.deinit();

    const retorno = configIni.getInt("RETORNOS", "ConfiguraIntSitefInterativo") orelse 0;

    return retorno;
}

export fn ConfiguraIntSitefInterativoEx(
    IPSiTef: [*:0]const u8,
    IdLoja: [*:0]const u8,
    IdTerminal: [*:0]const u8,
    Reservado: [*:0]const u8,
    ParametrosAdicionais: [*:0]const u8,
) c_int {
    std.debug.print("IP do Sitef: {s}\n", .{IPSiTef});
    std.debug.print("ID da Loja: {s}\n", .{IdLoja});
    std.debug.print("ID do Terminal: {s}\n", .{IdTerminal});
    std.debug.print("Reservado: {s}\n", .{Reservado});
    std.debug.print("Parâmetros Adicionais: {s}\n", .{ParametrosAdicionais});

    continuidade_step = 1;

    var configIni = config.loadConfig("config.ini") catch |err| {
        std.debug.print("Erro ao carregar configuração: {t}\n", .{err});
        return -1;
    };
    defer configIni.deinit();

    const retorno = configIni.getInt("RETORNOS", "ConfiguraIntSitefInterativoEx") orelse 0;

    return retorno;
}

export fn IniciaFuncaoSiTefInterativo(
    Funcao: i32,
    Valor: [*c]const u8,
    CupomFiscal: [*c]const u8,
    DataFiscal: [*c]const u8,
    HoraFiscal: [*c]const u8,
    Operador: [*c]const u8,
    ParametrosAdicionais: [*c]const u8,
) c_int {
    std.debug.print("Iniciando função AASiTefInterativoA\n", .{});
    std.debug.print("Função: {d}\n", .{Funcao});
    std.debug.print("Valor: {s}\n", .{Valor});
    std.debug.print("Cupom Fiscal: {s}\n", .{CupomFiscal});
    std.debug.print("Data Fiscal: {s}\n", .{DataFiscal});
    std.debug.print("Hora Fiscal: {s}\n", .{HoraFiscal});
    std.debug.print("Operador: {s}\n", .{Operador});
    std.debug.print("Parâmetros Adicionais: {s}\n", .{ParametrosAdicionais});

    var configIni = config.loadConfig("config.ini") catch |err| {
        std.debug.print("Erro ao carregar configuração: {t}\n", .{err});
        return -1;
    };
    defer configIni.deinit();

    const retorno = configIni.getInt("RETORNOS", "IniciaFuncaoSiTefInterativo") orelse 0;

    return retorno;
}

export fn IniciaFuncaoAASiTefInterativo(
    Funcao: i32,
    Valor: [*c]const u8,
    CupomFiscal: [*c]const u8,
    DataFiscal: [*c]const u8,
    HoraFiscal: [*c]const u8,
    Operador: [*c]const u8,
    ParametrosAdicionais: [*c]const u8,
    Produtos: [*c]const u8,
) c_int {
    std.debug.print("Iniciando função AASiTefInterativoA\n", .{});
    std.debug.print("Função: {d}\n", .{Funcao});
    std.debug.print("Valor: {s}\n", .{Valor});
    std.debug.print("Cupom Fiscal: {s}\n", .{CupomFiscal});
    std.debug.print("Data Fiscal: {s}\n", .{DataFiscal});
    std.debug.print("Hora Fiscal: {s}\n", .{HoraFiscal});
    std.debug.print("Operador: {s}\n", .{Operador});
    std.debug.print("Parâmetros Adicionais: {s}\n", .{ParametrosAdicionais});
    std.debug.print("Produtos: {s}\n", .{Produtos});

    continuidade_step = 1;

    var configIni = config.loadConfig("config.ini") catch |err| {
        std.debug.print("Erro ao carregar configuração: {t}\n", .{err});
        return -1;
    };
    defer configIni.deinit();

    const retorno = configIni.getInt("RETORNOS", "IniciaFuncaoAASiTefInterativo") orelse 0;

    return retorno;
}

export fn FinalizaTransacaoSiTefInterativo(
    confirma: u16,
    pCuponFiscal: [*c]const u8,
    pDataFiscal: [*c]const u8,
    pHorarioFiscal: [*c]const u8,
) void {
    std.debug.print("Finalizando transação SiTef Interativo\n", .{});
    std.debug.print("Confirma: {d}\n", .{confirma});
    std.debug.print("Cupom Fiscal: {s}\n", .{pCuponFiscal});
    std.debug.print("Data Fiscal: {s}\n", .{pDataFiscal});
    std.debug.print("Horário Fiscal: {s}\n", .{pHorarioFiscal});
}

export fn FinalizaFuncaoSiTefInterativo(
    confirma: u16,
    pCuponFiscal: [*c]const u8,
    pDataFiscal: [*c]const u8,
    pHorarioFiscal: [*c]const u8,
    pParmAdic: [*c]const u8,
) void {
    std.debug.print("Finalizando função SiTef Interativo\n", .{});
    std.debug.print("Confirma: {d}\n", .{confirma});
    std.debug.print("Cupom Fiscal: {s}\n", .{pCuponFiscal});
    std.debug.print("Data Fiscal: {s}\n", .{pDataFiscal});
    std.debug.print("Horário Fiscal: {s}\n", .{pHorarioFiscal});
    std.debug.print("Parâmetros Adicionais: {s}\n", .{pParmAdic});
}

export fn ContinuaFuncaoSiTefInterativo(
    ProximoComando: *i32,
    TipoCampo: *i32,
    TamanhoMinimo: *i16,
    TamanhoMaximo: *i16,
    pBuffer: [*c]u8,
    TamMaxBuffer: i32,
    Continua: i32,
) c_int {
    std.debug.print("Continuando função SiTef Interativo\n", .{});
    std.debug.print("Comando: {d}\n", .{ProximoComando.*});
    std.debug.print("Tipo de Campo: {d}\n", .{TipoCampo.*});
    std.debug.print("Tamanho Mínimo: {d}\n", .{TamanhoMinimo.*});
    std.debug.print("Tamanho Máximo: {d}\n", .{TamanhoMaximo.*});
    std.debug.print("Tamanho do Buffer: {d}\n", .{TamMaxBuffer});
    std.debug.print("Continua: {d}\n", .{Continua});
    const buffer_len: usize = if (TamMaxBuffer > 0) @intCast(TamMaxBuffer) else 0;
    std.debug.print("Buffer antes de escrever: {s}\n", .{pBuffer[0..buffer_len]});

    if (Continua != 0) {
        std.debug.print("Não há continuidade necessária.\n", .{});
        return 0;
    }

    var configIni = config.loadConfig("config.ini") catch |err| {
        std.debug.print("Erro ao carregar configuração: {t}\n", .{err});
        return -1;
    };
    defer configIni.deinit();

    const retorno = configIni.getInt("CONTINUIDADES", "ContinuaFuncaoSiTefInterativo") orelse 0;

    if (retorno == 10000) {
        if (utils.getContinuidadeStep(configIni, continuidade_step)) |step| {
            ProximoComando.* = step.comando;
            TipoCampo.* = step.tipo_campo;
            TamanhoMinimo.* = step.tamanho_minimo;
            TamanhoMaximo.* = step.tamanho_maximo;
            utils.copyCStringToBuffer(pBuffer, TamMaxBuffer, step.buffer);

            std.debug.print(
                "Passo continuidade {d}: comando={d} tipo={d} buffer={s}\n",
                .{ continuidade_step, step.comando, step.tipo_campo, step.buffer },
            );

            continuidade_step += 1;
            return step.retorno;
        }

        if (utils.hasContinuidadeSteps(configIni)) {
            continuidade_step = 1;
            return configIni.getInt("CONTINUIDADE_PASSOS", "Final") orelse 0;
        }

        const response = utils.getContinuidadeBuffer(configIni, ProximoComando.*, TipoCampo.*) orelse "";
        utils.copyCStringToBuffer(pBuffer, TamMaxBuffer, response);
        std.debug.print("Buffer preenchido: {s}\n", .{response});
    }

    return retorno;
}
