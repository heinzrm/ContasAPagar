unit ContasAPagar.Model.Entity.TipoReceita;

interface

uses
  System.Generics.Collections,
  Data.DB,
  ContasAPagar.Diversos.CustomAttributes,
  SysUtils;

type
  [ATabela('TipoReceitas')]
  TTipoReceitas = class
  private
    FIDTipoReceita : string;
    FDescricao     : String;
  public
    [APK('IdTipoReceita')]
    [ACampo('IdTipoReceita',False,True) , ANotNull, AFormato(4)]
    property IdReceita: string read FIDTipoReceita write FIDTipoReceita;
    [ACampo('DESCRICAO'), AFormato(100)]
    property Descricao: String read FDescricao write FDescricao;
  end;

implementation

{ TCartoes }

end.
