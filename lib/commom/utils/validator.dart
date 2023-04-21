class Validator {
  Validator._(); // Chama as propriedade da class

  static String? validateName(String? value) {
    if (value != null && value.isEmpty) {
      return "Esse campo não pode ser vazio";
    }
    return null;
  }

  

}
