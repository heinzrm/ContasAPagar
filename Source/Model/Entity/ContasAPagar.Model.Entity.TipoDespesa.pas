unit ContasAPagar.Model.Entity.TipoDespesa;

interface

uses

  Data.DB,
  ContasAPagar.Diversos.CustomAttributes,
  SysUtils;

type
  [ATabela('TipoDespesas')]
  TTipoDespesas = class
  private
    FIDTipoDepesa : string;
    FDescricao    : String;
  public
    [APK('IdTipoDespesas')]
    [ACampo('IdTipoDespesas',False,True) , ANotNull, AFormato(4)]
    property IdTipoDespesa: string read FIDTipoDepesa write FIDTipoDepesa;
    [ACampo('DESCRICAO'), AFormato(100)]
    property Descricao: String read FDescricao write FDescricao;
  end;

implementation

end.
