class AuthException implements Exception {}

class UserNotFoundException implements AuthException {}

class WrongPasswordException implements AuthException {}

class InvalidEmailException implements AuthException {}

class UserDisabledException implements AuthException {}

class WeakPasswordException implements AuthException {}

class EmailAlreadyInUseException implements AuthException {}

class TooManyRequestException implements AuthException {}
