import 'package:flutter/material.dart';

class ItemDetailView extends StatefulWidget {
  const ItemDetailView({super.key});

  @override
  State<ItemDetailView> createState() => _ItemDetailViewState();
}

class _ItemDetailViewState extends State<ItemDetailView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: 300,
                child: Image.asset(
                  "screen_1.png",
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),

              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 50,
                  height: 50,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close, size: 25, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Column(
                spacing: 10.0,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "🌟 4.1",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "fruitsItems[i].title",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 23.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "Qty: fruitsItems[i].quantity",
                    style: TextStyle(fontSize: 13.0, color: Colors.black38),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "fruitsItems[i].discountPercentage",
                    style: TextStyle(fontSize: 12, color: Colors.red),
                  ),
                  Row(
                    children: [
                      Text(
                        "fruitsItems[i].discountPrice",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "fruitsItems[i].originalPrice",
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                          fontSize: 16,
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
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                      onPressed: () {},
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Add to cart",
                            style: TextStyle(color: Colors.black, fontSize: 13),
                          ),
                          SizedBox(width: 5),
                          Icon(Icons.add, color: Colors.black, size: 12),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
