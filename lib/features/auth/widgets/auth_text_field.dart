import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType,
    this.validator,
  });

  // TextField-এর value এখানে রাখা হবে।
  final TextEditingController controller;

  final String label;
  final String hintText;
  final IconData prefixIcon;

  // Password hide/show করার জন্য ব্যবহার করব।
  final bool obscureText;

  // Password field-এর eye icon এখানে আসবে।
  final Widget? suffixIcon;

  final TextInputType? keyboardType;

  // Form validation-এর জন্য।
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.dark,
          ),
        ),

        const SizedBox(height: 8),

        TextFormField(
          controller: controller,

          // Password হলে text hide হবে।
          obscureText: obscureText,

          keyboardType: keyboardType,

          validator: validator,

          style: const TextStyle(
            fontSize: 16,
            color: AppColors.dark,
          ),

          decoration: InputDecoration(
            hintText: hintText,

            prefixIcon: Icon(
              prefixIcon,
              color: AppColors.textSecondary,
            ),

            suffixIcon: suffixIcon,

            filled: true,
            fillColor: AppColors.surface,

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 1.5,
              ),
            ),

            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(
                color: AppColors.emergency,
              ),
            ),

            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(
                color: AppColors.emergency,
                width: 1.5,
              ),
            ),

            contentPadding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 18,
            ),
          ),
        ),
      ],
    );
  }
}