import 'package:e_pets_and_care/Admin/PetCategoryManagement/Controller/pet_category_screen_controller.dart';
import 'package:e_pets_and_care/Admin/PetCategoryManagement/Views/Widget/pet_category_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PetCategory extends StatelessWidget {
  static const String id = '/pet_category';
  const PetCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PetCategoryScreenController>(
        init: PetCategoryScreenController(),
        builder: (petScreenController) {
          return PetCategoryPage(
            headingText: 'Add Pet',
            buttonText: 'Save',
            bgImgae: petScreenController.image != null
                ? FileImage(petScreenController.image!)
                : const NetworkImage("null") as ImageProvider,
            isActiveText: petScreenController.isActive ? 'Active' : 'Inactive',
            defaultControllerText: '',
            textController: petScreenController.titleController,
            onPress: () {
              petScreenController.sendData();
            },
          );
        });
  }
}
