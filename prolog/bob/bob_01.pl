% OBS: Don't pass all tests

hey(Sentence, Response) :-
  normalize_space(string(Trimed), Sentence),
  IsQuestion = sub_string(Trimed, _, 1, 0, "?"),
  string_upper(Trimed, Upper),
  IsYell = (Trimed = Upper),
  (
    Trimed = "", Response = "Fine. Be that way!";
    IsQuestion, IsYell, Response = "Calm down, I know what I'm doing!";
    IsQuestion, Response = "Sure.";
    IsYell, Response = "Whoa, chill out!";
    Response = "Whatever."
  ),
  !.