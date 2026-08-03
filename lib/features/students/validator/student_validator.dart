class StudentValidator {
  String? validateId(String? value) {
    if (value == null || value.trim().isEmpty) return 'Student ID is required.';
    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Name is required.';
    if (value.trim().length < 3) return 'Enter at least 3 characters.';
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required.';
    if (!value.contains('@') || !value.contains('.')) return 'Enter a valid email address.';
    return null;
  }

  String? validateProgram(String? value) {
    if (value == null || value.trim().isEmpty) return 'Programme is required.';
    return null;
  }
}
