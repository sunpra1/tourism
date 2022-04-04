import 'package:flutter/material.dart';

import '../utils/app_theme.dart';

class ViewDestinationScreen extends StatefulWidget {
  static const String routeName = "/viewDestination";

  const ViewDestinationScreen({Key? key}) : super(key: key);

  @override
  State<ViewDestinationScreen> createState() => _ViewDestinationScreenState();
}

class _ViewDestinationScreenState extends State<ViewDestinationScreen> {
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: _pinned,
              snap: _snap,
              floating: _floating,
              expandedHeight: 250.0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  'Title that is very long'.toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: Colors.white),
                ),
                centerTitle: false,
                background: Image.asset("assets/images/carousel1.jpg"),
              ),
            ),
            SliverToBoxAdapter(
              child: DefaultTabController(
                length: 6,
                child: Column(
                  children: [
                    PreferredSize(
                      preferredSize: Size.fromHeight(48),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TabBar(
                          isScrollable: true,
                          indicator: BoxDecoration(
                              gradient: AppTheme.gradientLR,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24))),
                          unselectedLabelColor:
                              Theme.of(context).colorScheme.primary,
                          tabs: [
                            Tab(
                              text: "ABOUT",
                              height: 36,
                            ),
                            Tab(
                              text: "NEARBY",
                              height: 36,
                            ),
                            Tab(
                              text: "FESTIVALS",
                              height: 36,
                            ),
                            Tab(
                              text: "STAY",
                              height: 36,
                            ),
                            Tab(
                              text: "PHOTOS",
                              height: 36,
                            ),
                            Tab(
                              text: "VIDEOS",
                              height: 36,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 142.5,
                      child: TabBarView(
                        children: [
                          Container(
                            height: double.infinity,
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(100.0),
                              child: Text(
                                "ABOUT",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Container(
                            height: double.infinity,
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(100.0),
                              child: Text(
                                "NEARBY",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Container(
                            height: double.infinity,
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(100.0),
                              child: Text(
                                "FESTIVALS",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Container(
                            height: double.infinity,
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(100.0),
                              child: Text(
                                "STAY",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Container(
                            height: double.infinity,
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(100.0),
                              child: Text(
                                "PHOTOS",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Container(
                            height: double.infinity,
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(100.0),
                              child: Text(
                                "VIDEOS",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
