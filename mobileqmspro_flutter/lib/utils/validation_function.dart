import 'package:string_validator/string_validator.dart';

String? validatePhone(String? value) {
  if (value == null || value.isEmpty) return 'Phone is required.';
  final RegExp nameExp = RegExp(
      r'(^\+[0-9]{2}|^\+[0-9]{2}\(0\)|^\(\+[0-9]{2}\)\(0\)|^00[0-9]{2}|^0)([0-9]{9}$|[0-9\-\s]{10}$)');
  if (!nameExp.hasMatch(value.trim())) {
    return 'Please enter only phone .';
  }
  return null;
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) return 'Email is required.';
  if (!isEmail(value.trim())) return 'Please enter only email.';
  return null;
}

String? validateEmails(List<String>? value) {
  if (value == null || value.isEmpty) return 'Email is required.';
  bool b = true;
  for (String email in value) {
    b = b && isEmail(email.trim());
  }
  if (b == false) return 'Please enter only email.';
  return null;
}

String? validateUrl(String? value) {
  if (value == null || value.isEmpty) return 'URL is required.';
  if (!isURL(value.toLowerCase().trim(), {'require_protocol': true})) {
    return 'Please enter only URL with protocol.';
  }
  return null;
}

String? validateWs(String value) {
  if (value.isEmpty) return 'WS is required.';
  if (!isURL(value.toLowerCase().trim(), {
    'protocols': ['ws', 'wss'],
    'require_protocol': true
  })) {
    return 'Please enter only WebSocket URL with protocol.';
  }
  return null;
}

String? validateText(String? value) {
  if (value == null || value.isEmpty) return 'Text is required.';
  final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
  if (!nameExp.hasMatch(value.trim())) {
    return 'Please enter only alphabetical characters.';
  }
  return null;
}

String? validateNotEmpty(String? value) {
  if (value == null || value.isEmpty) return 'Value is required.';
  return null;
}

String? validateJson(String? value) {
  if (value == null || value.isEmpty) return 'Json is required.';
  try {
    bool b = isJson(value);
    return (b == false) ? 'Json is invalid.' : null;
  } catch (e) {
    return 'JSON is required.';
  }
}

String? validateNum(String? value, int min, int max) {
  if (value == null || value.isEmpty) return 'Number is required.';
  try {
    int d = int.parse(value.trim());
    if (d >= min && d <= max) {
      return null;
    }
  } catch (exception) {
    return 'Please enter valid number';
  }
  return 'Please enter number only between $min and $max.';
}

String? validateDoubleValue(String? value) {
  if (value == null || value.isEmpty) return 'Number is required.';
  try {
    double.parse(value.trim());
  } catch (exception) {
    return 'Please enter valid number';
  }
  return null;
}

String? validateDouble(String? value, double min, double max) {
  if (value == null || value.isEmpty) return 'Number is required.';
  try {
    double d = double.parse(value.trim());
    if (d >= min && d <= max) {
      return null;
    }
  } catch (exception) {
    return 'Please enter valid number';
  }
  return 'Please enter number only between $min and $max.';
}

String? validateStringMinMax(String? value, int min, int max) {
  if (value == null || value.isEmpty) return 'Input is required.';
  if (value.trim().length < min) {
    return 'Please enter at least $min characters.';
  }
  if (value.trim().length > max) {
    return 'Please enter only $max characters.';
  }
  return null;
}

String? validateDigitMinMax(String? value, int min, int max) {
  if (value == null || value.isEmpty) return 'Input is required.';
  if (int.tryParse(value) == null) return 'Input MUST be digits';
  if (value.trim().length < min) {
    return 'Please enter at least $min digits.';
  }
  if (value.trim().length > max) {
    return 'Please enter only $max digits.';
  }
  return null;
}

String? validateAlphanumericMinMax(String? value, int min, int max) {
  if (value == null || value.isEmpty) return 'Input is required.';
  if (!isAlphanumeric(value)) return 'Alphanumeric is required.';
  if (value.trim().length < min) {
    return 'Please enter at least $min characters.';
  }
  if (value.trim().length > max) {
    return 'Please enter only $max characters.';
  }
  return null;
}

String? validateFilenameMinMax(String? value, int min, int max) {
  if (value == null || value.isEmpty) return 'Input is required.';
  if (isLength(value.trim(), min, max) == false) {
    return 'Please enter at least $min characters and at most $max characters.';
  }
  return null;
}

String? validateDeleteAccount(String? value) {
  if (value == null || value.isEmpty) return 'Input is required.';
  if (value != 'DELETE') {
    return 'Please enter "DELETE" in uppercase.';
  }
  return null;
}

String? validateLat(String value) {
  if (value.isEmpty) return 'Number Decimal is required.';
  double lat = double.parse(value.trim());
  if (!(lat >= -90 && lat <= 90)) {
    return 'Please enter only latitude. (-90.0>=lat && lat<=90.0).';
  }
  return null;
}

String? validateLng(String value) {
  if (value.isEmpty) return 'Number Decimal is required.';
  double lng = double.parse(value.trim());
  if (!(lng >= -180 && lng <= 180)) {
    return 'Please enter only longitude. (-180.0>=lng && lng<=180.0).';
  }
  return null;
}

String? validateInt(String? value) {
  if (value == null || value.isEmpty) return 'Number is required.';
  final RegExp nameExp = RegExp(r'^\d+$');
  if (!nameExp.hasMatch(value.trim())) {
    return 'Please enter only integer.';
  }
  return null;
}
