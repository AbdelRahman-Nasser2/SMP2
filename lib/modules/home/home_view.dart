import 'package:flutter/material.dart';
import 'package:smp/model/sport_field.dart';
import 'package:smp/modules/search_view.dart';
import 'package:smp/shared/components/sport_field_card.dart';
import 'package:smp/theme.dart';
import 'package:smp/utils/dummy_data.dart';

import '../../shared/components/category_card.dart';

class HomeScreen extends StatelessWidget {
  List<SportField> fieldList = recommendedSportField;

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          header(context),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                  child: Text(
                    "Let's Have Fun and \nBe Healty!",
                    style: greetingTextStyle,
                  ),
                ),
                const CategoryListView(),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Recommended Venue",
                        style: subTitleTextStyle,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return SearchView(
                                    selectedDropdownItem: "All",
                                  );
                                },
                              ),
                            );
                          },
                          child: const Text("Show All"))
                    ],
                  ),
                ),
                // RECOMMENDED FIELDS
                Column(
                    children: fieldList
                        .map((fieldEntity) => SportFieldCard(
                              field: fieldEntity,
                            ))
                        .toList()),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget header(context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: SafeArea(
        // SEARCH Icon
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  width: 55,
                  height: 55,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image:
                          AssetImage("assets/images/user_profile_example.png"),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome back,",
                      style: descTextStyle,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      sampleUser.name,
                      style: subTitleTextStyle,
                    ),
                  ],
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                  color: primaryColor500,
                  borderRadius: BorderRadius.circular(borderRadiusSize)),
              child: IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SearchView(
                      selectedDropdownItem: "",
                    );
                  }));
                },
                icon: const Icon(Icons.search, color: colorWhite),
              ),
            )
          ],
        ),
      ),
    );
  }
}
