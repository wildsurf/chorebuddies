class ActivitySummary {
  int totalActivities;
  int totalPoints;

  ActivitySummary({this.totalActivities = 0, this.totalPoints = 0});

  String get title {
    if (totalPoints == 0) {
      return "Lazy Bum";
    } else if (totalPoints < 10) {
      return "Rising Star";
    } else if (totalPoints < 20) {
      return "Protecor of the Realm";
    } else {
      return "Total Working Class Hero";
    }
  }
}
