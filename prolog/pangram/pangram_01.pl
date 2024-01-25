pangram(Sentence) :-
  string_lower(Sentence, LC),
  string_chars(LC, Chars),
  string_chars("abcdefghijklmnopqrstuvwxyz", Alphabet),
  subset(Alphabet, Chars).