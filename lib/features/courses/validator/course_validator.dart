class CourseValidator {
  String? validateId(String? value) {
    if (value == null || value.trim().isEmpty) return 'Course ID is required.';
    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Course Name is required.';
    if (value.trim().length < 3) return 'Enter at least 3 characters.';
    return null;
  }

  String? validateCredits(String? value) {
    if (value == null || value.trim().isEmpty) return 'Credits are required.';
    if (int.tryParse(value) == null) return 'Enter a valid number.';
    return null;
  }

  String? validateFee(String? value) {
    if (value == null || value.trim().isEmpty) return 'Fee is required.';
    if (double.tryParse(value) == null) return 'Enter a valid amount.';
    return null;
  }
}
