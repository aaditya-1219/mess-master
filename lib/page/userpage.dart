import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sub_mgmt/page/utils/admin_preferences.dart';
import 'package:sub_mgmt/widget/appbarwidget.dart';
import 'package:sub_mgmt/login/provider/auth_provider.dart';
import 'package:sub_mgmt/widget/navigation_drawer.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widget/profilewidget.dart';
import 'editprofile.dart';
import 'model/admin.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  static const menuItems = <String>[
    'English',
    'Hindi',
    'Marathi',
  ];
  final List<DropdownMenuItem<String>> _dropDownMenuItems = menuItems
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();
  final List<PopupMenuItem<String>> _popUpMenuItems = menuItems
      .map(
        (String value) => PopupMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();

  String _btn1SelectedVal = 'English';





  @override
  Widget build(BuildContext context) {
    final admin = AdminPreferences.getAdmin();
    return Scaffold(
        appBar: buildAppBar(context, "Profile".tr),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Column(
              children: [
                ProfileWidget(
                  imagePath: admin.imagePath,
                  onClicked: () async {
                    print(admin.imagePath);
                    await Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => EditProfile()));
                    setState(() {});
                  },
                ),

                const SizedBox(height: 24),
                buildName(admin),

                ListTile(
                  // contentPadding: EdgeInsets.all(20.0),
                  contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 0),

                  title: Text(
                    "Change_lan".tr,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  trailing: DropdownButton<String>(
                    // Must be one of items.value.
                    value: _btn1SelectedVal,
                    onChanged: (String? newValue) {
                      _language(newValue!);
                    },
                    items: this._dropDownMenuItems,
                  ),
                ),

                const SizedBox(height: 24),

                //
                // ElevatedButton(
                //   onPressed: () {
                //     // Help logic
                //     // For example: show a help dialog
                //     showDialog(
                //       context: context,
                //       builder: (_) => AlertDialog(
                //         title: Text("Help"),
                //         content: Text("Need help? Contact our support."),
                //         actions: [
                //           TextButton(
                //             onPressed: () => Navigator.of(context).pop(),
                //             child: Text("Close"),
                //           ),
                //         ],
                //       ),
                //     );
                //   },
                //   child: Text("Help"),
                // ),
                //
                // const SizedBox(height: 24),
                // ElevatedButton(
                //   onPressed: () {
                //
                //     showDialog(
                //       context: context,
                //       builder: (_) => AlertDialog(
                //         title: Text("Contact Us"),
                //         content: Text("You can reach us at support@example.com."),
                //         actions: [
                //           TextButton(
                //             onPressed: () => Navigator.of(context).pop(),
                //             child: Text("Close"),
                //           ),
                //         ],
                //       ),
                //     );
                //   },
                //   child: Text("Contact Us"),
                // ),
                // const SizedBox(height: 24),
                // ElevatedButton(
                //   onPressed: () async {
                //   },
                //   child: Text("Sign Out"),
                // ),

                ElevatedButton(
                  onPressed: () async {
                    // await userSignOut();
                    // Navigator.of(context).pop();
                  },
                  child: Text("Sign Out"),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text("How to use ?"),
                            content: Text(

                              "Step 1: Accessing the Expense Tracker,\n"
                               "1. Open the Mess Management app on your device.\n"
                               "2. After logging in, you'll be directed to the dashboard.\n"
                                "Step 2: Navigating to the Members Page\n"
                           "On the home page or dashboard, locate and tap on the\n"
                                  "Members section. This section might be labeled as Members or represented by an icon like Users.\n"
                            "Click/tap on the Members section to access the page where you can manage members.\n"

                               " Step 3: Searching for a Member\n"
                          "On the Members page, locate the search bar at the top of the page.\n"
                            "This search bar is designed to accommodate search queries in Hindi, Marathi, and English."
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text("Close"),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Text("Help"),
                    ),
                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text("How to use the App"),
                            content: Text("You can reach us at messmaster@gmail.com.com."),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text("Close"),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Text("Contact Us"),
                    ),

                  ],
                ),

              ],
            ),
          ],
        ));
  }

  void _language(String newValue) {
    setState(() => _btn1SelectedVal = newValue);
    if (newValue == 'Hindi') {
      var local = Locale('hi', 'IN');
      Get.updateLocale(local);
    } else if (newValue == 'English') {
      var local1 = Locale('en', 'US');
      Get.updateLocale(local1);
    } else {
      var local2 = Locale('mr', 'IN');
      Get.updateLocale(local2);
    }
  }

  Widget buildName(Admin admin) => Column(
        children: [
          Text(admin.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              )),
          const SizedBox(height: 4),
          Text(
            admin.email,
            style: TextStyle(
              color: Colors.grey,
            ),
          )
        ],
      );
}
