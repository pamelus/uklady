program ulad;
var	
	a : array [1..100,1..101] of real;
	n : integer;
	i,j : integer;
	plik : text;

function Zredukuj(k : integer) : boolean;
var
	zamiana : real;
	mnoznik : real;
	i, j : integer;
begin
	if k <= n then
	begin
		i := k+1;
		while (a[k,k] = 0) AND (i <= n) do
		begin
			for j := k to n+1 do
			begin
				zamiana := a[k,j];
				a[k,j] := a[i,j];
				a[i,j] := zamiana;
			end;
			i := i+1;
		end;
		
		if a[k,k] = 0 then Zredukuj := false else
		begin
			for i := k+1 to n do
			begin
				mnoznik := a[i,k] / a[k,k];
				for j := k to n+1 do
					a[i,j] := a[i,j] - (a[k,j] * mnoznik);
			end;
			Zredukuj := Zredukuj(k+1);
		end;
	end
	else Zredukuj := true;
end;

procedure Rozwiaz(k : integer);
var
	i : integer;
begin
	if k >= 0 then
	begin
		for i := k+1 to n do
			a[k,n+1] := a[k,n+1] - a[k,i];
		a[k,n+1] := a[k,n+1] / a[k,k];
		
		for i := 1 to k-1 do
			a[i,k] := a[i,k] * a[k,n+1];
		Rozwiaz(k-1);
	end;
end;
	

begin
	assign(plik, 'dane.txt');
	reset(plik);
	read(plik, n);
	for i := 1 to n do
		for j := 1 to n+1 do
			read(plik, a[i,j]);

	if Zredukuj(1) then
	begin
		Rozwiaz(n);
		for i := 1 to n do
			writeln('Rozwiazanie ', i, ' = ', a[i,n+1]:7:2)
	end
	else
	begin
		if a[n,n+1] = 0 then writeln('Nieskonczona liczba rozwiazan')
		else writeln('Brak rozwiazan rzeczywistych');
	end;
	
	close(plik);
end.
