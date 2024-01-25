pangram(Sentence) :-
  string_lower(Sentence, Lower),
  string_chars(Lower, Chars),
  include([Ch] >> (char_type(Ch, alpha)), Chars, Letters),
  sort(Letters, Abc),
  string_chars("abcdefghijklmnopqrstuvwxyz", Abc).
   