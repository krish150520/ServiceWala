import 'package:flutter/material.dart';

/// Login screen based on the supplied Figma frame.
///
/// Pass your exported Figma widgets/images into [brandLogo], [backIcon],
/// [countryFlagIcon], [phoneIcon], [fieldTrailingIcon], and [googleIcon].
/// Every slot has a simple fallback so the screen runs before the assets arrive.
class WelcomeBackScreen extends StatefulWidget {
  const WelcomeBackScreen({
    super.key,
    this.brandLogo,
    this.backIcon,
    this.countryFlagIcon,
    this.phoneIcon,
    this.fieldTrailingIcon,
    this.googleIcon,
    this.onBack,
    this.onSendOtp,
    this.onGoogle,
    this.onSignUp,
  });

  // FIGMA ASSET PLACEHOLDERS: replace any of these with Image.asset(...),
  // SvgPicture.asset(...), or your generated Figma widget.
  final Widget? brandLogo;
  final Widget? backIcon;
  final Widget? countryFlagIcon;
  final Widget? phoneIcon;
  final Widget? fieldTrailingIcon;
  final Widget? googleIcon;

  final VoidCallback? onBack;
  final ValueChanged<String>? onSendOtp;
  final VoidCallback? onGoogle;
  final VoidCallback? onSignUp;

  @override
  State<WelcomeBackScreen> createState() => _WelcomeBackScreenState();
}

class _WelcomeBackScreenState extends State<WelcomeBackScreen> {
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const navy = Color(0xFF10182D);
    const blue = Color(0xFF0B4DFF);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color(0xFFE7F8FF), Colors.white, Color(0xFFF0F4FF)],
              stops: [0, .40, 1],
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _circleButton(
                      onTap: widget.onBack ?? () => Navigator.maybePop(context),
                      child:
                          widget.backIcon ??
                          const Icon(Icons.arrow_back, color: navy),
                    ),
                    // FIGMA PLACEHOLDER: brand mark / "Wala" pill.
                    widget.brandLogo ?? _defaultBrandLogo(),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 30, 24, 22),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 460),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Welcome Back',
                          style: TextStyle(
                            fontSize: 29,
                            height: 1.2,
                            fontWeight: FontWeight.w800,
                            color: navy,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Enter your phone number to continue',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF506079),
                          ),
                        ),
                        const SizedBox(height: 28),
                        const Text(
                          'PHONE NUMBER',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF4A5870),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              height: 48,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF5F7FA),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(0xFFE2E8F0),
                                ),
                              ),
                              child: Row(
                                children: [
                                  // FIGMA PLACEHOLDER: country/flag icon.
                                  widget.countryFlagIcon ??
                                      const Icon(Icons.language, size: 18),
                                  const SizedBox(width: 7),
                                  const Text(
                                    '+91',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: navy,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 17,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: SizedBox(
                                height: 48,
                                child: TextField(
                                  controller: _phoneController,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    hintText: 'Enter your phone\nnumber',
                                    hintStyle: const TextStyle(
                                      fontSize: 14,
                                      height: 1.05,
                                      color: Color(0xFF52617A),
                                    ),
                                    // FIGMA PLACEHOLDER: phone icon.
                                    prefixIcon:
                                        widget.phoneIcon ??
                                        const Icon(
                                          Icons.phone_outlined,
                                          color: blue,
                                        ),
                                    // FIGMA PLACEHOLDER: validation/check icon.
                                    suffixIcon:
                                        widget.fieldTrailingIcon ??
                                        const Icon(
                                          Icons.check_circle_outline,
                                          color: blue,
                                          size: 19,
                                        ),
                                    enabledBorder: _fieldBorder(blue),
                                    focusedBorder: _fieldBorder(
                                      blue,
                                      width: 1.8,
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 6,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 28),
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () =>
                                widget.onSendOtp?.call(_phoneController.text),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: blue,
                              foregroundColor: Colors.white,
                              elevation: 5,
                              shadowColor: blue.withValues(alpha: .35),
                              shape: const StadiumBorder(),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Send OTP',
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                                SizedBox(width: 8),
                                Icon(Icons.arrow_forward, size: 19),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Row(
                          children: [
                            Expanded(child: Divider(color: Color(0xFFE1E8F1))),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                'OR',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFF8A98AE),
                                ),
                              ),
                            ),
                            Expanded(child: Divider(color: Color(0xFFE1E8F1))),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: OutlinedButton.icon(
                            onPressed: widget.onGoogle,
                            // FIGMA PLACEHOLDER: Google logo.
                            icon:
                                widget.googleIcon ??
                                const Icon(Icons.close, size: 18, color: navy),
                            label: const Text(
                              'Continue with Google',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: navy,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              shape: const StadiumBorder(),
                              side: const BorderSide(color: Color(0xFFD3DDEB)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 34),
                        Center(
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account? ",
                                style: TextStyle(color: Color(0xFF506079)),
                              ),
                              GestureDetector(
                                onTap: widget.onSignUp,
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: blue,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(36, 8, 36, 18),
                child: Text.rich(
                  TextSpan(
                    style: TextStyle(
                      fontSize: 11,
                      height: 1.4,
                      color: Color(0xFF8A98AE),
                    ),
                    children: [
                      TextSpan(text: 'By continuing, you agree to our '),
                      TextSpan(
                        text: 'Terms of Service',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Color(0xFF4D5B73),
                        ),
                      ),
                      TextSpan(text: ' and\n'),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Color(0xFF4D5B73),
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static OutlineInputBorder _fieldBorder(Color color, {double width = 1.4}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: color, width: width),
      );

  static Widget _circleButton({
    required Widget child,
    required VoidCallback onTap,
  }) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(30),
    child: Container(
      width: 38,
      height: 38,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFFF7F9FC),
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFE3E9F1)),
      ),
      child: child,
    ),
  );

  static Widget _defaultBrandLogo() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: .72),
      borderRadius: BorderRadius.circular(22),
    ),
    child: const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.home_work_outlined, size: 18, color: Color(0xFF0B4DFF)),
        SizedBox(width: 4),
        Text(
          'Wala',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
        ),
      ],
    ),
  );
}
