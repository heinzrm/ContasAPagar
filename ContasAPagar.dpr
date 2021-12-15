program ContasAPagar;

uses
  System.StartUpCopy,
  FMX.Forms,
  ContasAPagar.View.Cartoes in 'Source\View\ContasAPagar.View.Cartoes.pas' {frmCartoes},
  ContasAPagar.View.DashBoard in 'Source\View\ContasAPagar.View.DashBoard.pas' {frmDashBoard},
  ContasAPagar.View.ModeloPrincipal in 'Source\View\ContasAPagar.View.ModeloPrincipal.pas' {frmModelo},
  ContasAPagar.View.Principal in 'Source\View\ContasAPagar.View.Principal.pas' {frmPrincipal},
  ContasAPagar.View.Configuracoes in 'Source\View\ContasAPagar.View.Configuracoes.pas' {frmConfiguracoes},
  ContasAPagar.Diversos.LoadLayout in 'Source\Diversos\ContasAPagar.Diversos.LoadLayout.pas',
  ContasAPagar.Diversos.Enumerados in 'Source\Diversos\ContasAPagar.Diversos.Enumerados.pas',
  ContasAPagar.Model.Entity.Cartoes in 'Source\Model\Entity\ContasAPagar.Model.Entity.Cartoes.pas',
  ContasAPagar.Diversos.CustomAttributes in 'Source\Diversos\ContasAPagar.Diversos.CustomAttributes.pas',
  ContasAPagar.Diversos.Procedimentos in 'Source\Diversos\ContasAPagar.Diversos.Procedimentos.pas',
  ContasAPagar.Diversos.RTTI in 'Source\Diversos\ContasAPagar.Diversos.RTTI.pas',
  ContasAPagar.Controller.Cartoes in 'Source\Controller\ContasAPagar.Controller.Cartoes.pas',
  ContasAPagar.Interfaces.Controller.Cartoes in 'Source\Interfaces\ContasAPagar.Interfaces.Controller.Cartoes.pas',
  ContasAPagar.Interfaces.Model.Crud in 'Source\Interfaces\ContasAPagar.Interfaces.Model.Crud.pas',
  ContasAPagar.Factory.FactoryPadrao in 'Source\Factory\ContasAPagar.Factory.FactoryPadrao.pas',
  ContasAPagar.Factory.Interfaces in 'Source\Factory\ContasAPagar.Factory.Interfaces.pas',
  ContasAPagar.Model.Conexao in 'Source\Model\ContasAPagar.Model.Conexao.pas',
  ContasAPagar.Model.Cartoes in 'Source\Model\ContasAPagar.Model.Cartoes.pas',
  ContasAPagar.Dao.Generico in 'Source\Dao\ContasAPagar.Dao.Generico.pas',
  ContasAPagar.Interfaces.Dao.Generico in 'Source\Interfaces\ContasAPagar.Interfaces.Dao.Generico.pas',
  ContasAPagar.Diversos.Conexao in 'Source\Diversos\ContasAPagar.Diversos.Conexao.pas',
  ContasAPagar.View.TipoReceitas in 'Source\View\ContasAPagar.View.TipoReceitas.pas' {frmReceitas},
  ContasAPagar.Model.Entity.TipoReceita in 'Source\Model\Entity\ContasAPagar.Model.Entity.TipoReceita.pas',
  ContasAPagar.Model.Receitas in 'Source\Model\ContasAPagar.Model.Receitas.pas',
  ContasAPagar.Model.Entity.TipoDespesa in 'Source\Model\Entity\ContasAPagar.Model.Entity.TipoDespesa.pas',
  ContasAPagar.View.TipoDespesas in 'Source\View\ContasAPagar.View.TipoDespesas.pas' {frmTipoDespesas},
  ContasAPagar.Model.Despesas in 'Source\Model\ContasAPagar.Model.Despesas.pas',
  ContasAPagar.Model.Entity.Despesa in 'Source\Model\Entity\ContasAPagar.Model.Entity.Despesa.pas',
  ContasAPagar.Model.Entity.Categoria in 'Source\Model\Entity\ContasAPagar.Model.Entity.Categoria.pas',
  ContasAPagar.View.Categoria in 'Source\View\ContasAPagar.View.Categoria.pas' {frmCategoria},
  ContasAPagar.Model.Categoria in 'Source\Model\ContasAPagar.Model.Categoria.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmCategoria, frmCategoria);
  Application.Run;
end.
