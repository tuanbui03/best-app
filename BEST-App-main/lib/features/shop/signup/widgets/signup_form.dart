import 'package:best/api/user_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../model/user.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_string.dart';
import '../../../../../utils/validators/validator.dart';
import '../verify_email.dart';

class TSignupForm extends StatefulWidget {
  const TSignupForm({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  State<TSignupForm> createState() => _TSignupFormState();
}

class _TSignupFormState extends State<TSignupForm> {
  final fnameCtrl = TextEditingController();
  final lnameCtrl = TextEditingController();
  final unameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  bool isEye = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: fnameCtrl,
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: TTexts.firstName,
                      prefixIcon: Icon(Iconsax.user)),
                ),
              ),
              const SizedBox(width: TSizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  controller: lnameCtrl,
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: TTexts.lastName,
                      prefixIcon: Icon(Iconsax.user)),
                ),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          /// UserName
          TextFormField(
            controller: unameCtrl,
            expands: false,
            decoration: const InputDecoration(
                labelText: TTexts.username,
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

          /// Password
          TextFormField(
            controller: passCtrl,
            obscureText: isEye ? true : false, // an thanh ky tu
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
          const SizedBox(height: TSizes.spaceBtwSections),

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
                                widget.dark ? TColors.white : TColors.primary,
                            decoration: TextDecoration.underline,
                            decorationColor:
                                widget.dark ? TColors.white : TColors.primary,
                          )),
                  TextSpan(
                      text: '${TTexts.and} \n ',
                      style: Theme.of(context).textTheme.bodySmall),
                  TextSpan(
                      text: TTexts.termsOfUse,
                      style: Theme.of(context).textTheme.bodyMedium!.apply(
                            color:
                                widget.dark ? TColors.white : TColors.primary,
                            decoration: TextDecoration.underline,
                            decorationColor:
                                widget.dark ? TColors.white : TColors.primary,
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
                    dynamic validatedPass =
                        TValidator.validatePassword(passCtrl.text);
                    dynamic validatedPhone =
                        TValidator.validatePhoneNumber(phoneCtrl.text);
                    Users user = Users(
                        0,
                        fnameCtrl.text,
                        lnameCtrl.text,
                        unameCtrl.text,
                        passCtrl.text,
                        0,
                        emailCtrl.text,
                        'images',
                        phoneCtrl.text,
                        'address',
                        '2024-01-01T17:00:00.000+00:00',
                        1,
                        1);
                    if (validatedEmail == null &&
                        validatedPass == null &&
                        validatedPhone == null) {
                      dynamic result = await UserAPI.addUser(user);
                      if (result == true) {
                        Get.to(() => const VerifyEmailScreen());
                      }
                    } else {
                      showDialog(
                          context: context,
                          builder: (builder) {
                            return AlertDialog(
                              content: Text(
                                  '$validatedEmail \n $validatedPass\n$validatedPhone'),
                            );
                          });
                    }
                  },
                  child: const Text(TTexts.createAccount))),
        ],
      ),
    );
  }
}
