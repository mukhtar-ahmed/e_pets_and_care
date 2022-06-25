import 'package:e_pets_and_care/Admin/stock_model.dart';
import 'package:e_pets_and_care/view/widget/custome_product_details.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class ItemDetailsScreen extends StatelessWidget {
  static const String id = '/item_details_screen';
  const ItemDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StockModel? index1 = Get.arguments;
    return CustomeProductDetails(
      imageUrl: index1!.itemImageUrl.toString(),
      productName: index1.itemName.toString(),
      productPrice: index1.itemPrice!,
      productDescription: index1.itemDescription.toString(),
      petCategoy: index1.petCategory.toString(),
      id: index1.itemId.toString(),
    );
    
  }
}