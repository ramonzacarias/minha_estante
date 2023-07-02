// Para auxiliar para truncar texto
class TruncateText {
  static String truncateText(String description, int maxLength) {
    if (description.length > maxLength) {
      return description.substring(0, maxLength) + "...";
    } else {
      return description;
    }
  }
}