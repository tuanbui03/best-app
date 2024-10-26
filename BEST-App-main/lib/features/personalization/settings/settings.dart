import 'package:best/api/warehouse_voucher_api.dart';
import 'package:best/common/widgets/appbar/appbar.dart';
import 'package:best/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:best/common/widgets/list_title/settings_menu_tile.dart';
import 'package:best/common/widgets/texts/section_heading.dart';
import 'package:best/utils/global_variable/dataApp.dart';
import 'package:best/features/personalization/screen/address/adddress.dart';
import 'package:best/features/personalization/settings/warehouse_voucher.dart';
import 'package:best/features/shop/screens/order/order.dart';
import 'package:best/features/shop/signup/signup_shop.dart';
import 'package:best/utils/constants/colors.dart';
import 'package:best/utils/constants/sizes.dart';
import 'package:best/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../common/widgets/list_title/user_profile_title.dart';
import '../../authentication/screens/login/login.dart';
import '../../shop/screens/cart/cart.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  List listObs = [];
  Future<List> _loadDataWarehouseVoucher() async {
    listObs = await WarehouseVoucherAPI.getWarehouseVoucherByUserID(DataApp.user['id']);
    return listObs;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          /// Header
          TPrimaryHeaderContainer(
              child: Column(
            children: [
              /// AppBar
              TAppBar(
                  title: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text('Profile',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .apply(color: TColors.white)),
                      ),
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                              onPressed: () {
                                Get.offAll(const LoginScreen());
                              }, child: const Text('Logout',style: TextStyle(color: Colors.white),)),
                        ),
                      ),
                    ],
                  )),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// User Profile Card

              const TUserProfileTitle(),
              const SizedBox(height: TSizes.spaceBtwSections),

            ],
          )),

          /// Body
          Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                /// Account & Settings
                const TSectionHeading(
                  title: 'Account Settings',
                  showActionButton: false,
                ),
                const SizedBox(height: TSizes.spaceBtwItems),

                // TSettingsMenuTile(
                //     icon: Iconsax.safe_home,
                //     title: 'My Addresses',
                //     subTitle: 'Set Shopping delivery address',
                //     onTap: () => Get.to(() => const UserAddressScreen())),
                TSettingsMenuTile(
                  icon: Iconsax.safe_home,
                  title: 'My Cart',
                  subTitle: 'cart',
                  onTap: () {
                    Get.to(() => CartScreen());
                  },
                ),
                TSettingsMenuTile(
                  icon: Iconsax.safe_home,
                  title: 'My Order',
                  subTitle: 'Anh yeu em 123',
                  onTap: () => Get.to(() => const OrderScreen()),
                ),
            FutureBuilder(
              future: _loadDataWarehouseVoucher(),
              builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
              snapshot.hasData
                  ?
                TSettingsMenuTile(
                  icon: Iconsax.safe_home,
                  title: 'My Warehouse Voucher',
                  subTitle: '${listObs.length}+ Voucher',
                  onTap: () => Get.to(() => WarehouseVoucherScreen(listObs)),
                ):Text('')),
                TSettingsMenuTile(
                  icon: Iconsax.safe_home,
                  title: 'Notifications',
                  subTitle: 'Anh yeu em 123',
                  onTap:  () => Get.to(() => const UserAddressScreen())
                  ),
                (DataApp.userShopID == 0)?
                TSettingsMenuTile(
                    icon: Iconsax.safe_home,
                    title: 'Create Shop',
                    subTitle: 'Free sign up',
                    onTap: () => Get.to(() => const SignupShopScreen())):const Text(''),
                /// App Settings
                const SizedBox(height: TSizes.spaceBtwSections),
                const TSectionHeading(title: 'App Settings', showActionButton: false),
                const SizedBox(height: TSizes.spaceBtwItems),
                const TSettingsMenuTile(
                    icon: Iconsax.document_upload,
                    title: 'Load data',
                    subTitle: 'Upload to Firebase'),
                TSettingsMenuTile(
                  icon: Iconsax.location,
                  title: 'Geolocation',
                  subTitle: 'Set recommendation based on location',
                  trailing: Switch(value: true, onChanged: (value) {}),
                ),
                TSettingsMenuTile(
                  icon: Iconsax.security_user,
                  title: '???',
                  subTitle: 'True true true',
                  trailing: Switch(value: false, onChanged: (value) {}),
                ),
                TSettingsMenuTile(
                  icon: Iconsax.location,
                  title: 'T_T',
                  subTitle: 'Go go go',
                  trailing: Switch(value: false, onChanged: (value) {
                  }),
                ),

              ],
            ),
          ),
        ],
      ),
    ));
  }
}
