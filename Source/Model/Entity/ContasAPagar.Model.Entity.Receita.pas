unit ContasAPagar.Model.Entity.Receita;

interface

uses
  ContasAPagar.Diversos.CustomAttributes;

type
  [ATabela('Receita')]
  TReceita = class
  private
    FIdReceita      : string;
    FIdTipoReceita  : string;
    FDataRecebimento: TDateTime;
    FValor          : Currency;
  public
    [APK('IdReceita')]
    [ACampo('IdReceita',False,True) , ANotNull, AFormato(4)]
    property IdReceita: string read FIdReceita write FIdReceita;
    [ACampo('IdTipoReceita',False,False) , ANotNull, AFormato(4)]
    property IdTipoReceita: string read FIdTipoReceita write FIdTipoReceita;
    [ACampo('DataRecebimento'), AFormato(100)]
    property DataRecebimento: TDateTime  read FDataRecebimento write FDataRecebimento;
    [ACampo('Valor'), AFormato(100)]
    property Valor: Currency read FValor write FValor;
  end;

implementation

end.
