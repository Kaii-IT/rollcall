import 'package:flutter/widgets.dart';

abstract final class Validators {
  static final RegExp _email = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  static FormFieldValidator<String> required(String message) =>
      (value) => (value == null || value.trim().isEmpty) ? message : null;

  static String? email(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Enter your university email';
    if (!_email.hasMatch(v)) return 'That email doesn\u2019t look right';
    return null;
  }

  static String? newPassword(String? value) {
    if (value == null || value.isEmpty) return 'Choose a password';
    if (value.length < 8) return 'Use at least 8 characters';
    return null;
  }
}

/// Turns "maya.chen@uni.edu" or "maya_chen" into "Maya".
String displayNameFrom(String identifier) {
  final local = identifier.trim().split('@').first;
  final first = local.split(RegExp(r'[._\-\s]+')).firstWhere(
        (part) => part.isNotEmpty,
        orElse: () => '',
      );
  if (first.isEmpty) return '';
  return first[0].toUpperCase() + first.substring(1).toLowerCase();
}
