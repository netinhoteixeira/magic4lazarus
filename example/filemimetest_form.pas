unit filemimetest_form;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, EditBtn,
  StdCtrls, magic4lazarus;

type

  { TFormFileMimeTest }

  TFormFileMimeTest = class(TForm)
    CheckBoxOnlyMimeType: TCheckBox;
    CheckBoxOnlyMimeEncoding: TCheckBox;
    FileNameEdit: TFileNameEdit;
    LabelFileName: TLabel;
    Memo: TMemo;
    procedure CheckBoxOnlyMimeEncodingChange(Sender: TObject);
    procedure CheckBoxOnlyMimeTypeChange(Sender: TObject);
    procedure FileNameEditAcceptFileName(Sender: TObject; var Value: string);
  public
    procedure Refresh(filename: string);
  end;

var
  FormFileMimeTest: TFormFileMimeTest;

implementation

{$R *.lfm}

{ TFormFileMimeTest }

procedure TFormFileMimeTest.FileNameEditAcceptFileName(Sender: TObject; var Value: string);
begin
  Refresh(Value);
end;

procedure TFormFileMimeTest.Refresh(filename: string);
var
  filemagic: string;
begin
  if (FileExists(filename)) then
  begin
    filemagic := ExtractFilePath(Application.ExeName) + 'magic.mgc';

    Memo.Clear();
    Memo.Lines.Add('Choised file: ' + filename);

    try
      if (not CheckBoxOnlyMimeType.Checked and not CheckBoxOnlyMimeEncoding.Checked) then
      begin
        Memo.Lines.Add('Mime retrive kind: MIME');
        Memo.Lines.Add('Mime of content: ' + DetectMimeFromFile(filename, filemagic));
      end
      else if (CheckBoxOnlyMimeType.Checked) then
      begin
        Memo.Lines.Add('Mime retrive kind: MIME TYPE');
        Memo.Lines.Add('Mime of content: ' + DetectMimeTypeFromFile(filename, filemagic));
      end
      else if (CheckBoxOnlyMimeEncoding.Checked) then
      begin
        Memo.Lines.Add('Mime retrive kind: MIME ENCODING');
        Memo.Lines.Add('Mime of content: ' + DetectMimeEncodingFromFile(filename, filemagic));
      end;
    except
      on e: Exception do
      begin
        Memo.Lines.Add(e.Message);
      end;
    end;
  end;
end;

procedure TFormFileMimeTest.CheckBoxOnlyMimeTypeChange(Sender: TObject);
begin
  if (CheckBoxOnlyMimeType.Checked) then
  begin
    CheckBoxOnlyMimeEncoding.Checked := False;
  end;

  Refresh(FileNameEdit.Text);
end;

procedure TFormFileMimeTest.CheckBoxOnlyMimeEncodingChange(Sender: TObject);
begin
  if (CheckBoxOnlyMimeEncoding.Checked) then
  begin
    CheckBoxOnlyMimeType.Checked := False;
  end;

  Refresh(FileNameEdit.Text);
end;

end.

