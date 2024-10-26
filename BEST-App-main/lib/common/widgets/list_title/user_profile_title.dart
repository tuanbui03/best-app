import 'package:best/features/personalization/settings/edit_profile.dart';
import 'package:best/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../utils/global_variable/dataApp.dart';
import '../../../utils/constants/colors.dart';

class TUserProfileTitle extends StatelessWidget {
  const TUserProfileTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 50,
        height: 50,
        padding: const EdgeInsets.all(TSizes.sm),
        decoration: BoxDecoration(
          color: TColors.white,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
            child: Image(
              image: AssetImage(DataApp.user['image']),
              height: 60.0,
              width: 60.0,
              fit: BoxFit.fill,
            )
          //color: dark ? TColors.dark : TColors.light),
        ),
      ),
      title: Text(DataApp.user['user_name'],
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: TColors.white)),
      subtitle: Text(DataApp.user['email'],
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .apply(color: TColors.white)),
      trailing: IconButton(
          onPressed: () => Get.to(() => EditProfileScreen(DataApp.user)),
          icon: const Icon(Iconsax.edit, color: TColors.white)),
    );
  }
}
