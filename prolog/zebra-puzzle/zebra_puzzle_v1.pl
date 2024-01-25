color(C) :- member(C, [red, green, ivory, yellow, blue]).
color(C) --> { color(C) }, [C].

nationality(N) :- member(N, [englishman, spaniard, ukrainian, norwegian, japanese]).
nationality(N) --> { nationality(N) }, [N].

pet(P) :- member(P, [dog, fox, horse, snail, zebra]).
pet(P) --> { pet(P) }, [P].

beverage(B) :- member(B, [coffee, tea, milk, orange_juice, water]).
beverage(B) --> { beverage(B) }, [B].

cigarette(G) :- member(G, [old_gold, kools, chesterfields, lucky_strike, parliaments]).
cigarette(G) --> { cigarette(G) }, [G].

house_dif(_, []) --> [].
house_dif(H1, [H2 | Tail]) --> house_dif(H1, H2), house_dif(H1, Tail).
house_dif(H1, H2) --> 
    { H1 = (C1, N1, P1, B1, G1) , H2 = (C2, N2, P2, B2, G2)
    , maplist(dif, [C1, N1, P1, B1, G1], [C2, N2, P2, B2, G2])
    }.

% 1. There are five houses.
there_are_five_houses([H1, H2, H3, H4, H5]) -->
    house(H1),
    house(H2), house_dif(H2, [H1]),
    house(H3), house_dif(H3, [H1, H2]),
    house(H4), house_dif(H4, [H1, H2, H3]),
    house(H5), house_dif(H5, [H1, H2, H3, H4]),
    [].

% 2. The Englishman lives in the red house.
the_englishman_lives_in_the_red_house((red, englishman, _, _, _)) --> [].
the_englishman_lives_in_the_red_house(H) -->
    { (C, N, _, _, _) = H, dif(C, red), dif(N, englishman) }.

% 3. The Spaniard owns the dog.
the_spaniard_owns_the_dog((_, spaniard, dog, _, _)) --> [].
the_spaniard_owns_the_dog(H) -->
    { (_, N, P, _, _) = H, dif(N, spaniard), dif(P, dog) }.

% 4. Coffee is drunk in the green house.
coffee_is_drunk_in_the_green_house((green, _, _, coffee, _)) --> [].
coffee_is_drunk_in_the_green_house(H) -->
    { (C, _, _, B, _) = H, dif(C, green), dif(B, coffee) }.

% 5. The Ukrainian drinks tea.
the_ukrainian_drinks_tea((_, ukrainian, _, tea, _)) --> [].
the_ukrainian_drinks_tea(H) -->
    { (_, N, _, B, _) = H, dif(N, ukrainian), dif(B, tea) }.

% 6. The green house is immediately to the right of the ivory house.
the_green_house_is_immediately_to_the_right_of_the_ivory_house([LH, RH | _]) -->
    { LH = (ivory, _, _, _, _), RH = (green, _, _, _, _) }.
the_green_house_is_immediately_to_the_right_of_the_ivory_house([_ | Tail]) -->
    the_green_house_is_immediately_to_the_right_of_the_ivory_house(Tail).

% 7. The Old Gold smoker owns snails.
the_old_gold_smoker_owns_snails((_, _, snail, _, old_gold)) --> [].
the_old_gold_smoker_owns_snails(H) -->
    { (_, _, P, _, G) = H, dif(P, snail), dif(G, old_gold) }.

% 8. Kools are smoked in the yellow house.
kools_are_smoked_in_the_yellow_house((yellow, _, _, _, kools)) --> [].
kools_are_smoked_in_the_yellow_house(H) -->
    { (C, _, _, _, G) = H, dif(C, yellow), dif(G, kools) }.

% 9. Milk is drunk in the middle house.
milk_is_drunk_in_the_middle_house([_, _, (_, _, _, milk, _), _, _]) --> [].

% 10. The Norwegian lives in the first house.
the_norwegian_lives_in_the_first_house([(_, norwegian, _, _, _), _, _, _, _]) --> [].

% 11. The man who smokes Chesterfields lives in the house next to the man with the fox.
the_man_who_smokes_chesterfields_lives_in_the_house_next_to_the_man_with_the_fox([H1, H2 | _]) -->
    { LH = (_, _, _, _, chesterfields), RH = (_, _, fox, _, _)
    , ( (H1 = LH, H2 = RH) ; (H2 = LH, H1 = RH) )
    }.
the_man_who_smokes_chesterfields_lives_in_the_house_next_to_the_man_with_the_fox([_ | Tail]) --> 
    the_man_who_smokes_chesterfields_lives_in_the_house_next_to_the_man_with_the_fox(Tail).

% 12. Kools are smoked in the house next to the house where the horse is kept.
kools_are_smoked_in_the_house_next_to_the_house_where_the_horse_is_kept([H1, H2 | _]) -->
    { LH = (_, _, _, _, kools), RH = (_, _, horse, _, _)
    , ( (H1 = LH, H2 = RH) ; (H2 = LH, H1 = RH) )
    }.
kools_are_smoked_in_the_house_next_to_the_house_where_the_horse_is_kept([_ | Tail]) --> 
    kools_are_smoked_in_the_house_next_to_the_house_where_the_horse_is_kept(Tail).

% 13. The Lucky Strike smoker drinks orange juice.
the_lucky_strike_smoker_drinks_orange_juice((_, _, _, orange_juice, lucky_strike)) --> [].
the_lucky_strike_smoker_drinks_orange_juice(H) --> 
    { (_, _, _, B, G) = H, dif(B, orange_juice), dif(G, lucky_strike) }.

% 14. The Japanese smokes Parliaments.
the_japanese_smokes_parliaments((_, japanese, _, _, parliaments)) --> [].
the_japanese_smokes_parliaments(H) --> 
    { (_, N, _, _, G) = H, dif(N, japanese), dif(G, parliaments) }.

% 15. The Norwegian lives next to the blue house.
the_norwegian_lives_next_to_the_blue_house([H1, H2 | _]) -->
    { LH = (_, norwegian, _, _, _), RH = (blue, _, _, _, _)
    , ( (H1 = LH, H2 = RH) ; (H2 = LH, H1 = RH) )
    }.
the_norwegian_lives_next_to_the_blue_house([_ | Tail]) --> 
    the_norwegian_lives_next_to_the_blue_house(Tail).

house_valid((C, N, P, B, G)) --> color(C), nationality(N), pet(P), beverage(B), cigarette(G).

house(H) -->
    the_englishman_lives_in_the_red_house(H),
    the_spaniard_owns_the_dog(H),
    coffee_is_drunk_in_the_green_house(H),
    the_ukrainian_drinks_tea(H),
    the_old_gold_smoker_owns_snails(H),
    kools_are_smoked_in_the_yellow_house(H),
    the_lucky_strike_smoker_drinks_orange_juice(H),
    the_japanese_smokes_parliaments(H),
    house_valid(H).

houses(HS) --> 
    the_norwegian_lives_in_the_first_house(HS),
    the_norwegian_lives_next_to_the_blue_house(HS),
    milk_is_drunk_in_the_middle_house(HS),
    the_man_who_smokes_chesterfields_lives_in_the_house_next_to_the_man_with_the_fox(HS),
    kools_are_smoked_in_the_house_next_to_the_house_where_the_horse_is_kept(HS),
    the_green_house_is_immediately_to_the_right_of_the_ivory_house(HS),
    there_are_five_houses(HS).

zebra_owner(Owner) :-
  phrase(houses(Houses), _, []), !,
  once(member((_, Owner, zebra, _, _), Houses)).

water_drinker(Drinker) :-
  phrase(houses(Houses), _, []), !,
  once(member((_, Drinker, _, water, _), Houses)).
