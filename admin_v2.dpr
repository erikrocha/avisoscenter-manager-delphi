program admin_v2;

uses
  Vcl.Forms,
  main in 'main.pas' {frm_main},
  Vcl.Themes,
  Vcl.Styles,
  uAPIRest in 'classes\uAPIRest.pas',
  func in 'inc\func.pas',
  ad_details in 'ad_details.pas' {frm_ad_details},
  ad_list in 'ad_list.pas' {frm_ad_list};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Iceberg Classico');
  Application.CreateForm(Tfrm_main, frm_main);
  Application.Run;
end.
