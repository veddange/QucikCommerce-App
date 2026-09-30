import 'package:flutter/foundation.dart';
import 'package:quickcommerce_app/Network%20Sevices/NetworkManager.dart';

class SearchViewViewModel extends ChangeNotifier {
  final List<String> groceriesAndFruits = [
    // Fruits
    'Apple',
    'Banana',
    'Mango',
    'Orange',
    'Grapes',
    'Watermelon',
    'Papaya',
    'Pineapple',
    'Strawberry',
    'Blueberry',
    'Pomegranate',
    'Guava',
    'Kiwi',
    'Peach',
    'Pear',
    'Cherry',
    'Coconut',
    'Lemon',
    'Lime',

    // Vegetables
    'Potato',
    'Tomato',
    'Onion',
    'Carrot',
    'Cucumber',
    'Spinach',
    'Broccoli',
    'Cauliflower',
    'Cabbage',
    'Capsicum',
    'Beetroot',
    'Brinjal',
    'Green Peas',
    'Lady Finger',
    'Sweet Corn',

    // Groceries
    'Rice',
    'Wheat Flour',
    'Maida',
    'Sugar',
    'Salt',
    'Cooking Oil',
    'Olive Oil',
    'Dal',
    'Toor Dal',
    'Moong Dal',
    'Chana Dal',
    'Rajma',
    'Chickpeas',
    'Tea',
    'Coffee',
    'Milk',
    'Curd',
    'Butter',
    'Cheese',
    'Bread',
    'Biscuits',
    'Noodles',
    'Pasta',
    'Oats',
    'Cornflakes',
    'Honey',
    'Jam',
    'Peanut Butter',
  ];

  List<String> suggestions = [];

  bool fromDashboard = false;

  bool isSearchItem = false;

  bool isLoggedIn = false;

  String navigationTitle = "";

  void searchItem(String query) {
    if (query.isNotEmpty) {
      suggestions = groceriesAndFruits
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else {
      suggestions = [];
    }

    notifyListeners();
  }
}
