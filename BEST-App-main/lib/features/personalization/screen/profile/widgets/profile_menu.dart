import 'package:best/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TProfileMenu extends StatelessWidget {
  const TProfileMenu({
    super.key,
    required this.onPressed,
    required this.title,
    required this.value,
    this.icon = Iconsax.arrow_right_34,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String title, value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: TSizes.spaceBtwItems / 1.5),
        child: Row(
          children: [
            Expanded(
                flex: 3,
                child: Text('Name',
                    style: Theme.of(context).textTheme.bodySmall,
                    overflow: TextOverflow.ellipsis)),
            Expanded(
                flex: 5,
                child: Text('Vua cua Ha Noi',
                    style: Theme.of(context).textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis)),
            const Expanded(child: Icon(Iconsax.arrow_right_34, size: 16)),
          ],
        ),
      ),
    );
  }
}
