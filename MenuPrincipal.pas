unit MenuPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Conexao, Fornecedores,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.Imaging.jpeg;

type
  TFrmMenuPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    menuCadastro: TMenuItem;
    subCadProdutos: TMenuItem;
    subCadFornecedores: TMenuItem;
    menuEstoque: TMenuItem;
    menuMovimentaes: TMenuItem;
    menuRelatrios: TMenuItem;
    menuSair: TMenuItem;
    subCadUsuarios: TMenuItem;
    subCadFuncionarios: TMenuItem;
    Cargos1: TMenuItem;
    Image1: TImage;
    pnlImgMenu: TImage;
    procedure subCadUsuariosClick(Sender: TObject);
    procedure subCadFuncionariosClick(Sender: TObject);
    procedure Cargos1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure subCadFornecedoresClick(Sender: TObject);
    procedure menuSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
      var Resize: Boolean);
  private
    { Private declarations }
    procedure sair;
    procedure centralizarPainel;
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

procedure TFrmMenuPrincipal.centralizarPainel;
begin
    pnlImgMenu.Top := (self.Height div 2) - (pnlImgMenu.Height div 2);
    pnlImgMenu.Left := (self.Width div 2) - (pnlImgMenu.Width div 2);
end;

procedure TFrmMenuPrincipal.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  centralizarPainel;
end;

procedure TFrmMenuPrincipal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  sair;
end;

procedure TFrmMenuPrincipal.FormShow(Sender: TObject);
begin
  if (cargoUsuario = 'admin') or (cargoUsuario = 'Gerente') then
  begin
    subCadUsuarios.Enabled := true;
  end;

end;

procedure TFrmMenuPrincipal.menuSairClick(Sender: TObject);
begin
  sair;
end;

procedure TFrmMenuPrincipal.sair;
begin
  if MessageDlg('Deseja sair?', mtConfirmation,[mbYes, mbNo], 0) = mrYes then
  begin
    Application.Terminate;
  end
  else
  begin
    abort;
  end;
end;

procedure TFrmMenuPrincipal.subCadFornecedoresClick(Sender: TObject);
begin
  FrmFornecedores := TFrmFornecedores.Create(self);
  FrmFornecedores.ShowModal;
end;

procedure TFrmMenuPrincipal.subCadFuncionariosClick(Sender: TObject);
begin
  FrmFuncionarios := TFrmFuncionarios.Create(self);
  FrmFuncionarios.ShowModal;
end;

procedure TFrmMenuPrincipal.subCadUsuariosClick(Sender: TObject);
begin
  FrmUsuarios := TFrmUsuarios.Create(FrmMenuPrincipal);
  FrmUsuarios.ShowModal;
end;

end.
