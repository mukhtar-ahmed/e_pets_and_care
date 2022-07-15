import 'package:e_pets_and_care/Admin/PetSupplierManagement/Controller/supplier_controller.dart';
import 'package:e_pets_and_care/Admin/PetSupplierManagement/Views/Widget/supplier_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class Supplier extends StatelessWidget {
  static const String id = '/supplier';
  const Supplier({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupplierController>(
        init: SupplierController(),
        builder: (supplierController) {
          return SupplierPage(
            headingText: 'Pets Supplier',
            buttonText: 'Save',
            bgImgae: supplierController.image != null
                ? FileImage(supplierController.image!)
                : const NetworkImage("null") as ImageProvider,
            defaultControllerText:
                supplierController.supplierNameController.text,
            textController: supplierController.supplierNameController,
            defaultCompanyControllerText:
                supplierController.supplierCompanyController.text,
            textCompanyController: supplierController.supplierCompanyController,
            onPress: () {
              supplierController.sendData();
            },
          );
        });
  }
}
