isalpha(Ch) :- char_type(Ch, alpha).

isogram(Phrase) :- 
  string_upper(Phrase, UpperPhrase),
  string_chars(UpperPhrase, Chars),
  include(isalpha, Chars, Letters),
	is_set(Letters).
