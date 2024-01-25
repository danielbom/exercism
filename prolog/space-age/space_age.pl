earth_years("Mercury", 0.2408467).
earth_years("Venus", 0.61519726).
earth_years("Earth", 1.0).
earth_years("Mars", 1.8808158).
earth_years("Jupiter", 11.862615).
earth_years("Saturn", 29.447498).
earth_years("Uranus", 84.016846).
earth_years("Neptune", 164.79132).

earth_seconds(Planet, Seconds) :-
  earth_years(Planet, EarthYears),
  Seconds is EarthYears * 31557600.

space_age(Planet, Years, Age) :-
  earth_seconds(Planet, Seconds),
  Age is Years / Seconds.