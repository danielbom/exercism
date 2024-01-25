hey(Sentence, "Fine. Be that way!") :-
  string_chars(Sentence, Chars),
  is_whitespace(Chars),
  !.
hey(Sentence, Response) :-
  string_chars(Sentence, Chars),
  is_question(Chars),
  (is_yelling(Chars) ->
    Response = "Calm down, I know what I'm doing!" % '
  ; Response = "Sure."
  ),
  !.
hey(Sentence, "Whoa, chill out!") :-
  string_chars(Sentence, Chars),
  is_yelling(Chars),
  !.
hey(_, "Whatever.").

is_question(Chars) :-
  append(_, ['?' | Rest], Chars),
  (is_whitespace(Rest) ; is_question(Rest)).

is_yelling(Chars) :-
  partition(char_of_type(upper), Chars, [_ | _], Others),
  include(char_of_type(lower), Others, []).

is_whitespace(Chars) :-
  include(char_of_type(space), Chars, Chars).

char_of_type(Type, Ch) :-
  char_type(Ch, Type).
