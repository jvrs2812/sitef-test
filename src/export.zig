const std = @import("std");
const config = @import("config");

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

    const configIni = config.loadConfig("config.ini") catch |err| {
        std.debug.print("Erro ao carregar configuração: {s}\n", .{err});
        return -1;
    };

    const retorno = configIni.get("RETORNOS", "ConfiguraIntSitefInterativo") orelse 0;

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

    const configIni = config.loadConfig("config.ini") catch |err| {
        std.debug.print("Erro ao carregar configuração: {s}\n", .{err});
        return -1;
    };

    const retorno = configIni.get("RETORNOS", "ConfiguraIntSitefInterativoEx") orelse 0;

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

    const configIni = config.loadConfig("config.ini") catch |err| {
        std.debug.print("Erro ao carregar configuração: {s}\n", .{err});
        return -1;
    };

    const retorno = configIni.get("RETORNOS", "IniciaFuncaoSiTefInterativo") orelse 0;

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
    const configIni = config.loadConfig("config.ini") catch |err| {
        std.debug.print("Erro ao carregar configuração: {s}\n", .{err});
        return -1;
    };

    const retorno = configIni.get("RETORNOS", "IniciaFuncaoAASiTefInterativo") orelse 0;

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
    std.debug.print("Buffer antes de escrever: {s}\n", .{pBuffer[0..TamMaxBuffer]});

    const configIni = config.loadConfig("config.ini") catch |err| {
        std.debug.print("Erro ao carregar configuração: {s}\n", .{err});
        return -1;
    };

    const retorno = configIni.get("CONTINUIDADES", "ContinuaFuncaoSiTefInterativo") orelse 0;

    if (retorno == 10000) {
        const response = "Resposta Simulada";
        const bytesToWrite = std.math.min(response.len, TamMaxBuffer);
        std.mem.copy(u8, pBuffer, response[0..bytesToWrite]);
    }

    return retorno;
}
