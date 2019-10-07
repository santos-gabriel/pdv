unit Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, Vcl.StdCtrls, Vcl.Buttons, Datasnap.Provider, Data.DB,
  Datasnap.DBClient, Data.DBXMySQL, Data.FMTBcd, Data.SqlExpr, Vcl.Grids,
  Vcl.DBGrids, UdmModelo, Conexao;

type
  TFrmLogin = class(TForm)
    Panel1: TPanel;
    imgFundo: TImage;
    PnlLogin: TPanel;
    imgLogin: TImage;
    txtLogin: TEdit;
    txtSenha: TEdit;
    btnLogin: TSpeedButton;
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
      var Resize: Boolean);
    procedure btnLoginClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    procedure CentralizarPainel;
    procedure Login;
  public
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;

implementation

{$R *.dfm}

uses MenuPrincipal;

procedure TFrmLogin.btnLoginClick(Sender: TObject);
begin

    if Trim(txtLogin.Text) = '' then
    begin
      MessageDlg('Preencha o campo de usuário!', mtInformation, mbOKCancel, 0);
      txtLogin.SetFocus;
      exit;
    end;

    if Trim(txtSenha.Text) = '' then
    begin
      MessageDlg('Preencha o campo de senha', mtInformation, mbOKCancel, 0);
      txtSenha.SetFocus;
      exit;
    end;

    login;

end;

procedure TFrmLogin.CentralizarPainel;
begin
    PnlLogin.Top := (self.Height div 2) - (PnlLogin.Height div 2);
    PnlLogin.Left := (self.Width div 2) - (PnlLogin.Width div 2);
end;

procedure TFrmLogin.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
    CentralizarPainel;
end;

procedure TFrmLogin.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 13 then
  Login;
end;

procedure TFrmLogin.Login;
begin
  //AQUI VAI TODO O CODIGO PARA VALIDAÇÃO DE LOGIN
  dm.query_usuarios.Close;
  dm.query_usuarios.SQL.Clear;
  dm.query_usuarios.SQL.Add('SELECT * FROM usuarios WHERE usuario = :usuario and senha = :senha');
  dm.query_usuarios.ParamByName('usuario').Value := txtLogin.Text;
  dm.query_usuarios.ParamByName('senha').Value := txtSenha.Text;
  dm.query_usuarios.Open;

  if not dm.query_usuarios.IsEmpty then
  begin

    nomeUsuario := dm.query_usuarios['usuario'];
    cargoUsuario := dm.query_usuarios['cargo'];
    txtSenha.Text := '';
    FrmLogin.Visible := false;
    frmMenuPrincipal := TfrmMenuPrincipal.Create(FrmLogin);
    frmMenuPrincipal.ShowModal;
    FrmLogin.Close;

  end
  else
  begin
    MessageDlg('Campos inválidos', mtError, mbOKCancel, 0);
    txtLogin.Text := '';
    txtSenha.Text := '';
    txtLogin.SetFocus;
  end;

end;

end.
