hey(Sentence, Response) :-
  string_chars(Sentence, Chars),
  sentence(Chars, Uppers, Lowers, Digits, Spaces, Question),
  ( last(Question, '?') ->
    ( list_empty(Lowers), list_not_empty(Uppers) -> 
      Response = "Calm down, I know what I'm doing!", !
    ; Response = "Sure.", !
    )
  ; list_not_empty(Lowers) -> Response = "Whatever.", !
  ; list_not_empty(Uppers) -> Response = "Whoa, chill out!", !
  ; list_not_empty(Digits) -> Response = "Whatever.", !
  ; (list_not_empty(Spaces) ; list_empty(Chars)) ->
    Response = "Fine. Be that way!", !
  ; Response = "Sure.", !
  ).

list_empty([]).
list_not_empty([_ | _]).

sentence([Ch | Chars], [Ch | Uppers], Lowers, Digits, Spaces, [Ch | Question]) :-
  char_type(Ch, upper), !,
  sentence(Chars, Uppers, Lowers, Digits, Spaces, Question).
sentence([Ch | Chars], Uppers, [Ch | Lowers], Digits, Spaces, [Ch | Question]) :-
  char_type(Ch, lower), !,
  sentence(Chars, Uppers, Lowers, Digits, Spaces, Question).
sentence([Ch | Chars], Uppers, Lowers, Digits, [Ch | Spaces], Question) :-
  char_type(Ch, space), !,
  sentence(Chars, Uppers, Lowers, Digits, Spaces, Question).
sentence([Ch | Chars], Uppers, Lowers, [Ch | Digits], Spaces, Question) :-
  char_type(Ch, digit), !,
  sentence(Chars, Uppers, Lowers, Digits, Spaces, Question).
sentence(['?' | Chars], Uppers, Lowers, Digits, Spaces, ['?' | Question]) :-
  sentence(Chars, Uppers, Lowers, Digits, Spaces, Question), !.
sentence([_ | Chars], Uppers, Lowers, Digits, Spaces, Question) :-
  sentence(Chars, Uppers, Lowers, Digits, Spaces, Question), !.
sentence([], [], [], [], [], []).
