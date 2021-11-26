program ContasAPagar;

uses
  System.StartUpCopy,
  FMX.Forms,
  ContasAPagar.View.Principal in 'Source\View\ContasAPagar.View.Principal.pas' {frmPrincipal},
  ContasAPagar.Model.Entity.Categoria in 'Source\Model\Entity\ContasAPagar.Model.Entity.Categoria.pas',
  ContasAPagar.Model.Entity.Cartoes in 'Source\Model\Entity\ContasAPagar.Model.Entity.Cartoes.pas',
  ContasAPagar.View.ModeloPrincipal in 'Source\View\ContasAPagar.View.ModeloPrincipal.pas' {frmModelo},
  ContasAPagar.View.Cartoes in 'Source\View\ContasAPagar.View.Cartoes.pas' {frmCartoes},
  ContasAPagar.Diversos.Procedimentos in 'Source\Diversos\ContasAPagar.Diversos.Procedimentos.pas',
  ContasAPagar.Diversos.LoadLayout in 'Source\Diversos\ContasAPagar.Diversos.LoadLayout.pas',
  ContasAPagar.View.Entradas in 'Source\View\ContasAPagar.View.Entradas.pas' {frmEntrada},
  ContasAPagar.View.DashBoard in 'Source\View\ContasAPagar.View.DashBoard.pas' {frmDashBoard},
  ContasAPagar.View.Despesas in 'Source\View\ContasAPagar.View.Despesas.pas' {frmDespesas},
  ContasAPagar.Conexao.Modulo.Principal in 'Source\Conexao\ContasAPagar.Conexao.Modulo.Principal.pas' {dmPrincipal: TDataModule},
  ContasAPagar.Diversos.Conexao in 'Source\Diversos\ContasAPagar.Diversos.Conexao.pas',
  ContasAPagar.Diversos.Variaveis in 'Source\Diversos\ContasAPagar.Diversos.Variaveis.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TdmPrincipal, dmPrincipal);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
