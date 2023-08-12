import 'package:flutter/material.dart';
import 'package:foodie/screens/product_detail_screen.dart';
import 'package:foodie/utlits/data_class.dart';
import 'package:foodie/utlits/item_container.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import '../utlits/restaurent_container.dart';
import 'food_items_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  final _controller = PageController(
    viewportFraction: 0.8,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  var pageViewList = [
    "assets/images/burger.png",
    "assets/images/karhai.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.3,
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
          ),
          color: Colors.black,
          onPressed: () {},
        ),
        title: const Text(
          "HOME",
          style: TextStyle(fontSize: 20, color: Colors.black),
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
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.20,
              width: MediaQuery.of(context).size.width,
              child: PageView.builder(
                padEnds: false,
                controller: _controller,
                itemCount: pageViewList.length,
                itemBuilder: (context, index) => Container(
                  margin: index == 0
                      ? const EdgeInsets.fromLTRB(20, 20, 5, 10)
                      : const EdgeInsets.fromLTRB(5, 20, 20, 10),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: AssetImage(pageViewList[index]),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 3,
                          spreadRadius: 1,
                          offset: Offset(0,3),
                        ),
                      ]),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(3),
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
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "Restaurant",
                style: TextStyle(
                    fontSize: 19,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  restaurants.length,
                  (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    child: RestaurantCard(
                      image: restaurants[index].image,
                      name: restaurants[index].name,
                      isActive: currentIndex == index ? true : false,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Most Popular",
                      style: TextStyle(
                          fontSize: 19,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(
                            FoodItemPage(
                                currentIndex: currentIndex,
                                title: restaurants[currentIndex].name),
                            transition: Transition.leftToRightWithFade,
                            duration: const Duration(milliseconds: 400));
                      },
                      child: const Text(
                        "View All",
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFFEA7049),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: restaurants[currentIndex].menuList.length,
                  itemBuilder: (context, index) => Padding(
                    padding: index == 0
                        ? const EdgeInsets.only(left: 20, right: 20)
                        : const EdgeInsets.only(right: 20),
                    child: GestureDetector(
                      onTap: (){
                        Get.to(
                            ProductDetail(
                              image: restaurants[currentIndex].menuList[index].itemImage,
                                name: restaurants[currentIndex].menuList[index].itemName
                            ),
                            transition: Transition.leftToRightWithFade,
                            duration: const Duration(milliseconds: 400));
                      },
                      child: ItemContainer(
                        image:
                            restaurants[currentIndex].menuList[index].itemImage,
                        name: restaurants[currentIndex].menuList[index].itemName,
                        price: "200/-",
                        restImage: 'sd',
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFFEA7049),
        unselectedItemColor: Colors.black12,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "home",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on_outlined), label: "location"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded), label: "profile"),
        ],
      ),
    );
  }
}

