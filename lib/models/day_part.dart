enum DayPart { morning, noon, evening, night }

String getDayPartLabel(DayPart dayPart) {
  switch (dayPart) {
    case DayPart.morning:
      return "Morgens";
    case DayPart.noon:
      return "Mittags";
    case DayPart.evening:
      return "Abends";
    case DayPart.night:
      return "Nachts";
  }
}

String getDefaultTime(DayPart dayPart) {
  switch (dayPart) {
    case DayPart.morning:
      return "08:00";
    case DayPart.noon:
      return "12:00";
    case DayPart.evening:
      return "17:00";
    case DayPart.night:
      return "21:00";
  }
}
