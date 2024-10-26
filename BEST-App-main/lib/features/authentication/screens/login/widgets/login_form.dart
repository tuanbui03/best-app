import 'package:best/api/brand_api.dart';
import 'package:best/api/category_api.dart';
import 'package:best/utils/global_variable/dataApp.dart';
import 'package:best/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:best/features/shop/screens/admin/admin_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../api/user_api.dart';
import '../../../../../navigation_menu.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_string.dart';
import '../../signup/signup.dart';

class TLoginForm extends StatefulWidget {
  const TLoginForm({Key? key}) : super(key: key);

  @override
  State<TLoginForm> createState() => _TLoginFormState();
}

class _TLoginFormState extends State<TLoginForm> {
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  bool isEye = true;
  bool isRemember = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
        child: Column(
          children: [
            /// Email
            TextFormField(
              controller: emailCtrl,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.direct_right),
                  labelText: TTexts.email),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),

            /// Password
            TextFormField(
              controller: passwordCtrl,
              obscureText: isEye ? true : false,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Iconsax.password_check),
                  labelText: TTexts.password,
                  suffixIcon: IconButton(
                    onPressed: () {
                      isEye = !isEye;
                      setState(() {});
                    },
                    icon: Icon(isEye ? Iconsax.eye_slash : Iconsax.eye),
                  )),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields / 2),

            /// Remember ME & forget password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Remember me
                Row(
                  children: [
                    Checkbox(value: isRemember, onChanged: (value) {isRemember = !isRemember;
                    setState(() {
                    });}),
                    const Text(TTexts.rememberMe),
                  ],
                ),

                /// Forget password
                TextButton(
                    onPressed: () => Get.to(() => const ForgetPassword()),
                    child: const Text(TTexts.forgetPassword)),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            /// Sign in button
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () async {
                      try {
                        dynamic user = await UserAPI.loginUser(
                            emailCtrl.text, passwordCtrl.text);
                        DataApp.user = user;
                        DataApp.checkLiveShop();
                        if (user['role'] == 1) {
                          DataApp.listBrand = await BrandAPI.getBrands();
                          DataApp.listCategory = await CategoryAPI.getAllCategory();
                          await DataApp.setCart();
                          Get.offAll(() => const NavigationMenu());
                        } else if (user['role'] == 0) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AdminHome()));
                        }
                      } on Exception catch (_) {
                        showDialog(
                            context: context,
                            builder: (builder) {
                              return const AlertDialog(
                                content: Text(
                                    'The username or password is incorrect. \nTry again'),
                              );
                            });
                      }
                    },
                    child: const Text(TTexts.signIn))),
            const SizedBox(height: TSizes.spaceBtwItems),

            /// Create account button
            SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                    onPressed: () => Get.to(() => const SignupScreen()),
                    child: const Text(TTexts.createAccount))),
          ],
        ),
      ),
    );
  }
}
