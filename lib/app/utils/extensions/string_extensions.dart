extension StringExtensions on String {
  bool get isNullOrWhiteSpace {
    return this == null || this.trim().isEmpty;
  }
}

extension EmailExtensions on String {
  bool get isEmail {
    final regex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return regex.hasMatch(this);
  }
}

extension NumExtensions on String {
  double get parseToDouble {
    if (!this.isNullOrWhiteSpace) {
      return double.parse(this);
    } else {
      return 0;
    }
  }
}

extension CapExtension on String {
  String get inCaps => this.length > 0 ? '${this[0].toUpperCase()}${this.substring(1)}' : '';
  String get capitalizeFirstofEach {
    if (this.isNullOrWhiteSpace) return '';
    return this
        .toLowerCase()
        .replaceAll(RegExp(' +'), ' ')
        .split(" ")
        .map((str) => str.inCaps)
        .join(" ");
  }
}

extension PhoneExtensions on String {
  bool get isPhoneNumber {
    if (this.length > 9 && this.length < 12) {
      return true;
    } else {
      return false;
    }
  }
}
