color(C) :- member(C, [red, green, ivory, yellow, blue]).
nationality(N) :- member(N, [englishman, spaniard, ukrainian, norwegian, japanese]).
pet(P) :- member(P, [dog, fox, horse, snail, zebra]).
beverage(B) :- member(B, [coffee, tea, milk, orange_juice, water]).
cigarette(G) :- member(G, [old_gold, kools, chesterfields, lucky_strike, parliaments]).

contains(H, Houses) :- once(member(H, Houses)).

side_by_side(H1, H2, Houses) :- append(_, [H1, H2 | _], Houses).

next_of(H1, H2, Houses) :-
  side_by_side(H1, H2, Houses) ; side_by_side(H2, H1, Houses).

the_englishman_lives_in_red_house(Houses) :-
  contains(house(color(red), nationality(englishman), _, _, _), Houses).

the_spaniard_owns_the_dog(Houses) :-
  contains(house(_, nationality(spaniard), pet(dog), _, _), Houses).

coffee_is_drunk_in_the_green_house(Houses) :-
  contains(house(color(green), _, _, beverage(coffee), _), Houses).

the_ukrainian_drinks_tea(Houses) :-
  contains(house(_, nationality(ukrainian), _, beverage(tea), _), Houses).

the_green_house_is_immediately_to_the_right_of_the_ivory_house(Houses) :-
  side_by_side(house(color(green), _, _, _, _), house(color(ivory), _, _, _, _), Houses).

the_old_gold_smoker_owns_snails(Houses) :-
  contains(house(_, _, pet(snail), _, cigarette(old_gold)), Houses).

kools_are_smoked_in_the_yellow_house(Houses) :-
  contains(house(color(yellow), _, _, _, cigarette(kools)), Houses).

milk_is_drunk_in_the_middle_house([_, _, H, _, _]) :-
  H = house(_, _, _, beverage(milk), _).

the_norwegian_lives_in_the_first_house([H,_,_,_,_]) :-
  H = house(_, nationality(norwegian), _, _, _).

the_man_who_smokes_chesterfields_lives_in_the_house_next_to_the_man_with_the_fox(Houses) :-
  next_of(house(_, _, _, _, cigarette(chesterfields)), house(_, _, pet(fox), _, _), Houses).

kools_are_smoked_in_the_house_next_to_the_house_where_the_horse_is_kept(Houses) :-
  next_of(house(_, _, _, _, cigarette(kools)), house(_, _, pet(horse), _, _), Houses).

the_lucky_strike_smoker_drinks_orange_juice(Houses) :-
  contains(house(_, _, _, beverage(orange_juice), cigarette(lucky_strike)), Houses).

the_japonese_smokes_parliaments(Houses) :-
  contains(house(_, nationality(japanese), _, _, cigarette(parliaments)), Houses).

the_norwegian_lives_next_to_the_blue_house(Houses) :-
  next_of(house(_, nationality(norwegian), _, _, _), house(color(blue), _, _, _, _), Houses).

choice(Template, Rule, Values) :-
  findall(Template, Rule, AllValues),
  permutation(AllValues, Values).

combine([], [], [], [], [], []).
combine([C | CS], [N | NS], [P | PS], [B | BS], [G | GS], [H | Houses]) :-
    H = house(color(C), nationality(N), pet(P), beverage(B), cigarette(G)),
    combine(CS, NS, PS, BS, GS, Houses).

is_house(house(color(_), nationality(_), pet(_), beverage(_), cigarette(_))).

houses(Houses) :-
  length(Houses, 5),
  maplist(is_house, Houses),

  combine(Colors, Nationalities, Pets, Beverages, Cigarettes, Houses),

  the_norwegian_lives_in_the_first_house(Houses),
  milk_is_drunk_in_the_middle_house(Houses),

  choice(X, color(X), Colors),

  the_green_house_is_immediately_to_the_right_of_the_ivory_house(Houses),
  the_englishman_lives_in_red_house(Houses),
  the_norwegian_lives_next_to_the_blue_house(Houses),
  kools_are_smoked_in_the_yellow_house(Houses),
  coffee_is_drunk_in_the_green_house(Houses),    

  choice(X, nationality(X), Nationalities),

  the_japonese_smokes_parliaments(Houses),
  the_spaniard_owns_the_dog(Houses),
  the_ukrainian_drinks_tea(Houses),

  choice(X, cigarette(X), Cigarettes),

  the_old_gold_smoker_owns_snails(Houses),
  kools_are_smoked_in_the_house_next_to_the_house_where_the_horse_is_kept(Houses),
  the_man_who_smokes_chesterfields_lives_in_the_house_next_to_the_man_with_the_fox(Houses),
  the_lucky_strike_smoker_drinks_orange_juice(Houses),

  choice(X, beverage(X), Beverages),

  choice(X, pet(X), Pets).

zebra_owner(Owner) :-
  houses(Houses), !,
  contains(house(_, nationality(Owner), pet(zebra), _, _), Houses).

water_drinker(Drinker) :-
  houses(Houses), !,
  contains(house(_, nationality(Drinker), _, beverage(water), _), Houses).
