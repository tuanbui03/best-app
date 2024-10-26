import 'package:best/utils/global_variable/dataApp.dart';
import 'package:best/features/shop/screens/brand/brand.dart';
import 'package:best/features/shop/screens/store/page/store.dart';
import 'package:best/utils/constants/colors.dart';
import 'package:best/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'features/personalization/settings/settings.dart';
import 'features/shop/screens/home/home.dart';
import 'features/shop/screens/wishlist/wishlist.dart';


class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = THelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          backgroundColor: darkMode ? TColors.black : Colors.white,
          indicatorColor: darkMode
              ? TColors.white.withOpacity(0.1)
              : TColors.black.withOpacity(0.1),
          destinations: [
            const NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            const NavigationDestination(icon: Icon(Icons.grid_view), label: 'Brand'),
            const NavigationDestination(icon: Icon(Iconsax.heart), label: 'Wishlist'),
            if(DataApp.userShopID != 0)
              const NavigationDestination(icon: Icon(Iconsax.shop), label: 'Store'),
            const NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(() => (DataApp.userShopID != 0)? controller.screenShops[controller.selectedIndex.value]:
      controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screenShops = [
    HomeScreen(),
    BrandScreen(),
    const FavouriteScreen(),
    const StoreScreen(),
    SettingsScreen(),
  ];
  final screens = [
      HomeScreen(),
      BrandScreen(),
      const FavouriteScreen(),
    SettingsScreen(),
  ];
}
