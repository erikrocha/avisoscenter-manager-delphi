unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls,
  Vcl.ExtCtrls, Vcl.Menus,

  uAPIRest;

type
  Tfrm_main = class(TForm)
    Panel1: TPanel;
    PageControl1: TPageControl;
    tab_adds: TTabSheet;
    Panel8: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    tab_clients: TTabSheet;
    Panel9: TPanel;
    Panel15: TPanel;
    btn_clientNew: TSpeedButton;
    Panel17: TPanel;
    SpeedButton11: TSpeedButton;
    TabSheet4: TTabSheet;
    Panel2: TPanel;
    Panel4: TPanel;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    Panel5: TPanel;
    SpeedButton2: TSpeedButton;
    Label2: TLabel;
    Panel6: TPanel;
    SpeedButton3: TSpeedButton;
    Label3: TLabel;
    Panel7: TPanel;
    SpeedButton4: TSpeedButton;
    Label4: TLabel;
    btn_add_list: TSpeedButton;
    MainMenu1: TMainMenu;
    Menu1: TMenuItem;
    mnu_exit: TMenuItem;
    Window1: TMenuItem;
    mnu_cascade: TMenuItem;
    mnu_hotizontally: TMenuItem;
    mnu_vertically: TMenuItem;
    mnu_minimize: TMenuItem;
    mnu_arrangle: TMenuItem;
    mnu_help: TMenuItem;
    Acerca1: TMenuItem;
    Panel3: TPanel;
    SpeedButton5: TSpeedButton;
    edt_phone: TEdit;
    lb_ads: TListBox;
    lbl_ads_count: TLabel;
    btn_ads_clear: TButton;
    procedure btn_add_listClick(Sender: TObject);
    procedure btn_add_newClick(Sender: TObject);
    procedure edt_phoneKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure lb_adsDblClick(Sender: TObject);
    procedure btn_ads_clearClick(Sender: TObject);
  private
    procedure getAdsFromPhone;
  public
    { Public declarations }
  end;

var
  frm_main: Tfrm_main;

implementation

{$R *.dfm}

uses
  func, ad_list, ad_details;

procedure Tfrm_main.btn_add_listClick(Sender: TObject);
begin
  if not Assigned(frm_ad_list) then
  begin
    frm_ad_list := Tfrm_ad_list.Create(Application);
//    frm_ad_list.Width := 1000;
//    frm_ad_list.Height := 500;

//    frm_ad_list.Align := alClient;

//    frm_ad_list.Width := Self.ClientWidth - 3;
//    frm_ad_list.Height := Self.ClientHeight - 115;
    frm_ad_list.Show;


  end;
end;

procedure Tfrm_main.btn_add_newClick(Sender: TObject);
begin
  if not Assigned(frm_ad_details) then
  begin
    frm_ad_details := Tfrm_ad_details.Create(Application, 'new');
//    frm_ad_details.Left := (frm_main.Width - frm_ad_details.Width) div 2;
//    frm_ad_details.Top := (frm_main.Height - frm_ad_details.Height) div 4;
    frm_ad_details.Show;
  end;
end;

procedure Tfrm_main.btn_ads_clearClick(Sender: TObject);
begin
  lb_ads.Clear;
  lbl_ads_count.Caption:= '0';
  edt_phone.SetFocus;
end;

procedure Tfrm_main.edt_phoneKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
  begin
    lb_ads.Clear;
    getAdsFromPhone;
  end;
end;

procedure Tfrm_main.FormActivate(Sender: TObject);
begin
  edt_phone.SetFocus;
end;

procedure Tfrm_main.getAdsFromPhone;
var
  ads: TAPIRest;
  i: integer;
begin
  ads := TAPIRest.Create;
  ads.config(
    'https://api.avisoscenter.com/v1/getAdsFromPhone',
    //'http://159.223.101.156/api/getAdsFromPhone',
    '',
    '',
    'number',
    edt_phone.Text,
    '?number={number}',
    'items'
  );

  ads.getAdsFromPhone;
  lbl_ads_count.Caption:= ads.count.ToString;

  if ads.count > 0 then
  begin
    for i := 0 to ads.count-1 do
    begin
      lb_ads.items.Add(ads.phones(i) + ' | ' + Format('%06d', [ads.id(i).ToInteger]) + ' | ' + ads.categoryName(i) + ': ' + ads.ad(i) + ' | ' + ads.status(i) + ' | ' + relativeTime(ads.date(i)) );
    end;
  end
  else
  begin
      lb_ads.items.Add('No se encontraron resultados');
  end;


end;

procedure Tfrm_main.lb_adsDblClick(Sender: TObject);
begin
  showMessage(lb_ads.Items[lb_ads.ItemIndex]);
end;

end.
