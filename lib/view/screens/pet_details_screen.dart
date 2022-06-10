import 'package:e_pets_and_care/Admin/PetManagement/Model/pet_model.dart';
import 'package:e_pets_and_care/view/widget/custome_product_details.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class PetDetailsScreen extends StatelessWidget {
  static const String id = '/pet_details_screen';
  const PetDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PetModel? index1 = Get.arguments;
    return CustomeProductDetails(
      imageUrl: index1!.imageUrl.toString(),
      productName: index1.petName.toString(),
      productPrice: index1.petPrice!,
      productDescription: index1.petDescription.toString(),
      petCategoy: index1.petCategory.toString(),
      id: index1.petId.toString(),
    );
  }
}
