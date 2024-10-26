import 'package:best/common/styles/spacing_styles.dart';
import 'package:best/features/authentication/screens/login/widgets/login_form.dart';
import 'package:best/features/authentication/screens/login/widgets/login_header.dart';
import 'package:best/utils/constants/text_string.dart';
import 'package:best/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/login_signup/form_divider.dart';
import '../../../../common/widgets/login_signup/social_buttons.dart';
import '../../../../utils/constants/sizes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              /// Logo, Title, SubTitle
              TLoginHeader(dark: dark),

              /// FORM
              const TLoginForm(),

              /// Divider
              TFormDivider(dividerText: TTexts.orSignInWith.capitalize!, dark: dark),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Footer
              const TSocialButton(),
            ],
          ),
        ),
      ),
    );
  }
}




