unit ContasAPagar.Model.Entity.Despesa;

interface

uses
  ContasAPagar.Diversos.CustomAttributes;

type
  [ATabela('Despesa')]
  TDespesa = class
  private
    FIdDespesa      : string;
    FDescricao      : string;
    FIdTipoDespesas : string;
    FDataVencimento : TDateTime;
    FDataPagamento  : TDateTime;
    FValor          : Currency;
    FIdCategoria    : string;
    FIdCartoes      : string;
  public
    [APK('IdDespesa')]
    [ACampo('IdDespesa',False,True) , ANotNull, AFormato(4)]
    property IdDespesa: string read FIdDespesa write FIdDespesa;
    [AOrderBy('Descricao')]
    [ACampo('Descricao'), AFormato(100)]
    property Descricao: string read FDescricao write FDescricao;
    [ACampo('IdTipoDespesas',False,False) , ANotNull, AFormato(4)]
    property IdTipoDespesas: string read FIdTipoDespesas write FIdTipoDespesas;
    [ACampo('IdCartoes',False,False) , ANotNull, AFormato(4)]
    property IdCartoes: string read FIdCartoes write FIdCartoes;
    [ACampo('DataPagamento'), AFormato(100)]
    property DataPagamento: TDateTime  read FDataPagamento write FDataPagamento;
    [ACampo('DataVencimento'), AFormato(100)]
    property DataVencimento: TDateTime read FDataVencimento write FDataVencimento;
    [ACampo('Valor'), AFormato(100)]
    property Valor: Currency read FValor write FValor;
    [ACampo('IdCategoria',False,False) , ANotNull, AFormato(4)]
    property IdCategoria: string  read FIdCategoria write FIdCategoria;
  end;

implementation

end.
