import 'package:flutter/material.dart';
import 'package:quickcommerce_app/Model/quickSelectionCardModel.dart';
import 'package:quickcommerce_app/Model/quickSelectionTabModel.dart';
import 'package:quickcommerce_app/Viewmodel/quickSelectionCardsViewModel.dart';
import 'package:quickcommerce_app/Views/itemDetailView.dart';

final List<QuickSelectionTabModel> tabs = [
  QuickSelectionTabModel(title: "Fruits", image: "fruits.png"),
  QuickSelectionTabModel(title: "Groceries", image: "groceries.png"),
  QuickSelectionTabModel(title: "Dairy", image: "dairy.png"),
  QuickSelectionTabModel(title: "Chocolate", image: "chocolate.png"),
  QuickSelectionTabModel(title: "Groceries", image: "groceries.png"),
];

class QuickSelection extends StatefulWidget {
  final String title;
  final bool showTabBarView;
  final bool showTabBar;
  final List<QuickSelectionTabModel> tabs;
  final List<QuickSelectionCardModel> fruitsItemList;
  final List<QuickSelectionCardModel> groceryItemList;
  final List<QuickSelectionCardModel> dairyItemList;
  final List<QuickSelectionCardModel> chocolateItemList;

  const QuickSelection({
    super.key,
    required this.showTabBarView,
    required this.showTabBar,
    required this.tabs,
    required this.title,
    required this.fruitsItemList,
    required this.groceryItemList,
    required this.dairyItemList,
    required this.chocolateItemList,
  });

  @override
  State<QuickSelection> createState() => _QuickSelectionState();
}

class _QuickSelectionState extends State<QuickSelection>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late List<QuickSelectionCardModel> fruitsItems;
  late List<QuickSelectionCardModel> groceryItems;
  late List<QuickSelectionCardModel> dairyItems;
  late List<QuickSelectionCardModel> chocolateItems;

  @override
  void initState() {
    fruitsItems = widget.fruitsItemList;
    groceryItems = widget.groceryItemList;
    dairyItems = widget.dairyItemList;
    chocolateItems = widget.chocolateItemList;
    tabController = TabController(length: widget.tabs.length, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.title.isNotEmpty)
          // Tab Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        if (widget.showTabBar)
         const SizedBox(height: 10),

        if (widget.showTabBar)
          // Tabs // Tab 1, Tab 2 etc
          TabBar(
            indicator: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Color(0xFFCBE3FC),
                  Color(0xFFE8F4FF),
                  Color(0xFFFFFFFF),
                ],
              ),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: Colors.black,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelColor: const Color.fromARGB(255, 196, 189, 189),
            controller: tabController,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            tabs: widget.tabs.map((tab) {
              return SizedBox(
                width: 70,
                child: Tab(
                  text: tab.title,
                  icon: Image.asset(tab.image, width: 50),
                ),
              );
            }).toList(),
          ),

        if (widget.showTabBarView)
          // Quick selections
          Padding(
            padding: widget.showTabBar == false
                ? const EdgeInsets.symmetric(horizontal: 10.0)
                : const EdgeInsets.all(10.0),
            child: SizedBox(
              height: 500,
              child: TabBarView(
                controller: tabController,
                children: [
                  // MARK:- Fruits
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(4),
                      itemCount: 10,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 15.0,
                        crossAxisSpacing: 15.0,
                        mainAxisExtent: 150, // height
                      ),

                      itemBuilder: (context, i) {
                        return Container(
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                offset: Offset.zero,
                                blurRadius: 1.0,
                                spreadRadius: 1.0,
                              ),
                            ],
                          ),
                          child: TextButton(
                            onPressed: () {
                              showModalBottomSheet(
                                enableDrag: true,
                                isScrollControlled: true,
                                context: context,
                                builder: (_) => SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.9,
                                  child: ItemDetailView(),
                                ),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // SizedBox(height: 30),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Icon(
                                      Icons.dashboard_rounded,
                                      size: 35,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("🌟 ${fruitsItems[i].rating}"),
                                      Text(
                                        fruitsItems[i].title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        fruitsItems[i].quantity,
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        fruitsItems[i].discountPercentage,
                                        style: TextStyle(
                                          fontSize: 11.5,
                                          color: Colors.red,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            fruitsItems[i].discountPrice,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.5,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            fruitsItems[i].originalPrice,
                                            style: TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              color: Colors.grey,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: 10),

                                      Center(
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            backgroundColor: Colors.yellow,
                                            minimumSize: const Size(100, 35),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                            ),
                                          ),
                                          onPressed: () {},
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Add to cart",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              SizedBox(width: 5),
                                              Icon(
                                                Icons.add,
                                                color: Colors.black,
                                                size: 12,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // MARK:- Grocery
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(4),
                      itemCount: groceryItems.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 15.0,
                        crossAxisSpacing: 15.0,
                        mainAxisExtent: 150, // height
                      ),

                      itemBuilder: (context, i) {
                        return Container(
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                offset: Offset.zero,
                                blurRadius: 1.0,
                                spreadRadius: 1.0,
                              ),
                            ],
                          ),
                          child: TextButton(
                            onPressed: () {
                              print("object");
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // SizedBox(height: 30),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Icon(
                                      Icons.dashboard_rounded,
                                      size: 35,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("🌟 ${groceryItems[i].rating}"),
                                      Text(
                                        groceryItems[i].title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        groceryItems[i].quantity,
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        groceryItems[i].discountPercentage,
                                        style: TextStyle(
                                          fontSize: 11.5,
                                          color: Colors.red,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            groceryItems[i].discountPrice,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.5,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            groceryItems[i].originalPrice,
                                            style: TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              color: Colors.grey,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: 10),

                                      Center(
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            backgroundColor: Colors.yellow,
                                            minimumSize: const Size(100, 35),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                            ),
                                          ),
                                          onPressed: () {},
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Add to cart",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              SizedBox(width: 5),
                                              Icon(
                                                Icons.add,
                                                color: Colors.black,
                                                size: 12,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // MARK:- Dairy
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(4),
                      itemCount: dairyItems.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 15.0,
                        crossAxisSpacing: 15.0,
                        mainAxisExtent: 150, // height
                      ),

                      itemBuilder: (context, i) {
                        return Container(
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                offset: Offset.zero,
                                blurRadius: 1.0,
                                spreadRadius: 1.0,
                              ),
                            ],
                          ),
                          child: TextButton(
                            onPressed: () {
                              print("object");
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // SizedBox(height: 30),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Icon(
                                      Icons.dashboard_rounded,
                                      size: 35,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("🌟 ${dairyItems[i].rating}"),
                                      Text(
                                        dairyItems[i].title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        dairyItems[i].quantity,
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        dairyItems[i].discountPercentage,
                                        style: TextStyle(
                                          fontSize: 11.5,
                                          color: Colors.red,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            dairyItems[i].discountPrice,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.5,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            dairyItems[i].originalPrice,
                                            style: TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              color: Colors.grey,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: 10),

                                      Center(
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            backgroundColor: Colors.yellow,
                                            minimumSize: const Size(100, 35),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                            ),
                                          ),
                                          onPressed: () {},
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Add to cart",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              SizedBox(width: 5),
                                              Icon(
                                                Icons.add,
                                                color: Colors.black,
                                                size: 12,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // MARK:- Chocolate
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(4),
                      itemCount: chocolateItems.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 15.0,
                        crossAxisSpacing: 15.0,
                        mainAxisExtent: 150, // height
                      ),

                      itemBuilder: (context, i) {
                        return Container(
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                offset: Offset.zero,
                                blurRadius: 1.0,
                                spreadRadius: 1.0,
                              ),
                            ],
                          ),
                          child: TextButton(
                            onPressed: () {
                              print("object");
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // SizedBox(height: 30),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Icon(
                                      Icons.dashboard_rounded,
                                      size: 35,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("🌟 ${chocolateItems[i].rating}"),
                                      Text(
                                        chocolateItems[i].title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        chocolateItems[i].quantity,
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        chocolateItems[i].discountPercentage,
                                        style: TextStyle(
                                          fontSize: 11.5,
                                          color: Colors.red,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            chocolateItems[i].discountPrice,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.5,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            chocolateItems[i].originalPrice,
                                            style: TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              color: Colors.grey,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: 10),

                                      Center(
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            backgroundColor: Colors.yellow,
                                            minimumSize: const Size(100, 35),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                            ),
                                          ),
                                          onPressed: () {},
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Add to cart",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              SizedBox(width: 5),
                                              Icon(
                                                Icons.add,
                                                color: Colors.black,
                                                size: 12,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  //MARK:- Grocery
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(4),
                      itemCount: groceryItems.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 15.0,
                        crossAxisSpacing: 15.0,
                        mainAxisExtent: 150, // height
                      ),

                      itemBuilder: (context, i) {
                        return Container(
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                offset: Offset.zero,
                                blurRadius: 1.0,
                                spreadRadius: 1.0,
                              ),
                            ],
                          ),
                          child: TextButton(
                            onPressed: () {
                              print("object");
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // SizedBox(height: 30),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Icon(
                                      Icons.dashboard_rounded,
                                      size: 35,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("🌟 ${groceryItems[i].rating}"),
                                      Text(
                                        groceryItems[i].title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        groceryItems[i].quantity,
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        groceryItems[i].discountPercentage,
                                        style: TextStyle(
                                          fontSize: 11.5,
                                          color: Colors.red,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            groceryItems[i].discountPrice,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.5,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            groceryItems[i].originalPrice,
                                            style: TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              color: Colors.grey,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: 10),

                                      Center(
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            backgroundColor: Colors.yellow,
                                            minimumSize: const Size(100, 35),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                            ),
                                          ),
                                          onPressed: () {},
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Add to cart",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              SizedBox(width: 5),
                                              Icon(
                                                Icons.add,
                                                color: Colors.black,
                                                size: 12,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
