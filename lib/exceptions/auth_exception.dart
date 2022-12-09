class AuthException implements Exception {
  static const Map<String, String> erros = {
    'EMAIL_EXISTS': 'E-mail já cadastrado',
    'OPERATION_NOT_ALLOWED': 'Operação não permitida',
    'TOO_MANY_ATTEMPTS_TRY_LATER': 'Excesso de tentativas. Tente mais tarde',
    'EMAIL_NOT_FOUND': 'E-mail não encontrado',
    'INVALID_PASSWORD': 'Senha incorreta',
    'USER_DISABLED': 'Conta de usuário desabilitada',
  };

  final String key;

  AuthException(this.key);

  @override
  String toString() {
    return erros[key] ?? 'Ocorreu um erro no processo de autenticação.';
  }
}
