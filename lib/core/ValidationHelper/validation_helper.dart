class ValidationHelper {
  static String? validateEmail({
    required String? value,
  }) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());

    if (value == null || value == '') {
      return 'Please enter Email';
    } else if (!(regex.hasMatch(value))) {
      return "Invalid Email";
    } else {
      return null;
    }
  }

  static String? validatePassword({
    required String? value,
  }) {
    RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
    if (value == null || value == '') {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'should contain one(upper case - lower case - digit) and minimum 8 characters)';
      } else {
        return null;
      }
    }
  }

  static String? validatePassowrdConfirm(
      {required String? confirmPassword, required String password}) {
    if (confirmPassword == null || confirmPassword == '') {
      return 'Please enter your password again';
    } else if (confirmPassword != password) {
      return "Invalid Password";
    } else {
      return null;
    }
  }

  static String? validateName({required String? value, String? name = 'name'}) {
    if (value == null || value == '') {
      return 'Please enter your $name';
    } else {
      return null;
    }
  }

  static String? validateBio({required String? value}) {
    if (value == null || value == '') {
      return 'Please enter your bio';
    } else {
      return null;
    }
  }

  static String? validateRoomName({required String? value}) {
    RegExp regex = RegExp(r'^[a-zA-Z0-9_]+$');
    if (value == null || value == '') {
      return 'Please enter your room name';
    } else if (value.length < 3) {
      return 'Room name must be at least 3 characters';
    } else if (!regex.hasMatch(value)) {
      return 'Room name must be alphanumeric';
    } else {
      return null;
    }
  }

  static String? privateRoomId({required String? value}) {
    if (value == null || value == '') {
      return 'Please enter your room id';
    } else if (value.length != 24) {
      return 'Room id must be 24 characters';
    } else {
      return null;
    }
  }
}
