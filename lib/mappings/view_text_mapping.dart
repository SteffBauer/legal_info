class ViewTextMapping {
  ViewTextMapping();

  static const String _privateLaw = "Privatrecht";
  static const String _privateLawFullText = "Privatrecht";

  static String privateLaw({bool fullText = false}) {
    if (fullText) {
      return _privateLawFullText;
    }
    return _privateLaw;
  }

  static const String _publicLaw = "Öff. Recht";
  static const String _publicLawFullText = "Öffentliches Recht";

  static String publicLaw({bool fullText = false}) {
    if (fullText) {
      return _publicLawFullText;
    }
    return _publicLaw;
  }

  static const String _criminalLaw = "Strafrecht";
  static const String _criminalLawFullText = "Strafrecht";

  static String criminalLaw({bool fullText = false}) {
    if (fullText) {
      return _criminalLawFullText;
    }
    return _criminalLaw;
  }

  static const String _tools = "Tools";
  static const String _toolsFullText = "Tools";

  static String tools({bool fullText = false}) {
    if (fullText) {
      return _toolsFullText;
    }
    return _tools;
  }
}
