color(red).
color(green).
color(ivory).
color(yellow).
color(blue).

nationality(englishman).
nationality(spaniard).
nationality(ukrainian).
nationality(norwegian).
nationality(japanese).

pet(dog).
pet(fox).
pet(horse).
pet(snail).
pet(zebra).

beverage(coffee).
beverage(tea).
beverage(milk).
beverage(orange_juice).
beverage(water).

cigarette(old_gold).
cigarette(kools).
cigarette(chesterfields).
cigarette(lucky_strike).
cigarette(parliaments).

house_with(H, Houses) :- once(member(H, Houses)).

house_left(H1, H2, [H1, H2 | _]) :- !.
house_left(H1, H2, [_ | Tail]) :- house_left(H1, H2, Tail).

house_next(H1, H2, Houses) :-
  house_left(H1, H2, Houses);
  house_left(H2, H1, Houses).

the_englishman_lives_in_red_house(Houses) :-
  house_with(house(color(red), nationality(englishman), _, _, _), Houses).
the_spaniard_owns_the_dog(Houses) :-
  house_with(house(_, nationality(spaniard), pet(dog), _, _), Houses).
coffee_is_drunk_in_the_green_house(Houses) :-
  house_with(house(color(green), _, _, beverage(coffee), _), Houses).
the_ukrainian_drinks_tea(Houses) :-
  house_with(house(_, nationality(ukrainian), _, beverage(tea), _), Houses).
the_green_house_is_immediately_to_the_right_of_the_ivory_house(Houses) :-
  house_left(house(color(green), _, _, _, _), house(color(ivory), _, _, _, _), Houses).
the_old_gold_smoker_owns_snails(Houses) :-
  house_with(house(_, _, pet(snail), _, cigarette(old_gold)), Houses).
kools_are_smoked_in_the_yellow_house(Houses) :-
  house_with(house(color(yellow), _, _, _, cigarette(kools)), Houses).
milk_is_drunk_in_the_middle_house([_, _, H, _, _]) :-
  H = house(_, _, _, beverage(milk), _).
the_norwegian_lives_in_the_first_house([H,_,_,_,_]) :-
  H = house(_, nationality(norwegian), _, _, _).
the_man_who_smokes_chesterfields_lives_in_the_house_next_to_the_man_with_the_fox(Houses) :-
  house_next(house(_, _, _, _, cigarette(chesterfields)), house(_, _, pet(fox), _, _), Houses).
kools_are_smoked_in_the_house_next_to_the_house_where_the_horse_is_kept(Houses) :-
  house_next(house(_, _, _, _, cigarette(kools)), house(_, _, pet(horse), _, _), Houses).
the_lucky_strike_smoker_drinks_orange_juice(Houses) :-
  house_with(house(_, _, _, beverage(orange_juice), cigarette(lucky_strike)), Houses).
the_japonese_smokes_parliaments(Houses) :-
  house_with(house(_, nationality(japanese), _, _, cigarette(parliaments)), Houses).
the_norwegian_lives_next_to_the_blue_house(Houses) :-
  house_next(house(_, nationality(norwegian), _, _, _), house(color(blue), _, _, _, _), Houses).

houses(Houses) :-
  Houses = [
    house(color(C1), nationality(N1), pet(P1), beverage(B1), cigarette(G1)),
    house(color(C2), nationality(N2), pet(P2), beverage(B2), cigarette(G2)),
    house(color(C3), nationality(N3), pet(P3), beverage(B3), cigarette(G3)),
    house(color(C4), nationality(N4), pet(P4), beverage(B4), cigarette(G4)),
    house(color(C5), nationality(N5), pet(P5), beverage(B5), cigarette(G5))
  ],
    
  milk_is_drunk_in_the_middle_house(Houses),
  the_norwegian_lives_in_the_first_house(Houses),
  
  Colors        = [C1, C2, C3, C4, C5],
  Nationalities = [N1, N2, N3, N4, N5],
  Pets          = [P1, P2, P3, P4, P5],
  Beverages     = [B1, B2, B3, B4, B5],
  Cigarettes    = [G1, G2, G3, G4, G5],
  
  findall(X, color(X), AllColors),
  permutation(AllColors, Colors),

  the_green_house_is_immediately_to_the_right_of_the_ivory_house(Houses),

  findall(X, nationality(X), AllNationalities),
  permutation(AllNationalities, Nationalities),

  the_englishman_lives_in_red_house(Houses),
  the_norwegian_lives_next_to_the_blue_house(Houses),

  findall(X, cigarette(X), AllCigarettes),
  permutation(AllCigarettes, Cigarettes),
  
  kools_are_smoked_in_the_yellow_house(Houses),
  the_japonese_smokes_parliaments(Houses),
  
  findall(X, pet(X), AllPets),
  permutation(AllPets, Pets),

  the_spaniard_owns_the_dog(Houses),
  the_old_gold_smoker_owns_snails(Houses),
  kools_are_smoked_in_the_house_next_to_the_house_where_the_horse_is_kept(Houses),
  the_man_who_smokes_chesterfields_lives_in_the_house_next_to_the_man_with_the_fox(Houses),
  
  findall(X, beverage(X), AllBeverages),
  permutation(AllBeverages, Beverages),
  
  the_lucky_strike_smoker_drinks_orange_juice(Houses),
  coffee_is_drunk_in_the_green_house(Houses),    
  the_ukrainian_drinks_tea(Houses).

zebra_owner(Owner) :-
  houses(Houses), !,
  house_with(house(_, nationality(Owner), pet(zebra), _, _), Houses).

water_drinker(Drinker) :-
  houses(Houses), !,
  house_with(house(_, nationality(Drinker), _, beverage(water), _), Houses).
