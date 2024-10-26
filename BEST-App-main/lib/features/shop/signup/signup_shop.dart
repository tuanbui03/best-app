import 'package:best/api/shop_api.dart';
import 'package:best/utils/global_variable/dataApp.dart';
import 'package:best/features/authentication/screens/signup/verify_email.dart';
import 'package:best/model/shop.dart';
import 'package:best/utils/helpers/helper_functions.dart';
import 'package:best/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_string.dart';
import '../../../utils/constants/colors.dart';

class SignupShopScreen extends StatefulWidget {
  const SignupShopScreen({super.key});

  @override
  State<SignupShopScreen> createState() => _SignupShopScreenState();
}

class _SignupShopScreenState extends State<SignupShopScreen> {
  final nameCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              Text(TTexts.signupShopTitle,
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Form
              Form(
                child: Column(
                  children: [
                    /// NameShop
                    TextFormField(
                      controller: nameCtrl,
                      expands: false,
                      decoration: const InputDecoration(
                          labelText: TTexts.nameShop,
                          prefixIcon: Icon(Iconsax.user_edit)),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),
      
                    // Address
                    TextFormField(
                      controller: addressCtrl,
                      expands: false,
                      decoration: const InputDecoration(
                          labelText: TTexts.address,
                          prefixIcon: Icon(Iconsax.user_edit)),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    /// Email
                    TextFormField(
                      controller: emailCtrl,
                      expands: false,
                      decoration: const InputDecoration(
                          labelText: TTexts.email, prefixIcon: Icon(Iconsax.direct)),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    /// Phone Number
                    TextFormField(
                      controller: phoneCtrl,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      expands: false,
                      decoration: const InputDecoration(
                          labelText: TTexts.phoneNo, prefixIcon: Icon(Iconsax.call)),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    /// Term&Conditions Checkbox
                    Row(
                      children: [
                        SizedBox(
                            width: 24,
                            height: 24,
                            child: Checkbox(value: true, onChanged: (value) {})),
                        const SizedBox(width: TSizes.spaceBtwItems),
                        Text.rich(
                          TextSpan(children: [
                            TextSpan(
                                text: '${TTexts.iAgreeTo} ',
                                style: Theme.of(context).textTheme.bodySmall),
                            TextSpan(
                                text: '${TTexts.privacyPolicy} ',
                                style: Theme.of(context).textTheme.bodyMedium!.apply(
                                  color:
                                  dark ? TColors.white : TColors.primary,
                                  decoration: TextDecoration.underline,
                                  decorationColor:
                                  dark ? TColors.white : TColors.primary,
                                )),
                            TextSpan(
                                text: '${TTexts.and} \n ',
                                style: Theme.of(context).textTheme.bodySmall),
                            TextSpan(
                                text: TTexts.termsOfUse,
                                style: Theme.of(context).textTheme.bodyMedium!.apply(
                                  color:
                                  dark ? TColors.white : TColors.primary,
                                  decoration: TextDecoration.underline,
                                  decorationColor:
                                  dark ? TColors.white : TColors.primary,
                                )),
                          ]),
                        ),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwSections),

                    /// Sign Up Button
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () async {
                              dynamic validatedEmail =
                              TValidator.validateEmail(emailCtrl.text);
                              dynamic validatedPhone =
                              TValidator.validatePhoneNumber(phoneCtrl.text);
                              if (validatedEmail == null &&
                                  validatedPhone == null) {
                                Shop shop = Shop(DataApp.user['id'], nameCtrl.text, '', addressCtrl.text, emailCtrl.text, phoneCtrl.text);
                                dynamic result = await ShopAPI.addShop(shop);
                                if (result == true) {
                                  Get.to(() => const VerifyEmailScreen());
                                }
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (builder) {
                                      return AlertDialog(
                                        content: Text(
                                            '${validatedEmail??''}${validatedPhone??''}'),
                                      );
                                    });
                              }
                            },
                            child: const Text(TTexts.createAccount))),
                  ],
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

            ],
          ),
        ),
      ),
    );
  }
}

