// check if email is valid using regex.
bool isValidEmail(String email) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern.toString());
  return (!regex.hasMatch(email)) ? false : true;
}

bool isValidUrl(String url) {
  Pattern pattern = r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&:/~+#-]*[\w@?^=%&/~+#-])?';

  RegExp regex = RegExp(pattern.toString());
  return (!regex.hasMatch(url)) ? false : true;
}

bool isPasswordValid(String passowrd) {
  Pattern pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

  RegExp regex = RegExp(pattern.toString());
  return (!regex.hasMatch(passowrd)) ? false : true;
}

bool doPasswordsMatch(String password, String passwordConfirm) =>
    (password == passwordConfirm);