unit func;

interface

uses
  System.SysUtils,
  System.Classes,
  System.DateUtils,
  Dialogs,
  System.Math,
  System.IniFiles;

  { functions }
//  function FlipDate(date: string): string;
//  function ChangeColor(category: string): integer;
//  function changeColorImage(category: string): integer;
//  function bodyShort(body: string): string;
//  function typeToHuman(adType: string): string;
  function relativeTime(datetime: string): string;
  function relativeTimeFuture(datetime: string): string;
  function GetLogoFilePathFromIni: string;
  function GetSaveFilePathFromIni: string;

  { procedures }
//  procedure LoadImageFromURL(img: TBitmap; url: string);

implementation


// -----------------------------------------------------------------------------
// relativeTime
// e.g 07.01.2023 01.16 -> hace 1 minuto
// -----------------------------------------------------------------------------
function relativeTime(datetime: string): string;
var
  fs: TFormatSettings;
  dt: TDateTime;
  dtuDB, dtuNow: double;
  diff, day_diff: double;
begin
  { format datetime }
  fs := TFormatSettings.Create;
  fs.DateSeparator := '-';
  fs.ShortDateFormat := 'yyyy-MM-dd';
  fs.TimeSeparator := ':';
  fs.ShortTimeFormat := 'hh:mm';
  fs.LongTimeFormat := 'hh:mm:ss';
  dt := StrToDateTime(datetime, fs);

  dtuDB := dateTimeToUnix(dt);
  dtuNow := dateTimeToUnix(now());

  diff:= dtuNow - dtuDB;

  if diff = 0 then
  begin
    result:= 'Ahora mismo';
  end
  else if diff > 0 then
  begin
    day_diff:= floor(diff/86400);

    if day_diff = 0 then
    begin
      if (diff < 60) then
      begin
        result := 'Menos de un minuto';
      end
      else if (diff < 120) then
      begin
        result := 'Hace 1 minuto';
      end
      else if (diff < 3600) then
      begin
        result:= 'Hace ' + inttostr(round(diff/60)) + ' minutos';
      end
      else if (diff < 7200) then
      begin
        result:= 'Hace 1 hora';
      end
      else if (diff < 86400) then
      begin
        result:= 'Hace ' + inttostr(round(diff/3600)) + ' horas';
      end;
    end
    else if (day_diff = 1) then
    begin
      result:= 'Ayer';
    end
    else if (day_diff < 7) then
    begin
      result:= 'Hace ' + day_diff.ToString + ' días';
    end
    else if (day_diff < 14) then
    begin
      result:= 'Hace 1 semana';
    end
    else if (day_diff < 31) then
    begin
      result:= 'Hace ' + inttostr(ceil(day_diff/7)) + ' semanas';
    end
    else if (day_diff < 60) then
    begin
      result:= 'Hace 1 mes';
    end
    else
    begin
      result := datetime;
    end;
  end
  else
  begin
    // need to implement: in ' . floor($diff / 60) . ' minutes'
  end;
end;

// Esta funcion me dice: mañana cuando son dos días
//function relativeTimeFuture(datetime: string): string;
//var
//  fs: TFormatSettings;
//  dt: TDateTime;
//  dtuDB, dtuNow: double;
//  diff, day_diff: double;
//begin
//  { format datetime }
//  fs := TFormatSettings.Create;
//  fs.DateSeparator := '-';
//  fs.ShortDateFormat := 'yyyy-MM-dd';
//  fs.TimeSeparator := ':';
//  fs.ShortTimeFormat := 'hh:mm';
//  fs.LongTimeFormat := 'hh:mm:ss';
//  dt := StrToDateTime(datetime, fs);
//
//  dtuDB := dateTimeToUnix(dt);
//  dtuNow := dateTimeToUnix(now());
//
//  diff := dtuDB - dtuNow; // Calculate time difference for the future
//
//  if diff = 0 then
//  begin
//    result := 'Ahora mismo';
//  end
//  else if diff > 0 then
//  begin
//    day_diff := floor(diff / 86400);
//
//    if day_diff = 0 then
//    begin
//      if (diff < 60) then
//      begin
//        result := 'En menos de un minuto';
//      end
//      else if (diff < 120) then
//      begin
//        result := 'En 1 minuto';
//      end
//      else if (diff < 3600) then
//      begin
//        result := 'En ' + inttostr(round(diff / 60)) + ' minutos';
//      end
//      else if (diff < 7200) then
//      begin
//        result := 'En 1 hora';
//      end
//      else if (diff < 86400) then
//      begin
//        result := 'En ' + inttostr(round(diff / 3600)) + ' horas';
//      end;
//    end
//    else if (day_diff = 1) then
//    begin
//      result := 'Mañana';
//    end
//    else if (day_diff < 7) then
//    begin
//      result := 'En ' + day_diff.ToString + ' días';
//    end
//    else if (day_diff < 14) then
//    begin
//      result := 'En 1 semana';
//    end
//    else if (day_diff < 31) then
//    begin
//      result := 'En ' + inttostr(ceil(day_diff / 7)) + ' semanas';
//    end
//    else if (day_diff < 60) then
//    begin
//      result := 'En 1 mes';
//    end
//    else
//    begin
//      result := datetime;
//    end;
//  end
//  else
//  begin
//    // You can implement handling for negative time differences if needed.
//  end;
//end;

function relativeTimeFuture(datetime: string): string;
var
  fs: TFormatSettings;
  dt: TDateTime;
  dtuDB, dtuNow: double;
  diff, day_diff: double;
begin
  { format datetime }
  fs := TFormatSettings.Create;
  fs.DateSeparator := '-';
  fs.ShortDateFormat := 'yyyy-MM-dd';
  fs.TimeSeparator := ':';
  fs.ShortTimeFormat := 'hh:mm';
  fs.LongTimeFormat := 'hh:mm:ss';
  dt := StrToDateTime(datetime, fs);

  dtuDB := dateTimeToUnix(dt);
  dtuNow := dateTimeToUnix(now());

  diff := dtuDB - dtuNow; // Calculate time difference for the future

  if diff = 0 then
  begin
    result := 'Ahora mismo';
  end
  else if diff > 0 then
  begin
    day_diff := floor(diff / 86400);

    if (day_diff = 1) and (diff < 86400) then
    begin
      result := 'Mañana';
    end
    else if (diff < 60) then
    begin
      result := 'En menos de un minuto';
    end
    else if (diff < 120) then
    begin
      result := 'En 1 minuto';
    end
    else if (diff < 3600) then
    begin
      result := 'En ' + inttostr(round(diff / 60)) + ' minutos';
    end
    else if (diff < 7200) then
    begin
      result := 'En 1 hora';
    end
    else if (diff < 86400) then
    begin
      result := 'En ' + inttostr(round(diff / 3600)) + ' horas';
    end
    else if (day_diff = 1) then
    begin
      result := 'En 1 día';
    end
    else if (day_diff > 1) then
    begin
      result := 'En ' + inttostr(round(day_diff)) + ' días';
    end;
  end
  else
  begin
    // You can implement handling for negative time differences if needed.
  end;
end;

function GetLogoFilePathFromIni: string;
var
  IniFile: TIniFile;
  FilePath: string;
begin
  IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'env.ini');
  try
    FilePath := IniFile.ReadString('Images', 'LogoFilePath', '');

    if FilePath = '' then
      raise Exception.Create('El LogoFilePath no se encontró en el archivo env.ini');
  finally
    IniFile.Free;
  end;
  Result := FilePath;
end;

function GetSaveFilePathFromIni: string;
var
  IniFile: TIniFile;
  FilePath: string;
begin
  IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'env.ini');
  try
    FilePath := IniFile.ReadString('Images', 'SaveFilePath', '');

    if FilePath = '' then
      raise Exception.Create('El SaveFilePath no se encontró en el archivo env.ini');
  finally
    IniFile.Free;
  end;
  Result := FilePath;
end;

end.
