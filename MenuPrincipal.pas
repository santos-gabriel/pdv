unit MenuPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus;

type
  TFrmMenuPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    Cadastros1: TMenuItem;
    Produtos1: TMenuItem;
    Fornecedores1: TMenuItem;
    Estoque1: TMenuItem;
    Movimentaes1: TMenuItem;
    Relatrios1: TMenuItem;
    Sair1: TMenuItem;
    Usurios1: TMenuItem;
    Funcionrios1: TMenuItem;
    Cargos1: TMenuItem;
    procedure Usurios1Click(Sender: TObject);
    procedure Funcionrios1Click(Sender: TObject);
    procedure Cargos1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMenuPrincipal: TFrmMenuPrincipal;

implementation

{$R *.dfm}

uses Usuarios, Funcionarios, Cargos;

procedure TFrmMenuPrincipal.Cargos1Click(Sender: TObject);
begin
  frmCargos := TfrmCargos.Create(self);
  frmCargos.ShowModal;
end;

procedure TFrmMenuPrincipal.Funcionrios1Click(Sender: TObject);
begin
  FrmFuncionarios := TFrmFuncionarios.Create(self);
  FrmFuncionarios.ShowModal;
end;

procedure TFrmMenuPrincipal.Usurios1Click(Sender: TObject);
begin
  FrmUsuarios := TFrmUsuarios.Create(FrmMenuPrincipal);
  FrmUsuarios.ShowModal;
end;

end.
