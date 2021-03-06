unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, ImgList, JvImageWindow, JvComponent;

type
  TForm1 = class(TForm)
    ImageList1: TImageList;
    ImageWindow1: TJvImageWindow;
    MainMenu1: TMainMenu;
    Open1: TMenuItem;
    N2ndform1: TMenuItem;
    N2ndform2: TMenuItem;
    Columns1: TMenuItem;
    Change1: TMenuItem;
    Pics1: TMenuItem;
    procedure ImageWindow1Click(Sender: TObject);
    procedure N2ndform1Click(Sender: TObject);
    procedure N2ndform2Click(Sender: TObject);
    procedure Change1Click(Sender: TObject);
    procedure Pics1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Unit2, Unit3;

{$R *.DFM}

procedure TForm1.ImageWindow1Click(Sender: TObject);
begin
  Caption := Format('You clicked image %d',[ImageWindow1.ImageIndex]);
end;

procedure TForm1.N2ndform1Click(Sender: TObject);
begin
  Form3.Show;
end;

procedure TForm1.N2ndform2Click(Sender: TObject);
begin
  Form2.ShowModal;
end;

procedure TForm1.Change1Click(Sender: TObject);
var S:string;C:integer;
begin
  S := IntToStr(ImageWindow1.ColCount);
  if InputQuery('Change columns','Columns:',S) then
  begin
    C := StrToInt(S);
    with ImageWindow1 do
    begin
      if ImageCount < C then
        ImageCount := C;
      ColCount := C;
    end;
  end;
end;

procedure TForm1.Pics1Click(Sender: TObject);
var S:string;C:integer;
begin
  S := IntToStr(ImageWindow1.ImageCount);
  if InputQuery('Change pics display',
  Format('Show number of pics: ( max %d )',[ImageList1.Count]),S) then
  begin
    C := StrToInt(S);
    ImageWindow1.ImageCount := C;
  end;
end;

end.


