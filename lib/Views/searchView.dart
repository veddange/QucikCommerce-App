import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickcommerce_app/Viewmodel/quickSelectionCardsViewModel.dart';
import 'package:quickcommerce_app/Viewmodel/searchViewmodel.dart';
import 'package:quickcommerce_app/Views/itemDetailView.dart';
import 'package:quickcommerce_app/Views/searchedItemView.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController searchTxt = TextEditingController();
  bool isSearched = false;
  final cardItemViewModel = QuickSelectionCardsViewModel();
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

    final firstFourTrending = viewmodel.groceriesAndFruits.take(4).toList();

    final firstFourSuggestions = viewmodel.suggestions.take(4).toList();

    final sixCardSuggestions = cardItemViewModel.fruitsQuickSelectionCardModels
        .take(9)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Search ${viewmodel.isSearchItem ? "items" : "address"}"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // MARK:- Search Textfield
              TextField(
                decoration: InputDecoration(
                  hintText:
                      "Search ${viewmodel.isSearchItem ? "items" : "address"}",
                  prefixIcon: const Icon(Icons.search),

                  suffixIcon: searchTxt.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              searchTxt.clear();
                              isSearched = false;
                              _loadData();
                              print(isSearched);
                            });
                          },
                          icon: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                            ),
                            child: Text(
                              "Clear",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        )
                      : null,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    viewmodel.searchItem(value);
                  });
                },
                controller: searchTxt,
              ),

              if (!viewmodel.isSearchItem)
                isLoading
                    ? Column(
                        children: [
                          SizedBox(height: 200),
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator(strokeWidth: 4),
                          ),
                        ],
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: viewmodel.suggestions.isEmpty
                            ? firstFourTrending.length
                            : firstFourSuggestions.length,
                        itemBuilder: (context, i) {
                          return TextButton(
                            onPressed: () {
                              print(
                                viewmodel.suggestions.isEmpty
                                    ? firstFourTrending[i]
                                    : viewmodel.suggestions[i],
                              );
                              setState(() {
                                searchTxt.text = viewmodel.suggestions.isEmpty
                                    ? firstFourTrending[i]
                                    : viewmodel.suggestions[i];
                                isSearched = true;
                              });
                            },
                            child: Container(
                              height: 60,
                              child: Row(
                                children: [
                                  Icon(Icons.search),
                                  SizedBox(width: 20),
                                  Expanded(
                                    child: Align(
                                      alignment: AlignmentGeometry.centerLeft,
                                      child: Text(
                                        viewmodel.suggestions.isEmpty
                                            ? firstFourTrending[i]
                                            : firstFourSuggestions[i],
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  // SizedBox(width: ,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0,
                                    ),
                                    child: Icon(Icons.trending_up),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),

              if (viewmodel.isSearchItem)
                isSearched
                    ? SizedBox(height: 900, child: SearchedItemView())
                    : isLoading
                    ? Column(
                        children: [
                          SizedBox(height: 200),
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator(strokeWidth: 4),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: viewmodel.suggestions.isEmpty
                                ? firstFourTrending.length
                                : firstFourSuggestions.length,
                            itemBuilder: (context, i) {
                              return TextButton(
                                onPressed: () {
                                  print(
                                    viewmodel.suggestions.isEmpty
                                        ? firstFourTrending[i]
                                        : viewmodel.suggestions[i],
                                  );
                                  setState(() {
                                    searchTxt.text =
                                        viewmodel.suggestions.isEmpty
                                        ? firstFourTrending[i]
                                        : viewmodel.suggestions[i];
                                    isSearched = true;
                                  });
                                },
                                child: Container(
                                  height: 60,
                                  child: Row(
                                    children: [
                                      Icon(Icons.search),
                                      SizedBox(width: 20),
                                      Expanded(
                                        child: Align(
                                          alignment:
                                              AlignmentGeometry.centerLeft,
                                          child: Text(
                                            viewmodel.suggestions.isEmpty
                                                ? firstFourTrending[i]
                                                : firstFourSuggestions[i],
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      // SizedBox(width: ,),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0,
                                        ),
                                        child: Icon(Icons.trending_up),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),

                          SizedBox(height: 15),
                          // MARK:- Suggestions
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: GridView.builder(
                              shrinkWrap: true,
                              itemCount: 9,
                              padding: const EdgeInsets.symmetric(
                                vertical: 10.0,
                              ),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 15.0,
                                    crossAxisSpacing: 15.0,
                                    mainAxisExtent: 230, // height
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
                                              MediaQuery.of(
                                                context,
                                              ).size.height *
                                              0.9,
                                          child: ItemDetailView(),
                                        ),
                                      );
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
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
                                              Text(
                                                "🌟 ${sixCardSuggestions[i].rating}",
                                              ),
                                              Text(
                                                sixCardSuggestions[i].title,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Text(
                                                sixCardSuggestions[i].quantity,
                                                style: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Colors.black38,
                                                ),
                                              ),
                                              SizedBox(height: 20),
                                              Text(
                                                sixCardSuggestions[i]
                                                    .discountPercentage,
                                                style: TextStyle(
                                                  fontSize: 11.5,
                                                  color: Colors.red,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    sixCardSuggestions[i]
                                                        .discountPrice,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15.5,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(width: 8),
                                                  Text(
                                                    sixCardSuggestions[i]
                                                        .originalPrice,
                                                    style: TextStyle(
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      color: Colors.grey,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              SizedBox(height: 10),

                                              TextButton(
                                                style: TextButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.yellow,
                                                  minimumSize: const Size(
                                                    100,
                                                    35,
                                                  ),
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                      ),
                                                ),
                                                onPressed: () {},
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Add to cart",
                                                      style: TextStyle(
                                                        color:
                                                            const Color.fromARGB(
                                                              255,
                                                              49,
                                                              49,
                                                              49,
                                                            ),
                                                        fontSize:
                                                            (MediaQuery.of(
                                                                  context,
                                                                ).size.width >
                                                                400)
                                                            ? 13
                                                            : 10,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                    SizedBox(width: 5),
                                                    Icon(
                                                      Icons.add,
                                                      color:
                                                          const Color.fromARGB(
                                                            255,
                                                            49,
                                                            49,
                                                            49,
                                                          ),
                                                      size:
                                                          (MediaQuery.of(
                                                                context,
                                                              ).size.width >
                                                              400)
                                                          ? 12
                                                          : 10,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 5),
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

                          SizedBox(height: 30),
                        ],
                      ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
