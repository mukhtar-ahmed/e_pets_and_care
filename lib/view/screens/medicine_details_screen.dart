import 'package:e_pets_and_care/Admin/MedicineManagement/Model/medicine_model.dart';
import 'package:e_pets_and_care/view/widget/custome_product_details.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class MedicineDetailsScreen extends StatelessWidget {
  static const String id = '/medicine_details_screen';
  const MedicineDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MedicineModel? index1 = Get.arguments;
    return CustomeProductDetails(
      imageUrl: index1!.imageUrl.toString(),
      productName: index1.medicineName.toString(),
      productPrice: index1.medicinePrice!,
      productDescription: index1.medicineDescription.toString(),
      petCategoy: index1.petCategory.toString(),
      id: index1.medicineId.toString(),
    );
  }
}
