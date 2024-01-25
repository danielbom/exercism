pangram(Sentence):-
  string_lower(Sentence, SentenceLower),
  string_codes(SentenceLower, CharCodes),
  string_codes('az', [A, Z]),
  numlist(A, Z, EnglishLetters),
  subset(EnglishLetters, CharCodes).
   