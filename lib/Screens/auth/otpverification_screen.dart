import 'dart:async';

import 'package:flutter/material.dart';

/// OTP verification screen based on the supplied Figma frame.
///
/// Supply your exported Figma widgets/images through the asset parameters.
class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({
    super.key,
    this.phoneNumber = '+91 98765XXXXX',
    this.brandLogo,
    this.backIcon,
    this.statusIcon,
    this.clockIcon,
    this.onBack,
    this.onVerify,
    this.onResend,
    this.onSupport,
  });

  final String phoneNumber;

  // FIGMA ASSET PLACEHOLDERS: replace these with Image.asset(...),
  // SvgPicture.asset(...), or your Figma-generated widgets.
  final Widget? brandLogo;
  final Widget? backIcon;
  final Widget? statusIcon;
  final Widget? clockIcon;

  final VoidCallback? onBack;
  final ValueChanged<String>? onVerify;
  final VoidCallback? onResend;
  final VoidCallback? onSupport;

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  static const _blue = Color(0xFF0B4DFF);
  final _controllers = List.generate(6, (_) => TextEditingController());
  final _focusNodes = List.generate(6, (_) => FocusNode());
  Timer? _timer;
  int _secondsRemaining = 30;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _secondsRemaining = 30);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        timer.cancel();
      } else {
        setState(() => _secondsRemaining--);
      }
    });
  }

  String get _otp => _controllers.map((controller) => controller.text).join();

  @override
  void dispose() {
    _timer?.cancel();
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const navy = Color(0xFF10182D);

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
                padding: const EdgeInsets.fromLTRB(30, 28, 30, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _circleButton(
                      child: widget.backIcon ??
                          const Icon(Icons.arrow_back, color: navy),
                      onTap: widget.onBack ??
                          () => Navigator.maybePop(context),
                    ),
                    // FIGMA PLACEHOLDER: brand mark / Wala pill.
                    widget.brandLogo ?? _defaultBrandLogo(),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(30, 27, 30, 20),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 460),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Verify OTP',
                          style: TextStyle(
                            fontSize: 29,
                            fontWeight: FontWeight.w800,
                            color: navy,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text.rich(
                          TextSpan(
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF506079),
                            ),
                            children: [
                              const TextSpan(text: "We've sent a 6-digit code to "),
                              TextSpan(
                                text: widget.phoneNumber,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: navy,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 27),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 42,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFD),
                            border: Border.all(color: const Color(0xFFDDE6F0)),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFE0F3FF),
                                ),
                                // FIGMA PLACEHOLDER: awaiting-verification icon.
                                child: widget.statusIcon ??
                                    const Icon(Icons.close_rounded, color: _blue),
                              ),
                              const SizedBox(width: 14),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Awaiting Verification',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w800,
                                      color: navy,
                                    ),
                                  ),
                                  SizedBox(height: 1),
                                  Text(
                                    'The code expires in 10 minutes',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF506079),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(6, _buildOtpBox),
                        ),
                        const SizedBox(height: 15),
                        Center(
                          child: GestureDetector(
                            onTap: _secondsRemaining == 0
                                ? () {
                                    widget.onResend?.call();
                                    _startTimer();
                                  }
                                : null,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // FIGMA PLACEHOLDER: clock icon.
                                widget.clockIcon ??
                                    const Icon(
                                      Icons.access_time_outlined,
                                      size: 16,
                                      color: Color(0xFF8291A8),
                                    ),
                                const SizedBox(width: 5),
                                Text(
                                  _secondsRemaining == 0
                                      ? 'Resend OTP'
                                      : 'Resend OTP in ',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF506079),
                                  ),
                                ),
                                if (_secondsRemaining > 0)
                                  Text(
                                    '00:${_secondsRemaining.toString().padLeft(2, '0')}',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: _blue,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: _otp.length == 6
                                ? () => widget.onVerify?.call(_otp)
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _blue,
                              disabledBackgroundColor: _blue,
                              foregroundColor: Colors.white,
                              disabledForegroundColor: Colors.white,
                              elevation: 5,
                              shadowColor: _blue.withValues(alpha: .35),
                              shape: const StadiumBorder(),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Verify',
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                                SizedBox(width: 8),
                                Icon(Icons.arrow_forward, size: 21),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 31),
                child: Center(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Text(
                        'Having trouble? Contact ',
                        style: TextStyle(fontSize: 11, color: Color(0xFF8A98AE)),
                      ),
                      GestureDetector(
                        onTap: widget.onSupport,
                        child: const Text(
                          'Support Team',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF4D5B73),
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOtpBox(int index) => SizedBox(
        width: 40,
        height: 46,
        child: TextField(
          controller: _controllers[index],
          focusNode: _focusNodes[index],
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          style: const TextStyle(
            color: Color(0xFF10182D),
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
          decoration: InputDecoration(
            counterText: '',
            contentPadding: EdgeInsets.zero,
            enabledBorder: _otpBorder(const Color(0xFFDDE6F0)),
            focusedBorder: _otpBorder(_blue, width: 1.8),
          ),
          onChanged: (value) {
            setState(() {});
            if (value.isNotEmpty && index < 5) {
              _focusNodes[index + 1].requestFocus();
            }
          },
          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        ),
      );

  static OutlineInputBorder _otpBorder(Color color, {double width = 1}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: color, width: width),
      );

  static Widget _circleButton({
    required Widget child,
    required VoidCallback onTap,
  }) =>
      InkWell(
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
            Icon(Icons.home_work_outlined, size: 18, color: _blue),
            SizedBox(width: 4),
            Text('Wala', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
          ],
        ),
      );
}
