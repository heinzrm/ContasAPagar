program ContasAPagar;

uses
  System.StartUpCopy,
  FMX.Forms,
  ContasAPagar.View.Principal in 'Source\View\ContasAPagar.View.Principal.pas' {frmPrincipal},
  ContasAPagar.Model.Entity.Categoria in 'Source\Model\Entity\ContasAPagar.Model.Entity.Categoria.pas',
  ContasAPagar.Model.EntityCartoes in 'Source\Model\Entity\ContasAPagar.Model.EntityCartoes.pas',
  ContasAPagar.View.ModeloPrincipal in 'Source\View\ContasAPagar.View.ModeloPrincipal.pas' {frmModelo},
  ContasAPagar.View.Cartoes in 'Source\View\ContasAPagar.View.Cartoes.pas' {frmCartoes},
  ContasAPagar.Diversos.Procedimentos in 'Source\Diversos\ContasAPagar.Diversos.Procedimentos.pas',
  ContasAPagar.Diversos.LoadLayout in 'Source\Diversos\ContasAPagar.Diversos.LoadLayout.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
