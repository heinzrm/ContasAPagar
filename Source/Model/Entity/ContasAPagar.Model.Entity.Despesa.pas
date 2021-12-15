unit ContasAPagar.Model.Entity.Despesa;

interface

type
  TDespesa = class
  private
    FIdDespesa: string;
    FDescricao: string;
    FIdTipoDespesas: string;
    FDataVencimento: TDateTime;
    FDataPagamento: TDateTime;
    FValor: Currency;
    FIdCategoria: string;
  public
    property IdDespesa: string read FIdDespesa write FIdDespesa;
    property Descricao: string read FDescricao write FDescricao;
    property IdTipoDespesas: string read FIdTipoDespesas write FIdTipoDespesas;
    property DataPagamento: TDateTime  read FDataPagamento write FDataPagamento;
    property DataVencimento: TDateTime read FDataVencimento write FDataVencimento;
    property Valor: Currency read FValor write FValor;
    property IdCategoria: string  read FIdCategoria write FIdCategoria;
  end;
implementation

end.
