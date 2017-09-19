unit uPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, Data.DbxSqlite,
  Data.DB, Data.SqlExpr, System.IOUtils, FMX.TabControl, FMX.StdCtrls, FMX.Helpers.Android,
  System.Actions, FMX.ActnList, FMX.Edit, FMX.VirtualKeyboard, FMX.Platform,
  FMX.ListBox, FMX.Layouts, Data.FMTBcd, FMX.Memo, FMX.TreeView,
  FMX.Controls.Presentation;

type
  TfrmPrincipal = class(TForm)
    bdDados: TSQLConnection;
    TabControl1: TTabControl;
    tabPrincipal: TTabItem;
    ToolBar1: TToolBar;
    Label1: TLabel;
    btnSair: TSpeedButton;
    btnSobre: TSpeedButton;
    tabSobre: TTabItem;
    ToolBar3: TToolBar;
    Label2: TLabel;
    ToolBar8: TToolBar;
    btnOK_tabSobre: TSpeedButton;
    ActionList1: TActionList;
    cngPrincipal: TChangeTabAction;
    cngSobre: TChangeTabAction;
    tabConfig: TTabItem;
    ToolBar2: TToolBar;
    Label4: TLabel;
    ToolBar4: TToolBar;
    btnConfirmar: TSpeedButton;
    btnCancelar: TSpeedButton;
    btnConfig: TSpeedButton;
    cngConfig: TChangeTabAction;
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    Label5: TLabel;
    ListBoxItem2: TListBoxItem;
    Label14: TLabel;
    Label3: TLabel;
    lblLicenca: TLabel;
    ListBoxItem3: TListBoxItem;
    Label6: TLabel;
    Label7: TLabel;
    ListBoxItem4: TListBoxItem;
    Label8: TLabel;
    Label9: TLabel;
    ListBoxItem5: TListBoxItem;
    Label10: TLabel;
    Label11: TLabel;
    ListBox2: TListBox;
    ListBoxItem6: TListBoxItem;
    Label12: TLabel;
    cbxPalavras: TComboBox;
    ListBoxItem7: TListBoxItem;
    Label13: TLabel;
    cbxPausa: TComboBox;
    ListBoxDocumentos: TListBox;
    ToolBar5: TToolBar;
    btnAdicionarDocumento: TSpeedButton;
    btnApagarDocumento: TSpeedButton;
    btnAlterarDocumento: TSpeedButton;
    btnLerDocumento: TSpeedButton;
    tabConfirmaApagar: TTabItem;
    cngConfirmaApagar: TChangeTabAction;
    ToolBar6: TToolBar;
    Label15: TLabel;
    ToolBar7: TToolBar;
    btnConfimarApagar: TSpeedButton;
    btnCancelaApagar: TSpeedButton;
    Label16: TLabel;
    tabLeitura: TTabItem;
    cngLeitura: TChangeTabAction;
    ToolBar9: TToolBar;
    Label17: TLabel;
    ToolBar10: TToolBar;
    btnInicio: TSpeedButton;
    btnContinuar: TSpeedButton;
    lblPalavra: TLabel;
    lblDestaque: TLabel;
    tabDocumento: TTabItem;
    ToolBar11: TToolBar;
    Label18: TLabel;
    ToolBar12: TToolBar;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    cngDocumento: TChangeTabAction;
    SpeedButton3: TSpeedButton;
    tabArquivos: TTabItem;
    cngArquivos: TChangeTabAction;
    ToolBar13: TToolBar;
    Label22: TLabel;
    ToolBar14: TToolBar;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    TreeView1: TTreeView;
    Label23: TLabel;
    Label24: TLabel;
    SpeedButton8: TSpeedButton;
    Label19: TLabel;
    edtTitulo: TEdit;
    ClearEditButton1: TClearEditButton;
    Label20: TLabel;
    mmoTexto: TMemo;
    Label21: TLabel;
    Label25: TLabel;
    btnAnterior: TSpeedButton;
    tabProcesso: TTabItem;
    cngProcesso: TChangeTabAction;
    ToolBar15: TToolBar;
    lblMensagem: TLabel;
    lblGeral: TLabel;
    pgbTarefa: TProgressBar;
    pgbGeral: TProgressBar;
    procedure FormCreate(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnOK_tabSobreClick(Sender: TObject);
    procedure btnSobreClick(Sender: TObject);
    procedure btnConfigClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure bdDadosBeforeConnect(Sender: TObject);
    procedure bdDadosAfterConnect(Sender: TObject);
    procedure btnApagarDocumentoClick(Sender: TObject);
    procedure btnCancelaApagarClick(Sender: TObject);
    procedure btnConfimarApagarClick(Sender: TObject);
    procedure btnLerDocumentoClick(Sender: TObject);
    procedure btnContinuarClick(Sender: TObject);
    procedure btnInicioClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure btnAdicionarDocumentoClick(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure btnAlterarDocumentoClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure btnAnteriorClick(Sender: TObject);
  private
    procedure MontaTela;
    procedure lePalavrasConfig;
    procedure criaDocumentoExemplo;
    procedure leDocumentos;
    procedure CriaItemDocumento(ID: Integer; Titulo, NumPalavras,
      NumAtual: string);
    procedure ProcessaTexto(ID: integer);
    procedure OnIdle(Sender: TObject; var ADone: Boolean);
    procedure ApagaDocumento(ID: integer);
    procedure Leitura(ID: integer);
    procedure CriaItemTree(Pai: TFmxObject; Titulo: string);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;
  lCriandoDocumento : boolean;

implementation

{$R *.fmx}

procedure TfrmPrincipal.MontaTela;
begin
    lePalavrasConfig;
    leDocumentos;
end;

procedure TfrmPrincipal.Leitura(ID: integer);
var
    Query       : TSQLQuery;
    iTempo      : integer;
    iPausa      : integer;
    iAtual      : integer;
    iCont       : integer;
    iUltimaLida : integer;
    lPode       : boolean;
begin
    iPausa := 50;
    iAtual := 0;

    if cbxPalavras.ItemIndex = 0 then iTempo := 250 else
    if cbxPalavras.ItemIndex = 1 then iTempo := 350 else
    if cbxPalavras.ItemIndex = 2 then iTempo := 450 else
    if cbxPalavras.ItemIndex = 3 then iTempo := 550 else
    if cbxPalavras.ItemIndex = 4 then iTempo := 650 else
    if cbxPalavras.ItemIndex = 5 then iTempo := 750 else
    if cbxPalavras.ItemIndex = 6 then iTempo := 850 else
    if cbxPalavras.ItemIndex = 7 then iTempo := 950 else
    if cbxPalavras.ItemIndex = 8 then iTempo := 1000;

    iTempo := 60000 div iTempo;

    if cbxPausa.ItemIndex = 0 then iPausa :=  50 else
    if cbxPausa.ItemIndex = 1 then iPausa := 100 else
    if cbxPausa.ItemIndex = 2 then iPausa := 200 else
    if cbxPausa.ItemIndex = 3 then iPausa := 300 else
    if cbxPausa.ItemIndex = 4 then iPausa := 400 else
    if cbxPausa.ItemIndex = 5 then iPausa := 500 else
    if cbxPausa.ItemIndex = 6 then iPausa := 600 else
    if cbxPausa.ItemIndex = 7 then iPausa := 700 else
    if cbxPausa.ItemIndex = 8 then iPausa := 800 else
    if cbxPausa.ItemIndex = 9 then iPausa := 900;

    Query := TSQLQuery.Create(Self);
    Query.SQLConnection := bdDados;

    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Add('SELECT num_palavras, num_atual FROM documento');
    Query.SQL.Add('WHERE id = :ID');
    Query.ParamByName('ID').AsInteger := ID;

    Query.Open;
    Query.First;

    if not Query.IsEmpty then
       iAtual := Query.FieldByName('num_atual').AsInteger;

    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Add('SELECT sequencia, palavra, destaque FROM palavra');
    Query.SQL.Add('WHERE id_documento = :ID');
    Query.SQL.Add('  AND sequencia   >= :Atual');
    Query.SQL.Add('ORDER BY sequencia');

    Query.ParamByName('ID').AsInteger    := ID;
    Query.ParamByName('Atual').AsInteger := iAtual;

    Query.Open;
    Query.First;

    iCont := 1;
    lPode := True;
    while not Query.Eof do
    begin
        if lPode then
        begin
            lblPalavra.Text  := Query.FieldByName('palavra').AsString;
            lblDestaque.Text := Query.FieldByName('destaque').AsString;
            iUltimaLida      := Query.FieldByName('sequencia').AsInteger;

            Application.ProcessMessages;

            if Pos('.',lblPalavra.Text) <> 0 then
               Sleep(iTempo + 300)
            else
               Sleep(iTempo);

            if iCont > iPausa then
               if Pos('.',lblPalavra.Text) <> 0 then
                  lPode := False;
        end;

        Query.Next;
        iCont := iCont + 1;
    end;

    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Add('UPDATE documento SET num_atual = :Atual, num_anterior = :Anterior WHERE id = :ID');
    Query.ParamByName('ID').AsInteger       := ID;
    Query.ParamByName('Atual').AsInteger    := iUltimaLida;
    Query.ParamByName('Anterior').AsInteger := iAtual;
    Query.ExecSQL();

    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Add('SELECT num_palavras, num_atual, num_anterior FROM documento');
    Query.SQL.Add('WHERE id = :ID');
    Query.ParamByName('ID').AsInteger := ID;
    Query.Open;
    Query.First;

    Label25.Text := 'Palavras: ' + Query.FieldByName('num_palavras').AsString;
    Label25.Text := 'Atual: ' + Query.FieldByName('num_atual').AsString;

    btnInicio.Enabled    := True;
    btnAnterior.Enabled  := True;
    btnContinuar.Enabled := True;

    if Query.FieldByName('num_atual').AsInteger = 0 then
    begin
        btnInicio.Enabled   := False;
        btnAnterior.Enabled := False;
    end;

    if Query.FieldByName('num_atual').AsInteger >= Query.FieldByName('num_palavras').AsInteger then
       btnContinuar.Enabled := False;

    if Query.FieldByName('num_anterior').AsInteger >= Query.FieldByName('num_atual').AsInteger then
       btnAnterior.Enabled := False;

    Query.Close;
    Query.Free;
end;


procedure TfrmPrincipal.ApagaDocumento(ID: integer);
var
    Query : TSQLQuery;
begin
    Query := TSQLQuery.Create(Self);
    Query.SQLConnection := bdDados;

    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Add('DELETE FROM palavra WHERE id_documento = :ID');
    Query.ParamByName('ID').AsInteger := ID;
    Query.ExecSQL();

    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Add('DELETE FROM documento WHERE id = :ID');
    Query.ParamByName('ID').AsInteger := ID;
    Query.ExecSQL();

    Query.Close;
    Query.Free;
end;

procedure TfrmPrincipal.ProcessaTexto(ID: integer);
var
    Query : TSQLQuery;
    vTexto : TStringList;
    i, a : integer;
    sAux : string;
    sAuxDestaque : string;
begin
    vTexto := TStringList.Create;
    vTexto.Delimiter := ' ';

    Query := TSQLQuery.Create(Self);
    Query.SQLConnection := bdDados;

    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Add('DELETE FROM palavra WHERE id_documento = :ID');
    Query.ParamByName('ID').AsInteger := ID;
    Query.ExecSQL();

    pgbGeral.Value  := 2;
    Application.ProcessMessages;

    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Add('SELECT id, texto FROM documento');
    Query.SQL.Add('WHERE id = :ID');
    Query.ParamByName('ID').AsInteger := ID;
    Query.Open;
    Query.First;

    pgbGeral.Value  := 3;
    Application.ProcessMessages;

    if not Query.IsEmpty then
       vTexto.DelimitedText := Query.Fields[1].AsString;

    pgbGeral.Value  := 4;
    Application.ProcessMessages;

    pgbTarefa.Max := vTexto.Count;

     for i := 0 to vTexto.Count - 1 do
     begin
        pgbTarefa.Value := i;
        Application.ProcessMessages;

        sAux         := Copy(vTexto[i],1,22);
        sAux         := StringOfChar(' ',((22 - Length(sAux)) div 2)) + sAux;
        sAux         := sAux + StringOfChar(' ',(22 - Length(sAux)));
        sAuxDestaque := sAux;

        Delete(sAux, (Length(sAux) div 2), 1);
        Insert(' ', sAux, (Length(sAux) div 2) + 1);

        for a := 1 to Length(sAux) do
        begin
            if Copy(sAux,a,1) <> ' ' then
            begin
                Delete(sAuxDestaque, a, 1);
                Insert(' ', sAuxDestaque, a);
            end;
        end;

        Query.Close;
        Query.SQL.Clear;
        Query.SQL.Add('INSERT INTO palavra (id_documento, sequencia, palavra, destaque)');
        Query.SQL.Add('VALUES (:ID, :Sequencia, :Palavra, :Destaque)');
        Query.ParamByName('ID').AsInteger        := ID;
        Query.ParamByName('Sequencia').AsInteger := i + 1;
        Query.ParamByName('Palavra').AsString    := sAux;
        Query.ParamByName('Destaque').AsString   := sAuxDestaque;
        Query.ExecSQL();
    end;

    pgbGeral.Value  := 5;
    Application.ProcessMessages;

    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Add('UPDATE documento SET num_palavras = :Palavras, num_atual = 0, num_anterior = 0 WHERE id = :ID');
    Query.ParamByName('ID').AsInteger       := ID;
    Query.ParamByName('Palavras').AsInteger := vTexto.Count;
    Query.ExecSQL();

    pgbGeral.Value  := 6;
    Application.ProcessMessages;

    FreeAndNil(vTexto);

    pgbGeral.Value  := 7;
    Application.ProcessMessages;

    Query.Close;
    Query.Free;

    pgbGeral.Value  := 8;
    Application.ProcessMessages;
end;

procedure TfrmPrincipal.SpeedButton1Click(Sender: TObject);
var
    Query : TSQLQuery;
    iNumDocto : integer;
begin
    if edtTitulo.Text = '' then
    begin
        MessageDlg('Informe o título do documento !', TMsgDlgType.mtWarning, [TMsgDlgBtn.mbOK], 0,
        procedure(const AResult: TModalResult)
        begin
            Exit;
        end);

        exit;
    end;

    if mmoTexto.Text = '' then
    begin
        MessageDlg('Informe o texto do documento !', TMsgDlgType.mtWarning, [TMsgDlgBtn.mbOK], 0,
        procedure(const AResult: TModalResult)
        begin
            Exit;
        end);

        exit;
    end;

    lblMensagem.Text := 'Aguarde';
    lblGeral.Text    := 'Processando o Documento';
    pgbGeral.Max     := 8;
    pgbGeral.Value   := 0;

    cngProcesso.ExecuteTarget(Self);

    Query := TSQLQuery.Create(Self);
    Query.SQLConnection := bdDados;

    if lCriandoDocumento then
    begin
        Query.Close;
        Query.SQL.Clear;
        Query.SQL.Add('SELECT count(id) FROM documento');
        Query.Open;
        Query.First;
        iNumDocto := Query.Fields[0].AsInteger;

        Query.Close;
        Query.SQL.Clear;
        Query.SQL.Add('INSERT INTO documento (id, titulo, texto, num_palavras, num_atual, num_anterior) VALUES (:ID, :Titulo, :Texto, 0, 0, 0)');

        Query.ParamByName('ID').AsInteger    := iNumDocto;
        Query.ParamByName('Titulo').AsString := edtTitulo.Text;
        Query.ParamByName('Texto').AsString  := mmoTexto.Text;

        Query.ExecSQL();
    end
    else
    begin
        iNumDocto := StrToInt(ListBoxDocumentos.Selected.TagString);

        Query.Close;
        Query.SQL.Clear;
        Query.SQL.Add('UPDATE documento SET titulo = :Titulo, texto = :Texto WHERE id = :ID');

        Query.ParamByName('ID').AsInteger    := iNumDocto;
        Query.ParamByName('Titulo').AsString := edtTitulo.Text;
        Query.ParamByName('Texto').AsString  := mmoTexto.Text;

        Query.ExecSQL();
    end;

    pgbGeral.Value  := 1;
    Application.ProcessMessages;

    ProcessaTexto(iNumDocto);

    Query.Close;
    Query.Free;

    MontaTela;

    cngDocumento.ExecuteTarget(Self);

    lCriandoDocumento := False;

    cngPrincipal.ExecuteTarget(Self);
end;

procedure TfrmPrincipal.SpeedButton2Click(Sender: TObject);
begin
    cngPrincipal.ExecuteTarget(Self);
end;

procedure TfrmPrincipal.SpeedButton3Click(Sender: TObject);
begin
    MontaTela;
    cngPrincipal.ExecuteTarget(Self);
end;

procedure TfrmPrincipal.SpeedButton5Click(Sender: TObject);
var
    F : TextFile;
    sFileName : string;
    sAux : string;
begin
    if TreeView1.Selected = nil then
    begin
        MessageDlg('Selecione um arquivo para importar !', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0,
        procedure(const AResult: TModalResult)
        begin
            Exit;
        end);

        exit;
    end;

    sFileName := TPath.Combine(TPath.GetSharedDocumentsPath, TreeView1.Selected.Text);

    if not FileExists(sFileName) then
    begin
        MessageDlg('Arquivo selecionado não disponível !', TMsgDlgType.mtWarning, [TMsgDlgBtn.mbOK], 0,
        procedure(const AResult: TModalResult)
        begin
            Exit;
        end);

        exit;
    end;

    mmoTexto.Lines.Clear;

    AssignFile(F, sFileName);
    Reset(F);

    while not Eof(F) do
    begin
       ReadLn(F, sAux);
       mmoTexto.Lines.Add(sAux);
    end;

    CloseFile(F);

    cngDocumento.ExecuteTarget(Self);
end;

procedure TfrmPrincipal.SpeedButton6Click(Sender: TObject);
begin
    cngDocumento.ExecuteTarget(Self);
end;

procedure TfrmPrincipal.CriaItemTree(Pai: TFmxObject; Titulo: string);
var
    tItem : TTreeViewItem;
begin
    tItem        := TTreeViewItem.Create(TreeView1);
    tItem.Parent := Pai;
    tItem.Text   := Titulo;
end;

procedure TfrmPrincipal.SpeedButton8Click(Sender: TObject);
var
    FileList: TStringDynArray;
    sAux: string;
begin
    TreeView1.Clear;

    FileList := TDirectory.GetFiles(TPath.GetSharedDocumentsPath);
    Label23.Text := TPath.GetSharedDocumentsPath;

    for sAux in FileList do
        if TPath.GetExtension(sAux) = '.txt' then
           CriaItemTree(TreeView1, TPath.GetFileName(sAux));

    cngArquivos.ExecuteTarget(Self);
end;

procedure TfrmPrincipal.leDocumentos;
var
    Query : TSQLQuery;
begin
    ListBoxDocumentos.Clear;

    Query := TSQLQuery.Create(Self);
    Query.SQLConnection := bdDados;

    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Add('SELECT id, titulo, num_palavras, num_atual FROM documento ORDER BY titulo');
    Query.Open;
    Query.First;

    while not Query.Eof do
    begin
        CriaItemDocumento(Query.FieldByName('id').AsInteger,
                          Query.FieldByName('titulo').AsString,
                          Query.FieldByName('num_palavras').AsString,
                          Query.FieldByName('num_atual').AsString);
        Query.Next;
    end;

    Query.Close;
    Query.Free;
end;

procedure TfrmPrincipal.CriaItemDocumento(ID: Integer; Titulo, NumPalavras, NumAtual: string);
var
    listBoxItem  : TListBoxItem;
begin
    listBoxItem             := TListBoxItem.Create(ListBoxDocumentos);
    listBoxItem.Parent      := ListBoxDocumentos;
    listBoxItem.StyleLookup := 'listboxitemnodetail';
    listBoxItem.TagString   := IntToStr(ID);
    listBoxItem.Text        := Titulo;
end;

procedure TfrmPrincipal.lePalavrasConfig;
var
    Query : TSQLQuery;
begin
    cbxPalavras.ItemIndex := 0;

    Query := TSQLQuery.Create(Self);
    Query.SQLConnection := bdDados;

    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Add('SELECT palavras_min, palavras_pausa FROM config');
    Query.SQL.Add('WHERE id = 1');
    Query.Open;
    Query.First;

    if Query.Fields[0].AsInteger = 250  then cbxPalavras.ItemIndex := 0 else
    if Query.Fields[0].AsInteger = 350  then cbxPalavras.ItemIndex := 1 else
    if Query.Fields[0].AsInteger = 450  then cbxPalavras.ItemIndex := 2 else
    if Query.Fields[0].AsInteger = 550  then cbxPalavras.ItemIndex := 3 else
    if Query.Fields[0].AsInteger = 650  then cbxPalavras.ItemIndex := 4 else
    if Query.Fields[0].AsInteger = 750  then cbxPalavras.ItemIndex := 5 else
    if Query.Fields[0].AsInteger = 850  then cbxPalavras.ItemIndex := 6 else
    if Query.Fields[0].AsInteger = 950  then cbxPalavras.ItemIndex := 7 else
    if Query.Fields[0].AsInteger = 1000 then cbxPalavras.ItemIndex := 8;

    if Query.Fields[1].AsInteger = 50  then cbxPausa.ItemIndex := 0 else
    if Query.Fields[1].AsInteger = 100 then cbxPausa.ItemIndex := 1 else
    if Query.Fields[1].AsInteger = 200 then cbxPausa.ItemIndex := 2 else
    if Query.Fields[1].AsInteger = 300 then cbxPausa.ItemIndex := 3 else
    if Query.Fields[1].AsInteger = 400 then cbxPausa.ItemIndex := 4 else
    if Query.Fields[1].AsInteger = 500 then cbxPausa.ItemIndex := 5 else
    if Query.Fields[1].AsInteger = 600 then cbxPausa.ItemIndex := 6 else
    if Query.Fields[1].AsInteger = 700 then cbxPausa.ItemIndex := 7 else
    if Query.Fields[1].AsInteger = 800 then cbxPausa.ItemIndex := 8 else
    if Query.Fields[1].AsInteger = 900 then cbxPausa.ItemIndex := 9;

    Query.Close;
    Query.Free;
end;

procedure TfrmPrincipal.criaDocumentoExemplo;
var
    Query : TSQLQuery;
    lPode : boolean;
    F : TextFile;
    sFileName : string;
    sAux : string;
    sLinha : string;
begin
    Query := TSQLQuery.Create(Self);
    Query.SQLConnection := bdDados;

    lPode := False;
    sAux  := '';

    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Add('SELECT id FROM documento WHERE id = 0');
    Query.Open;
    Query.First;

    if Query.IsEmpty then
       lPode := True;

    if not lPode then
    begin
        Query.Close;
        Query.Free;
        Exit;
    end;

    sFileName := TPath.Combine(TPath.GetSharedDocumentsPath, 'Exemplo.txt');

    if not FileExists(sFileName) then
       Exit;

    AssignFile(F, sFileName);
    Reset(F);

    while not Eof(F) do
    begin
        ReadLn(F, sLinha);
        sAux := sAux + sLinha;
    end;

    if sAux <> '' then
    begin
        Query.Close;
        Query.SQL.Clear;
        Query.SQL.Add('INSERT INTO documento (id, titulo, texto, num_palavras, num_atual, num_anterior) VALUES (0, :Titulo, :Texto, 0, 0, 0)');

        Query.ParamByName('Titulo').AsString := 'Documento Exemplo';
        Query.ParamByName('Texto').AsString  := sAux;

        Query.ExecSQL();
    end;

    CloseFile(F);

    ProcessaTexto(0);

    Query.Close;
    Query.Free;
end;

procedure TfrmPrincipal.bdDadosAfterConnect(Sender: TObject);
var
    Query : TSQLQuery;
    lPode : boolean;
begin
    Query := TSQLQuery.Create(Self);
    Query.SQLConnection := bdDados;

    {$REGION Tabelas}
    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Add('CREATE TABLE IF NOT EXISTS config (id INTEGER PRIMARY KEY ASC, palavras_min INTEGER, palavras_pausa INTEGER)');
    Query.ExecSQL();

    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Add('CREATE TABLE IF NOT EXISTS documento (id INTEGER PRIMARY KEY ASC, titulo TEXT, texto TEXT, num_palavras INTEGER, num_atual INTEGER, num_anterior INTEGER)');
    Query.ExecSQL();

    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Add('CREATE TABLE IF NOT EXISTS palavra (id_documento INTEGER, sequencia INTEGER, palavra TEXT, destaque TEXT, PRIMARY KEY (id_documento, sequencia))');
    Query.ExecSQL();

    {$ENDREGION}

    {$REGION ConfigPadrao}
    lPode := False;

    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Add('SELECT id FROM config WHERE id = 1');
    Query.Open;
    Query.First;

    if Query.IsEmpty then
       lPode := True;

    if lPode then
    begin
        Query.Close;
        Query.SQL.Clear;
        Query.SQL.Add('INSERT INTO config (id, palavras_min, palavras_pausa) VALUES (1, 250, 50)');
        Query.ExecSQL();
    end;
    {$ENDREGION}

    {$REGION DocumentoExemplo}
    criaDocumentoExemplo;
    {$ENDREGION}

    Query.Close;
    Query.Free;
end;

procedure TfrmPrincipal.bdDadosBeforeConnect(Sender: TObject);
begin
    bdDados.Params.Values['Database'] := TPath.Combine(TPath.GetDocumentsPath, 'database.db3');
end;

procedure TfrmPrincipal.btnAdicionarDocumentoClick(Sender: TObject);
begin
    lCriandoDocumento := True;
    Label18.Text      := 'Novo Documento';
    edtTitulo.Text    := '';
    mmoTexto.Text     := '';

    cngDocumento.ExecuteTarget(Self);
end;

procedure TfrmPrincipal.btnAlterarDocumentoClick(Sender: TObject);
var
    Query : TSQLQuery;
begin
    Query := TSQLQuery.Create(Self);
    Query.SQLConnection := bdDados;

    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Add('SELECT titulo, texto FROM documento WHERE id = :ID');
    Query.ParamByName('ID').AsInteger := StrToInt(ListBoxDocumentos.Selected.TagString);
    Query.Open;
    Query.First;

    lCriandoDocumento := False;
    Label18.Text      := Query.Fields[0].AsString;
    edtTitulo.Text    := Query.Fields[0].AsString;
    mmoTexto.Text     := Query.Fields[1].AsString;

    Query.Close;
    Query.Free;

    cngDocumento.ExecuteTarget(Self);
end;

procedure TfrmPrincipal.btnAnteriorClick(Sender: TObject);
var
    Query : TSQLQuery;
begin
    Query := TSQLQuery.Create(Self);
    Query.SQLConnection := bdDados;

    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Add('UPDATE documento SET num_atual = num_anterior WHERE id = :ID');
    Query.ParamByName('ID').AsInteger := StrToInt(ListBoxDocumentos.Selected.TagString);
    Query.ExecSQL();

    lblPalavra.Text  := '';
    lblDestaque.Text := '';

    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Add('SELECT num_palavras, num_atual, num_anterior FROM documento');
    Query.SQL.Add('WHERE id = :ID');
    Query.ParamByName('ID').AsInteger := StrToInt(ListBoxDocumentos.Selected.TagString);
    Query.Open;
    Query.First;

    Label25.Text := 'Atual: ' + Query.FieldByName('num_atual').AsString;

    btnInicio.Enabled    := True;
    btnAnterior.Enabled  := True;
    btnContinuar.Enabled := True;

    if Query.FieldByName('num_atual').AsInteger = 0 then
    begin
        btnInicio.Enabled   := False;
        btnAnterior.Enabled := False;
    end;

    if Query.FieldByName('num_atual').AsInteger >= Query.FieldByName('num_palavras').AsInteger then
       btnContinuar.Enabled := False;

    if Query.FieldByName('num_anterior').AsInteger >= Query.FieldByName('num_atual').AsInteger then
       btnAnterior.Enabled := False;

    Query.Close;
    Query.Free;
end;

procedure TfrmPrincipal.btnApagarDocumentoClick(Sender: TObject);
var
    Query : TSQLQuery;
begin
    Query := TSQLQuery.Create(Self);
    Query.SQLConnection := bdDados;

    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Add('SELECT titulo FROM documento WHERE id = :ID');
    Query.ParamByName('ID').AsInteger := StrToInt(ListBoxDocumentos.Selected.TagString);
    Query.Open;
    Query.First;

    Label15.Text := Query.Fields[0].AsString;

    Query.Close;
    Query.Free;

    cngConfirmaApagar.ExecuteTarget(Self);
end;

procedure TfrmPrincipal.btnCancelaApagarClick(Sender: TObject);
begin
    cngPrincipal.ExecuteTarget(Self);
end;

procedure TfrmPrincipal.btnCancelarClick(Sender: TObject);
begin
    cngPrincipal.ExecuteTarget(Self);
end;

procedure TfrmPrincipal.btnConfigClick(Sender: TObject);
begin
    lePalavrasConfig;
    cngConfig.ExecuteTarget(Self);
end;

procedure TfrmPrincipal.btnConfimarApagarClick(Sender: TObject);
begin
    ApagaDocumento(StrToInt(ListBoxDocumentos.Selected.TagString));
    MontaTela;
    cngPrincipal.ExecuteTarget(Self);
end;

procedure TfrmPrincipal.btnConfirmarClick(Sender: TObject);
var
    Query : TSQLQuery;
begin
    Query := TSQLQuery.Create(Self);
    Query.SQLConnection := bdDados;

    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Add('UPDATE config SET palavras_min = :Palavras, palavras_pausa = :Pausa WHERE id = 1');

    if cbxPalavras.ItemIndex = 0 then Query.ParamByName('Palavras').AsInteger := 250 else
    if cbxPalavras.ItemIndex = 1 then Query.ParamByName('Palavras').AsInteger := 350 else
    if cbxPalavras.ItemIndex = 2 then Query.ParamByName('Palavras').AsInteger := 450 else
    if cbxPalavras.ItemIndex = 3 then Query.ParamByName('Palavras').AsInteger := 550 else
    if cbxPalavras.ItemIndex = 4 then Query.ParamByName('Palavras').AsInteger := 650 else
    if cbxPalavras.ItemIndex = 5 then Query.ParamByName('Palavras').AsInteger := 750 else
    if cbxPalavras.ItemIndex = 6 then Query.ParamByName('Palavras').AsInteger := 850 else
    if cbxPalavras.ItemIndex = 7 then Query.ParamByName('Palavras').AsInteger := 950 else
    if cbxPalavras.ItemIndex = 8 then Query.ParamByName('Palavras').AsInteger := 1000;

    if cbxPausa.ItemIndex = 0 then Query.ParamByName('Pausa').AsInteger := 50  else
    if cbxPausa.ItemIndex = 1 then Query.ParamByName('Pausa').AsInteger := 100 else
    if cbxPausa.ItemIndex = 2 then Query.ParamByName('Pausa').AsInteger := 200 else
    if cbxPausa.ItemIndex = 3 then Query.ParamByName('Pausa').AsInteger := 300 else
    if cbxPausa.ItemIndex = 4 then Query.ParamByName('Pausa').AsInteger := 400 else
    if cbxPausa.ItemIndex = 5 then Query.ParamByName('Pausa').AsInteger := 500 else
    if cbxPausa.ItemIndex = 6 then Query.ParamByName('Pausa').AsInteger := 600 else
    if cbxPausa.ItemIndex = 7 then Query.ParamByName('Pausa').AsInteger := 700 else
    if cbxPausa.ItemIndex = 8 then Query.ParamByName('Pausa').AsInteger := 800 else
    if cbxPausa.ItemIndex = 9 then Query.ParamByName('Pausa').AsInteger := 900;

    Query.ExecSQL();
    Query.Close;
    Query.Free;

    cngPrincipal.ExecuteTarget(Self);
end;

procedure TfrmPrincipal.btnContinuarClick(Sender: TObject);
begin
    Leitura(StrToInt(ListBoxDocumentos.Selected.TagString));
end;

procedure TfrmPrincipal.btnInicioClick(Sender: TObject);
var
    Query : TSQLQuery;
begin
    Query := TSQLQuery.Create(Self);
    Query.SQLConnection := bdDados;

    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Add('UPDATE documento SET num_atual = 0, num_anterior = 0 WHERE id = :ID');
    Query.ParamByName('ID').AsInteger := StrToInt(ListBoxDocumentos.Selected.TagString);
    Query.ExecSQL();

    lblPalavra.Text  := '';
    lblDestaque.Text := '';
    Label25.Text     := 'Atual: 0';

    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Add('SELECT num_palavras, num_atual, num_anterior FROM documento');
    Query.SQL.Add('WHERE id = :ID');
    Query.ParamByName('ID').AsInteger := StrToInt(ListBoxDocumentos.Selected.TagString);
    Query.Open;
    Query.First;

    btnInicio.Enabled    := True;
    btnAnterior.Enabled  := True;
    btnContinuar.Enabled := True;

    if Query.FieldByName('num_atual').AsInteger = 0 then
    begin
        btnInicio.Enabled   := False;
        btnAnterior.Enabled := False;
    end;

    if Query.FieldByName('num_atual').AsInteger >= Query.FieldByName('num_palavras').AsInteger then
       btnContinuar.Enabled := False;

    if Query.FieldByName('num_anterior').AsInteger >= Query.FieldByName('num_atual').AsInteger then
       btnAnterior.Enabled := False;

    Query.Close;
    Query.Free;
end;

procedure TfrmPrincipal.btnLerDocumentoClick(Sender: TObject);
var
    Query : TSQLQuery;
begin
    lblPalavra.Text  := '';
    lblDestaque.Text := '';

    Query := TSQLQuery.Create(Self);
    Query.SQLConnection := bdDados;

    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Add('SELECT titulo, num_palavras, num_atual, num_anterior FROM documento WHERE id = :ID');
    Query.ParamByName('ID').AsInteger := StrToInt(ListBoxDocumentos.Selected.TagString);
    Query.Open;
    Query.First;

    Label17.Text := Query.Fields[0].AsString;
    Label21.Text := 'Palavras: ' + Query.Fields[1].AsString;
    Label25.Text := 'Atual: '    + Query.Fields[2].AsString;

    btnInicio.Enabled    := True;
    btnAnterior.Enabled  := True;
    btnContinuar.Enabled := True;

    if Query.FieldByName('num_atual').AsInteger = 0 then
    begin
        btnInicio.Enabled   := False;
        btnAnterior.Enabled := False;
    end;

    if Query.FieldByName('num_atual').AsInteger >= Query.FieldByName('num_palavras').AsInteger then
       btnContinuar.Enabled := False;

    if Query.FieldByName('num_anterior').AsInteger >= Query.FieldByName('num_atual').AsInteger then
       btnAnterior.Enabled := False;

    Query.Close;
    Query.Free;

    cngLeitura.ExecuteTarget(Self);
end;

procedure TfrmPrincipal.btnOK_tabSobreClick(Sender: TObject);
begin
    cngPrincipal.ExecuteTarget(Self);
end;

procedure TfrmPrincipal.btnSairClick(Sender: TObject);
begin
    MessageDlg('Deseja realmente encerrar o aplicativo ?', TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0,
    procedure(const AResult: TModalResult)
    begin
        if AResult = mrYes then
           Close
        else
           Exit;
    end);
end;

procedure TfrmPrincipal.btnSobreClick(Sender: TObject);
begin
    cngSobre.ExecuteTarget(Self);
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    bdDados.Close;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
    System.SysUtils.FormatSettings.ShortDateFormat := 'dd/mm/yyyy';
    Application.OnIdle := OnIdle;

    bdDados.Open;

    TabControl1.ActiveTab := tabPrincipal;
end;

procedure TfrmPrincipal.FormKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
var
    FService : IFMXVirtualKeyboardService;
begin
    if Key = vkHardwareBack then
    begin
        Key := 0;

        TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(FService));

        if (FService <> nil) and (TVirtualKeyboardState.Visible in FService.VirtualKeyBoardState) then
        begin
            FService.HideVirtualKeyboard();
            Exit;
        end;

        if TabControl1.ActiveTab = tabPrincipal then
           btnSair.OnClick(Sender);

        if TabControl1.ActiveTab = tabSobre          then cngPrincipal.ExecuteTarget(Self) else
        if TabControl1.ActiveTab = tabConfig         then cngPrincipal.ExecuteTarget(Self) else
        if TabControl1.ActiveTab = tabConfirmaApagar then cngPrincipal.ExecuteTarget(Self) else
        if TabControl1.ActiveTab = tabDocumento      then cngPrincipal.ExecuteTarget(Self) else
        if TabControl1.ActiveTab = tabLeitura        then cngPrincipal.ExecuteTarget(Self) else
        if TabControl1.ActiveTab = tabArquivos       then cngDocumento.ExecuteTarget(Self);
    end;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
    MontaTela;
end;

procedure TfrmPrincipal.OnIdle(Sender: TObject; var ADone: Boolean);
begin
    btnApagarDocumento.Enabled  := ListBoxDocumentos.Selected <> Nil;
    btnAlterarDocumento.Enabled := ListBoxDocumentos.Selected <> Nil;
    btnLerDocumento.Enabled     := ListBoxDocumentos.Selected <> Nil;

    if ListBoxDocumentos.Selected <> nil then
    begin
        if ListBoxDocumentos.Selected.TagString = '0' then
        begin
            btnApagarDocumento.Enabled  := False;
            btnAlterarDocumento.Enabled := False;
        end;
    end;
end;

end.
