unit uFileByDate;

interface

procedure DoWork;

implementation

uses Windows, SysUtils, Exif;

procedure DoWork;
var
  sPath, sFileName, sDate: string;
  D: TDateTime;
  E: TExif;
  AFormatSettings: TFormatSettings;
begin
  with AFormatSettings do
  begin
    LongDateFormat := 'yyyy''Äê''MM''ÔÂ''dd''ÈÕ''';
    ShortDateFormat := 'yyyy:MM:dd';
    LongTimeFormat := 'HH:mm:ss';
    ShortTimeFormat := 'HH:mm';
    DateSeparator := ':';
    TimeSeparator := ':';
  end;
  if ParamCount > 0 then
  begin
    sFileName := ParamStr(1);
    if FileExists(sFileName) then
    begin
      E := TExif.Create;
      try
        E.ReadFromFile(sFileName);
        sDate := StringReplace(E.DateTimeOriginal, '-', ':', [rfReplaceAll]);
        if not TryStrToDateTime(sDate, D, AFormatSettings) then
          D := FileDateToDateTime(FileAge(sFileName));
      finally
        E.Free;
      end;

      sPath := ExtractFilePath(ParamStr(0)) + FormatDateTime('yyyy-MM', D);
      ForceDirectories(sPath);
      if MoveFileEx(PChar(sFileName), PChar(sPath + '\' + ExtractFileName(sFileName)), MOVEFILE_REPLACE_EXISTING or MOVEFILE_COPY_ALLOWED) then
        Writeln(sFileName)
      else
        Writeln('fail');
    end
    else
      Writeln('file not exists');
  end
  else
    Writeln('please input filename');
end;

end.

