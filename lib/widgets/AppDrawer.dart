import 'package:flutter/material.dart';

import '../utils/app_theme.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Container(
          decoration: AppTheme.backgroundGradient,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      child: Image.asset("assets/images/abstract.png"),
                    ),
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "KERALA TOURISM",
                                style: TextStyle(color: Colors.white),
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                    minimumSize:
                                    MaterialStateProperty.all(Size(60, 24)),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(24)))),
                                onPressed: () {},
                                child: Text(
                                  "LOGIN",
                                  style: TextStyle(fontSize: 10),
                                ),
                              )
                            ],
                          ),
                        )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
                  child: Divider(color: Colors.black45,),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
