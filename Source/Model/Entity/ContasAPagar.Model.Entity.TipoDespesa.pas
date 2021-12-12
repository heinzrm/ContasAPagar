unit ContasAPagar.Model.Entity.TipoDespesa;

interface

uses
  System.Generics.Collections,
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
    [APK('IdTipoReceita')]
    [ACampo('IdTipoReceita',False,True) , ANotNull, AFormato(4)]
    property IdReceita: string read FIDTipoDepesa write FIDTipoDepesa;
    [ACampo('DESCRICAO'), AFormato(100)]
    property Descricao: String read FDescricao write FDescricao;
  end;

implementation

end.
