import 'package:e_pets_and_care/Admin/CategoryManagement/Controller/category_screen_controller.dart';
import 'package:e_pets_and_care/Admin/CategoryManagement/Views/Widget/category_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Category extends StatelessWidget {
  static const String id = '/category';
  const Category({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryScreenController>(
        init: CategoryScreenController(),
        builder: (categoryScreenController) {
          return CategoryPage(
            headingText: 'Category',
            buttonText: 'Save',
            bgImgae: categoryScreenController.image != null
                ? FileImage(categoryScreenController.image!)
                : const NetworkImage("null") as ImageProvider,
            isActiveText:
                categoryScreenController.isActive ? 'Active' : 'Inactive',
            defaultControllerText: '',
            textController: categoryScreenController.titleController,
            onPress: () {
              
              categoryScreenController.sendData();
            },
          );
        });
  }
}
