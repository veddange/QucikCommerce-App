import 'package:flutter/material.dart';
// import 'package:quickcommerce_app/Helper/Utility.dart';
import 'package:quickcommerce_app/OnboardingScreen/onboarding_screen_model.dart';
import 'package:quickcommerce_app/Views/tabView.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  int _currentPage = 0;
  List colors = const [Color(0xffDAD3C8), Color(0xffFFE5DE), Color(0xffDCF6E6)];

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

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double width = SizeConfig.screenW!;
    // double height = SizeConfig.screenH!;

    return Scaffold(
      backgroundColor: colors[_currentPage],
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color((0xFFCBE3FC)),
                Color(0xFFE8F4FF),
                Color(0xFFFFFFFF),
              ],
            ),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: _controller,
                  onPageChanged: (value) =>
                      setState(() => _currentPage = value),
                  itemCount: onboardingScreensData.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: CircleAvatar(
                              radius: 150,
                              backgroundColor: Colors.grey[200],
                              child: ClipOval(
                                child: Image.asset(
                                  onboardingScreensData[i].image,
                                  width: 300,
                                  height: 300,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 40),
                          Text(
                            onboardingScreensData[i].title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "Mulish",
                              fontWeight: FontWeight.w600,
                              fontSize: (width <= 550) ? 30 : 35,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            onboardingScreensData[i].description,
                            style: TextStyle(
                              fontFamily: "Mulish",
                              fontWeight: FontWeight.w300,
                              fontSize: (width <= 550) ? 17 : 25,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          onboardingScreensData.length,
                          (int index) => _buildDots(index: index),
                        ),
                      ),
                      _currentPage + 1 == onboardingScreensData.length
                          ? Padding(
                              padding: const EdgeInsets.all(30),
                              child: ElevatedButton(
                                onPressed: () async {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => TabView(),
                                    ),
                                  );
                                  // await Utility.setValues(
                                  //   key: Keys.userOnboarded.value,
                                  //   value: true,
                                  // );
                                },
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(300, 50),
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 50,
                                    vertical: 20,
                                  ),
                                  textStyle: TextStyle(
                                    fontSize: (width <= 550) ? 17 : 20,
                                  ),
                                ),
                                child: const Text("START"),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => TabView(),
                                        ),
                                      );
                                      // await Utility.setValues(
                                      //   key: Keys.userOnboarded.value,
                                      //   value: true,
                                      // );
                                    },
                                    style: TextButton.styleFrom(
                                      fixedSize: (width <= 550)
                                          ? Size(130, 50)
                                          : Size(150, 50),
                                      elevation: 0,
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: (width <= 550) ? 13 : 17,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                        side: BorderSide(color: Colors.black),
                                      ),
                                    ),
                                    child: const Text(
                                      "SKIP",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      _controller.nextPage(
                                        duration: const Duration(
                                          milliseconds: 200,
                                        ),
                                        curve: Curves.easeIn,
                                      );
                                    },

                                    style: ElevatedButton.styleFrom(
                                      fixedSize: (width <= 550)
                                          ? Size(130, 50)
                                          : Size(150, 50),
                                      foregroundColor: Colors.white,
                                      backgroundColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      elevation: 0,
                                      padding: (width <= 550)
                                          ? const EdgeInsets.symmetric(
                                              horizontal: 30,
                                              vertical: 20,
                                            )
                                          : const EdgeInsets.symmetric(
                                              horizontal: 30,
                                              vertical: 25,
                                            ),
                                      textStyle: TextStyle(
                                        fontSize: (width <= 550) ? 13 : 17,
                                      ),
                                    ),
                                    child: const Text("NEXT"),
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
      ),
    );
  }
}
