unit ad_list;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.Grids, Vcl.ExtCtrls, System.DateUtils,

  uAPIRest, Vcl.StdCtrls;

type
  Tfrm_ad_list = class(TForm)
    pnl_container: TPanel;
    pnl_body: TPanel;
    sg_data: TStringGrid;
    pnl_header: TPanel;
    btn_refresh: TSpeedButton;
    btn_new: TButton;
    btn_edit: TButton;
    edt_delete: TButton;
    lbl_count: TLabel;
    btn_pag_1: TButton;
    btn_pag_2: TButton;
    btn_pag_3: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure btn_printClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btn_editClick(Sender: TObject);
    procedure btn_newClick(Sender: TObject);
    procedure btn_pag_1Click(Sender: TObject);
    procedure btn_pag_2Click(Sender: TObject);
    procedure btn_pag_3Click(Sender: TObject);
  private
    procedure clearControls;
    procedure getAds;
  public
    _ad_id, _city_id, _date, _status, _category_id, _category_name,
    _type_id, _type_name, _body, _address, _latitude,
    _longitude, _condition, _isIA, _price, _bath, _wifi,
    _cable, _parking_moto, _parking_car, _thermal, _laundry,
    _silent, _pets, _currency, _year, _mileage, _engine,
    _fuel, _transmission, _color : String;
    _phones, _images, _brands, _models : array of string;

    _page: string;
  end;

var
  frm_ad_list: Tfrm_ad_list;
  ads: TAPIRest;

implementation

{$R *.dfm}

uses
  func, main, ad_details;

procedure Tfrm_ad_list.btn_editClick(Sender: TObject);
var
  ad    : TAPIRest;
  phones: TAPIRest;
  images: TAPIRest;
  i     : integer;
begin
  if sg_data.Cells[0,sg_data.Row] <> '' then
  begin

    { ads }
    ad := TAPIRest.Create;
    ad.config(
      'https://api.avisoscenter.com/v1/getAdFromId',
      '',
      '',
      'ad_id',
      sg_data.Cells[0,sg_data.Row],
      '?ad_id={ad_id}',
      'items'
    );

    ad.getAd;

    _ad_id        := ad.id(0);
    _date         := ad.date(0);
    _category_id  := ad.categoryId(0);
    _category_name:= ad.categoryName(0);
    _type_id      := ad.typeId(0);
    _type_name    := ad.typeName(0);
    _body         := ad.ad(0);
    _address      := ad.address(0);
    _latitude     := ad.latitude(0);
    _longitude    := ad.longitude(0);
    _condition    := ad.condition(0);
    _isIA         := ad.isIA(0);
    _price        := ad.price(0);
    _bath         := ad.bath(0);
    _wifi         := ad.wifi(0);
    _cable        := ad.cable(0);
    _parking_moto := ad.parkingMoto(0);
    _parking_car  := ad.parkingCar(0);
    _thermal      := ad.thermal(0);
    _laundry      := ad.laundry(0);
    _silent       := ad.silent(0);
    _pets         := ad.pets(0);
    _status       := ad.status(0);

    { phones }
    phones := TAPIRest.Create;
    phones.config(
      'https://api.avisoscenter.com/v1/getPhonesFromId',
      '',
      '',
      'ad_id',
      sg_data.Cells[0,sg_data.Row],
      '?ad_id={ad_id}',
      'items'
    );

    phones.getPhonesFromId;
    SetLength(_phones, phones.count);

    for i := 0 to phones.count-1 do
    begin
      _phones[i]:= phones.phones(i);
    end;

    { images }
    images := TAPIRest.Create;
    images.config(
      'https://api.avisoscenter.com/v1/getImagesFromAd',
      '',
      '',
      'ad_id',
      sg_data.Cells[0,sg_data.Row],
      '?ad_id={ad_id}',
      'items'
    );

    images.getImagesFromId;
    SetLength(_images, images.count);

    for i := 0 to images.count-1 do
    begin
      _images[i]:= images.images(i);
//      showMessage(images.images(i));
    end;

    { is edit or new ? }
    if not Assigned(frm_ad_details) then
    begin
      frm_ad_details := Tfrm_ad_details.Create(Application, 'edit');
      frm_ad_details.Caption := 'Editar Aviso';
//      frm_ad_details.Left := (frm_main.Width - frm_ad_details.Width) div 2;
//      frm_ad_details.Top := (frm_main.Height - frm_ad_details.Height) div 4;
      frm_ad_details.Left := self.Left;
      frm_ad_details.Top := self.top;
      frm_ad_details.Show;
    end;
  end
  else
  begin
    // empty
  end;
end;

procedure Tfrm_ad_list.btn_newClick(Sender: TObject);
begin
  if not Assigned(frm_ad_details) then
  begin
    frm_ad_details := Tfrm_ad_details.Create(Application, 'new');
//    frm_ad_details.Left := (frm_main.Width - frm_ad_details.Width) div 2;
//    frm_ad_details.Top := (frm_main.Height - frm_ad_details.Height) div 4;
    frm_ad_details.Left := self.Left;
    frm_ad_details.Top := self.top;
    frm_ad_details.Show;
  end;
end;

procedure Tfrm_ad_list.btn_pag_1Click(Sender: TObject);
begin
  _page:= '?page=1';
  getAds;
end;

procedure Tfrm_ad_list.btn_pag_2Click(Sender: TObject);
begin
  _page:= '?page=2';
  getAds;
end;

procedure Tfrm_ad_list.btn_pag_3Click(Sender: TObject);
begin
  _page:= '?page=3';
  getAds;
end;

procedure Tfrm_ad_list.btn_printClick(Sender: TObject);
begin
  getAds;
end;

procedure Tfrm_ad_list.clearControls;
var
  cbase: integer;
  remainingWidth: Integer;
begin
  sg_data.ColCount:= 12;
  cbase:= 700;

  sg_data.Cells[0, 0] := 'ID';
  sg_data.Cells[1, 0] := 'Publicación';
  sg_data.Cells[2, 0] := 'Categoría';
  sg_data.Cells[3, 0] := 'Aviso';
  sg_data.Cells[4, 0] := 'Dirección';
  sg_data.Cells[5, 0] := 'Condición';
  sg_data.Cells[6, 0] := 'Estado';
  sg_data.Cells[7, 0] := 'Mapa';
  sg_data.Cells[8, 0] := 'Updated';
  sg_data.Cells[9, 0] := 'Expired';
  sg_data.Cells[10, 0]:= 'ExpDate';
  sg_data.Cells[11, 0]:= 'Notas';

  sg_data.ColWidths[0] := 50;
  sg_data.ColWidths[1] := 125;
  sg_data.ColWidths[2] := 75;
//  sg_data.ColWidths[3] := sg_data.Width - cbase;
  sg_data.ColWidths[4] := 200;
  sg_data.ColWidths[5] := 75;
  sg_data.ColWidths[6] := 40;
  sg_data.ColWidths[7] := 40;
  sg_data.ColWidths[8] := 80;
  sg_data.ColWidths[9] := 80;
  sg_data.ColWidths[10]:= 65;
  sg_data.ColWidths[11]:= 100;

   // Calcula el ancho restante para el campo "Aviso"
  remainingWidth := sg_data.Width - (sg_data.ColWidths[0] + sg_data.ColWidths[1] +
    sg_data.ColWidths[2] + sg_data.ColWidths[4] + sg_data.ColWidths[5] +
    sg_data.ColWidths[6] + sg_data.ColWidths[7] + sg_data.ColWidths[8] +
    sg_data.ColWidths[9] + sg_data.ColWidths[10]+ sg_data.ColWidths[11]) - 30;

  // Asigna el ancho restante al campo "Aviso"
  sg_data.ColWidths[3] := remainingWidth;
end;

procedure Tfrm_ad_list.FormActivate(Sender: TObject);
begin
  clearControls;
  getAds;

  WindowState := wsNormal;
  Left := 0;
  Top := 0;
end;

procedure Tfrm_ad_list.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  frm_ad_list.Release;
  frm_ad_list := nil;
end;

procedure Tfrm_ad_list.FormResize(Sender: TObject);
begin
  clearControls;
end;

procedure Tfrm_ad_list.getAds;
var
  i: integer;
  dateTimeStr : string;
  formattedDateTimeStr: string;
  dateTime : TDateTime;
begin
  ads := TAPIRest.Create;
  ads.config(
    'https://api.avisoscenter.com/v1/getAllAdsWithoutStatus',
    //'http://159.223.101.156/api/getAllAdsWithoutStatus',
    '',
    '',
    '', //name
    '',
    _page, //?name={name}
    'items'
  );

  ads.getAds;

  sg_data.RowCount:= ads.count + 1;

   lbl_count.Caption:= ads.count.ToString;

  for i := 0 to ads.count-1 do
  begin
//    sg_data.Cells[0, i+1] := document.date(i);
//    dateTimeStr := ads.date(i);
//    dateTime := ISO8601ToDate(dateTimeStr);
//    formattedDateTimeStr := FormatDateTime('dd-mm-yyyy hh:nn', dateTime);
//    formattedDateTimeStr := FormatDateTime('dd-mm-yyyy', dateTime);
    sg_data.Cells[0, i+1] := ads.id(i);
//    sg_data.Cells[1, i+1] := formattedDateTimeStr;
    sg_data.Cells[1, i+1] := relativeTime(ads.date(i));
    sg_data.Cells[2, i+1] := ads.categoryName(i);
    sg_data.Cells[3, i+1] := ads.ad(i);
    sg_data.Cells[4, i+1] := ads.address(i);
    sg_data.Cells[5, i+1] := ads.condition(i);
    sg_data.Cells[6, i+1] := ads.status(i);

    { status }
    if (ads.status(i) = '1') then
    begin
      sg_data.Cells[6, i+1] := 'OK';
    end
    else
    if (ads.status(i) = '0') then
    begin
      sg_data.Cells[6, i+1] := '--';
    end;

    { map }
    if (ads.latitude(i) = 'null') or (ads.longitude(i) = 'null') then
    begin
      sg_data.Cells[7, i+1] := '--';
    end
    else
    begin
      sg_data.Cells[7, i+1] := 'SI';
    end;

    { updated }
    if (ads.updated(i) = 'null') then
    begin
      sg_data.Cells[8, i+1] := '--';
    end
    else
    begin
      sg_data.Cells[8, i+1] := relativeTime(ads.updated(i));
    end;

    { expired }
    if (ads.expired(i) = 'null') then
    begin
      sg_data.Cells[9, i+1] := '--';
    end
    else
    begin
      sg_data.Cells[9, i+1] := relativeTimeFuture(ads.expired(i));
    end;

    sg_data.Cells[10, i+1]:= ads.expired(i);
    sg_data.Cells[11, i+1]:= ads.notes(i);
  end;
end;

end.
