unit Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, Vcl.StdCtrls, Vcl.Buttons;

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

    Login;
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

procedure TFrmLogin.Login;
begin
  //AQUI VAI TODO O CODIGO PARA VALIDAÇÃO DE LOGIN
  frmMenuPrincipal := TfrmMenuPrincipal.Create(FrmLogin);
  frmMenuPrincipal.ShowModal;
end;

end.
