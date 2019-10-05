unit Usuarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.Buttons, Vcl.StdCtrls;

type
  TFrmUsuarios = class(TForm)
    txtNome: TEdit;
    Label2: TLabel;
    txtBuscar: TEdit;
    btnNovo: TSpeedButton;
    btnSalvar: TSpeedButton;
    btnEditar: TSpeedButton;
    btnExcluir: TSpeedButton;
    DBGrid1: TDBGrid;
    txtUsuario: TEdit;
    txtSenha: TEdit;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    btnBuscarFunc: TSpeedButton;
    procedure btnBuscarFuncClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure txtBuscarChange(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
  private
    { Private declarations }
    procedure limparCampos;
    procedure desabilitarCampos;
    procedure habilitarCampos;

    procedure buscarCampos;
    procedure associarCampos;
    procedure listar;

  public
    { Public declarations }
  end;

var
  FrmUsuarios: TFrmUsuarios;
  usuarioAntigo : String;

implementation

{$R *.dfm}

uses Conexao, Funcionarios;

procedure TFrmUsuarios.associarCampos;
begin
  dm.tb_usuarios.FieldByName('nome').Value := txtNome.Text;
  dm.tb_usuarios.FieldByName('usuario').Value := txtUsuario.Text;
  dm.tb_usuarios.FieldByName('senha').Value := txtSenha.Text;
  dm.tb_usuarios.FieldByName('cargo').Value := cargoFuncionario;
  dm.tb_usuarios.FieldByName('idFuncionario').Value := idFuncionario;
end;

procedure TFrmUsuarios.btnBuscarFuncClick(Sender: TObject);
begin
  chamada := 'Func';
  FrmFuncionarios := TFrmFuncionarios.Create(self);
  FrmFuncionarios.Show;
end;

procedure TFrmUsuarios.btnEditarClick(Sender: TObject);
var
    usuario : String;
begin
  associarCampos;
  //VERICAR NOME VAZIO
  if Trim(txtNome.Text) = '' then
  begin
    MessageDlg('Selecione o nome!', mtInformation, mbOKCancel, 0);
    listar;
    exit;
  end;

  //VERICAR USUARIO VAZIO
  if Trim(txtUsuario.Text) = '' then
  begin
    MessageDlg('Osuário inválido!', mtInformation, mbOKCancel, 0);
    txtUsuario.SetFocus;
    listar;
    exit;
  end;

  //VERICAR SENHA VAZIO
  if Trim(txtSenha.Text) = '' then
  begin
    MessageDlg('Senha inválida!', mtInformation, mbOKCancel, 0);
    txtSenha.SetFocus;
    listar;
    exit;
  end;


  //VERIFICAR USUARIO JA CADASTRADO
  dm.query_usuarios.Close;
  dm.query_usuarios.SQL.Clear;
  dm.query_usuarios.SQL.Add('SELECT * FROM usuarios WHERE usuario = ' + QuotedStr(Trim(txtUsuario.Text)));
  dm.query_usuarios.Open;

  if not dm.query_usuarios.IsEmpty then
  begin
      usuario := dm.query_usuarios['usuario'];
      MessageDlg('O usuário '+usuario+' já está cadastrado!', mtError, mbOKCancel, 0);
      desabilitarCampos;
      limparCampos;
      listar;
      exit;
  end;
end;

procedure TFrmUsuarios.btnNovoClick(Sender: TObject);
begin
  limparCampos;
  dm.tb_usuarios.Insert;
  habilitarCampos;
  btnSalvar.Enabled := true;
end;

procedure TFrmUsuarios.btnSalvarClick(Sender: TObject);
  var
    usuario : String;
begin
  associarCampos;
  //VERICAR NOME VAZIO
  if Trim(txtNome.Text) = '' then
  begin
    MessageDlg('Selecione o nome!', mtInformation, mbOKCancel, 0);
    listar;
    exit;
  end;

  //VERICAR USUARIO VAZIO
  if Trim(txtUsuario.Text) = '' then
  begin
    MessageDlg('Osuário inválido!', mtInformation, mbOKCancel, 0);
    txtUsuario.SetFocus;
    listar;
    exit;
  end;

  //VERICAR SENHA VAZIO
  if Trim(txtSenha.Text) = '' then
  begin
    MessageDlg('Senha inválida!', mtInformation, mbOKCancel, 0);
    txtSenha.SetFocus;
    listar;
    exit;
  end;


  //VERIFICAR USUARIO JA CADASTRADO
  dm.query_usuarios.Close;
  dm.query_usuarios.SQL.Clear;
  dm.query_usuarios.SQL.Add('SELECT * FROM usuarios WHERE usuario = ' + QuotedStr(Trim(txtUsuario.Text)));
  dm.query_usuarios.Open;

  if not dm.query_usuarios.IsEmpty then
  begin
      usuario := dm.query_usuarios['usuario'];
      MessageDlg('O usuário '+usuario+' já está cadastrado!', mtError, mbOKCancel, 0);
      desabilitarCampos;
      limparCampos;
      listar;
      exit;
  end;


  associarCampos;
  dm.tb_usuarios.Post;
  MessageDlg('Salvo com sucesso!', mtConfirmation, mbOKCancel, 0);
  desabilitarCampos;
  limparCampos;
  btnSalvar.Enabled := false;

  listar;


end;

procedure TFrmUsuarios.buscarCampos;
begin
  dm.query_usuarios.Close;
  dm.query_usuarios.SQL.Clear;
  dm.query_usuarios.SQL.Add('SELECT * FROM usuarios WHERE nome LIKE :nome ORDER BY nome asc');
  dm.query_usuarios.ParamByName('nome').Value := txtBuscar.Text + '%';
  dm.query_usuarios.Open;
end;

procedure TFrmUsuarios.desabilitarCampos;
begin
  txtNome.Enabled := false;
  txtUsuario.Enabled := false;
  txtSenha.Enabled := false;
  btnSalvar.Enabled := false;
  btnEditar.Enabled := false;
  btnExcluir.Enabled := false;
  btnBuscarFunc.Enabled := false;
end;

procedure TFrmUsuarios.FormActivate(Sender: TObject);
begin
  txtNome.Text := nomeFuncionario;
end;

procedure TFrmUsuarios.FormShow(Sender: TObject);
begin
  desabilitarCampos;
  dm.tb_usuarios.Active := true;
  listar;
end;

procedure TFrmUsuarios.habilitarCampos;
begin
  txtUsuario.Enabled := true;
  txtSenha.Enabled := true;
  btnBuscarFunc.Enabled := true;
end;

procedure TFrmUsuarios.limparCampos;
begin
  txtNome.Text := '';
  txtUsuario.Text := '';
  txtSenha.Text := '';
end;

procedure TFrmUsuarios.listar;
begin
  //LISTAGEM DA TABELA
  dm.query_usuarios.Close;
  dm.query_usuarios.SQL.Clear;
  dm.query_usuarios.SQL.Add('SELECT * FROM usuarios ORDER BY nome asc');
  dm.query_usuarios.Open;

end;



procedure TFrmUsuarios.txtBuscarChange(Sender: TObject);
begin
  buscarCampos;
end;

end.
