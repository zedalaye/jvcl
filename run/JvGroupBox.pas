{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvAlignListbox.PAS, released on 2000-11-22.

The Initial Developer of the Original Code is Peter Below <100113.1101@compuserve.com>
Portions created by Peter Below are Copyright (C) 2000 Peter Below.
All Rights Reserved.

Contributor(s): ______________________________________.

Last Modified: 2000-mm-dd

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}

{$I jvcl.inc}

unit JvGroupBox;

interface

uses
  SysUtils, Classes,
  {$IFDEF WINDOWS}
  Windows,
  {$ENDIF}
  {$IFDEF VCL}
  Messages, Graphics, Controls, Forms, StdCtrls,
  {$ENDIF}
  {$IFDEF VisualCLX}
  QWindows, QGraphics, QControls, QForms, QStdCtrls,
  {$ENDIF}
  JVCLVer, JvThemes, JvExStdCtrls;

type
  TJvGroupBox = class(TJvExGroupBox)
  private
    FAboutJVCL: TJVCLAboutInfo;
    FOnHotKey: TNotifyEvent;
    FHintColor: TColor;
    FSaved: TColor;
    FOnParentColorChange: TNotifyEvent;
    FOver: Boolean;
    FPropagateEnable: Boolean;
    procedure SetPropagateEnable(const Value: Boolean);
    {$IFDEF VCL}
    procedure CMDenySubClassing(var Msg: TMessage); message CM_DENYSUBCLASSING;
    {$ENDIF}
  {$IFDEF JVCLThemesEnabledD56}
    function GetParentBackground: Boolean;
  protected
    procedure SetParentBackground(Value: Boolean); virtual;
  {$ENDIF JVCLThemesEnabledD56}
  protected
    function WantKey(Key: Integer; Shift: TShiftState;
      const KeyText: WideString): Boolean; override;
    procedure MouseEnter(Control: TControl); override;
    procedure MouseLeave(Control: TControl); override;
    procedure EnabledChanged; override;
    procedure ParentColorChanged; override;
    procedure DoHotKey; dynamic;
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    property Canvas;
  published
    property AboutJVCL: TJVCLAboutInfo read FAboutJVCL write FAboutJVCL stored False;
    property HintColor: TColor read FHintColor write FHintColor default clInfoBk;
    {$IFDEF JVCLThemesEnabledD56}
    property ParentBackground: Boolean read GetParentBackground write SetParentBackground default True;
    {$ENDIF JVCLThemesEnabledD56}
    property PropagateEnable: Boolean read FPropagateEnable write SetPropagateEnable default False;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnParentColorChange: TNotifyEvent read FOnParentColorChange write FOnParentColorChange;
    property OnHotKey: TNotifyEvent read FOnHotKey write FOnHotKey;
  end;

implementation

uses
  Math;

constructor TJvGroupBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FHintColor := clInfoBk;
  FOver := False;
  FPropagateEnable := False;
  ControlStyle := ControlStyle + [csAcceptsControls];
  IncludeThemeStyle(Self, [csParentBackground]);
end;

procedure TJvGroupBox.Paint;
var
  H: Integer;
  R: TRect;
  Flags: Longint;
  {$IFDEF JVCLThemesEnabledD56}
  Details: TThemedElementDetails;
  CaptionRect: TRect;
  {$ENDIF}
begin
  {$IFDEF JVCLThemesEnabled}
  if ThemeServices.ThemesEnabled then
  begin
    {$IFDEF COMPILER7_UP}
    inherited;
    {$ELSE}
    if Enabled then
      Details := ThemeServices.GetElementDetails(tbGroupBoxNormal)
    else
      Details := ThemeServices.GetElementDetails(tbGroupBoxDisabled);
    R := ClientRect;
    Inc(R.Top, Canvas.TextHeight('0') div 2);
    ThemeServices.DrawElement(Canvas.Handle, Details, R);

    CaptionRect := Rect(8, 0, Min(Canvas.TextWidth(Caption) + 8, ClientWidth - 8),
      Canvas.TextHeight(Caption));

    Canvas.Brush.Color := Self.Color;
    DrawThemedBackground(Self, Canvas, CaptionRect);
    ThemeServices.DrawText(Canvas.Handle, Details, Caption, CaptionRect, DT_LEFT, 0);
    {$ENDIF COMPILER7_UP}
    Exit;
  end;
  {$ENDIF JVCLThemesEnabled}
  with Canvas do
  begin
    Font := Self.Font;
    H := TextHeight('0');
    R := Rect(0, H div 2 - 1, Width, Height);
    if Ctl3D then
    begin
      Inc(R.Left);
      Inc(R.Top);
      Brush.Color := clBtnHighlight;
      FrameRect(R);
      OffsetRect(R, -1, -1);
      Brush.Color := clBtnShadow;
    end
    else
      Brush.Color := clWindowFrame;
    FrameRect(R);
    if Text <> '' then
    begin
      if not UseRightToLeftAlignment then
        R := Rect(8, 0, 0, H)
      else
        R := Rect(R.Right - Canvas.TextWidth(Text) - 8, 0, 0, H);
      Flags := DrawTextBiDiModeFlags(DT_SINGLELINE);
      // calculate text rect
      DrawText(Handle, PChar(Text), Length(Text), R, Flags or DT_CALCRECT);
      Brush.Color := Color;
      if not Enabled then
      begin
        OffsetRect(R, 1, 1);
        Font.Color := clBtnHighlight;
        DrawText(Handle, PChar(Text), Length(Text), R, Flags);
        OffsetRect(R, -1, -1);
        Font.Color := clBtnShadow;
        SetBkMode(Handle, Windows.TRANSPARENT);
        DrawText(Handle, PChar(Text), Length(Text), R, Flags);
      end
      else
        DrawText(Handle, PChar(Text), Length(Text), R, Flags);
    end;
  end;
end;

{$IFDEF JVCLThemesEnabledD56}

function TJvGroupBox.GetParentBackground: Boolean;
begin
  Result := JvThemes.GetParentBackground(Self);
end;

procedure TJvGroupBox.SetParentBackground(Value: Boolean);
begin
  JvThemes.SetParentBackground(Self, Value);
end;

{$ENDIF JVCLThemesEnabledD56}

function TJvGroupBox.WantKey(Key: Integer; Shift: TShiftState;
  const KeyText: WideString): Boolean;
begin
  Result := inherited WantKey(Key, Shift, KeyText);
  if Result then
    DoHotKey;
end;

procedure TJvGroupBox.EnabledChanged;
var
  I: Integer;
begin
  inherited EnabledChanged;
  if PropagateEnable then
    for I := 0 to ControlCount - 1 do
      Controls[I].Enabled := Enabled;
  Invalidate;
end;

procedure TJvGroupBox.MouseEnter(Control: TControl);
begin
  if csDesigning in ComponentState then
    Exit;
  if not FOver then
  begin
    FSaved := Application.HintColor;
    Application.HintColor := FHintColor;
    FOver := True;
  end;
  inherited MouseEnter(Control);
end;

procedure TJvGroupBox.MouseLeave(Control: TControl);
begin
  if csDesigning in ComponentState then
    Exit;
  if FOver then
  begin
    Application.HintColor := FSaved;
    FOver := False;
  end;
  inherited MouseLeave(Control);
end;

procedure TJvGroupBox.ParentColorChanged;
begin
  inherited ParentColorChanged;
  if Assigned(FOnParentColorChange) then
    FOnParentColorChange(Self);
end;

{$IFDEF VCL}
procedure TJvGroupBox.CMDenySubClassing(var Msg: TMessage);
begin
  Msg.Result := 1;
end;
{$ENDIF}

procedure TJvGroupBox.DoHotKey;
begin
  if Assigned(FOnHotKey) then
    FOnHotKey(Self);
end;

procedure TJvGroupBox.SetPropagateEnable(const Value: Boolean);
var
  I: Integer;
begin
  FPropagateEnable := Value;
  for I := 0 to ControlCount - 1 do
    Controls[I].Enabled := Enabled;
end;

end.

