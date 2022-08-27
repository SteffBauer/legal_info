enum GenderType { male, female }

class Gender {
  final GenderType gender;

  Gender(this.gender);

  @override
  String toString() {
    switch (gender) {
      case GenderType.male:
        return 'Männlich';
      case GenderType.female:
        return 'Weiblich';
    }
  }
}
