import 'package:e_pets_and_care/view/widget/custome_text_field_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDisplayCard extends StatelessWidget {
  const ProductDisplayCard({
    Key? key,
    required this.image,
    required this.productName,
    required this.rating,
    required this.reviews,
    required this.price,
  }) : super(key: key);
  final ImageProvider image;
  final String productName;
  final double rating;
  final int reviews;
  final double price;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 360.h,
      width: 166.w,
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
          ),
          Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              SizedBox(
                height: 180.h,
                child: Image(
                  image: image,
                ),
              ),
              Container(
                // ignore: prefer_const_constructors
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                height: 80.h,
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /* ----------------------------- Name Of Product ---------------------------- */
                    CustomeTextFieldLabel(
                      labelText: productName,
                      textAlign: TextAlign.start,
                      fontSized: 14.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    /* ------------------------- Review and total order ------------------------- */
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 14.sp,
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text(
                          rating.toString(),
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(reviews.toString()),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text(
                          'Reviews',
                          style: TextStyle(fontSize: 12.sp),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    /* ----------------------------- Price and Cart ----------------------------- */
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'RS: 50',
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.w900),
                        ),
                        Container(
                          width: 50.w,
                          height: 28.h,
                          child: const Icon(Icons.shopping_cart),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
