program filemimetest;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, Forms, filemimetest_form, magic4lazarus;

begin
  Application.Initialize;
  Application.CreateForm(TFormFileMimeTest, FormFileMimeTest);
  Application.Run;
end.

