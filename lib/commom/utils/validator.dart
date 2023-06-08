class Validator {
  Validator._(); // Construtor privado para impedir a instanciação da classe

  // Método estático para validar um nome
  static String? validateName(String? value) {
    final condition = RegExp(r'^[a-zA-ZÀ-ÖØ-öø-ÿ]+(?: [a-zA-ZÀ-ÖØ-öø-ÿ]+)*$');

    if (value != null && value.isEmpty) {
      return "Por favor, informe o nome"; // Retorna uma mensagem de erro se o campo estiver vazio
    }
    if (value != null && !condition.hasMatch(value)) {
      return "Nome inválido. Por favor, informe um nome válido"; // Retorna uma mensagem de erro se o nome não atender ao padrão definido pela expressão regular
    }
    return null; // Retorna null se o nome for válido
  }

  // Método estático para validar um endereço de e-mail
  static String? validateEmail(String? value) {
    final condition = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (value != null && value.isEmpty) {
      return "Por favor, informe um endereço de e-mail"; // Retorna uma mensagem de erro se o campo estiver vazio
    }
    if (value != null && !condition.hasMatch(value)) {
      return "E-mail inválido. Por favor, informe um e-mail válido"; // Retorna uma mensagem de erro se o e-mail não atender ao padrão definido pela expressão regular
    }
    return null; // Retorna null se o e-mail for válido
  }

  // Método estático para validar uma senha
  static String? validatePassword(String? value) {
    final condition =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

    if (value != null && value.isEmpty) {
      return "Por favor, informe a senha"; // Retorna uma mensagem de erro se o campo estiver vazio
    }
    if (value != null && !condition.hasMatch(value)) {
      return "Senha Inválida. Digite uma senha válida."; // Retorna uma mensagem de erro se a senha não atender aos critérios definidos pela expressão regular
    }
    return null; // Retorna null se a senha for válida
  }

  // Método estático para validar a confirmação de senha
  static String? validateConfirmPassword(String? first, String? second) {
    if (first != second) {
      return "As senhas não são iguais."; // Retorna uma mensagem de erro se as senhas não forem iguais
    }
    return null; // Retorna null se as senhas forem iguais
  }
}