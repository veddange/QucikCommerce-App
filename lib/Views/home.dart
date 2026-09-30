import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickcommerce_app/OnboardingScreen/onboarding_screen_model.dart';
import 'package:quickcommerce_app/Viewmodel/quickSelectionCardsViewModel.dart';
import 'package:quickcommerce_app/Viewmodel/searchViewmodel.dart';
import 'package:quickcommerce_app/Views/login_signup.dart';
import 'package:quickcommerce_app/Views/quickSelectionTabView.dart';
import 'package:quickcommerce_app/Views/searchView.dart';
import 'package:quickcommerce_app/Views/searchedItemView.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController controller = PageController();
  TextEditingController txtSearch = TextEditingController();

  final viewmodel = QuickSelectionCardsViewModel();

  Timer? timer;

  int _currentPage = 0;

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (controller.hasClients) {
        int nextPage = _currentPage + 1;

        if (nextPage >= onboardingScreensData.length) {
          nextPage = 0;
        }

        controller.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _loadData() async {
    setState(() {
      isLoading = true;
    });

    try {
      await Future.delayed(Duration(seconds: 2));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final searchVM = context.watch<SearchViewViewModel>();

    AnimatedContainer _buildDots({int? index}) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          color: Color(0xFF000000),
        ),
        margin: const EdgeInsets.only(right: 5),
        height: 10,
        curve: Curves.easeIn,
        width: _currentPage == index ? 20 : 10,
      );
    }

    return Scaffold(
      body: isLoading
          ? Center(
              child: SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(strokeWidth: 4),
              ),
            )
          : Container(
              alignment: Alignment.center,
              child: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Stack(
                            alignment: AlignmentGeometry.center,
                            children: [
                              Image.asset("brand_logo.png", height: 50),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey[300],
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        print(searchVM.isLoggedIn);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => searchVM.isLoggedIn
                                                ? Placeholder()
                                                : LoginSignupView(),
                                          ),
                                        );
                                      },
                                      icon: Icon(Icons.person),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: 5),

                          // MARK:- Address
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.location_on, size: 30),
                              const SizedBox(width: 5),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      // A very long username or title that should be truncated truncated
                                      searchVM.isLoggedIn
                                          ? "Hi, Name"
                                          : "Hi, Guest",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        searchVM.isSearchItem = false;
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => const SearchView(),
                                          ),
                                        );
                                      },
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        alignment: Alignment.centerLeft,
                                      ),
                                      child: const Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              // A very long username or title that should be truncated truncated
                                              "Rashmi Nagar, Near Hotel Ansh, Kavitha Road, Kandli, Paratwada",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Icon(Icons.chevron_right_sharp),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          // MARK:- Search & Expected delivery time
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 5.0,
                                ),
                                child: Container(
                                  // height: 30,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.blue,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      "10\nmins",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  readOnly: true,
                                  controller: txtSearch,
                                  onTap: () {
                                    searchVM.isSearchItem = true;
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const SearchView(),
                                      ),
                                    );
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Search items",
                                    prefixIcon: const Icon(Icons.search),

                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),

                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),

                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                        color: Colors.blue,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 5),
                        ],
                      ),
                    ),

                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // MARK:- Quick Select
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 90,
                                child: GridView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: 5,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1,
                                        mainAxisSpacing: 15.0,
                                        mainAxisExtent: 90,
                                      ),
                                  itemBuilder: ((context, index) {
                                    return Container(
                                      // width: 90,
                                      child: TextButton(
                                        onPressed: () {
                                          searchVM.fromDashboard = true;
                                          searchVM.navigationTitle =
                                              tabs[index].title;
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  SearchedItemView(),
                                            ),
                                          );
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              tabs[index].image,
                                              width: 50,
                                              height: 50,
                                            ),
                                            SizedBox(height: 10),
                                            Text(tabs[index].title),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ),

                            // MARK:- Slidder
                            Column(
                              children: [
                                SizedBox(
                                  height: 200,
                                  child: PageView.builder(
                                    itemCount: onboardingScreensData.length,
                                    physics: const BouncingScrollPhysics(),
                                    controller: controller,
                                    onPageChanged: (value) {
                                      setState(() {
                                        _currentPage = value;
                                      });
                                    },

                                    itemBuilder: (context, i) {
                                      return Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),

                                          child: GestureDetector(
                                            onTap: () {
                                              print(
                                                onboardingScreensData[i].image,
                                              );
                                            },
                                            child: Image.asset(
                                              onboardingScreensData[i].image,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    onboardingScreensData.length,
                                    (index) => _buildDots(index: index),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10),

                            // MARK:- Recommended for you
                            QuickSelection(
                              showTabBarView: true,
                              showTabBar: true,
                              tabs: tabs,
                              title: "Recommended for you",
                              fruitsItemList:
                                  viewmodel.fruitsQuickSelectionCardModels,
                              groceryItemList:
                                  viewmodel.groceryQuickSelectionCardModels,
                              dairyItemList:
                                  viewmodel.dairyQuickSelectionCardModels,
                              chocolateItemList:
                                  viewmodel.chocolateQuickSelectionCardModels,
                            ),

                            const SizedBox(height: 5),

                            // MARK:- Ads Banner
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                // width: 15,
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.transparent,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: GestureDetector(
                                    onTap: () {
                                      print(onboardingScreensData[0].image);
                                    },
                                    child: Image.asset(
                                      height: 150,
                                      onboardingScreensData[0].image,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 10),

                            // MARK:- Groceries & Fruits
                            QuickSelection(
                              showTabBarView: true,
                              showTabBar: false,
                              tabs: tabs,
                              title: "Groceries & Fruits",
                              fruitsItemList:
                                  viewmodel.fruitsQuickSelectionCardModels,
                              groceryItemList:
                                  viewmodel.groceryQuickSelectionCardModels,
                              dairyItemList:
                                  viewmodel.dairyQuickSelectionCardModels,
                              chocolateItemList:
                                  viewmodel.chocolateQuickSelectionCardModels,
                            ),

                            const SizedBox(height: 10),

                            // MARK:- Ads Banner
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.transparent,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: GestureDetector(
                                    onTap: () {
                                      print(onboardingScreensData[0].image);
                                    },
                                    child: Image.asset(
                                      height: 150,
                                      onboardingScreensData[0].image,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 10),

                            // MARK:- Groceries & Fruits
                            QuickSelection(
                              showTabBarView: true,
                              showTabBar: false,
                              tabs: tabs,
                              title: "Festival Special",
                              fruitsItemList:
                                  viewmodel.fruitsQuickSelectionCardModels,
                              groceryItemList:
                                  viewmodel.groceryQuickSelectionCardModels,
                              dairyItemList:
                                  viewmodel.dairyQuickSelectionCardModels,
                              chocolateItemList:
                                  viewmodel.chocolateQuickSelectionCardModels,
                            ),

                            const SizedBox(height: 5),

                            // MARK:- Ads Banner
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.transparent,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: GestureDetector(
                                    onTap: () {
                                      print(onboardingScreensData[0].image);
                                    },
                                    child: Image.asset(
                                      height: 150,
                                      onboardingScreensData[0].image,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            //MARK:- With love from Buykart
                            Container(
                              width: MediaQuery.of(context).size.width,
                              color: Colors.grey[200],
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 25),
                                    Text(
                                      "With Love ❤️",
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    Text(
                                      "from Buykart",
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    SizedBox(height: 25),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // MARK:- Bottom text
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38,
                            spreadRadius: 0.5,
                            blurRadius: 2.5,
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(12),

                      child: Row(
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey[200],
                                ),
                                child: Icon(Icons.electric_bike),
                              ),

                              Positioned(
                                right: 0,
                                bottom: 0,
                                left: 0,
                                child: Container(
                                  width: 15,
                                  height: 15,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 95, 115, 243),
                                    shape: BoxShape.circle,
                                    border: BoxBorder.all(width: 2.0),
                                  ),
                                  child: const Icon(
                                    Icons.lock,
                                    size: 10,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Add items worth ₹99",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),

                              Text(
                                "to get free delivery",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
