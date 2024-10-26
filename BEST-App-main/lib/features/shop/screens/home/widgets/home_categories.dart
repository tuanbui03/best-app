import 'package:best/api/category_api.dart';
import 'package:best/utils/global_variable/dataApp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/image_text_widgets/vertical_image_dark.dart';
import '../../sub_category/sub_categories.dart';

class THomeCategories extends StatefulWidget {
  const THomeCategories({Key? key}) : super(key: key);

  @override
  State<THomeCategories> createState() => _THomeCategoriesState();
}

class _THomeCategoriesState extends State<THomeCategories> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: DataApp.listCategory.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    return Column(
                      children: [
                        TVerticalImageText(
                          image: '${DataApp.listCategory[index]['image']}',
                          title: '${DataApp.listCategory[index]['name']}',
                          onTap: () => Get.to(
                              () => SubCategoriesScreen(DataApp.listCategory[index])),
                        ),
                      ],
                    );
                  })
    );
  }
}
