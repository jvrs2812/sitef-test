# Sitef Test

Biblioteca dinâmica para simular integrações CliSiTef/SiTef Interativo em ambientes de desenvolvimento e homologação, especialmente quando a equipe não tem acesso a um PinPad físico.

Este projeto gera `.dll` para Windows e `.so` para Linux, compatíveis com aplicações que carregam bibliotecas dinâmicas e resolvem funções C por nome. A proposta é permitir que fluxos de pagamento, captura de comprovantes, retornos de transação e rotinas auxiliares sejam testados de forma previsível, configurável e sem dependência de hardware.

> Esta biblioteca é um simulador para testes. Ela não substitui a CliSiTef oficial em produção, não realiza comunicação real com autorizadores e não processa pagamentos reais.

## Objetivo

Em muitos ambientes de desenvolvimento, a automação comercial precisa integrar com SiTef, mas o time não possui:

- PinPad disponível para todos os desenvolvedores;
- servidor SiTef acessível localmente;
- ambiente estável para testar todos os retornos;
- liberdade para simular erros, cancelamentos e respostas específicas.

Esta biblioteca resolve esse problema oferecendo uma implementação controlada das principais funções usadas pela aplicação, com respostas definidas por arquivo `config.ini`.

## Principais Recursos

- Simulação de chamadas CliSiTef/SiTef Interativo.
- Retornos configuráveis por função.
- Fluxo de continuidade configurável por passos.
- Preenchimento de `Buffer`, `ProximoComando`, `TipoCampo`, tamanhos mínimo/máximo e retorno.
- Suporte a comprovante via cliente e via caixa.
- Simulação de dados de cartão, NSU, autorização, bandeira, instituição, BIN e validade.
- Build para Windows 32 bits, Windows 64 bits e Linux.
- Exports compatíveis com carregamento dinâmico por nome (`GetProcAddress`, `dlsym` ou equivalente).
- Workflow GitHub Actions para build e release automática por tag.

## Funções Exportadas

A biblioteca exporta as principais funções esperadas pela automação:

| Função | Descrição |
|---|---|
| `ConfiguraIntSiTefInterativo` | Simula a configuração inicial do SiTef Interativo. |
| `ConfiguraIntSiTefInterativoEx` | Simula a configuração inicial com parâmetros adicionais. |
| `IniciaFuncaoSiTefInterativo` | Simula o início de uma função/transação interativa. |
| `IniciaFuncaoAASiTefInterativo` | Simula o início de função com produtos. |
| `ContinuaFuncaoSiTefInterativo` | Executa o fluxo interativo por passos configurados no `config.ini`. |
| `FinalizaTransacaoSiTefInterativo` | Simula a finalização da transação. |
| `FinalizaFuncaoSiTefInterativo` | Simula a finalização da função SiTef. |
| `VerificaPresencaPinPad` | Simula a presença do PinPad. |
| `EscreveMensagemPermanentePinPad` | Simula escrita de mensagem no PinPad. |
| `LeSimNaoPinPad` | Simula leitura de resposta Sim/Não no PinPad. |
| `ObtemQuantidadeTransacoesPendentes` | Simula consulta de transações pendentes. |
| `LeCartaoDireto` | Simula leitura direta de cartão. |
| `LeCartaoDiretoSeguro` | Simula leitura segura de cartão. |
| `ObtemDadoPinPadEx` | Simula obtenção de dados pelo PinPad. |
| `ObtemDadoPinPadDiretoEx` | Simula obtenção direta de dados pelo PinPad. |
| `ObtemVersao` | Retorna versão simulada da CliSiTef/CliSiTefI. |

## Arquivo de Configuração

O comportamento da biblioteca é definido em `config.ini`.

### Retornos por Função

Na seção `[RETORNOS]`, cada função pode ter seu retorno configurado:

```ini
[RETORNOS]
ConfiguraIntSiTefInterativo=0
ConfiguraIntSiTefInterativoEx=0
IniciaFuncaoSiTefInterativo=0
IniciaFuncaoAASiTefInterativo=0
ObtemVersao=0
```

Exemplos comuns:

| Retorno | Significado |
|---:|---|
| `0` | Sucesso. |
| `10000` | Continua processo interativo. |
| `-1` | Módulo não inicializado. |
| `-2` | Operação cancelada pelo operador. |
| `-5` | Sem comunicação com o SiTef. |

### Versão da Biblioteca

O método `ObtemVersao` usa a seção `[VERSAO]`:

```ini
[VERSAO]
CliSiTef=6.0
CliSiTefI=6.0
```

A biblioteca preenche cinco posições com espaços, evitando bytes nulos em aplicações que leem buffers fixos.

### Continuidade Interativa

O fluxo da `ContinuaFuncaoSiTefInterativo` pode ser controlado por passos:

```ini
[CONTINUIDADE_PASSOS]
Passo1.Comando=0
Passo1.Tipo=100
Passo1.Min=0
Passo1.Max=0
Passo1.Buffer=0200
Passo1.Retorno=10000

Passo2.Comando=0
Passo2.Tipo=121
Passo2.Min=0
Passo2.Max=0
Passo2.Buffer=COMPROVANTE CLIENTE SITEF TESTE
Passo2.Retorno=10000

Final=0
```

Cada chamada da automação para `ContinuaFuncaoSiTefInterativo` recebe o próximo passo configurado. Quando os passos terminam, a biblioteca retorna o valor de `Final`.

## Build Local

Requisito:

- Zig `0.16.0`

Build Linux nativo:

```bash
zig build
```

Build Windows 32 bits:

```bash
zig build -Dtarget=x86-windows -Dversion=1.2.3 -Doptimize=ReleaseSmall
```

Build Windows 64 bits:

```bash
zig build -Dtarget=x86_64-windows -Dversion=1.2.3 -Doptimize=ReleaseSmall
```

Build Linux 64 bits glibc:

```bash
zig build -Dtarget=x86_64-linux-gnu -Dversion=1.2.3 -Doptimize=ReleaseSmall
```

Build Linux 64 bits musl:

```bash
zig build -Dtarget=x86_64-linux-musl -Dversion=1.2.3 -Doptimize=ReleaseSmall
```

Os artefatos são gerados em `zig-out/`.

## Releases Automatizadas

O projeto possui GitHub Actions para gerar builds automaticamente.

Em pushes e pull requests, o workflow compila todos os targets suportados. Ao publicar uma tag, o workflow cria uma GitHub Release com os artefatos:

- Linux x86 glibc;
- Linux x86_64 glibc;
- Linux x86 musl;
- Linux x86_64 musl;
- Windows x86;
- Windows x86_64.

Para criar uma release:

```bash
git tag v1.2.3
git push origin v1.2.3
```

## Uso em Aplicações

Qualquer linguagem capaz de carregar bibliotecas dinâmicas pode usar o simulador, desde que declare as assinaturas compatíveis com a ABI C/Windows esperada.

Exemplo simplificado de carregamento em Windows:

```c
HMODULE lib = LoadLibraryA("CliSiTef32I.dll");

if (lib == NULL) {
    /* tratar erro */
}

FARPROC configura = GetProcAddress(lib, "ConfiguraIntSiTefInterativo");
FARPROC continua = GetProcAddress(lib, "ContinuaFuncaoSiTefInterativo");
FARPROC obtem_versao = GetProcAddress(lib, "ObtemVersao");
```

Exemplo simplificado de carregamento em Linux:

```c
void *lib = dlopen("libclisitef.so", RTLD_LAZY);

if (lib == NULL) {
    /* tratar erro */
}

void *configura = dlsym(lib, "ConfiguraIntSiTefInterativo");
void *continua = dlsym(lib, "ContinuaFuncaoSiTefInterativo");
void *obtem_versao = dlsym(lib, "ObtemVersao");
```

No Windows 32 bits, o binário também exporta aliases sem decoração para facilitar o carregamento por nome em aplicações legadas.

## Observações Importantes

- Esta biblioteca é destinada exclusivamente a testes.
- Não há comunicação real com PinPad.
- Não há autorização real de pagamentos.
- Os dados retornados são simulados e definidos no `config.ini`.
- O arquivo `config.ini` deve estar no diretório de execução da aplicação que carrega a biblioteca.

## Estrutura do Projeto

```text
.
├── .github/workflows/build-release.yml
├── build.zig
├── build.zig.zon
├── CliSiTef32I.def
├── config.ini
└── src
    ├── config.zig
    ├── export.zig
    └── utils.zig
```

## Licença e Uso

Este projeto deve ser usado como ferramenta interna de desenvolvimento, testes e homologação. Antes de distribuir publicamente ou usar em ambientes de terceiros, revise as políticas de licenciamento e nomenclatura relacionadas à integração oficial CliSiTef/SiTef.
