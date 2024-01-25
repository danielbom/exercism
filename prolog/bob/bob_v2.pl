hey(Sentence, Response) :-
  string_chars(Sentence, Chars),
  sentence_semantic(Chars, W, Q, Y),
  ( (W, Q, Y) = (1, 0, 0) -> Response = "Fine. Be that way!"
  ; (W, Q, Y) = (0, 1, 0) -> Response = "Sure."
  ; (W, Q, Y) = (0, 0, 1) -> Response = "Whoa, chill out!"
  ; (W, Q, Y) = (0, 1, 1) -> Response = "Calm down, I know what I'm doing!" % '
  ; Response = "Whatever."
  ).

sentence_semantic(Chars, W, Q, Y) :-
  (is_whitespace(Chars) -> W = 1 ; W = 0),
  (is_question(Chars) -> Q = 1 ; Q = 0),
  (is_yelling(Chars) -> Y = 1 ; Y = 0).

is_question(Chars) :-
  append(_, ['?' | Rest], Chars),
  is_whitespace(Rest),
  !.

is_yelling(Chars) :-
  partition(char_of_type(upper), Chars, [_ | _], Others),
  include(char_of_type(lower), Others, []).

is_whitespace(Chars) :-
  include(char_of_type(space), Chars, Chars).

char_of_type(Type, Ch) :-
  char_type(Ch, Type).
