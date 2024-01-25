nucleotide_count(Nucleo, Result) :-
	string_chars(Nucleo, Chars),
	string_length(Nucleo, Length),
	include(=('A'), Chars, Adenosines), length(Adenosines, As),
	include(=('C'), Chars, Cytosines), length(Cytosines, Cs),
	include(=('G'), Chars, Guanines), length(Guanines, Gs),
	include(=('T'), Chars, Thymines), length(Thymines, Ts),
	Total is As + Cs + Gs + Ts,
	Total =:= Length,
	Result = [('A', As), ('C', Cs), ('G', Gs), ('T', Ts)].