{ po pierwsze, wezmy sobie dane testowe, jak na skanie:
5
6 3 -2 1 7 4
3 -2 1 -4 5 7
8 2 4 6 -2 7
0 3 5 4 2 -1
4 7 6 5 3 2

weŸmy sobie z nich liniê powiedzmy 3:

3 -2 1 -4 5 7

to znaczy, ¿e: 

3*x1 - 2*x2 + 1*x3 - 4*x4 + 5*x5 = 7

Twój program dla takich danych zwraca:

x1= -5.56
x2=  7.12
x3=  1.11
x4=  1.70
x5= -0.77

3 * (-5,56) - 2 * (7,12) + 1*(1,11) - 4*(1,70) + 5*(-0,77) = -40,46, czyli nie 7

z mojego wychodzi:
x1=  1.15
x2= -0.38
x3=  0.51
x4= -0.60
x5= -0.02

3*(1,15) - 2*(-0,38) + 1*(0,51) - 4*(-0,60) + 5*(-0,02) = 7

To najprostsza metoda sprawdzenia wyniku. Przejrza³em nieco kod i zaznaczy³em kilka b³êdów.
Najpowa¿niejszy dotyczy tego, ¿e np. dla danych:

3
0 2 3 0
1 2 3 8
3 2 1 8

program sie wywala (dzielenie przez zero)

}


uses crt;

var z:real;
    f:text;
    n,q,j,i:integer;
    a:array[1..101,1..100] of real;
    x:array[1..100] of real;

begin
clrscr; {proponowalbym wywalic, w systemach uniksowych psuje konsole ;/}

assign(f,'dane.txt');
reset(f);
read(f,n);

{dlaczego zmienna która siê rzadziej zmienia ma n+1?
aktualnie np dane 

5
6 3 -2 1 7 4
3 -2 1 -4 5 7
8 2 4 6 -2 7
0 3 5 4 2 -1
4 7 6 5 3 2

wczytujesz do tablicy tak, ze wygladaja w sposob nastepujacy:

6 3 -2 1 7
4 3 -2 1 -4
5 7 8 2 4
6 -2 7 0 3
5 4 2 -1 4
7 6 5 3 2

powinno byc, albo read(f,a[j,i]) (wtedy wczytasz macierz wejsciowa jako stransponowana)
albo i to n i j do n + 1
}

for i:=1 to n+1 do
    for j:=1 to n do
        read(f,a[i,j]);

for i:=2 to n do
   begin
   	{a co jeœli a[i-1,i] = 0? Dlaczego z jest wyliczane dla ka¿dej kolumny tylko raz? }
   	{ je¿eli drugi wspólczynnik w pierwszej kolumnie da siê wyzerowaæ cyfr¹ 2, to nie znaczy }
   	{ ¿e da siê ni¹ wyzerowaæ tak¿e wspó³czynnik trzeci }
    z:=-a[i-1,i-1]/a[i-1,i];
    {ile na pocz¹tku wynosi q?}
    q:=q+1;
    
    for j:=1+q to (n+1) do
     a[j,i]:= z * a[j,i] + a[j,i-1];
    {a tego to ju¿ zupe³nie nie rozumiem. :P Redukujesz kolumnami czy jak? Po co to q, skoro jest i?
    dlaczego element mnozymy razy z i dodajemy cos do niego, zamiast dodac pomnozony przez z element a[i-1,i-1]?}
   end;

{cale ponizsze jest chyba ok - o ile w macierzy sa odpowiednie wspolczynniki, a kazdy z bledow powyzej
warunkuje, ze nie sa}
for i:=n downto 1 do
    begin
         x[i]:=a[n+1,i];
         for j:=1 to n-i do
             x[i]:=x[i]-a[i+j,i]*x[i+j];
         x[i]:=x[i]/a[i,i];
    end;

for i:=1 to n do writeln('x',i,'=',x[i]);

readkey;
end.
