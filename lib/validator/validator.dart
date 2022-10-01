class Validator {
  RegExp phoneRegExp = RegExp(r"^05[0-9][0-9][0-9]{3}[0-9]{2}[0-9]{2}$");
  RegExp nameRegExp = RegExp(
      r"^([a-zA-Z]{1,10}\s?[a-zA-Z]{1,10}'?-?[a-zA-Z]{1,10}\s?([a-zA-Z]{1,10})?)$");

  String? phoneValidate(String? value) {
    bool? result;
    try {
      result = phoneRegExp.hasMatch(value!);
      if (result) {
        return null;
      }
    } catch (e) {
      return "please enter a valid number";
    }
    return "please enter a valid number";
  }

  String? nameValidate(String? value) {
    bool? result;
    try {
      result = nameRegExp.hasMatch(value!);
      if (!result) {
        return "please enter a valid name";
      }
    } catch (e) {
      return "please enter a valid name";
    }
    return null;
  }
}
