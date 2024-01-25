all_foods([pad_thai, frybread, tagine, biryani]).

all_drinks([tonic, lassi, kombucha, amasi]).

chefs(Chefs):-
    length(Chefs, 4),
    maplist(chef, Chefs).

chef([_, _, _]).

info(Chefs):-
    chefs(Chefs),
    all_foods(Foods),
    all_drinks(Drinks),
    Chefs = [Aisha, Emma, Mei, Winona],
    member([_, frybread, tonic], Chefs), % info 3
    member([_, FoodOfLassiChef, lassi], Chefs),
    dif(FoodOfLassiChef, biryani), % info 6
    Aisha = [aisha, tagine, ADrink],
    select(tagine, Foods, RF1), % info 1
    Emma = [emma, EDish, amasi],
    select(amasi, Drinks, RD1), % info 2
    Mei = [mei, MDish, lassi],
    select(lassi, RD1, RD2), % info 4
    Winona = [winona, WDish, WDrink],
    dif(WDish, pad_thai), % info 5
    select(EDish, RF1, RF2),
    select(MDish, RF2, RF3),
    select(WDish, RF3, []),
    select(ADrink, RD2, RD3),
    select(WDrink, RD3, []).
  
beverage(Chef, Beverage):-
    info(Chefs),
    member([Chef, _, Beverage], Chefs),
    !.
  
dish(Chef, Dish):-
    info(Chefs),
    member([Chef, Dish, _], Chefs),
    !.
