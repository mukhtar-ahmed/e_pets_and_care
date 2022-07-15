import 'package:e_pets_and_care/Admin/UserManagement/Controller/user_screen_controller.dart';
import 'package:e_pets_and_care/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textfieldtext;
    return GetBuilder<UserScreenController>(
        init: UserScreenController(),
        builder: (userScreenController) {
          return Scaffold(
            appBar: AppBar(
              title: Text('User Management'),
            ),
            body: SingleChildScrollView(
              child: StreamBuilder<List<UserModel>>(
                stream: userScreenController.readUserRoleUser(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Some Thing Wrong');
                  } else if (snapshot.hasData) {
                    return Column(
                      children: [
                        /* -------------------------------------------------------------------------- */
                        /*                                Search Field                                */
                        /* -------------------------------------------------------------------------- */
                        Container(
                          margin: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                          padding: const EdgeInsets.fromLTRB(15, 3, 0, 3),
                          decoration: const BoxDecoration(
                            color: Color(0xffEDF0F4),
                            // color: Colors.red,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: TextFormField(
                            controller: userScreenController.searchController,
                            decoration: InputDecoration(
                              // contentPadding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
                              hintText: 'Search',
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                  icon: const Icon(FontAwesomeIcons.xmark),
                                  onPressed: () {}),
                            ),
                            onChanged: (String query) {
                              textfieldtext = userScreenController
                                  .searchController.text
                                  .trim();
                              final suggestions =
                                  snapshot.data!.where((categoryfilter) {
                                final categoryTitle =
                                    categoryfilter.fullName!.toLowerCase();
                                final input = query.toLowerCase();
                                return categoryTitle.contains(input);
                              }).toList();
                              userScreenController.addFill(suggestions);
                              // setState(() {
                              //   addMedicineScreenController.fil =
                              //       suggestions;
                              // });
                            },
                          ),
                        ),

                        /* -------------------------------------------------------------------------- */
                        /*                              Search Field End                              */
                        /* -------------------------------------------------------------------------- */

                        GridView.builder(
                            itemCount: userScreenController
                                        .searchController.text
                                        .trim() !=
                                    ''
                                ? userScreenController.fil.length
                                : snapshot.data!.length,
                            physics: const ScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 0,
                                    crossAxisCount: 1,
                                    mainAxisExtent: 150),
                            itemBuilder: (BuildContext context, index) {
                              return buildUserContainer(
                                  index1: userScreenController
                                              .searchController.text
                                              .trim() !=
                                          ''
                                      ? userScreenController.fil[index]
                                      : snapshot.data![index]);
                            }),
                      ],
                    );
                  } else {
                    return const Center(child: CircleAvatar());
                  }
                },
              ),
            ),
          );
        });
  }

  Widget buildUserContainer({UserModel? index1}) {
    return GetBuilder<UserScreenController>(
        init: UserScreenController(),
        builder: (userScreenController) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
            child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(10.sp),
                decoration: BoxDecoration(border: Border.all()),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Name : ',
                          style: TextStyle(
                              fontSize: 20.sp, fontWeight: FontWeight.w900),
                        ),
                        Text(
                          index1!.fullName.toString(),
                          style: TextStyle(fontSize: 20.sp),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                      children: [
                        Text(
                          'Email : ',
                          style: TextStyle(
                              fontSize: 20.sp, fontWeight: FontWeight.w900),
                        ),
                        Flexible(
                          child: Text(
                            index1.email.toString(),
                            style: TextStyle(fontSize: 20.sp),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(20.sp),
                              ),
                              alignment: Alignment.center,
                              height: 30.h,
                              child: Text(
                                'Block',
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              userScreenController.deleteUser(index1);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(20.sp),
                              ),
                              alignment: Alignment.center,
                              height: 30.h,
                              child: Text(
                                'Delete',
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          );
        });
  }
}
