import 'package:flutter/material.dart';

/// Profile screen based on the supplied Figma design.
///
/// Use [avatar], [editIcon], and [navigationIcons] to inject Figma-exported
/// images/widgets. The defaults keep the screen functional without assets.
class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({
    super.key,
    this.name = 'Rahul Verma',
    this.phoneNumber = '+91 98765 43210',
    this.email = 'rahul.verma@email.com',
    this.role = 'Customer',
    this.avatar,
    this.editIcon,
    this.navigationIcons = const {},
    this.onEdit,
    this.onItemSelected,
    this.currentTab = ProfileTab.profile,
    this.onTabChanged,
  });

  final String name;
  final String phoneNumber;
  final String email;
  final String role;

  // FIGMA ASSET PLACEHOLDERS.
  final Widget? avatar;
  final Widget? editIcon;
  final Map<ProfileMenuItem, Widget> navigationIcons;

  final VoidCallback? onEdit;
  final ValueChanged<ProfileMenuItem>? onItemSelected;
  final ProfileTab currentTab;
  final ValueChanged<ProfileTab>? onTabChanged;

  @override
  Widget build(BuildContext context) {
    const navy = Color(0xFF111A2E);
    final mainItems = [
      ProfileMenuItem.bookings,
      ProfileMenuItem.messages,
      ProfileMenuItem.notifications,
      ProfileMenuItem.reviews,

      ProfileMenuItem.settings,
    ];
    final secondaryItems = [
      ProfileMenuItem.terms,
      ProfileMenuItem.privacy,
      ProfileMenuItem.about,
      ProfileMenuItem.logout,
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _bottomNavigation(context),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 22, 15, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'My Profile',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: navy,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: onEdit,
                    // FIGMA PLACEHOLDER: edit pen icon.
                    icon: editIcon ??
                        const Icon(Icons.edit_outlined, size: 14, color: Color(0xFF0B4DFF)),
                    label: const Text(
                      'Edit',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF0B4DFF),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFFF2F5FF),
                      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: const StadiumBorder(),
                    ),
                  ),
                ],
              ),
            ),
            _profileHeader(),
            const SizedBox(height: 13),
            const Divider(height: 1, color: Color(0xFFE1E7F0)),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(15, 8, 15, 18),
                children: [
                  for (final item in mainItems) _menuRow(context, item),
                  const SizedBox(height: 10),
                  const Divider(height: 1, color: Color(0xFFE1E7F0)),
                  const SizedBox(height: 10),
                  for (final item in secondaryItems) _menuRow(context, item),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileHeader() => Column(
        children: [
          Container(
            width: 70,
            height: 70,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF0B4DFF), width: 2),
            ),
            // FIGMA PLACEHOLDER: profile image. Example: Image.asset(..., fit: BoxFit.cover)
            child: avatar ??
                const Icon(Icons.person, size: 45, color: Color(0xFF93A1B5)),
          ),
          const SizedBox(height: 7),
          Text(
            name,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: Color(0xFF111A2E),
            ),
          ),
          const SizedBox(height: 1),
          Text(
            phoneNumber,
            style: const TextStyle(fontSize: 10, color: Color(0xFF8291A8)),
          ),
          const SizedBox(height: 1),
          Text(
            email,
            style: const TextStyle(fontSize: 10, color: Color(0xFF8291A8)),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
            decoration: const BoxDecoration(
              color: Color(0xFF0B4DFF),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Text(
              role.toUpperCase(),
              style: const TextStyle(
                fontSize: 9,
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      );

  Widget _menuRow(BuildContext context, ProfileMenuItem item) {
    final isLogout = item == ProfileMenuItem.logout;
    final color = isLogout ? const Color(0xFFE94A4A) : const Color(0xFF111A2E);
    return InkWell(
      onTap: () => onItemSelected?.call(item),
      child: Container(
        height: 49,
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFFE8EDF4))),
        ),
        child: Row(
          children: [
            Container(
              width: 27,
              height: 27,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Color(0xFFF5F7FB),
                shape: BoxShape.circle,
              ),
              // FIGMA PLACEHOLDER: each menu item's icon.
              child: navigationIcons[item] ??
                  Icon(item.icon, size: 15, color: isLogout ? color : const Color(0xFF506079)),
            ),
            const SizedBox(width: 12),
            Text(
              item.label,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: color),
            ),
            const Spacer(),
            Icon(
              isLogout ? Icons.logout_rounded : Icons.chevron_right_rounded,
              size: 17,
              color: isLogout ? color : const Color(0xFF8291A8),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomNavigation(BuildContext context) => SafeArea(
        top: false,
        child: Container(
          height: 58,
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Color(0xFFE1E7F0))),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ProfileTab.values.map((tab) {
              final selected = tab == currentTab;
              final color = selected ? const Color(0xFF0B4DFF) : const Color(0xFF8291A8);
              return InkWell(
                onTap: () => onTabChanged?.call(tab),
                child: SizedBox(
                  width: 53,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(tab.icon, size: 19, color: color),
                      const SizedBox(height: 2),
                      Text(
                        tab.label,
                        style: TextStyle(
                          fontSize: 8,
                          color: color,
                          fontWeight: selected ? FontWeight.w800 : FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      );
}

enum ProfileMenuItem {
  bookings('My Bookings', Icons.description_outlined),
  messages('Messages', Icons.chat_bubble_outline),
  notifications('Notifications', Icons.notifications_none_outlined),
  reviews('My Reviews', Icons.star_border_rounded),
  
  settings('Settings', Icons.settings_outlined),
  terms('Terms of Service', Icons.article_outlined),
  privacy('Privacy Policy', Icons.privacy_tip_outlined),
  about('About ServiceWala', Icons.info_outline_rounded),
  logout('Logout', Icons.logout_rounded);

  const ProfileMenuItem(this.label, this.icon);
  final String label;
  final IconData icon;
}

enum ProfileTab {
  home('Home', Icons.home_outlined),
  bookings('Bookings', Icons.calendar_today_outlined),
  chat('Chat', Icons.chat_bubble_outline),
  profile('Profile', Icons.person_outline);

  const ProfileTab(this.label, this.icon);
  final String label;
  final IconData icon;
}
