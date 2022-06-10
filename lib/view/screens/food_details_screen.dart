import 'package:e_pets_and_care/Admin/FoodManagement/Model/food_model.dart';
import 'package:e_pets_and_care/view/widget/custome_product_details.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class FoodDetailsScreen extends StatelessWidget {
  static const String id = '/food_details_screen';
  const FoodDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FoodModel? index1 = Get.arguments;
    
    return CustomeProductDetails(
      imageUrl: index1!.imageUrl.toString(),
      productName: index1.foodName.toString(),
      productPrice: index1.foodPrice!,
      productDescription: index1.foodDescription.toString(),
      petCategoy: index1.petCategory.toString(),
      id: index1.foodId.toString(),
    );
  }
}
