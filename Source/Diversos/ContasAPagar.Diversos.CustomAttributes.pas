unit ContasAPagar.Diversos.CustomAttributes;

interface

uses
  Rtti, System.TypInfo;

type
  TEntidade = class(TObject)
  end;

  ATabela = class(TCustomAttribute)
  private
    FNomeTabela: string;
  public
    constructor Create(nomeTabela: string);
    property NomeTabela:string  read FNomeTabela write FNomeTabela;
  end;

  ACampo = class(TCustomAttribute)
  private
    FNomeDB: String;
    FNomeDisplay: String;
    FSomenteLitura: Boolean;
  public
    constructor Create(nomeDB: String;ReadOnly:Boolean = False);
    property NomeDB: String read FNomeDB write FNomeDB;
    property SomenteLitura: Boolean read FSomenteLitura write FSomenteLitura;
  end;

  APK = class(TCustomAttribute)
  end;

  ANotNull = class(TCustomAttribute)
  end;

  AFormato = class(TCustomAttribute)
  private
    FTamanho: integer;
    FPrecisao: integer;
    FMascara: string;
    function getTamanhoTotal: integer;
  public
    property Tamanho: integer read FTamanho write FTamanho;
    property Precisao: integer read FPrecisao write FPrecisao;
    property Mascara: string read FMascara write FMascara;
    function getMascaraNumerica: String;
    constructor Create(tamanho: integer; precisao: integer = 0);overload;
    constructor Create(mascara: string);overload;
  end;

implementation

{ AFormato }

constructor AFormato.Create(tamanho, precisao: integer);
begin
  FMascara:=mascara;
end;

constructor AFormato.Create(mascara: string);
begin
  FTamanho:=tamanho;
  FPrecisao:=precisao;
end;

function AFormato.getMascaraNumerica: String;
var
  sTamanho, sPrecisao: string;
begin
  sTamanho  :=StringOfChar('0',FTamanho-FPrecisao);
  sPrecisao :=StringOfChar('0',FPrecisao);

  Result:=sTamanho+'.'+sPrecisao;
end;

function AFormato.getTamanhoTotal: integer;
begin
  Result:=FTamanho-FPrecisao;
end;

{ ACampo }

constructor ACampo.Create(nomeDB: String;ReadOnly:Boolean = False);
begin
  FNomeDB:=nomeDB;
  FSomenteLitura := ReadOnly;
end;

{ ATabela }

constructor ATabela.Create(nomeTabela: string);
begin
  FNomeTabela:=nomeTabela;
end;

end.

