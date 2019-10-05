unit Funcionarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Buttons, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask;

type
  TFrmFuncionarios = class(TForm)
    Label1: TLabel;
    rbNome: TRadioButton;
    rbCPF: TRadioButton;
    txtBuscaNome: TEdit;
    txtBuscaCPF: TMaskEdit;
    txtNome: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    txtEndereco: TEdit;
    txtCPF: TMaskEdit;
    txtTelefone: TMaskEdit;
    cbxCargo: TComboBox;
    DBGrid1: TDBGrid;
    btnNovo: TSpeedButton;
    btnSalvar: TSpeedButton;
    btnEditar: TSpeedButton;
    btnExcluir: TSpeedButton;
    procedure btnNovoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure txtBuscaNomeChange(Sender: TObject);
    procedure txtBuscaCPFChange(Sender: TObject);
    procedure rbNomeClick(Sender: TObject);
    procedure rbCPFClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }

    procedure limparCampos;
    procedure habilitarCampos;
    procedure habilitarCamposBtnNovo;
    procedure habilitarCamposCellClick;
    procedure desabilitarCampos;

    procedure associarCampos;
    procedure listar;

    procedure carregarCombobox;
    procedure buscarNome;
    procedure buscarCpf;

  public
    { Public declarations }
  end;

var
  FrmFuncionarios: TFrmFuncionarios;
  id : String;
  cpfAntigo : String;

implementation

{$R *.dfm}

uses Conexao;

{ TFrmFuncionarios }

procedure TFrmFuncionarios.associarCampos;
begin
  //associcao dos campos do bd com os campos de texto
  dm.tb_func.FieldByName('nome').Value := txtNome.Text;
  dm.tb_func.FieldByName('cpf').Value := txtCPF.Text;
  dm.tb_func.FieldByName('telefone').Value := txtTelefone.Text;
  dm.tb_func.FieldByName('endereco').Value := txtEndereco.Text;
  dm.tb_func.FieldByName('cargo').Value := cbxCargo.Text;
  dm.tb_func.FieldByName('data').Value := DateToStr(Date);
end;

procedure TFrmFuncionarios.btnEditarClick(Sender: TObject);
  var
    cpf : String;
begin
  associarCampos;
  //VERICAR NOME VAZIO
  if Trim(txtNome.Text) = '' then
  begin
    MessageDlg('Preencha o nome!', mtInformation, mbOKCancel, 0);
    txtNome.SetFocus;
    listar;
    exit;
  end;
  //VERICAR CPF VAZIO
  if Trim(txtCPF.Text) = '' then
  begin
    MessageDlg('Preencha o cpf!', mtInformation, mbOKCancel, 0);
    txtCPF.SetFocus;
    listar;
    exit;
  end;
  //VERICAR CARGO VAZIO
  if Trim(cbxCargo.Text) = '' then
  begin
    MessageDlg('Preencha o cargo!', mtInformation, mbOKCancel, 0);
    cbxCargo.SetFocus;
    listar;
    exit;
  end;
  //VERICAR ENDERECO VAZIO
  if Trim(txtEndereco.Text) = '' then
  begin
    MessageDlg('Preencha o endereço!', mtInformation, mbOKCancel, 0);
    txtEndereco.SetFocus;
    listar;
    exit;
  end;


  if cpfAntigo <> txtCPF.Text then
  begin
  //VERIFICAR (PELO CPF) FUNCIONARIO JA CADASTRADO
    dm.query_func.Close;
    dm.query_func.SQL.Clear;
    dm.query_func.SQL.Add('SELECT * FROM funcionarios WHERE cpf = ' + QuotedStr(Trim(txtCPF.Text)));
    dm.query_func.Open;

    if not dm.query_func.IsEmpty then
    begin
        cpf := dm.query_func['cpf'];
        MessageDlg('O CPF '+cpf+' já está cadastrado!', mtInformation, mbOKCancel, 0);
        txtCPF.Text := '';
        txtCPF.SetFocus;
        listar;
        exit;
    end;

  end;

  associarCampos;
  dm.query_func.Close;
  dm.query_func.SQL.Clear;
  dm.query_func.SQL.Add('UPDATE funcionarios SET nome = :nome, cpf = :cpf, telefone = :telefone, endereco = :endereco, cargo = :cargo WHERE id = :id;');
  dm.query_func.ParamByName('nome').Value := txtNome.Text;
  dm.query_func.ParamByName('cpf').Value := txtCPF.Text;
  dm.query_func.ParamByName('telefone').Value := txtTelefone.Text;
  dm.query_func.ParamByName('endereco').Value := txtEndereco.Text;
  dm.query_func.ParamByName('cargo').Value := cbxCargo.Text;
  dm.query_func.ParamByName('id').Value := id;
  dm.query_func.ExecSQL;

  listar;
  MessageDlg('Editado com sucesso!', mtConfirmation, mbOKCancel, 0);
  limparCampos;
  desabilitarCampos;

end;

procedure TFrmFuncionarios.btnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Deseja excluir este registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    dm.tb_func.Delete;
  end;

  limparCampos;
  desabilitarCampos;
  listar
end;

procedure TFrmFuncionarios.btnNovoClick(Sender: TObject);
begin
  habilitarCamposBtnNovo;
  dm.tb_func.Insert;
end;

procedure TFrmFuncionarios.btnSalvarClick(Sender: TObject);
  var
    cpf : String;
begin
  associarCampos;
  //VERICAR NOME VAZIO
  if Trim(txtNome.Text) = '' then
  begin
    MessageDlg('Preencha o nome!', mtInformation, mbOKCancel, 0);
    txtNome.SetFocus;
    exit;
  end;
  //VERICAR CPF VAZIO
  if Trim(txtCPF.Text) = '' then
  begin
    MessageDlg('Preencha o cpf!', mtInformation, mbOKCancel, 0);
    txtCPF.SetFocus;
    exit;
  end;
  //VERICAR CARGO VAZIO
  if Trim(cbxCargo.Text) = '' then
  begin
    MessageDlg('Preencha o cargo!', mtInformation, mbOKCancel, 0);
    cbxCargo.SetFocus;
    exit;
  end;
  //VERICAR ENDERECO VAZIO
  if Trim(txtEndereco.Text) = '' then
  begin
    MessageDlg('Preencha o endereço!', mtInformation, mbOKCancel, 0);
    txtEndereco.SetFocus;
    exit;
  end;

  //VERIFICAR FUNCIONARIO JA CADASTRADO
  dm.query_func.Close;
  dm.query_func.SQL.Clear;
  dm.query_func.SQL.Add('SELECT * FROM funcionarios WHERE cpf = ' + QuotedStr(Trim(txtCPF.Text)));
  dm.query_func.Open;

  if not dm.query_func.IsEmpty then
  begin
      cpf := dm.query_func['cpf'];
      MessageDlg('O CPF '+cpf+' já está cadastrado!', mtInformation, mbOKCancel, 0);
      txtCPF.Text := '';
      txtCPF.SetFocus;
      exit;
  end;


  associarCampos;
  dm.tb_func.Post;
  MessageDlg('Salvo com sucesso!', mtConfirmation, mbOKCancel, 0);
  desabilitarCampos;
  limparCampos;
  btnSalvar.Enabled := false;

  listar;

end;

procedure TFrmFuncionarios.buscarCpf;
begin
  //busca atraves do cpf
  dm.query_func.Close;
  dm.query_func.SQL.Clear;
  dm.query_func.SQL.Add('SELECT * FROM funcionarios WHERE cpf = :cpf ORDER BY nome asc');
  dm.query_func.ParamByName('cpf').Value := txtBuscaCPF.Text;
  dm.query_func.Open;
end;

procedure TFrmFuncionarios.buscarNome;
begin
  //busca atraves do nome
  dm.query_func.Close;
  dm.query_func.SQL.Clear;
  dm.query_func.SQL.Add('SELECT * FROM funcionarios WHERE nome LIKE :nome ORDER BY nome asc');
  dm.query_func.ParamByName('nome').Value := txtBuscaNome.Text + '%';
  dm.query_func.Open;
end;

procedure TFrmFuncionarios.carregarCombobox;
begin
  dm.query_cargos.Close;
  dm.query_cargos.Open;
  if not dm.query_cargos.IsEmpty then
  begin

    while not dm.query_cargos.Eof do
    begin
      cbxCargo.Items.Add(dm.query_cargos.FieldByName('cargo').AsString);
      dm.query_cargos.Next;
    end;

  end;

end;

procedure TFrmFuncionarios.DBGrid1CellClick(Column: TColumn);
begin
  habilitarCamposCellClick;

  dm.tb_func.Edit;
  if dm.query_func.FieldByName('telefone').Value <> null then
  begin
    txtTelefone.Text := dm.query_func.FieldByName('telefone').Value;
  end;

  txtNome.Text := dm.query_func.FieldByName('nome').Value;
  txtEndereco.Text := dm.query_func.FieldByName('endereco').Value;
  txtCPF.Text := dm.query_func.FieldByName('cpf').Value;
  cbxCargo.Text := dm.query_func.FieldByName('cargo').Value;

  id := dm.query_func.FieldByName('id').Value;
  //VERIFICAR SE HOUVE ALTERACAO NO CPF
  cpfAntigo := dm.query_func.FieldByName('cpf').Value;

end;

procedure TFrmFuncionarios.DBGrid1DblClick(Sender: TObject);
begin
  if chamada = 'Func' then
  begin
    idFuncionario := dm.query_func.FieldByName('id').Value;
    nomeFuncionario := dm.query_func.FieldByName('nome').Value;
    cargoFuncionario := dm.query_func.FieldByName('cargo').Value;
    Close;
    chamada := '';
  end;
end;

procedure TFrmFuncionarios.desabilitarCampos;
begin
  txtNome.Enabled := false;
  txtEndereco.Enabled := false;
  txtCPF.Enabled := false;
  txtTelefone.Enabled := false;
  cbxCargo.Enabled := false;
end;

procedure TFrmFuncionarios.FormShow(Sender: TObject);
begin
  limparCampos;
  dm.tb_cargos.Active := true;
  dm.tb_func.Active := true;

  carregarCombobox;
  cbxCargo.ItemIndex := 0;
  listar;
  rbNome.Checked := true;
end;

procedure TFrmFuncionarios.habilitarCampos;
begin
  txtNome.Enabled := true;
  txtEndereco.Enabled := true;
  txtCPF.Enabled := true;
  txtTelefone.Enabled := true;
  cbxCargo.Enabled := true;
  btnSalvar.Enabled := true;
  btnEditar.Enabled := true;
  btnExcluir.Enabled := true;

end;

procedure TFrmFuncionarios.habilitarCamposBtnNovo;
begin
  txtNome.Enabled := true;
  txtEndereco.Enabled := true;
  txtCPF.Enabled := true;
  txtTelefone.Enabled := true;
  cbxCargo.Enabled := true;
  btnSalvar.Enabled := true;
end;

procedure TFrmFuncionarios.habilitarCamposCellClick;
begin
  txtNome.Enabled := true;
  txtEndereco.Enabled := true;
  txtCPF.Enabled := true;
  txtTelefone.Enabled := true;
  cbxCargo.Enabled := true;
  btnEditar.Enabled := true;
  btnExcluir.Enabled := true;
end;

procedure TFrmFuncionarios.limparCampos;
begin
  txtNome.Text := '';
  txtEndereco.Text := '';
  txtCPF.Text := '';
  txtTelefone.Text := '';
end;

procedure TFrmFuncionarios.listar;
begin
  //listagem na tabela
  dm.query_func.Close;
  dm.query_func.SQL.Clear;
  dm.query_func.SQL.Add('SELECT * FROM funcionarios ORDER BY nome asc');
  dm.query_func.Open;
end;

procedure TFrmFuncionarios.rbCPFClick(Sender: TObject);
begin
  listar;
  txtBuscaCPF.Visible := true;
  txtBuscaNome.Visible := false;
end;

procedure TFrmFuncionarios.rbNomeClick(Sender: TObject);
begin
  listar;
  txtBuscaCPF.Visible := false;
  txtBuscaNome.Visible := true;
end;

procedure TFrmFuncionarios.txtBuscaCPFChange(Sender: TObject);
begin
buscarCpf;
end;

procedure TFrmFuncionarios.txtBuscaNomeChange(Sender: TObject);
begin
  buscarNome;
end;

end.
