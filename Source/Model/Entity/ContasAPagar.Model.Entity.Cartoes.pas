unit ContasAPagar.Model.Entity.Cartoes;

interface

uses
  System.Generics.Collections, Data.DB,
  ContasAPagar.Diversos.CustomAttributes;

type
  [ATabela('Cartoes')]
  TCartoes = class
  private
    FID: Integer;
    FDescricao: String;
  public
    [ACampo('ID',True) , ANotNull, APK, AFormato(4)]
    property ID: Integer read FID write FID;
    [ACampo('DESCRICAO'), AFormato(100)]
    property Descricao: String read FDescricao write FDescricao;
  end;

implementation

end.
