unit ContasAPagar.Model.Entity.Cartoes;

interface

type
  TCartoes = class
  private
    FID: Integer;
    FDescricao: String;
  public
    property Descricao: String read FDescricao write FDescricao;
    property ID: Integer read FID write FID;
  end;

implementation

end.
