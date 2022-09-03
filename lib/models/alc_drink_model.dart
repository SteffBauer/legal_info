class AlcoholicDrink {
  double percentage;
  double volume;
  int volumeFactor = 1;
  DrinkType drinkType;

  double alcoholInGrams() {
    return (percentage / 100) * volume * 0.8;
  }

  AlcoholicDrink(
      {required this.percentage,
      required this.volume,
      required this.drinkType});

  AlcoholicDrink.clone(AlcoholicDrink alcoholicDrink)
      : this(
          percentage: alcoholicDrink.percentage,
          volume: alcoholicDrink.volume,
          drinkType: alcoholicDrink.drinkType,
        );

  static Map<DrinkType, double> drinkTypeToPercentage = {
    DrinkType.Bier: 5.0,
    DrinkType.Wein: 12.0,
    DrinkType.Schnaps: 40.0,
    DrinkType.Cocktail: 17.0,
    DrinkType.Sonstiges: 0.0,
  };

  static Map<String, int> volumeTypeFactor = {
    "ml": 1,
    "l": 1000,
    "cl": 10,
    "dl": 100,
  };
}

enum DrinkType { Bier, Wein, Schnaps, Cocktail, Sonstiges }
