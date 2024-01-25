convert(N, Numeral) :-
  number_chars(N, Digits),
  convert_list(Digits, Numeral).

convert_list([],    Numeral) :- Numeral = "".
convert_list([H|T], Numeral) :-
  convert_head_digit([H|T], DigitNumeral),
  convert_list(T, NumeralRemainder),
  string_concat(DigitNumeral, NumeralRemainder, Numeral), !.

convert_head_digit([H|T], DigitNumeral) :-
  length(T, 3), convert_digit(H, 'M', '?', '?', DigitNumeral);
  length(T, 2), convert_digit(H, 'C', 'D', 'M', DigitNumeral);
  length(T, 1), convert_digit(H, 'X', 'L', 'C', DigitNumeral);
  length(T, 0), convert_digit(H, 'I', 'V', 'X', DigitNumeral).

convert_digit('0', _,   _,    _,   Numeral) :- string_chars(Numeral, []).
convert_digit('1', One, _,    _,   Numeral) :- string_chars(Numeral, [One]).
convert_digit('2', One, _,    _,   Numeral) :- string_chars(Numeral, [One, One]).
convert_digit('3', One, _,    _,   Numeral) :- string_chars(Numeral, [One, One, One]).
convert_digit('4', One, Five, _,   Numeral) :- string_chars(Numeral, [One, Five]).
convert_digit('5', _,   Five, _,   Numeral) :- string_chars(Numeral, [Five]).
convert_digit('6', One, Five, _,   Numeral) :- string_chars(Numeral, [Five, One]).
convert_digit('7', One, Five, _,   Numeral) :- string_chars(Numeral, [Five, One, One]).
convert_digit('8', One, Five, _,   Numeral) :- string_chars(Numeral, [Five, One, One, One]).
convert_digit('9', One, _,    Ten, Numeral) :- string_chars(Numeral, [One, Ten]).
