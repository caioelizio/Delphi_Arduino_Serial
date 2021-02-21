unit uFuncoes;

interface

uses Forms, SysUtils, Windows, Dialogs, Wininet, StdCtrls, Buttons, ShellAPI,
     ShlObj, Controls, IniFiles, Classes, Graphics, DB, DBCtrls, Grids, DBGrids,
     DBClient, TypInfo, ExcelXP, ComObj, Menus, Variants, Registry, IdIcmpClient,
     Messages,  ComCtrls, ExtCtrls, Mask, WinSock;

type
   TAcaoFormulario = (afCreate, afShow, afShowModal);

   //INDEX FUNCOES INI
   procedure GravaStr( Nome, Variavel, Texto, Arquivo: String );                                 //GRAVA NO ARQUIVO config.ini
   function  LerStr(   Nome, Variavel, Texto, Arquivo: String): String;                          //LER NO ARQUIVO config.ini
   procedure GravaInt( Nome, Variavel : String; Num:    Integer; Arquivo : String);              //GRAVA NO ARQUIVO config.ini
   function  LerInt(   Nome, Variavel : String; Num:    integer; Arquivo : String): Integer;     //LER NO ARQUIVO config.ini
   procedure GravaDate(Nome, Variavel : String; Data:   TDateTime; Arquivo : String);            //GRAVA NO ARQUIVO config.ini
   function  LerDate(  Nome, Variavel : String; Data:   TDateTime; Arquivo : String): TDateTime; //LER NO ARQUIVO config.ini
   procedure GravaBoo( Nome, Variavel : String; Status: Boolean; Arquivo : String);              //GRAVA NO ARQUIVO config.ini
   function  LerBoo(   Nome, Variavel : String; Status: Boolean; Arquivo : String): Boolean;     //LER NO ARQUIVO config.ini
//
   function  MensagemExcluir: boolean;
   function  MensagemSimNao(Mensagem: string; DefBut: Integer = 1): Boolean;
   function  MensagemSimNaoCancelar(Mensagem: string): Integer;
   procedure MensagemPare(Mensagem: string);
   procedure MensagemAtencao(Mensagem: string);

   //INDEX FUNCOES INI AUXILIARES
   Function MapeaRede(Letra,Path,provedor:Pchar):String; //mapea um Drive via programação
   procedure AlterarRegistroWindows();                                          //ALTERAR REGISTRO WINDOWS USES Registry,
   procedure ExecutePrograma(Nome, Parametros: String);
   function SystemDateTime(tDate: TDateTime; tTime: TDateTime): Boolean;
   function DataDeCriacao(Arq: string): TDateTime;
//
   function  DateTimeFinal(Valor: TDateTime): string;
   procedure StringGridLimpa(StringGrid: TStringGrid);
   Function  RetornaCom( componet: TComponent; Nome:String ) : TDBEdit;


//INDEX FUNCOES INI AUXILIARES REDE INTERNET
   function  TipoConexao(): string;
   function  ConexaoAtiva(): Boolean;
   procedure TestaConexao();
   procedure verifica_conexao_internet();
   Function  GetIP(): string;       //Declare a Winsock na clausula uses da unit

//INDEX FUNCOES INI AUXILIARES REDE INTERNET STRINGS
   procedure Insere(var sString: string; sSubString: string; iwPos: word);
   function  ZeroEsquerda(const I: integer; const Casas: byte): string; //FUNCAO ADCIONA ZERO A ESQUERDA
   function  ZeroEsquerda64(const I: Int64; const Casas: byte): string; //FUNCAO ADCIONA ZERO A ESQUERDA NUMERO LONGO
   function  ZeroEsquerdaFloat(const I: Double; const Casas: byte): string;   //FUNCAO ADCIONA ZERO A ESQUERDA NUMERO com casas decimais
   function  NomeComputador: string;
   function  Espaco(iwNumEspaco: word): string;
   function  Centraliza(sString: string; iwNumEspaco: word): string;
   function  AlinharDireita(sString: string; iwPosicoes: word): string;
   function  Justifica(mCad: string; mMAx: integer): string;
   function  TamanhoMax(mCad: string; mMAx: integer): string;
   function  Replicar(sString: string; iwQuantidade: word): string;
//
   function  Negrito(value: string): string;
   function  Sublinha(value: string): string;
   function  TiraPontos(sString: string): string;
   function  ParseName(Str: string; Separator: string): string;
   function  ParseValue(Str: string; Separator: string): string;
   function  StringUltimaPalavra(const Text: String): String;
   function  StringPesqLetra(Busca, Text : string) : Boolean; //Pesquisa um caractere à direita da string,
   function  StrRemoveEspacos( str : string ) : string;
   function  StrRemoveCaractereEspecialAspas( Str : string ) : string;
   function  StrRemoveCaractereColchetes( Str : string ) : string;
   function  AjustaCadastroDescricao(Str: string): string; //Bernardino. Função para eliminar espaços em branco duplicados e caracteres especiais}
   function  SubstituiStr(S, Localizar, Substituir: string): string;
   function  SoNumero(s: string): Boolean;
   function  SoNumeros(s: string): string;
   function  FormatoMoedaCur(rdValor: double): string;
   function  FormatoMoedaFloat(rdValor: double): string;
   function  extenso(valor: real): string;

//INDEX FUNCOES INI AUXILIARES REDE INTERNET STRINGS FORMULARIOS
   function  VersaoArquivo(const Filename: string): string;
   function  TamanhoArquivo(const FileName: string): integer;

//INDEX FUNCOES INI AUXILIARES REDE INTERNET STRINGS FORMULARIOS VARIAVEIS
   Const cNomeSistema : String = 'ARDUINO CaioT.I.';
   Var
   CaptionSistema         : Pchar = 'ARDUINO CaioT.I.';
   EmpresaSistema         : Pchar = 'CaioT.I.';
   sCaminhoDoSistema      : String;   //CAMINHO DA PASTA ONDE ESTA INSTALADA O SISTEMA
   sNomeBancoDados        : String;
   sVersaoAtual           : String;   //1.0.0.1
   sCorFonte              : String;   //clRed
   sCorFundo              : String;
   sCorFundo_S            : String;
   bDebug                 : boolean;
   bAtualizar             : boolean;  //SE VALOR IGUAL FALSE SISTEMA NAO ATUALIZARA
   sImpressora            : String;   //CAMINHO DA IMPRESSORA DE CUPOM FISCAL //RECEBI DO .INI
   sCaminhoAtualizacao    : String;   //CAMINHO PARA BUSCAR O ARQUIVO DE ATUALIZACAO DO SISTEMA

   //ARDUINO
   sStatusRele1 : String = 'L';

   //SISTEMA
   dDataAtual      : TDateTime;
   sDataAtual      : String;
   iRetorno        : Integer;
   Buffer          : Pchar = #0;
   //Schema          : String;
   bUltimaPesquisa : Boolean;

   //CONEXAO
   ArquivoConexcaoBanco : String = 'config.ini';
   sUrlSoap             : String;

   //VARIAVEIS_SISTEMA
   sCaminhoFTP            : String;
   sCaminhoDiretorioLocal : String;
   sLink                  : String;
   sCaminhoArquivo        : String;   //INDICA O CAMINHO DE UM DIRETORIO OU ARQUIVO
   cCaminhoArquivo        : Pchar;    //INDICA O CAMINHO DE UM DIRETORIO OU ARQUIVO
   Arquivoini             : TIniFile; //uses , IniFiles //USADA PARA USAR ARQUIVO .ini

   //VARIAVEIS_MAQUIMA_DE_ACESSO
   sNomeComputador        : String;
   HoraInicial            : string;    //GRAVA HORA DO INICIO DO PROCESSAMENTO PARA CALCULAR O TEMPO GASTO
   sDesabMensConfirmacao  : boolean;

implementation


//INDEX FUNCOES INI AUXILIARES
Function MapeaRede(Letra,Path,provedor:Pchar):String; //mapea um Drive via programação
var NRW: TNetResource;
begin
   with NRW do
   begin
     dwType       := RESOURCETYPE_ANY;
     lpLocalName  := Letra;
     lpRemoteName := Path;
     lpProvider   := provedor;
   end;

   //Local = Letra atribuida a unidade //Path =  Caminho do mapeamento //Provedor = Provedor da rede
   WNetAddConnection2(NRW, ' ', ' ', CONNECT_UPDATE_PROFILE);
   Case GetLastError() of
      5:    Result := 'Acesso Negado';
      66:   Result := 'Tipo de dispositivo local ou recurso inválido';
      67:   Result := 'Caminho não encontrado ou inválido';
      85:   Result := 'Este mapeamento já existe';
      86:   Result := 'Senha não encontrada ou inválida';
      1200: Result := 'Letra atribuída a unidade já é reservada ou inválida';
      1202: Result := 'Um mapeamento com esta letra já existe';
      1203: Result := 'Rede ou caminho não encontrado ou inválido';
      1204: Result := 'Provedor não encontrado ou inválido';
      1205: Result := 'Não foi possível abrir o perfil';
      1206: Result := 'Perfil do usuário não encontrado ou inválido';
      1208: Result := 'Ocorreu um Erro específico na rede';
      170:  Result := 'Rede congestionada';
      2138: Result := 'Rede não encontrada ou fora do ar'
   else
      Result := 'Unidade mapeada com sucesso';
   end;
end;

procedure AlterarRegistroWindows(); //ALTERAR REGISTRO WINDOWS USES Registry,
begin
   //Alterar configuracoes regionais do windows
   CurrencyString    := 'R$';
   ThousandSeparator := '.';
   DecimalSeparator  := '.';
   CurrencyDecimals  := 2;
   DateSeparator     := '/';
   ShortDateFormat   := 'dd/MM/yyyy';//}
end;

//Ex: GravaStr('GRUPO', 'CODIGO', now); //GRAVA NO ARQUIVO config.ini
procedure GravaDate(Nome, Variavel: String; Data: TDateTime; Arquivo : String); //GRAVA NO ARQUIVO config.ini
begin
   Try
      if Arquivo  = '' then
         Arquivoini := TIniFile.Create( sCaminhoDoSistema+'\'+'config.ini' )
      else
         Arquivoini := TIniFile.Create( sCaminhoDoSistema+'\'+Arquivo );//}

      if Nome     = '' then Nome     := 'ERRO';
      if Variavel = '' then Variavel := 'ERRO';

      Arquivoini.WriteDate( Nome, Variavel, Data );
   finally
      Arquivoini.Free;                                                          //libera a variável da memória
   end;//}
end;

function  LerDate(Nome, Variavel : String; Data: TDateTime; Arquivo : String): TDateTime;   //LER NO ARQUIVO config.ini
begin
   Try
      if Arquivo  = '' then
         Arquivoini := TIniFile.Create( sCaminhoDoSistema+'\'+'config.ini' )
      else
         Arquivoini := TIniFile.Create( sCaminhoDoSistema+'\'+Arquivo );//}

      if Nome     = '' then Nome     := 'ERRO';
      if Variavel = '' then Variavel := 'ERRO';

      if Arquivoini.ReadDate( Nome, Variavel, Data ) <> Null then
         Result     := Arquivoini.ReadDate( Nome, Variavel, Data );
   finally
      Arquivoini.Free;
   end;//}
end;

//Ex: GravaStr('GRUPO', 'CODIGO', RetornaParamentro2);                   //GRAVA NO ARQUIVO config.ini
//procedure GravaStr(Nome: String; Variavel: String; Texto: String );    //GRAVA NO ARQUIVO config.ini
procedure GravaStr(Nome, Variavel, Texto, Arquivo: String );    //GRAVA NO ARQUIVO config.ini
begin
   Try
      if Arquivo  = '' then
         Arquivoini := TIniFile.Create( sCaminhoDoSistema+'\'+'config.ini' )
      else
         Arquivoini := TIniFile.Create( sCaminhoDoSistema+'\'+Arquivo );

      if Nome     = '' then Nome     := 'ERRO';
      if Variavel = '' then Variavel := 'ERRO';
      //if Texto    = '' then Texto    := 'ERRO';

      Arquivoini.WriteString( Nome, Variavel, Texto );
   finally
      Arquivoini.Free;
   end;//}
end;

function LerStr(Nome, Variavel, Texto, Arquivo : String): String;     //LER NO ARQUIVO config.ini
begin
   Try
      if Arquivo  = '' then
         Arquivoini := TIniFile.Create( sCaminhoDoSistema+'\'+'config.ini' )
      else
         Arquivoini := TIniFile.Create( sCaminhoDoSistema+'\'+Arquivo );

      if Arquivoini.ReadString( Nome, Variavel, Texto ) <> '' then
         Result := Arquivoini.ReadString( Nome, Variavel, Texto );
   finally
      Arquivoini.Free;
   end;//}
end;

//Ex: GravaInt('rgFiltros', 'X', rgFiltros.ItemIndex); //GRAVA NO ARQUIVO config.ini
procedure GravaInt(Nome, Variavel: String; Num: integer; Arquivo: String); //GRAVA NO ARQUIVO config.ini
begin
   Try
      //Arquivoini := TIniFile.Create( GetCurrentDir+'\config.ini' );
      if Arquivo  = '' then
         Arquivoini := TIniFile.Create( sCaminhoDoSistema+'\'+'config.ini' )
      else
         Arquivoini := TIniFile.Create( sCaminhoDoSistema+'\'+Arquivo );
      if Nome     = '' then Nome     := 'ERRO';
      if Variavel = '' then Variavel := 'ERRO';
      Arquivoini.WriteInteger( Nome, Variavel, Num );
   finally
      Arquivoini.Free;
   end;//}
end;

//Ex: LerInt('rgFiltros', 'X', rgFiltros.ItemIndex): integer; //LER NO ARQUIVO config.ini
function LerInt(Nome, Variavel: String; Num: integer; Arquivo: String): integer; //LER NO ARQUIVO config.ini
begin
   Try
      if Arquivo  = '' then
         Arquivoini := TIniFile.Create( sCaminhoDoSistema+'\'+'config.ini' )
      else
         Arquivoini := TIniFile.Create( sCaminhoDoSistema+'\'+Arquivo );
      if Arquivoini.ReadInteger( Nome, Variavel, Num ) <> 0 then
         Result  := Arquivoini.ReadInteger( Nome, Variavel, Num );
   finally
      Arquivoini.Free;
   end;//}
end;

//Ex:
procedure GravaBoo(Nome, Variavel: String; Status: Boolean; Arquivo : String); //GRAVA NO ARQUIVO config.ini
begin
   Try
      //Arquivoini := TIniFile.Create( GetCurrentDir+'\config.ini' );
      if Arquivo  = '' then
         //Arquivoini := TIniFile.Create( GetCurrentDir+'\'+'config.ini' )
         Arquivoini := TIniFile.Create( sCaminhoDoSistema+'\'+'config.ini' )
      else
         //Arquivoini := TIniFile.Create( GetCurrentDir+'\'+Arquivo );
         Arquivoini := TIniFile.Create( sCaminhoDoSistema+'\'+Arquivo );
      if Nome     = '' then Nome     := 'ERRO';
      if Variavel = '' then Variavel := 'ERRO';
      Arquivoini.WriteBool( Nome, Variavel, Status );
   finally
      Arquivoini.Free;
   end;//}
end;

//Ex:
function LerBoo(Nome, Variavel: String; Status: Boolean; Arquivo : String): Boolean; //LER NO ARQUIVO config.ini
begin
   Try
      //Arquivoini := TIniFile.Create( GetCurrentDir+'\config.ini' );
      if Arquivo  = '' then
         //Arquivoini := TIniFile.Create( GetCurrentDir+'\'+'config.ini' )
         Arquivoini := TIniFile.Create( sCaminhoDoSistema+'\'+'config.ini' )

      else
         //Arquivoini := TIniFile.Create( GetCurrentDir+'\'+Arquivo );
         Arquivoini := TIniFile.Create( sCaminhoDoSistema+'\'+Arquivo );
      Result     := Arquivoini.ReadBool( Nome, Variavel, Status );
   finally
      Arquivoini.Free;
   end;//}
end;

procedure ExecutePrograma(Nome, Parametros: String);
Var
   Comando: Array[0..1024] of Char;
   Parms: Array[0..1024] of Char;
begin
   StrPCopy (Comando, Nome);
   StrPCopy (Parms, Parametros);
   //ShellExecute (0, Nil, Comando, Parms, Nil, SW_Shownormal);
   ShellExecute (0, Nil, Comando, Parms, Nil, SW_SHOWMAXIMIZED);
end;

//Permite que você altere a data e a hora do sistema
//Ex: SystemDateTime(tDate: TDateTime; tTime: TDateTime);
function SystemDateTime(tDate: TDateTime; tTime: TDateTime): Boolean;
var tSetDate: TDateTime;
    vDateBias: Variant;
    tSetTime: TDateTime;
    vTimeBias: Variant;
    tTZI: TTimeZoneInformation;
    tST: TSystemTime;
begin
   GetTimeZoneInformation(tTZI);
   vDateBias := tTZI.Bias / 1440;
   tSetDate  := tDate + vDateBias;
   vTimeBias := tTZI.Bias / 1440;
   tSetTime  := tTime + vTimeBias;
   with tST do
     begin
     wYear   := StrToInt(FormatDateTime('yyyy', tSetDate));
     wMonth  := StrToInt(FormatDateTime('mm', tSetDate));
     wDay    := StrToInt(FormatDateTime('dd', tSetDate));
     wHour   := StrToInt(FormatDateTime('hh', tSettime));
     wMinute := StrToInt(FormatDateTime('nn', tSettime));
     wSecond := StrToInt(FormatDateTime('ss', tSettime));
     wMilliseconds := 0;
     end;
   SystemDateTime := SetSystemTime(tST);
end;

function DataDeCriacao(Arq: string): TDateTime;
var ffd: TWin32FindData;
    dft: DWORD;
    lft: TFileTime;
    h: THandle;
begin
   h := Windows.FindFirstFile(PChar(Arq), ffd);
   try
      if (INVALID_HANDLE_VALUE <> h) then
      begin
         FileTimeToLocalFileTime(ffd.ftLastWriteTime, lft);
         //FileTimeToLocalFileTime(ffd.ftCreationTime, lft);
         FileTimeToDosDateTime(lft, LongRec(dft).Hi, LongRec(dft).Lo);
         Result := FileDateToDateTime(dft);
      end;
   finally
      Windows.FindClose(h);
   end;
end;


function DateTimeFinal;
  var iwYear, iwMonth, iwDay: word;
      sYear, sMonth, sDay: string;
begin
  DecodeDate(Valor, iwYear, iwMonth, iwDay);
  sYear  := Format('%0.4d', [iwYear]);
  sMonth := Format('%0.2d', [iwMonth]);
  sDay   := Format('%0.2d', [iwDay]);
  Result := Trim(#39+ sMonth + '/' + sDay + '/' + sYear +' 23:59:59'+#39);
end;


procedure StringGridLimpa(StringGrid: TStringGrid); //Limpando uma coluna de cada vez do StringGrid1...
var i: integer;
begin
   with StringGrid do begin
       for i := 0 to ColCount -1 do
         Cols[i].Clear;
   end;
end;//}

Function RetornaCom( componet: TComponent; Nome:String ) : TDBEdit;
var Comp : integer;
    ds   : TDataSource;
    fn   : string;
begin
   for Comp := 0 to componet.ComponentCount - 1 do begin
      if componet.Components[Comp].ComponentCount > 0 Then
         RetornaCom( componet.Components[Comp] , Nome );
      if IsPublishedProp( componet.Components[Comp],'DataSource') then begin
         ds := TDataSource(GetObjectProp( componet.Components[Comp],'DataSource'));
         if IsPublishedProp( componet.Components[Comp] ,'DataField') then begin
            fn := GetStrProp( componet.Components[Comp] ,'DataField');
            if (fn = Nome) and
            (TDBEdit( componet.Components[Comp]).DataSource.State in [dsEdit, dsInsert]) Then Begin
               TDBEdit( componet.Components[Comp]).SetFocus;
            end;
         end;
      end;
   end;
end;

//INDEX FUNCOES INI AUXILIARES REDE INTERNET STRINGS
procedure Insere(var sString: string; sSubString: string; iwPos: word);
var
   iwCont: word;
   iwLen: word;
begin
   iwLen := Length(sString);
   if (iwLen < (iwPos + Length(sSubString))) then
   begin
      SetLength(sString, iwPos + Length(sSubString));
      for iwCont := iwLen + 1 to Length(sString) do
         sString[iwCont] := ' ';
   end;

   for iwCont := 1 to Length(sSubString) do
      sString[iwPos + (iwCont - 1)] := sSubString[iwCont];
end;

function Negrito(value: string): string;
begin
   Result := #27#69 + value + #27#70;
end;

function Sublinha(value: string): string;
begin
   //   Result := #27#45 + value + #27#45;
   Result := #45 + value + #45;
end;

function FormatoMoedaCur(rdValor: double): string;
var
   sInteiro: string;
   sFracao: string;
   iwCont: word;
   iwVirgula: word;
begin
   Result := FormatFloat('R$ #,,,,0.00', rdValor);
end; //}

function FormatoMoedaFloat(rdValor: double): string;
var
   sInteiro: string;
   sFracao: string;
   iwCont: word;
   iwVirgula: word;
begin
   Result := FormatFloat('#,,,,0.00', rdValor);
end; //}


function Espaco(iwNumEspaco: word): string;
var
   sString: string;
   iwCont: word;
begin
   SetLength(sString, iwNumEspaco);
   for iwCont := 1 to Length(sString) do
      sString[iwCont] := ' ';
   Result := sString;
end;

function AlinharDireita(sString: string; iwPosicoes: word): string;
var
   sStringAux: string;
   iwCont: word;
begin
   sStringAux := Espaco(iwPosicoes);
   for iwCont := 1 to Length(sString) do
      sStringAux[iwPosicoes - (Length(sString) - iwCont)] := sString[iwCont];
   Result := sStringAux;
end;

function Justifica(mCad: string; mMAx: integer): string;
var
   mPos, mPont, mTam, mNr, mCont: integer;
   mStr: string;
begin
   mTam := Length(mCad);
   if mTam >= mMax then
      Result := copy(mCad, 1, mMax)
   else
      mStr := '';

   mCont := 0;
   mPont := 1;
   mNr := mMax - mTam;
   while mCont < mNr do
   begin
      mPos := pos(mStr, copy(mCad, mPont, 100));
      if mPos = 0 then
      begin
         mStr := mStr + ' ';
         mPont := 1;
         continue;
      end
      else
      begin
         mCont := mCont + 1;
         Insert(' ', mCad, mPos + mPont);
         mPont := mPont + mPos + length(mStr);
      end;
      Result := mCad;
   end;
end;

//LIMITA TEXTO ATE O TAMNHO MAXIMO OU ADCIONA ESPACOS EM BRANCO AO FINAL NO TEXTO ATE COMPLETA O TAMANHO...

function TamanhoMax(mCad: string; mMAx: integer): string;
var
   mTam, mNr, mCont: integer;
   mStr: string;
begin
   mTam := Length(mCad);
   if mTam >= mMax then
      Result := copy(mCad, 1, mMax)
   else
      mStr := '';

   mCont := 0;
   mNr := mMax - mTam;
   while mCont < mNr do
   begin
      mCont := mCont + 1;
      Insert(' ', mCad, mTam + 1);
      Result := mCad;
   end;
end;

function Replicar(sString: string; iwQuantidade: word): string;
var
   iwCont: word;
   sResult: string;
begin
   for iwCont := 1 to iwQuantidade do
      sResult := Concat(sResult, sString);
   Result := sResult;
end;

function Centraliza(sString: string; iwNumEspaco: word): string;
var
   iEspaco: Integer;
begin
   if Length(sString) > iwNumEspaco then
   begin
      Result := sString;
      exit;
   end;
   iEspaco := Trunc((iwNumEspaco - Length(sString)) / 2);
   Result := Espaco(iEspaco) + sString;
end;
//fim funcoes impressao---------------------------------------------------------

function ZeroEsquerda(const I: integer; const Casas: byte): string; //FUNCAO ADCIONA ZERO A ESQUERDA
var
   Ch: Char;
begin
   Result := IntToStr(I);
   if Length(Result) > Casas then
   begin
      Ch     := '*';
      Result := '';
   end
   else
      Ch := '0';
   while Length(Result) < Casas do
      Result := Ch + Result;
end;

function ZeroEsquerda64(const I: Int64; const Casas: byte): string; //FUNCAO ADCIONA ZERO A ESQUERDA
var
   Ch: Char;
begin
   Result := IntToStr(I);
   if Length(Result) > Casas then
   begin
      Ch := '*';
      Result := '';
   end
   else
      Ch := '0';
   while Length(Result) < Casas do
      Result := Ch + Result;
end;

function ZeroEsquerdafloat(const I: Double; const Casas: byte): string; //FUNCAO ADCIONA ZERO A ESQUERDA
var
   Ch: Char;
begin
   Result := FloatToStr(I);
   if Length(Result) > Casas then
   begin
      Ch := '*';
      Result := '';
   end
   else
      Ch := '0';
   while Length(Result) < Casas do
      Result := Ch + Result;
end;

function NomeComputador: string;
var
   nome: PAnsiChar;
   i: Cardinal;
begin
   Nome := AllocMem(255);
   for i := 0 to 255 do
      Nome[i] := ' ';
   GetComputerName(Nome, i);
   Result := Copy(Nome, 1, i);
end;

function SoNumeros(s: string): string;
var
   i: Integer;
begin
   Result := '';
   for i := 1 to length(s) do
   begin
      if (s[i] in ['0'..'9']) then
      begin
         Result := Result + copy(s, i, 1);
      end;
   end;
end;

//FUNCAO TESTE SE A SOMENTE NUMEROS EM UMA STRING
function SoNumero(s: string): Boolean;
var
   i: Integer;
begin
   Result := True;
   for i := 1 to length(s) do
   begin
      if not (s[i] in ['0'..'9', ',', '.']) then
      begin
         Result := False;
         exit;
      end;
   end;
end;


function extenso(valor: real): string;
var
   Centavos, Centena, Milhar, Texto, msg: string;
const
   Unidades: array[1..9] of string = ('Um', 'Dois', 'Tres', 'Quatro', 'Cinco', 'Seis', 'Sete', 'Oito', 'Nove');
   Dez: array[1..9] of string = ('Onze', 'Doze', 'Treze', 'Quatorze', 'Quinze', 'Dezesseis', 'Dezessete',
      'Dezoito', 'Dezenove');
   Dezenas: array[1..9] of string = ('Dez', 'Vinte', 'Trinta', 'Quarenta', 'Cinquenta', 'Sessenta', 'Setenta',
      'Oitenta', 'Noventa');
   Centenas: array[1..9] of string = ('Cento', 'Duzentos', 'Trezentos', 'Quatrocentos', 'Quinhentos',
      'Seiscentos', 'Setecentos', 'Oitocentos', 'Novecentos');

   function ifs(Expressao: Boolean; CasoVerdadeiro, CasoFalso: string): string;
   begin
      if Expressao then
         Result := CasoVerdadeiro
      else
         Result := CasoFalso;
   end;

   function MiniExtenso(trio: string): string;
   var
      Unidade, Dezena, Centena: string;
   begin
      Unidade := '';
      Dezena := '';
      Centena := '';
      if (trio[2] = '1') and (trio[3] <> '0') then
      begin
         Unidade := Dez[strtoint(trio[3])];
         Dezena := '';
      end
      else
      begin
         if trio[2] <> '0' then
            Dezena := Dezenas[strtoint(trio[2])];
         if trio[3] <> '0' then
            Unidade := Unidades[strtoint(trio[3])];
      end;
      if (trio[1] = '1') and (Unidade = '') and (Dezena = '') then
         Centena := 'cem'
      else if trio[1] <> '0' then
         Centena := Centenas[strtoint(trio[1])]
      else
         Centena := '';
      Result := Centena + ifs((Centena <> '') and ((Dezena <> '') or (Unidade <> '')), ' e ', '')
         + Dezena + ifs((Dezena <> '') and (Unidade <> ''), ' e ', '') + Unidade;
   end;

begin
   if (valor > 999999.99) or (valor < 0) then
   begin
      msg := 'O valor está fora do intervalo permitido.';
      msg := msg + 'O número deve ser maior ou igual a zero e menor que 999.999,99.';
      msg := msg + ' Se não for corrigido o número não será escrito por extenso.';
      ShowMessage(msg);
      Result := '';
      exit;
   end;
   if valor = 0 then
   begin
      Result := '';
      Exit;
   end;
   Texto := formatfloat('000000.00', valor);
   Milhar := MiniExtenso(Copy(Texto, 1, 3));
   Centena := MiniExtenso(Copy(Texto, 4, 3));
   Centavos := MiniExtenso('0' + Copy(Texto, 8, 2));
   Result := Milhar;
   if Milhar <> '' then
      if copy(texto, 4, 3) = '000' then
         Result := Result + ' Mil Reais'
      else
         Result := Result + ' Mil, ';

   if (((copy(texto, 4, 2) = '00') and (Milhar <> '')
      and (copy(texto, 6, 1) <> '0')) or (centavos = ''))
      and (Centena <> '') then
      Result := Result + '';

   if (Milhar + Centena <> '') then
      Result := Result + Centena;
   if (Milhar = '') and (copy(texto, 4, 3) = '001') then
      Result := Result + ' Real'
   else if (copy(texto, 4, 3) <> '000') then
      Result := Result + ' Reais';
   if Centavos = '' then
   begin
      Result := Result + '.';
      Exit;
   end
   else
   begin
      if Milhar + Centena = '' then
         Result := Centavos
      else
         Result := Result + ', e ' + Centavos;
      if (copy(texto, 8, 2) = '01') and (Centavos <> '') then
         Result := Result + ' Centavo.'
      else
         Result := Result + ' Centavos.';
   end;
end;

function Acesso: Boolean;
var arquivo: TextFile;
    NomeArquivo, Texto: string;
begin
//
end;


//FUNCOES PARA INTERNET---------------------------------------------------------
//Ex: MensagemAtencao( TipoConexao() );
function TipoConexao: string;
var
   flags: dword;
   res: string;
   con: Boolean;
begin
   con := InternetGetConnectedState(@flags, 0); //uses Wininet
   if con then
   begin
      res := 'Internet Ativa';
      if (flags and INTERNET_CONNECTION_LAN) = INTERNET_CONNECTION_LAN then
         res := res + ' - Conexão por LAN';
      if (flags and INTERNET_CONNECTION_PROXY) = INTERNET_CONNECTION_PROXY then
         res := res + ' - Conexão por PROXY';
      if (flags and INTERNET_CONNECTION_MODEM) = INTERNET_CONNECTION_MODEM then
         res := res + ' - Conexão por MODEM';
      if (flags and INTERNET_CONNECTION_MODEM_BUSY) = INTERNET_CONNECTION_MODEM_BUSY then
         res := 'MODEM Ocupado!';
      Result := res;
   end
   else //}
      res := 'Não conectado!';
end;

//Ex: ConexaoAtiva();
function ConexaoAtiva: Boolean;
var
   flags: dword;
begin
   Result := InternetGetConnectedState(@flags, 0);
end;

//Ex: TestaConexao();
procedure TestaConexao();
begin
   if (not ConexaoAtiva()) then
   begin
      MensagemAtencao('A Internet não está Ativa!');
      exit;
   end;
end;

   function IsWin95: boolean;
   var
      OS: TOSVersionInfo;
   begin
      ZeroMemory(@OS, SizeOf(OS));
      OS.dwOSVersionInfoSize := SizeOf(OS);
      GetVersionEx(OS);
      Result := (OS.dwMajorVersion >= 4) and (OS.dwMinorVersion = 0) and
         (OS.dwPlatformId = VER_PLATFORM_WIN32_WINDOWS);
   end;

   function FuncAvail(_dllname, _funcname: string; var _p: pointer): boolean;
   var
      _lib: tHandle;
   begin
      Result := false;
      if LoadLibrary(PChar(_dllname)) = 0 then
         exit;

      _lib := GetModuleHandle(PChar(_dllname));

      if _lib <> 0 then begin
         _p := GetProcAddress(_lib, PChar(_funcname));
         if _p <> nil then
            Result := true;
      end;
   end;

procedure verifica_conexao_internet;
var
   InetIsOffline: function(dwFlags: DWORD): BOOL; stdcall;
   Lib: string;
begin
   if (IsWin95) then
      Lib := 'SHELL32.DLL'
   else
      Lib := 'URL.DLL';

   if FuncAvail(Lib, 'InetIsOffline', @InetIsOffline) then begin
      if (InetIsOffLine(0)) then begin
         ShowMessage('Este computador não está conectado à Internet.');
         abort;
      end else
         ShowMessage('Conexão à Internet ok!');
   end;
end;

Function GetIP() : string;  //Declare a Winsock na clausula uses da unit
var
   WSAData: TWSAData;
   HostEnt: PHostEnt;
   Name:string;
begin
   WSAStartup(2, WSAData);
   SetLength(Name, 255);
   Gethostname(PChar(Name), 255);
   SetLength(Name, StrLen(PChar(Name)));
   HostEnt := gethostbyname(PChar(Name));
   with HostEnt^ do begin
      Result := Format('%d.%d.%d.%d',
      [Byte(h_addr^[0]),Byte(h_addr^[1]),
      Byte(h_addr^[2]),Byte(h_addr^[3])]);
   end;
   WSACleanup;
end;
//FUNCOES PARA INTERNET---------------------------------------------------------

function TiraPontos(sString: string): string;
var
   i: Integer;
   sStrin: string;
begin
   sStrin := '';
   for i := 1 to Length(sString) do begin
      if sString[i] in ['0'..'9'] then
         sStrin := sStrin + sString[i];
   end;
   Result := sStrin;
end;

function ParseName(Str: string; Separator: string): String;
begin
  Result := Copy(Str, 0, Pos(Separator, Str)-1);
end;

function ParseValue(Str: string; Separator: string): String;
begin
  Result := Copy(Str, Pos(Separator, Str) + Length(Separator), Length(Str));
end;


//Retorna a última letra de uma string
//retornar a última palavra de uma string
function StringUltimaPalavra(const Text: String): String;
begin
  with TStringList.Create do
  try
    Delimiter := ' ';
    DelimitedText := Text;
    Result := Strings[Count - 1];
  finally
    Free;
  end;
end;

function StringPesqLetra(Busca,Text : string) : Boolean; //Pesquisa um caractere à direita da string,
var n : Integer;
begin
Result := False;
   for n := length(Text) downto 1 do begin
      if Copy(Text,n,1) = Busca then begin
         break;
      end;
   Result := True;
   end;
end;

function StrRemoveEspacos( str : string ) : string;
begin
  Result := StringReplace(str,' ','',[rfReplaceAll]);
end;

//StrRemoveCaractereEspecialAspas( '[' );
function StrRemoveCaractereEspecialAspas( Str : string ) : string;
begin
   Result := StringReplace(str,Chr(39),'',[rfReplaceAll]);
end;

//EX: StrRemoveCaractereColchetes(variavel);
function StrRemoveCaractereColchetes( Str : string ) : string;
begin
   Result := StringReplace(str,'[','',[rfReplaceAll]);
   Result := StringReplace(Result,']','',[rfReplaceAll]);
end;

//Função para eliminar espaços em branco duplicados e caracteres especiais de uma string
function AjustaCadastroDescricao(Str: string): string;
const
   ComAcento = '1234567890àâêôûãõáéíóúçüÀÂÊÔÛÃÕÁÉÍÓÚÇÜ*/-+<>;:?@#$%&{}[]()'+Chr(39);
   SemAcento = '1234567890aaeouaoaeioucuAAEOUAOAEIOUCU                    ';
var
   iCont: Integer;
   sStr: string;
   x: Integer;
begin
   sStr := Str;
   //o for abaixo, retira os acentos e caracteres especiais
   for x := 1 to Length(sStr) do
      if Pos(sStr[x], ComAcento) <> 0 then
         sStr[x] := SemAcento[Pos(sStr[x], ComAcento)];
   //a rotina abaixo retira os espaços extras
   iCont := 1;
   while iCont <= Length(sStr) do
   begin
      if sStr[iCont] = #32 then
      begin
         Inc(iCont);
         while sStr[iCont] = #32 do
            Delete(sStr, iCont, 1);
      end;
      Inc(iCont);
   end;

   Result := sStr;
end;

function SubstituiStr(S, Localizar, Substituir: string): string;
var
   Retorno: string;
   Posicao: Integer;
begin
   Retorno := S;
   //Obtendo a posição inicial da substring Localizar na string Localizar.
   Posicao := Pos(Localizar, Retorno);
   if Posicao <> 0 then // Verificando se a substring Localizar existe.
   begin
      // Excluindo a Localizar.
      Delete(Retorno, Posicao, Length(Localizar));
      // Inserindo a string do parâmetro Substituir
      Insert(Substituir, Retorno, Posicao);
   end;
   Result := Retorno;
end;

//INDEX FUNCOES INI AUXILIARES REDE INTERNET STRINGS FORMULARIOS DIRETORIO VARIAVEIS
//VersaoArquivo('C:\SicadTemp\prjClient.exe');
function VersaoArquivo(const Filename: string): string; //Retorna a versão do executavel
type
   TVersionInfo = packed record
      Dummy: array[0..7] of Byte;
      V2, V1, V4, V3: Word;
   end;
var
   Zero, Size: Cardinal;
   Data: Pointer;
   VersionInfo: ^TVersionInfo;
begin
   Size := GetFileVersionInfoSize(Pointer(Filename), Zero);
   if Size = 0 then
      Result := '\'
   else
   begin
      GetMem(Data, Size);
      try
         GetFileVersionInfo(Pointer(Filename), 0, Size, Data);
         VerQueryValue(Data, '\\\', Pointer(VersionInfo), Size);
         Result := Format('%d.%d.%d.%d', [VersionInfo.V1, VersionInfo.V2, VersionInfo.V3, VersionInfo.V4]);
      finally
         FreeMem(Data);
      end;
   end;
end;

//A função abaixo retorna o tamanho do arquivo, ou -1 se o arquivo não for encontrado
function TamanhoArquivo(const FileName: string): integer;
var
   SR: TSearchRec;
   I: integer;
begin
   I := FindFirst(FileName, faArchive, SR);
   try
      if I = 0 then
         Result := (SR.Size) //VALOR EM Byte
      else
         Result := -1;
   finally
      //    FindClose(SR);
   end;
end;


function MensagemExcluir: boolean;
begin
   Result := (MessageBoxEx(Application.Handle, 'Tem certeza que deseja EXCLUIR este registro?', CaptionSistema,
      MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION + MB_SYSTEMMODAL, 1046) = IDYES);
end;

function MensagemSimNao(Mensagem: string; DefBut: Integer = 1): Boolean;
begin
   MessageBeep(1000);
   if DefBut = 1 then
      Result := id_yes = (MessageBoxEx(Application.Handle, PChar(Mensagem), captionSistema, MB_YESNO +
         MB_DEFBUTTON1 + MB_ICONQUESTION + MB_SYSTEMMODAL, 1046))
   else if DefBut = 2 then
      Result := id_yes = (MessageBoxEx(Application.Handle, PChar(Mensagem), captionSistema, MB_YESNO +
         MB_DEFBUTTON2 + MB_ICONQUESTION + MB_SYSTEMMODAL, 1046));
end;

function MensagemSimNaoCancelar(Mensagem: string): Integer;
begin
//   MessageBeep(1000);
   Result := (MessageBoxEx(Application.Handle, PChar(Mensagem), captionSistema, MB_YESNOCANCEL + MB_DEFBUTTON3 +
      MB_ICONQUESTION + MB_SYSTEMMODAL, 1046));
end;

procedure MensagemPare(Mensagem: string);
begin
//   MessageBeep(1000);
   MessageBoxEx(Application.Handle, PChar(Mensagem), captionSistema, MB_OK + MB_ICONSTOP + MB_TOPMOST, 1046);
end;

procedure MensagemAtencao(Mensagem: string);
begin
//   MessageBeep(1000);
//   MessageBeep(1000);
   MessageBoxEx(Application.Handle, PChar(Mensagem), Pchar(Application.Name), MB_OK + MB_ICONWARNING +
      MB_SYSTEMMODAL, 1046);
end;


end.
