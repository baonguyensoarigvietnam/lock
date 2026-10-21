import 'package:flutter/material.dart';
import 'package:applock/presentation/common/widget/common_button.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        // Top-left Back Button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: IconButton(
            onPressed: widget.onBack,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: AppColorsPalette.black,
              size: 22,
            ),
          ),
        ),
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
                  "We're here to help. Fill out the form below and\nour support team will get back to you as soon as\npossible.",
                  style: AppTypography.regular.copyWith(
                    fontSize: 15,
                    color: AppColorsPalette.gray600,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 24),

                // Email Address Field
                _buildFieldLabel('Email Address'),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _emailController,
                  hintText: 'you@example.com',
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),

                // Subject Field
                _buildFieldLabel('Subject'),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _subjectController,
                  hintText: 'Brief summary of your issue',
                ),
                const SizedBox(height: 20),

                // Message Field
                _buildFieldLabel('Message'),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _messageController,
                  hintText: 'Describe your issue in detail...',
                  maxLines: 5,
                ),
                const SizedBox(height: 16),

                // Privacy Policy Disclaimer
                Text(
                  'By submitting this form, you agree to our Privacy Policy. We\nwill only use your email to respond to this request.',
                  style: AppTypography.regular.copyWith(
                    fontSize: 12,
                    color: AppColorsPalette.gray500,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 24),

                // Send message Button
                CommonButton.filled(
                  text: 'Send message',
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
                      const SnackBar(
                        content: Text('Message sent to support team'),
                        duration: Duration(seconds: 2),
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
