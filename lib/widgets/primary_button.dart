import 'package:flutter/material.dart';
import 'package:refresher/utils/color_pallete.dart';
import 'package:refresher/utils/custom_text_theme.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.onPressed,
    required this.title,
    required this.disabled,
    super.key,
    this.isLoading,
    this.isAlert,
    this.height,
  });

  final VoidCallback onPressed;
  final String title;
  final bool disabled;
  final bool? isLoading;
  final bool? isAlert;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return MaterialButton(
          color: isAlert ?? false
              ? (disabled || (isLoading ?? false))
                  ? AppTheme.appTheme().kErrorColor.withValues(alpha: .4)
                  : AppTheme.appTheme().kErrorColor
              : (disabled || (isLoading ?? false))
                  ? AppTheme.appTheme().kPrimaryColorV2.withValues(alpha: .4)
                  : AppTheme.appTheme().kPrimaryColorV2,
          minWidth: double.infinity,
          height: height ?? 55,
          elevation: 0,
          highlightElevation: 0,
          focusElevation: 0,
          hoverElevation: 0,
          disabledElevation: 0,
          onPressed: disabled ? () {} : onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          child: Wrap(
            children: [
              if (isLoading ?? false) ...[
                SizedBox(
                  height: 14,
                  width: 14,
                  child: CircularProgressIndicator(
                    color: AppTheme.appTheme().kBackgroundColor,
                    backgroundColor: Colors.transparent,
                    strokeWidth: 2,
                  ),
                ),
                const SizedBox(width: 8),
              ] else
                const SizedBox.shrink(),
              Text(
                title,
                style:
                    CustomTextTheme.customTextTheme().headlineSmall!.copyWith(
                          color: AppTheme.appTheme().kBackgroundColor,
                          fontWeight: FontWeight.w700,
                        ),
              ),
            ],
          ),
        );
      },
    );
  }
}
