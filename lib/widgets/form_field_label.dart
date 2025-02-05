import 'package:flutter/material.dart';
import 'package:refresher/utils/custom_text_theme.dart';

class FormFieldLabel extends StatelessWidget {
  const FormFieldLabel({
    required this.label,
    super.key,
    this.isOptional,
    this.isRequired,
    this.color,
  });
  final String label;
  final bool? isOptional;
  final bool? isRequired;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return RichText(
          text: TextSpan(
            text: label,
            style: CustomTextTheme.customTextTheme().headlineSmall!.copyWith(
                  fontSize: 15,
                  color: color,
                ),
            children: [
              if (isRequired ?? false)
                TextSpan(
                  text: ' *',
                  style:
                      CustomTextTheme.customTextTheme().headlineSmall!.copyWith(
                            fontSize: 14,
                          ),
                ),
              if (isOptional ?? false)
                TextSpan(
                  text: ' (optional)',
                  style:
                      CustomTextTheme.customTextTheme().titleMedium!.copyWith(
                            color: const Color(0xff939393),
                            fontSize: 14,
                          ),
                ),
            ],
          ),
        );
      },
    );
  }
}
