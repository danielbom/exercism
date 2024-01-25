is_anagram(Word1, Word2) :-
  string_upper(Word1, Upper1), string_chars(Upper1, Chars1), msort(Chars1, Sort1),
  string_upper(Word2, Upper2), string_chars(Upper2, Chars2), msort(Chars2, Sort2),
  Upper1 \= Upper2,
  Sort1 = Sort2.

anagram(Word, Candidates, Anagrams) :-
  include(is_anagram(Word), Candidates, Anagrams).
