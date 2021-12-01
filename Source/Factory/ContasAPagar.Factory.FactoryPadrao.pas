unit ContasAPagar.Factory.FactoryPadrao;

interface

uses
  ContasAPagar.Factory.Interfaces,
  ContasAPagar.Model.Cartoes,
  ContasAPagar.Model.Interfaces.Cartoes,
  FireDAC.Comp.Client;

type
  TFactory= class(TInterfacedObject, IFactory)
  private
    FConexao: TFDConnection;
  public
    Class function New(pConexao: TFDConnection):IFactory;
    constructor Create(pConexao: TFDConnection);
    function FactoryCartoes: ICartoes;
  end;
implementation

{ TFactory }

constructor TFactory.Create(pConexao: TFDConnection);
begin
  inherited Create;

  FConexao := pConexao;
end;

function TFactory.FactoryCartoes: ICartoes;
begin
  Result := TModelCartoes.New(FConexao);
end;

class function TFactory.New(pConexao: TFDConnection): IFactory;
begin
  Result := Self.Create(pConexao);
end;

end.
