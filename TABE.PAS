program catch_the_tabe;

uses crt,Dmon3b,mouse,keyboard;

label
  iniciar,eixir;

const
  facil     = 0;
  normal    = 1;
  dificil   = 2;
  imposible = 3;

var
  x,y,a,xa,ya,b,e,i: word;
  c1,c2,c3 : word;
  need,PR : boolean;

  mouseX,mouseY: word;
  b1,b2,b3: boolean;

  mode: word;

  mx,my,mxa,mya: array[0..4] of word; {78 243}
  pal: AuxPalette;

begin

Randomize;
InitDM;
InitMouse;
HookKb;
LoadPCX('spr.pcx',SP);
SavePalette(Pal);
BlackOut;
{RestorePalette(Pal);}
Delay(1000);
PutSprite(SP,78,0,VGA,70,90,165,16);
FadeIn(Pal);
Delay(2000);
FadeOut;



cls(0,VGA);
PR := True;
iniciar:

For i := 0 to 4 do
begin
mx[i] := Random(260)+30;
my[i] := Random(140)+30;
mxa[i] := Random(8)-4;
mya[i] := Random(8)-4;
end;

need := False;
mode := 200;

repeat
GetMouse(mouseX, mouseY, b1, b2, b3);

For i := 0 to 4 do
begin
  If (Random(10) = 1) or (need) then
    begin
    mxa[i] := Random(8)-4;
    mya[i] := Random(8)-4;
    need := False;
    end;

  If ((mx[i]+mxa[i]) > 300) or ((mx[i]+mxa[i]) < 20) then need := True else mx[i] := mx[i] + mxa[i];
  If ((my[i]+mya[i]) > 180) or ((my[i]+mya[i]) < 20) then need := True else my[i] := my[i] + mya[i];


If a = 16 then a := 0 else a := 16;

PutSprite(SP,a,0,WP,mx[i],my[i],16,16);
end;




PutSprite(SP,0,16,WP,50+Random(3)-1,50+Random(3)-1,218,21);

PutSprite(SP,0,37,WP,147+Random(3)-1,100+Random(3)-1,17,5);
PutSprite(SP,0,42,WP,144+Random(3)-1,110+Random(3)-1,23,5);
PutSprite(SP,0,47,WP,145+Random(3)-1,120+Random(3)-1,21,5);
PutSprite(SP,0,52,WP,140+Random(3)-1,130+Random(3)-1,31,5);
PutSprite(SP,32,0,WP,mouseX,mouseY,16,16);

If b1 then
  begin
  If (mouseX+8 >= 147) and (mouseX+8 <= 164) and
     (mouseY+8 >= 100) and (mouseY+8 <= 105) then mode := facil;
  If (mouseX+8 >= 144) and (mouseX+8 <= 167) and
     (mouseY+8 >= 110) and (mouseY+8 <= 115) then mode := normal;
  If (mouseX+8 >= 145) and (mouseX+8 <= 166) and
     (mouseY+8 >= 120) and (mouseY+8 <= 125) then mode := dificil;
  If (mouseX+8 >= 140) and (mouseX+8 <= 171) and
     (mouseY+8 >= 130) and (mouseY+8 <= 135) then mode := imposible;
  end;

WaitRetrace;
flip(WP,VGA);
cls(0,WP);
If PR then begin FadeIn(Pal); PR := False; end;

If KeyPress(KeyEsc) then goto eixir;
until (mode <> 200);
FadeOut;
PR := True;

x := Random(260)+30;
y := Random(140)+30;
xa := Random(8)-4;
ya := Random(8)-4;
need := False;
c1 := 50;
b := 20;
e := 5;


repeat

GetMouse(mouseX, mouseY, b1, b2, b3);

If (b1) and (c1 = 0) and (b > 0) then
  begin
  If (mouseX+8 > x) and (mouseX+8 < x+16) and (mouseY+8 > y) and (mouseY+8 < y+16) then
    begin
    sound(440); delay(10); nosound;
    dec(e);
    end;
    c1 := 50;
  dec(b);
  end;

If c2 = 0 then
  begin
  If (Random(10) = 1) or (need) then
    begin
    xa := Random(8)-4;
    ya := Random(8)-4;
    need := False;
    end;

  If ((x+xa) > 300) or ((x+xa) < 20) then need := True else x := x + xa;
  If ((y+ya) > 180) or ((y+ya) < 20) then need := True else y := y + ya;
  If (mode = facil) then c2 := 2;
  If (mode = dificil) then c2 := 4;
  end;

If a = 16 then a := 0 else a := 16;

If c1 > 0 then dec(c1);
If c2 > 0 then dec(c2);

PutSprite(SP,a,0,WP,x,y,16,16);
PutSprite(SP,56,0,WP,5,183,21,8);
PutSprite(SP,56,9,WP,9,167,21,8);

For i := 1 to e do
  begin
  PutSprite(SP,48,8,WP,22+(i shl 3),167,8,8);
  end;
For i := 1 to b do
  begin
  PutSprite(SP,48,0,WP,22+(i shl 3),183,8,8);
  end;


PutSprite(SP,32,0,WP,mouseX,mouseY,16,16);

If (mode <> imposible) and (mode <> dificil) then WaitRetrace;
Flip(WP,VGA);
cls(0,WP);
If PR Then begin FadeIn(Pal); PR := False; end;
{delay(50);}

until (keypress(keyesc)) or (e = 0) or (b = 0);

If e = 0 then
  begin
  If mode = facil     then PutSprite(SP,0,67,VGA,78,90,168,10);
  If mode = normal    then PutSprite(SP,0,77,VGA,100,90,112,10);
  If mode = dificil   then PutSprite(SP,0,87,VGA,70,90,184,10);
  If mode = imposible then PutSprite(SP,0,97,VGA,50,90,212,10);
  repeat until QkeyPress;
  FadeOut;
  PR := True;
  ClearKb;
  goto iniciar;
  end;
If b = 0 then
  begin
  PutSprite(SP,0,57,VGA,76,90,168,10);
  repeat until QkeyPress;
  FadeOut;
  PR := True;
  ClearKb;
  goto iniciar;
  end;
eixir:
fadeout;


FreeKb;
EndMouse;
EndDM;
end.