import 'package:flutter/material.dart';
import 'package:applock/presentation/common/widget/common_app_bar.dart';
import 'package:applock/presentation/common/widget/common_button.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';
import 'package:applock/utility/extension/build_context.dart';

class SettingsContactUsView extends StatefulWidget {
  final VoidCallback onBack;
  final VoidCallback onSubmitted;

  const SettingsContactUsView({
    required this.onBack,
    required this.onSubmitted,
    super.key,
  });

  @override
  State<SettingsContactUsView> createState() => _SettingsContactUsViewState();
}

class _SettingsContactUsViewState extends State<SettingsContactUsView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top-left Back Button
        CommonAppBar.back(onBack: widget.onBack),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                // Intro Description
                Text(
                  l10n.contactUsIntro,
                  style: AppTypography.regular.copyWith(
                    fontSize: 15,
                    color: AppColorsPalette.gray600,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 24),

                // Email Address Field
                _buildFieldLabel(l10n.emailAddressLabel),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _emailController,
                  hintText: l10n.emailHint,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),

                // Subject Field
                _buildFieldLabel(l10n.subjectLabel),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _subjectController,
                  hintText: l10n.subjectHint,
                ),
                const SizedBox(height: 20),

                // Message Field
                _buildFieldLabel(l10n.messageLabel),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _messageController,
                  hintText: l10n.messageHint,
                  maxLines: 5,
                ),
                const SizedBox(height: 16),

                // Privacy Policy Disclaimer
                Text(
                  l10n.contactPrivacyDisclaimer,
                  style: AppTypography.regular.copyWith(
                    fontSize: 12,
                    color: AppColorsPalette.gray500,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 24),

                // Send message Button
                CommonButton.filled(
                  text: l10n.sendMessageButton,
                  height: 48,
                  cornerRadius: 10,
                  backgroundColor: AppColorsPalette.black,
                  textColor: AppColorsPalette.white,
                  textStyle: AppTypography.semiBold.copyWith(
                    fontSize: 14,
                    color: AppColorsPalette.white,
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(l10n.messageSentSnackBar),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                    widget.onSubmitted();
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: AppTypography.bold.copyWith(
        fontSize: 15.5,
        color: AppColorsPalette.black,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColorsPalette.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: AppColorsPalette.gray200,
          width: 1,
        ),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        style: AppTypography.regular.copyWith(
          fontSize: 14.5,
          color: AppColorsPalette.black,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTypography.regular.copyWith(
            fontSize: 14.5,
            color: AppColorsPalette.gray400,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 14,
          ),
        ),
      ),
    );
  }
}
