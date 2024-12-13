import 'package:flutter/material.dart';
import '../Auth/login_screen.dart';
import '../Meals/add_meal_screen.dart';
import '../Orders/orders_screen.dart';
import '../../Widgets/meal_card.dart';
import '../../Widgets/offer_card.dart';
import '../Categories/categories_data.dart';
import '../Categories/category_screen.dart';
import '../Payment/payment_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, String>> allMeals = [
    {'name': 'وجبة لذيذة', 'price': '15.00 ر.س', 'image': 'assets/images/catagray1.jpeg'},
    {'name': 'وجبة مميزة', 'price': '20.00 ر.س', 'image': 'assets/images/offer1.png'},
    {'name': 'وجبة خفيفة', 'price': '10.00 ر.س', 'image': 'assets/images/offer30.jpeg'},
  ];

  List<Map<String, String>> filteredMeals = [];
  bool isSearching = false;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredMeals = allMeals;
  }

  void searchMeals(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredMeals = allMeals;
      } else {
        filteredMeals = allMeals.where((meal) => meal['name']!.contains(query)).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: isSearching
              ? TextField(
            controller: searchController,
            decoration: const InputDecoration(
              hintText: 'ابحث عن وجبة...',
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.white70),
            ),
            style: const TextStyle(color: Colors.white),
            onChanged: searchMeals,
          )
              : const Text('تطبيق الطعام'),
          actions: [
            IconButton(
              icon: Icon(isSearching ? Icons.close : Icons.search),
              onPressed: () {
                setState(() {
                  isSearching = !isSearching;
                  if (!isSearching) {
                    searchController.clear();
                    searchMeals('');
                  }
                });
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.green),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('مرحبًا بك!', style: TextStyle(color: Colors.white, fontSize: 18)),
                    SizedBox(height: 10),
                    Text('اختيار القائمة...', style: TextStyle(color: Colors.white70, fontSize: 14)),
                  ],
                ),
              ),
              _buildDrawerItem(Icons.home, 'الرئيسية', context),
              _buildDrawerItem(Icons.shopping_cart, 'الطلبات', context),
              _buildDrawerItem(Icons.account_circle, 'الحساب', context),
              _buildDrawerItem(Icons.add, 'إضافة وجبة', context),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildOffersSection(),
              _buildSectionTitle('التصنيفات'),
              _buildCategoriesSection(context),
              _buildSectionTitle('وجبات موصى بها'),
              _buildRecommendedMealsSection(),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'الطلبات'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'الحساب'),
          ],
          selectedItemColor: Colors.green,
          onTap: (index) {
            switch (index) {
              case 0:
                break;
              case 1:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OrdersScreen()),
                );
                break;
              case 2:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  LoginScreen(
                    ),
                  ),
                );
                break;
            }
          },
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        if (title == 'الطلبات') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const OrdersScreen()),
          );
        } else if (title == 'الحساب') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>  LoginScreen(
              ),
            ),
          );
        } else if (title == 'إضافة وجبة') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  AddMealScreen()),
          );
        }
      },
    );
  }

  Widget _buildOffersSection() {
    return SizedBox(
      height: 200,
      child: PageView(
        controller: PageController(viewportFraction: 0.8),
        children: const [
          OfferCard(imagePath: 'assets/images/offer1.png', title: 'عرض اليوم'),
          OfferCard(imagePath: 'assets/images/offer30.jpeg', title: 'خصم 30%'),
          OfferCard(imagePath: 'assets/images/offer_free.jpeg', title: 'وجبة مجانية'),
        ],
      ),
    );
  }

  Widget _buildCategoriesSection(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryScreen(categoryName: category['name']!),
                ),
              );
            },
            child: _buildCategoryCard(category['image']!, category['name']!),
          );
        },
      ),
    );
  }

  Widget _buildRecommendedMealsSection() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filteredMeals.length,
      itemBuilder: (context, index) {
        final meal = filteredMeals[index];
        return MealCard(
          imagePath: meal['image']!,
          title: meal['name']!,
          price: meal['price']!,
          onCartPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PaymentScreen()),
            );
          },
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildCategoryCard(String imagePath, String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundImage: AssetImage(imagePath),
          ),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}

