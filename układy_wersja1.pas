program rownania;
var	plik		: text;
	sciezka 	: string;
	tab			: array [1..100,1..101] of real;
	wynik		: array [1..100] of real;
	n,m,i,j		: integer;
	osobliwy	: boolean;

procedure ZamienWiersze(k : integer; l : integer);
var
	tmp			: real;
	i			: integer;
begin
	for i := 1 to m do begin
		tmp := tab[k,i];
		tab[k,i] := tab[l,i];
		tab[l,i] := tmp;
	end;
end;

procedure PomnozDodaj(k : integer; l : integer; a : real);
var
	tmp			: real;
	i			: integer;
begin
	for i := 1 to m do begin
		tmp := tab[l,i] * a;
		tab[k,i] := tab[k,i] + tmp;
	end;
end;

begin
	write('Podaj nazwe pliku: '); readln(sciezka);
	assign(plik, sciezka);
	reset(plik);
	read(plik, n);
	m := n+1;
	
	for i := 1 to n do
		for j := 1 to m do
			read(plik, tab[i,j]);
	close(plik);
	
	for i := 1 to n do begin
		j := i;
		
		while (tab[j,i] = 0) AND NOT osobliwy do begin
			j := j+1;
			if j > n then osobliwy := true;
		end;
		
		if j <> i then ZamienWiersze(j, i);
		
		if tab[i,i] <> 0 then
			for j := i+1 to n do
				PomnozDodaj(j, i, -tab[j,i] / tab[i,i]);
	end;
	
	if NOT osobliwy then
		for i := n downto 1 do begin
			wynik[i] := tab[i,m];
			for j := n downto i+1 do
				wynik[i] := wynik[i] - tab[i,j] * wynik[j];
			wynik[i] := wynik[i] / tab[i,i];
			writeln('x', i, ': ', wynik[i]:8:2);
		end
	else writeln('Uklad rownan jest osobliwy.');
end.
