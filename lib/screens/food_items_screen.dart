import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utlits/data_class.dart';
import '../utlits/item_container.dart';
import 'product_detail_screen.dart';

class FoodItemPage extends StatefulWidget {
  const FoodItemPage(
      {Key? key, required this.title, required this.currentIndex})
      : super(key: key);
  final String title;
  final int currentIndex;

  @override
  State<FoodItemPage> createState() => _FoodItemPageState();
}

class _FoodItemPageState extends State<FoodItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.3,
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 20, color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
              icon: const Icon(
                Icons.shopping_cart,
              ),
              color: Colors.black,
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(2),
                filled: true,
                fillColor: Colors.black.withOpacity(0.03),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.black12,
                ),
                hintText: "Search Product",
                hintStyle: const TextStyle(color: Colors.black12),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                  ),
                ),
              ),
              cursorColor: Colors.black38,
              style: const TextStyle(color: Colors.black38),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.7,
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemCount: restaurants[widget.currentIndex].menuList.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: (){
                    Get.to(
                        ProductDetail(image: restaurants[widget.currentIndex].menuList[index].itemImage, name: restaurants[widget.currentIndex].menuList[index].itemName),
                        transition: Transition.leftToRightWithFade,
                        duration: const Duration(milliseconds: 400));
                  },
                  child: ItemContainer(
                      image: restaurants[widget.currentIndex].menuList[index].itemImage,
                      name: restaurants[widget.currentIndex].menuList[index].itemName,
                      price: "200/-",
                      restImage: widget.currentIndex == 0
                          ? "assets/images/rest.png"
                          : "assets/images/thr.png"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


