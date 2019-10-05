program PDV;

uses
  Vcl.Forms,
  Login in 'Login.pas' {FrmLogin},
  MenuPrincipal in 'MenuPrincipal.pas' {FrmMenuPrincipal},
  Usuarios in 'cadastros\Usuarios.pas' {FrmUsuarios},
  Funcionarios in 'cadastros\Funcionarios.pas' {FrmFuncionarios},
  Cargos in 'cadastros\Cargos.pas' {frmCargos},
  Conexao in 'Conexao.pas' {dm: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.CreateForm(Tdm, dm);
  Application.Run;
end.
