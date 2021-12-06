unit ContasAPagar.Model.Entity.Cartoes;

interface

uses
  System.Generics.Collections,
  Data.DB,
  ContasAPagar.Diversos.CustomAttributes,
  SysUtils;

type
  [ATabela('Cartoes')]
  TCartoes = class
  private
    FIDCartoes: string;
    FDescricao: String;
  public
    [APK('IdCartoes')]
    [ACampo('IdCartoes',False,True) , ANotNull, AFormato(4)]
    property IdCartoes: string read FIDCartoes write FIDCartoes;
    [ACampo('DESCRICAO'), AFormato(100)]
    property Descricao: String read FDescricao write FDescricao;
  end;

implementation

{ TCartoes }

end.