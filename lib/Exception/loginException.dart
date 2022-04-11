class LoginException{
  final String message;

  LoginException(this.message);

  @override
  String toString() {
    return this.message;
  }
}