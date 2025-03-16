import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import 'social_login_divider.dart';
import 'social_media_button.dart';

class LoginSocialSection extends StatelessWidget {
  const LoginSocialSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SocialLoginDivider(),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SocialMediaButton(
              onPressed: () {},
              icon: AppAssets.imagesGoogle,
              text: 'Google',
              backgroundColor: Colors.white,
              textColor: Colors.black87,
            ),
            const SizedBox(width: 16),
            SocialMediaButton(
              onPressed: () {},
              icon: AppAssets.imagesFacebook,
              text: 'Facebook',
              backgroundColor: Colors.white,
              textColor: Colors.white,
            ),
          ],
        ),
      ],
    );
  }
}
