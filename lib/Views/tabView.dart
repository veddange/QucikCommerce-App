import 'package:flutter/material.dart';
import 'package:quickcommerce_app/Views/home.dart';

class TabView extends StatefulWidget {
  const TabView({super.key});

  @override
  State<TabView> createState() => _TabViewState();
}

class _TabViewState extends State<TabView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: TabBarView(children: [Home()]),
        bottomNavigationBar: Container(
          color: Color.fromARGB(255, 232, 225, 240),
          child: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.home),
                child: Text(
                  'Home',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.visible,
                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700),
                ),
              ),

              Tab(
                icon: Icon(Icons.home),
                child: Text(
                  'Home',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.visible,
                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
