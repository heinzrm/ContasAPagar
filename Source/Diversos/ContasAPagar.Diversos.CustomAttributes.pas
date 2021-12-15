unit ContasAPagar.Diversos.CustomAttributes;

interface

uses
  Rtti;

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
    FNomeDB        : String;
    FSomenteLitura : Boolean;
    FCondicaoWhere : Boolean;
  public
    constructor Create(nomeDB: String;ReadOnly:Boolean = False; pCondicaoWhere: Boolean = False);
    property NomeDB         : String  read FNomeDB        write FNomeDB;
    property SomenteLeitura : Boolean read FSomenteLitura write FSomenteLitura;
    property CondicaoWhere  : Boolean read FCondicaoWhere write FCondicaoWhere;
  end;

  APK = class(TCustomAttribute)
  private
    FChavePrimaria: string;
  public
    constructor Create(pChavePrimaria: string);
    property ChavePrimaria : string  read FChavePrimaria write FChavePrimaria;
  end;

  ANotNull = class(TCustomAttribute)
  end;

  AFormato = class(TCustomAttribute)
  private
    FTamanho  : integer;
    FPrecisao : integer;
    FMascara  : string;
  public
    property Tamanho  : integer read FTamanho  write FTamanho;
    property Precisao : integer read FPrecisao write FPrecisao;
    property Mascara  : string  read FMascara  write FMascara;
    function getMascaraNumerica: String;
    constructor Create(tamanho: integer; precisao: integer = 0);overload;
    constructor Create(mascara: string);overload;
  end;

implementation

{ AFormato }

constructor AFormato.Create(tamanho, precisao: integer);
begin
  FMascara := mascara;
end;

constructor AFormato.Create(mascara: string);
begin
  FTamanho  := tamanho;
  FPrecisao := precisao;
end;

function AFormato.getMascaraNumerica: String;
var
  sTamanho, sPrecisao: string;
begin
  sTamanho  := StringOfChar('0',FTamanho-FPrecisao);
  sPrecisao := StringOfChar('0',FPrecisao);

  Result := sTamanho+'.'+sPrecisao;
end;

{ ACampo }

constructor ACampo.Create(nomeDB: String;ReadOnly:Boolean = False; pCondicaoWhere: Boolean = False);
begin
  FNomeDB        := nomeDB;
  FSomenteLitura := ReadOnly;
  FCondicaoWhere := pCondicaoWhere;
end;

{ ATabela }

constructor ATabela.Create(nomeTabela: string);
begin
  FNomeTabela := nomeTabela;
end;

{ APK }

constructor APK.Create(pChavePrimaria: string);
begin
  FChavePrimaria := pChavePrimaria;
end;

end.

