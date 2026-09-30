import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickcommerce_app/Viewmodel/searchViewmodel.dart';
import 'package:quickcommerce_app/Views/ItemDetailView.dart';

class SearchedItemView extends StatefulWidget {
  const SearchedItemView({super.key});

  @override
  State<SearchedItemView> createState() => _SearchedItemViewState();
}

class _SearchedItemViewState extends State<SearchedItemView> {
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
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
    final viewmodel = context.watch<SearchViewViewModel>();
    return Scaffold(
      appBar: viewmodel.fromDashboard
          ? AppBar(
              title: Text(viewmodel.navigationTitle),
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  viewmodel.fromDashboard = false;
                },
                icon: Icon(Icons.arrow_back),
              ),
            )
          : null,
      body: isLoading
          ? Column(
              children: [
                SizedBox(height: 200),
                Center(
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(strokeWidth: 4),
                  ),
                ),
              ],
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Searched Result",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: viewmodel.fromDashboard ? 800 : 850,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GridView.builder(
                        itemCount: 12,
                        padding: const EdgeInsets.all(5.0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 15.0,
                          crossAxisSpacing: 15.0,
                          mainAxisExtent: 230, // height
                        ),

                        itemBuilder: (context, i) {
                          return Container(
                            // width: 150,
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
                                        MediaQuery.of(context).size.height *
                                        0.9,
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
                                        Text("🌟 4.1"),
                                        Text(
                                          "Lady Fingure",
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          "1 kg",
                                          style: TextStyle(
                                            fontSize: 13.0,
                                            color: Colors.black38,
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        Text(
                                          "33% OFF",
                                          style: TextStyle(
                                            fontSize: 11.5,
                                            color: Colors.red,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "₹31.00",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15.5,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              "₹46.00",
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
                                              minimumSize: const Size(50, 35),
                                              padding:
                                                  const EdgeInsets.symmetric(
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
                  ),
                ],
              ),
              // ),
            ),
    );
  }
}
