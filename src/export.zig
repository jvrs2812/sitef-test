const std = @import("std");
const builtin = @import("builtin");
const config = @import("config.zig");
const utils = @import("utils.zig");

var continuidade_step: usize = 1;
const sitef_callconv = if (builtin.os.tag == .windows)
    std.builtin.CallingConvention.winapi
else
    std.builtin.CallingConvention.c;

fn debugPrint(comptime fmt: []const u8, args: anytype) void {
    if (builtin.os.tag != .windows) {
        std.debug.print(fmt, args);
    }
}

export fn ConfiguraIntSiTefInterativo(
    IPSiTef: [*:0]const u8,
    IdLoja: [*:0]const u8,
    IdTerminal: [*:0]const u8,
    Reservado: [*:0]const u8,
) callconv(sitef_callconv) c_int {
    debugPrint("IP do Sitef: {s}\n", .{IPSiTef});
    debugPrint("ID da Loja: {s}\n", .{IdLoja});
    debugPrint("ID do Terminal: {s}\n", .{IdTerminal});
    debugPrint("Reservado: {s}\n", .{Reservado});

    var configIni = config.loadConfig("config.ini") catch |err| {
        debugPrint("Erro ao carregar configuração: {t}\n", .{err});
        return -1;
    };
    defer configIni.deinit();

    const retorno = configIni.getInt("RETORNOS", "ConfiguraIntSiTefInterativo") orelse
        configIni.getInt("RETORNOS", "ConfiguraIntSitefInterativo") orelse 0;

    return retorno;
}

export fn ConfiguraIntSiTefInterativoEx(
    IPSiTef: [*:0]const u8,
    IdLoja: [*:0]const u8,
    IdTerminal: [*:0]const u8,
    Reservado: i16,
    ParametrosAdicionais: [*:0]const u8,
) callconv(sitef_callconv) c_int {
    debugPrint("IP do Sitef: {s}\n", .{IPSiTef});
    debugPrint("ID da Loja: {s}\n", .{IdLoja});
    debugPrint("ID do Terminal: {s}\n", .{IdTerminal});
    debugPrint("Reservado: {d}\n", .{Reservado});
    debugPrint("Parâmetros Adicionais: {s}\n", .{ParametrosAdicionais});

    continuidade_step = 1;

    var configIni = config.loadConfig("config.ini") catch |err| {
        debugPrint("Erro ao carregar configuração: {t}\n", .{err});
        return -1;
    };
    defer configIni.deinit();

    const retorno = configIni.getInt("RETORNOS", "ConfiguraIntSiTefInterativoEx") orelse
        configIni.getInt("RETORNOS", "ConfiguraIntSitefInterativoEx") orelse 0;

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
) callconv(sitef_callconv) c_int {
    debugPrint("Iniciando função AASiTefInterativoA\n", .{});
    debugPrint("Função: {d}\n", .{Funcao});
    debugPrint("Valor: {s}\n", .{Valor});
    debugPrint("Cupom Fiscal: {s}\n", .{CupomFiscal});
    debugPrint("Data Fiscal: {s}\n", .{DataFiscal});
    debugPrint("Hora Fiscal: {s}\n", .{HoraFiscal});
    debugPrint("Operador: {s}\n", .{Operador});
    debugPrint("Parâmetros Adicionais: {s}\n", .{ParametrosAdicionais});

    var configIni = config.loadConfig("config.ini") catch |err| {
        debugPrint("Erro ao carregar configuração: {t}\n", .{err});
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
) callconv(sitef_callconv) c_int {
    debugPrint("Iniciando função AASiTefInterativoA\n", .{});
    debugPrint("Função: {d}\n", .{Funcao});
    debugPrint("Valor: {s}\n", .{Valor});
    debugPrint("Cupom Fiscal: {s}\n", .{CupomFiscal});
    debugPrint("Data Fiscal: {s}\n", .{DataFiscal});
    debugPrint("Hora Fiscal: {s}\n", .{HoraFiscal});
    debugPrint("Operador: {s}\n", .{Operador});
    debugPrint("Parâmetros Adicionais: {s}\n", .{ParametrosAdicionais});
    debugPrint("Produtos: {s}\n", .{Produtos});

    continuidade_step = 1;

    var configIni = config.loadConfig("config.ini") catch |err| {
        debugPrint("Erro ao carregar configuração: {t}\n", .{err});
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
) callconv(sitef_callconv) void {
    debugPrint("Finalizando transação SiTef Interativo\n", .{});
    debugPrint("Confirma: {d}\n", .{confirma});
    debugPrint("Cupom Fiscal: {s}\n", .{pCuponFiscal});
    debugPrint("Data Fiscal: {s}\n", .{pDataFiscal});
    debugPrint("Horário Fiscal: {s}\n", .{pHorarioFiscal});
}

export fn FinalizaFuncaoSiTefInterativo(
    confirma: u16,
    pCuponFiscal: [*c]const u8,
    pDataFiscal: [*c]const u8,
    pHorarioFiscal: [*c]const u8,
    pParmAdic: [*c]const u8,
) callconv(sitef_callconv) void {
    debugPrint("Finalizando função SiTef Interativo\n", .{});
    debugPrint("Confirma: {d}\n", .{confirma});
    debugPrint("Cupom Fiscal: {s}\n", .{pCuponFiscal});
    debugPrint("Data Fiscal: {s}\n", .{pDataFiscal});
    debugPrint("Horário Fiscal: {s}\n", .{pHorarioFiscal});
    debugPrint("Parâmetros Adicionais: {s}\n", .{pParmAdic});
}

export fn ContinuaFuncaoSiTefInterativo(
    ProximoComando: *i32,
    TipoCampo: *i32,
    TamanhoMinimo: *i16,
    TamanhoMaximo: *i16,
    pBuffer: [*c]u8,
    TamMaxBuffer: i32,
    Continua: i32,
) callconv(sitef_callconv) c_int {
    debugPrint("Continuando função SiTef Interativo\n", .{});
    debugPrint("Comando: {d}\n", .{ProximoComando.*});
    debugPrint("Tipo de Campo: {d}\n", .{TipoCampo.*});
    debugPrint("Tamanho Mínimo: {d}\n", .{TamanhoMinimo.*});
    debugPrint("Tamanho Máximo: {d}\n", .{TamanhoMaximo.*});
    debugPrint("Tamanho do Buffer: {d}\n", .{TamMaxBuffer});
    debugPrint("Continua: {d}\n", .{Continua});
    const buffer_len: usize = if (TamMaxBuffer > 0) @intCast(TamMaxBuffer) else 0;
    debugPrint("Buffer antes de escrever: {s}\n", .{pBuffer[0..buffer_len]});

    if (Continua != 0) {
        debugPrint("Não há continuidade necessária.\n", .{});
        return 0;
    }

    var configIni = config.loadConfig("config.ini") catch |err| {
        debugPrint("Erro ao carregar configuração: {t}\n", .{err});
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

            debugPrint(
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
        debugPrint("Buffer preenchido: {s}\n", .{response});
    }

    return retorno;
}

export fn VerificaPresencaPinPad() callconv(sitef_callconv) c_int {
    debugPrint("Verificando presença do PinPad\n", .{});

    var configIni = config.loadConfig("config.ini") catch |err| {
        debugPrint("Erro ao carregar configuração: {t}\n", .{err});
        return -1;
    };
    defer configIni.deinit();

    const retorno = configIni.getInt("RETORNOS", "VerificaPresencaPinPad") orelse 0;

    return retorno;
}

export fn EscreveMensagemPermanentePinPad(
    pMensagem: [*c]const u8,
) callconv(sitef_callconv) c_int {
    debugPrint("Escrevendo mensagem permanente no PinPad\n", .{});
    debugPrint("Mensagem: {s}\n", .{pMensagem});

    var configIni = config.loadConfig("config.ini") catch |err| {
        debugPrint("Erro ao carregar configuração: {t}\n", .{err});
        return -1;
    };
    defer configIni.deinit();

    const retorno = configIni.getInt("RETORNOS", "EscreveMensagemPermanentePinPad") orelse 0;

    return retorno;
}

export fn LeSimNaoPinPad(
    pMensagem: [*c]const u8,
) callconv(sitef_callconv) c_int {
    debugPrint("Lendo resposta do PinPad\n", .{});
    debugPrint("Mensagem: {s}\n", .{pMensagem});

    var configIni = config.loadConfig("config.ini") catch |err| {
        debugPrint("Erro ao carregar configuração: {t}\n", .{err});
        return -1;
    };
    defer configIni.deinit();

    const retorno = configIni.getInt("RETORNOS", "LeSimNaoPinPad") orelse 0;

    return retorno;
}

export fn ObtemQuantidadeTransacoesPendentes(pDataFiscal: [*:0]const u8, pNumeroCupon: [*:0]const u8) callconv(sitef_callconv) c_int {
    debugPrint("Obtendo quantidade de transações pendentes\n", .{});
    debugPrint("Data Fiscal: {s}\n", .{pDataFiscal});
    debugPrint("Número do Cupom: {s}\n", .{pNumeroCupon});

    var configIni = config.loadConfig("config.ini") catch |err| {
        debugPrint("Erro ao carregar configuração: {t}\n", .{err});
        return -1;
    };
    defer configIni.deinit();

    const retorno = configIni.getInt("RETORNOS", "ObtemQuantidadeTransacoesPendentes") orelse 0;

    return retorno;
}

export fn LeCartaoDireto(Mensagem: [*:0]const u8, Trilha1: [*:0]const u8, Trilha2: [*:0]const u8) callconv(sitef_callconv) c_int {
    debugPrint("Lendo cartão diretamente\n", .{});
    debugPrint("Mensagem: {s}\n", .{Mensagem});
    debugPrint("Trilha 1: {s}\n", .{Trilha1});
    debugPrint("Trilha 2: {s}\n", .{Trilha2});

    var configIni = config.loadConfig("config.ini") catch |err| {
        debugPrint("Erro ao carregar configuração: {t}\n", .{err});
        return -1;
    };
    defer configIni.deinit();

    const retorno = configIni.getInt("RETORNOS", "LeCartaoDireto") orelse 0;

    return retorno;
}

export fn LeCartaoDiretoSeguro(
    Mensagem: [*:0]const u8,
    TipoTrilha1: [*:0]const u8,
    Trilha1: [*:0]u8, // Geralmente um buffer de saída (mutável)
    TipoTrilha2: [*:0]const u8,
    Trilha2: [*:0]u8, // Geralmente um buffer de saída (mutável)
    Timeout: i16,
    TestaCancelamento: i16,
) callconv(sitef_callconv) c_int {
    debugPrint("Lendo cartão diretamente (seguro)\n", .{});
    debugPrint("Mensagem: {s}\n", .{Mensagem});
    debugPrint("Tipo Trilha 1: {s}\n", .{TipoTrilha1});
    debugPrint("Tipo Trilha 2: {s}\n", .{TipoTrilha2});
    debugPrint("Timeout: {d}\n", .{Timeout});
    debugPrint("Testa Cancelamento: {d}\n", .{TestaCancelamento});
    debugPrint("Trilha 1 (antes): {s}\n", .{Trilha1});
    debugPrint("Trilha 2 (antes): {s}\n", .{Trilha2});

    var configIni = config.loadConfig("config.ini") catch |err| {
        debugPrint("Erro ao carregar configuração: {t}\n", .{err});
        return -1;
    };
    defer configIni.deinit();

    const retorno = configIni.getInt("RETORNOS", "LeCartaoDiretoSeguro") orelse 0;

    return retorno;
}

export fn ObtemDadoPinPadDiretoEx(pChaveAcesso: [*:0]const u8, pIdentificador: [*:0]const u8, pEntrada: [*:0]const u8, pSaida: [*:0]u8) callconv(sitef_callconv) c_int {
    debugPrint("Obtendo dado do PinPad (ex)\n", .{});
    debugPrint("Chave de Acesso: {s}\n", .{pChaveAcesso});
    debugPrint("Identificador: {s}\n", .{pIdentificador});
    debugPrint("Entrada: {s}\n", .{pEntrada});
    debugPrint("Saída (antes): {s}\n", .{pSaida});

    var configIni = config.loadConfig("config.ini") catch |err| {
        debugPrint("Erro ao carregar configuração: {t}\n", .{err});
        return -1;
    };
    defer configIni.deinit();

    const retorno = configIni.getInt("RETORNOS", "ObtemDadoPinPadDiretoEx") orelse 0;

    return retorno;
}

export fn ObtemDadoPinPadEx(pChaveAcesso: [*:0]const u8, pIdentificador: [*:0]const u8, pEntrada: [*:0]const u8) callconv(sitef_callconv) c_int {
    debugPrint("Obtendo dado do PinPad (ex)\n", .{});
    debugPrint("Chave de Acesso: {s}\n", .{pChaveAcesso});
    debugPrint("Identificador: {s}\n", .{pIdentificador});
    debugPrint("Entrada: {s}\n", .{pEntrada});

    var configIni = config.loadConfig("config.ini") catch |err| {
        debugPrint("Erro ao carregar configuração: {t}\n", .{err});
        return -1;
    };
    defer configIni.deinit();

    const retorno = configIni.getInt("RETORNOS", "ObtemDadoPinPadEx") orelse 0;

    return retorno;
}

export fn ObtemVersao(pVersaoCliSiTef: [*:0]u8, pVersaoCliSiTefI: [*:0]u8) callconv(sitef_callconv) c_int {
    debugPrint("Obtendo versão do CliSiTef\n", .{});
    debugPrint("Versão CliSiTef (antes): {s}\n", .{pVersaoCliSiTef});
    debugPrint("Versão CliSiTef Interativo (antes): {s}\n", .{pVersaoCliSiTefI});

    var configIni = config.loadConfig("config.ini") catch |err| {
        debugPrint("Erro ao carregar configuração: {t}\n", .{err});
        return -1;
    };
    defer configIni.deinit();

    const retorno = configIni.getInt("RETORNOS", "ObtemVersao") orelse 0;

    if (retorno == 0) {
        const versao_clisitef = configIni.getString("VERSAO", "CliSiTef") orelse "6.0";
        const versao_clisitefi = configIni.getString("VERSAO", "CliSiTefI") orelse versao_clisitef;
        utils.writeVersionBuffer(pVersaoCliSiTef, versao_clisitef);
        utils.writeVersionBuffer(pVersaoCliSiTefI, versao_clisitefi);
        debugPrint("Versão do CliSiTef definida para {s}\n", .{versao_clisitefi});
    }

    return retorno;
}
