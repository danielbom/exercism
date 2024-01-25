remove_non_letters(A,B) :-
  findall(X, (member(X, A), char_type(X,alpha)), B).

isogram(S) :-
  string_lower(S,S1), string_chars(S1, CS),
  remove_non_letters(CS,DS),
  sort(DS, ES),
  length(DS,L), length(ES,L).