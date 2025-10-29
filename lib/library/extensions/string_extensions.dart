import 'package:flutter/material.dart';

/// Extensions for String class
extension StringExtensions on String {
  /// Check if string is null or empty
  bool get isNullOrEmpty => isEmpty;

  /// Check if string is not null and not empty
  bool get isNotNullOrEmpty => isNotEmpty;

  /// Check if string is null, empty, or only whitespace
  bool get isNullOrWhitespace => trim().isEmpty;

  /// Check if string is not null, not empty, and not only whitespace
  bool get isNotNullOrWhitespace => trim().isNotEmpty;

  /// Capitalize the first letter of the string
  String get capitalize {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }

  /// Capitalize the first letter of each word
  String get capitalizeWords {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize).join(' ');
  }

  /// Convert string to title case
  String get toTitleCase {
    return split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  /// Convert string to camelCase
  String get toCamelCase {
    if (isEmpty) return this;
    
    final words = split(RegExp(r'[\s_-]+'));
    if (words.isEmpty) return this;
    
    final firstWord = words[0].toLowerCase();
    final otherWords = words.skip(1).map((word) => word.capitalize).join('');
    
    return firstWord + otherWords;
  }

  /// Convert string to snake_case
  // String get toSnakeCase {
  //   return replaceAll(RegExp(r'[A-Z]'), (match) => '_${match.group(0)!.toLowerCase()}')
  //       .replaceAll(RegExp(r'[\s-]+'), '_')
  //       .replaceAll(RegExp(r'^_|_$'), '')
  //       .toLowerCase();
  // }

  // /// Convert string to kebab-case
  // String get toKebabCase {
  //   return replaceAll(RegExp(r'[A-Z]'), (match) => '-${match.group(0)!.toLowerCase()}')
  //       .replaceAll(RegExp(r'[\s_]+'), '-')
  //       .replaceAll(RegExp(r'^-|-$'), '')
  //       .toLowerCase();
  // }

  /// Convert string to slug (URL-friendly)
  String get toSlug {
    return toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9\s-]'), '')
        .replaceAll(RegExp(r'\s+'), '-')
        .replaceAll(RegExp(r'-+'), '-')
        .trim();
  }

  /// Truncate string to maximum length
  String truncate(int maxLength, {String suffix = '...'}) {
    if (length <= maxLength) return this;
    return substring(0, maxLength - suffix.length) + suffix;
  }

  /// Truncate string at word boundaries
  String truncateWords(int maxWords, {String suffix = '...'}) {
    final words = split(' ');
    if (words.length <= maxWords) return this;
    return words.take(maxWords).join(' ') + suffix;
  }

  /// Remove all whitespace from string
  String get removeWhitespace {
    return replaceAll(RegExp(r'\s+'), '');
  }

  /// Normalize whitespace in string
  String get normalizeWhitespace {
    return replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  /// Extract initials from name
  String getInitials({int maxInitials = 2}) {
    if (isEmpty) return '';
    
    final words = trim().split(RegExp(r'\s+'));
    final initials = words.take(maxInitials).map((word) {
      if (word.isEmpty) return '';
      return word[0].toUpperCase();
    }).join('');
    
    return initials;
  }

  /// Mask email address
  String get maskEmail {
    if (isEmpty || !contains('@')) return this;
    
    final parts = split('@');
    final username = parts[0];
    final domain = parts[1];
    
    if (username.length <= 2) return this;
    
    final maskedUsername = username[0] + '*' * (username.length - 2) + username[username.length - 1];
    return '$maskedUsername@$domain';
  }

  /// Mask phone number
  String get maskPhone {
    if (length < 4) return this;
    
    final visibleDigits = length - 4;
    final masked = '*' * visibleDigits + substring(visibleDigits);
    return masked;
  }

  /// Format phone number
  String get formatPhone {
    final digits = replaceAll(RegExp(r'\D'), '');
    
    if (digits.length == 10) {
      return '(${digits.substring(0, 3)}) ${digits.substring(3, 6)}-${digits.substring(6)}';
    } else if (digits.length == 11 && digits[0] == '1') {
      return '+1 (${digits.substring(1, 4)}) ${digits.substring(4, 7)}-${digits.substring(7)}';
    }
    
    return this;
  }

  /// Check if string contains only digits
  bool get isNumeric {
    return RegExp(r'^\d+$').hasMatch(this);
  }

  /// Check if string contains only letters
  bool get isAlpha {
    return RegExp(r'^[a-zA-Z]+$').hasMatch(this);
  }

  /// Check if string contains only letters and numbers
  bool get isAlphaNumeric {
    return RegExp(r'^[a-zA-Z0-9]+$').hasMatch(this);
  }

  /// Check if string is a valid email
  bool get isValidEmail {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(this);
  }

  /// Check if string is a valid phone number
  bool get isValidPhone {
    return RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(this);
  }

  /// Check if string is a valid URL
  bool get isValidUrl {
    return RegExp(r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$').hasMatch(this);
  }

  /// Count words in string
  int get wordCount {
    if (trim().isEmpty) return 0;
    return trim().split(RegExp(r'\s+')).length;
  }

  /// Count characters excluding spaces
  int get characterCount {
    return replaceAll(RegExp(r'\s'), '').length;
  }

  /// Reverse the string
  String get reversed {
    return split('').reversed.join('');
  }

  /// Check if string is a palindrome
  bool get isPalindrome {
    final cleaned = toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');
    return cleaned == cleaned.reversed;
  }

  /// Extract numbers from string
  String get extractNumbers {
    return replaceAll(RegExp(r'[^0-9]'), '');
  }

  /// Extract letters from string
  String get extractLetters {
    return replaceAll(RegExp(r'[^a-zA-Z]'), '');
  }

  /// Remove HTML tags from string
  String get stripHtml {
    return replaceAll(RegExp(r'<[^>]*>'), '');
  }

  /// Pad string to specific length (left padding)
  String padLeft(int length, {String padding = ' '}) {
    if (this.length >= length) return this;
    return padding * (length - this.length) + this;
  }

  /// Pad string to specific length (right padding)
  String padRight(int length, {String padding = ' '}) {
    if (this.length >= length) return this;
    return this + padding * (length - this.length);
  }

  /// Center string within specific length
  String padCenter(int length, {String padding = ' '}) {
    if (this.length >= length) return this;
    
    final totalPadding = length - this.length;
    final leftPadding = totalPadding ~/ 2;
    final rightPadding = totalPadding - leftPadding;
    
    return padding * leftPadding + this + padding * rightPadding;
  }

  /// Convert string to Color
  Color get toColor {
    // Remove # if present
    String hexColor = replaceAll('#', '');
    
    // Add alpha if not present
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    
    return Color(int.parse(hexColor, radix: 16));
  }

  /// Convert string to int with fallback
  int toInt({int fallback = 0}) {
    return int.tryParse(this) ?? fallback;
  }

  /// Convert string to double with fallback
  double toDouble({double fallback = 0.0}) {
    return double.tryParse(this) ?? fallback;
  }

  /// Convert string to bool
  bool get toBool {
    final lower = toLowerCase();
    return lower == 'true' || lower == '1' || lower == 'yes' || lower == 'on';
  }

  /// Split string by multiple delimiters
  List<String> splitBy(List<String> delimiters) {
    if (delimiters.isEmpty) return [this];
    
    String pattern = delimiters.map((d) => RegExp.escape(d)).join('|');
    return split(RegExp(pattern));
  }

  /// Replace multiple patterns at once
  String replaceMultiple(Map<String, String> replacements) {
    String result = this;
    replacements.forEach((pattern, replacement) {
      result = result.replaceAll(pattern, replacement);
    });
    return result;
  }

  /// Check if string starts with any of the given prefixes
  bool startsWithAny(List<String> prefixes) {
    return prefixes.any((prefix) => startsWith(prefix));
  }

  /// Check if string ends with any of the given suffixes
  bool endsWithAny(List<String> suffixes) {
    return suffixes.any((suffix) => endsWith(suffix));
  }

  /// Check if string contains any of the given substrings
  bool containsAny(List<String> substrings) {
    return substrings.any((substring) => contains(substring));
  }

  /// Check if string contains all of the given substrings
  bool containsAll(List<String> substrings) {
    return substrings.every((substring) => contains(substring));
  }

  /// Get substring between two strings
  String substringBetween(String start, String end) {
    final startIndex = indexOf(start);
    if (startIndex == -1) return '';
    
    final endIndex = indexOf(end, startIndex + start.length);
    if (endIndex == -1) return '';
    
    return substring(startIndex + start.length, endIndex);
  }

  /// Remove substring between two strings
  String removeBetween(String start, String end) {
    final startIndex = indexOf(start);
    if (startIndex == -1) return this;
    
    final endIndex = indexOf(end, startIndex + start.length);
    if (endIndex == -1) return this;
    
    return substring(0, startIndex) + substring(endIndex + end.length);
  }
}
