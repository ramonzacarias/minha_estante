class Validator {
  Validator._(); // Chama as propriedade da class

  static String? validateName(String? value) {
    final condition = RegExp(r'^[a-zA-ZÀ-ÖØ-öø-ÿ]+(?: [a-zA-ZÀ-ÖØ-öø-ÿ]+)*$');

    if (value != null && value.isEmpty) {
      return "Por favor, informe o nome";
    }
    if (value != null && !condition.hasMatch(value)) {
      return "Nome inválido. Por favor, informe um nome válido";
    }
    return null;
  }

  static String? validateEmail(String? value) {
    final condition = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (value != null && value.isEmpty) {
      return "Por favor, informe um endereço de e-mail";
    }
    if (value != null && !condition.hasMatch(value)) {
      return "E-mail inválido. Por favor, informe um e-mail válido";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    final condition =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

    if (value != null && value.isEmpty) {
      return "Por favor, informe a senha";
    }
    if (value != null && !condition.hasMatch(value)) {
      return "Senha Inválida. Digite uma senha válida.";
    }
    return null;
  }

  static String? validateConfirmPassword(String? first, String? second) {
    if (first != second) {
      return "As senhas não são iguais.";
    }
    return null;
  }
}
