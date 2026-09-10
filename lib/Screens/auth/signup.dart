import 'package:flutter/material.dart';

/// Account creation screen based on the supplied Figma frame.
///
/// Replace the optional Widget slots with exported Figma assets/widgets.
class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({
    super.key,
    this.initialPhoneNumber = '+91 98765XXXXX',
    this.initialCity = 'Amritsar',
    this.brandLogo,
    this.backIcon,
    this.profilePlaceholder,
    this.cameraIcon,
    this.nameIcon,
    this.emailIcon,
    this.phoneIcon,
    this.lockIcon,
    this.cityIcon,
    this.addressIcon,
    this.onBack,
    this.onCreateAccount,
    this.onLogin,
  });

  final String initialPhoneNumber;
  final String initialCity;

  // FIGMA ASSET PLACEHOLDERS: Image.asset(...), SvgPicture.asset(...), etc.
  final Widget? brandLogo;
  final Widget? backIcon;
  final Widget? profilePlaceholder;
  final Widget? cameraIcon;
  final Widget? nameIcon;
  final Widget? emailIcon;
  final Widget? phoneIcon;
  final Widget? lockIcon;
  final Widget? cityIcon;
  final Widget? addressIcon;

  final VoidCallback? onBack;
  final ValueChanged<AccountDetails>? onCreateAccount;
  final VoidCallback? onLogin;

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class AccountDetails {
  const AccountDetails({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.city,
    required this.address,
  });

  final String fullName;
  final String email;
  final String phoneNumber;
  final String city;
  final String address;
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  static const _navy = Color(0xFF10182D);
  static const _blue = Color(0xFF0B4DFF);
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  late final TextEditingController _phoneController;
  late String _city;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController(text: widget.initialPhoneNumber);
    _city = widget.initialCity;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    widget.onCreateAccount?.call(AccountDetails(
      fullName: _nameController.text.trim(),
      email: _emailController.text.trim(),
      phoneNumber: _phoneController.text.trim(),
      city: _city,
      address: _addressController.text.trim(),
    ));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Color(0xFFE7F8FF), Colors.white, Color(0xFFF0F4FF)],
                stops: [0, .4, 1],
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(23, 24, 23, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _circleButton(
                        child: widget.backIcon ??
                            const Icon(Icons.arrow_back, color: _navy),
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
                    padding: const EdgeInsets.fromLTRB(23, 22, 23, 20),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 460),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Create Account',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w800,
                                color: _navy,
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              'Fill in your details to get started',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF506079),
                              ),
                            ),
                            const SizedBox(height: 21),
                            Center(child: _profilePhoto()),
                            const SizedBox(height: 19),
                            _label('FULL NAME'),
                            const SizedBox(height: 5),
                            _textField(
                              controller: _nameController,
                              hint: 'Enter your full name',
                              icon: widget.nameIcon ??
                                  const Icon(Icons.person_outline),
                              validator: (value) => value == null ||
                                      value.trim().isEmpty
                                  ? 'Please enter your full name'
                                  : null,
                            ),
                            const SizedBox(height: 13),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _label('EMAIL ADDRESS'),
                                const Text(
                                  '(Optional)',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Color(0xFF8291A8),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            _textField(
                              controller: _emailController,
                              hint: 'Enter email address',
                              keyboardType: TextInputType.emailAddress,
                              icon: widget.emailIcon ??
                                  const Icon(Icons.mail_outline),
                              validator: (value) {
                                if (value == null || value.isEmpty) return null;
                                return value.contains('@')
                                    ? null
                                    : 'Enter a valid email';
                              },
                            ),
                            const SizedBox(height: 13),
                            _label('PHONE NUMBER'),
                            const SizedBox(height: 5),
                            _textField(
                              controller: _phoneController,
                              icon: widget.phoneIcon ??
                                  const Icon(Icons.phone_outlined),
                              suffix: widget.lockIcon ??
                                  const Icon(Icons.lock_outline, size: 17),
                              readOnly: true,
                            ),
                            const SizedBox(height: 13),
                            _label('CITY'),
                            const SizedBox(height: 5),
                            DropdownButtonFormField<String>(
                              value: _city,
                              isExpanded: true,
                              decoration: _inputDecoration(
                                widget.cityIcon ??
                                    const Icon(Icons.location_on_outlined),
                              ),
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: ['Amritsar', 'Chandigarh', 'Delhi', 'Mumbai']
                                  .map(
                                    (city) => DropdownMenuItem(
                                      value: city,
                                      child: Text(
                                        city,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: _navy,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (city) =>
                                  setState(() => _city = city ?? _city),
                            ),
                            const SizedBox(height: 13),
                            _label('ADDRESS'),
                            const SizedBox(height: 5),
                            _textField(
                              controller: _addressController,
                              hint: 'Enter your home address',
                              icon: widget.addressIcon ??
                                  const Icon(Icons.home_outlined),
                              validator: (value) => value == null ||
                                      value.trim().isEmpty
                                  ? 'Please enter your address'
                                  : null,
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: _submit,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _blue,
                                  foregroundColor: Colors.white,
                                  elevation: 5,
                                  shadowColor: _blue.withValues(alpha: .35),
                                  shape: const StadiumBorder(),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Create Account',
                                      style: TextStyle(fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(width: 7),
                                    Icon(Icons.arrow_forward, size: 17),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 14),
                            Center(
                              child: Wrap(
                                children: [
                                  const Text(
                                    'Already have an account? ',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Color(0xFF506079),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: widget.onLogin,
                                    child: const Text(
                                      'Login',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: _blue,
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
                ),
              ],
            ),
          ),
        ),
      );

  Widget _profilePhoto() => Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 72,
            height: 72,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFDDE6F0)),
            ),
            // FIGMA PLACEHOLDER: profile/avatar illustration.
            child: widget.profilePlaceholder ??
                const Icon(Icons.person_outline, size: 37, color: _navy),
          ),
          Positioned(
            right: -1,
            bottom: -1,
            child: Container(
              width: 25,
              height: 25,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _blue,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              // FIGMA PLACEHOLDER: camera icon.
              child: widget.cameraIcon ??
                  const Icon(Icons.camera_alt_outlined, size: 13, color: Colors.white),
            ),
          ),
        ],
      );

  static Widget _label(String text) => Text(
        text,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: Color(0xFF4A5870),
        ),
      );

  Widget _textField({
    required TextEditingController controller,
    required Widget icon,
    String? hint,
    Widget? suffix,
    TextInputType? keyboardType,
    bool readOnly = false,
    String? Function(String?)? validator,
  }) =>
      TextFormField(
        controller: controller,
        readOnly: readOnly,
        keyboardType: keyboardType,
        validator: validator,
        style: const TextStyle(fontSize: 12, color: _navy),
        decoration: _inputDecoration(icon, hint: hint, suffix: suffix),
      );

  static InputDecoration _inputDecoration(Widget icon, {String? hint, Widget? suffix}) =>
      InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 12, color: Color(0xFF8291A8)),
        prefixIcon: IconTheme(
          data: const IconThemeData(size: 17, color: Color(0xFF506079)),
          child: icon,
        ),
        suffixIcon: suffix == null
            ? null
            : IconTheme(
                data: const IconThemeData(size: 17, color: Color(0xFF8291A8)),
                child: suffix,
              ),
        filled: true,
        fillColor: const Color(0xFFF7F9FC),
        contentPadding: const EdgeInsets.symmetric(vertical: 1),
        enabledBorder: _border(const Color(0xFFE2E8F0)),
        focusedBorder: _border(_blue, width: 1.5),
        errorBorder: _border(Colors.redAccent),
        focusedErrorBorder: _border(Colors.redAccent, width: 1.5),
      );

  static OutlineInputBorder _border(Color color, {double width = 1}) =>
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
          width: 30,
          height: 30,
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
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: .72),
          borderRadius: BorderRadius.circular(22),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.home_work_outlined, size: 15, color: _blue),
            SizedBox(width: 3),
            Text('Wala', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800)),
          ],
        ),
      );
}
