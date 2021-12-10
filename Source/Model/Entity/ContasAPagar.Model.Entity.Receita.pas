unit ContasAPagar.Model.Entity.Receita;

interface

uses
  System.Generics.Collections,
  Data.DB,
  ContasAPagar.Diversos.CustomAttributes,
  SysUtils;

type
  [ATabela('Receitas')]
  TReceitas = class
  private
    FIDReceita: string;
    FDescricao: String;
  public
    [APK('IdReceita')]
    [ACampo('IdReceita',False,True) , ANotNull, AFormato(4)]
    property IdReceita: string read FIDReceita write FIDReceita;
    [ACampo('DESCRICAO'), AFormato(100)]
    property Descricao: String read FDescricao write FDescricao;
  end;

implementation

{ TCartoes }

end.
