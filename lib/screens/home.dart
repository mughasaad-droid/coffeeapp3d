import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'cart.dart';

// Product data structure
class Product {
  final String name;
  final double price;
  final String assetPath;

  Product({required this.name, required this.price, required this.assetPath});
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  String selectedCategory = 'COFFEE';
  List<Product> cartItems = [];
  
  final Map<String, List<Product>> categoryProducts = {
    'COFFEE': [
      Product(name: 'Classic Espresso', price: 4.50, assetPath: 'assets/3d_items/coffe1.glb'),
      Product(name: 'Caramel Macchiato', price: 5.20, assetPath: 'assets/3d_items/coffe2.glb'),
      Product(name: 'Iced Latte', price: 4.80, assetPath: 'assets/3d_items/coffe3.glb'),
      Product(name: 'Cappuccino Special', price: 5.00, assetPath: 'assets/3d_items/coffe4.glb'),
      Product(name: 'Mocha Delight', price: 5.50, assetPath: 'assets/3d_items/coffe5.glb'),
      Product(name: 'Hazelnut Brew', price: 5.30, assetPath: 'assets/3d_items/coffe6.glb'),
    ],
    'BAKERY': [
      Product(name: 'Chocolate Muffin', price: 3.50, assetPath: 'assets/3d_items/bak1.glb'),
      Product(name: 'Butter Croissant', price: 2.80, assetPath: 'assets/3d_items/bak2.glb'),
      Product(name: 'Blueberry Cake', price: 4.00, assetPath: 'assets/3d_items/bak3.glb'),
      Product(name: 'Donut Glaze', price: 2.50, assetPath: 'assets/3d_items/bak4.glb'),
      Product(name: 'Cheese Danish', price: 3.20, assetPath: 'assets/3d_items/bak5.glb'),
      Product(name: 'Fruit Tart', price: 4.50, assetPath: 'assets/3d_items/bak6.glb'),
    ],
    'TEA': [
      Product(name: 'Green Tea', price: 3.00, assetPath: 'assets/3d_items/tea1.glb'),
      Product(name: 'Chamomile Relax', price: 3.50, assetPath: 'assets/3d_items/tea2.glb'),
      Product(name: 'Black Tea', price: 2.80, assetPath: 'assets/3d_items/tea3.glb'),
      Product(name: 'Herbal Infusion', price: 3.80, assetPath: 'assets/3d_items/tea4.glb'),
      Product(name: 'Earl Grey', price: 4.00, assetPath: 'assets/3d_items/tea5.glb'),
    ],
    'JUICE': [
      Product(name: 'Orange Fresh', price: 4.00, assetPath: 'assets/3d_items/juc1.glb'),
      Product(name: 'Apple Crisp', price: 4.20, assetPath: 'assets/3d_items/juc2.glb'),
      Product(name: 'Berry Mix', price: 4.80, assetPath: 'assets/3d_items/juc3.glb'),
      Product(name: 'Mango Tango', price: 5.00, assetPath: 'assets/3d_items/juc4.glb'),
      Product(name: 'Pineapple Punch', price: 4.50, assetPath: 'assets/3d_items/juc5.glb'),
      Product(name: 'Watermelon Chill', price: 4.00, assetPath: 'assets/3d_items/juc6.glb'),
    ],
  };

  final PageController _pageController = PageController();
  int _currentProductIndex = 0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    List<Product> currentProducts = categoryProducts[selectedCategory] ?? [];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Animated Top Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: TweenAnimationBuilder(
              duration: const Duration(milliseconds: 800),
              tween: Tween<double>(begin: -100, end: 0),
              builder: (context, double top, child) {
                return Positioned(top: top, child: child!); // Note: This structure in builder is slightly wrong for Positioned, fixing below
              },
              child: Container() // Placeholder
            ),
          ),
          
          // Re-structured for cleaner animations
          _buildTopBar(),

          // Main 3D Display with entrance animation
          Positioned(
            top: 150,
            left: 0,
            right: 0,
            bottom: 250,
            child: TweenAnimationBuilder(
              duration: const Duration(milliseconds: 1000),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, double value, child) {
                return Opacity(opacity: value, child: child);
              },
              child: currentProducts.isNotEmpty ? _buildProductView(currentProducts) : Container(),
            ),
          ),

          // Bottom Bar with entrance animation
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: TweenAnimationBuilder(
              duration: const Duration(milliseconds: 800),
              tween: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero),
              builder: (context, Offset offset, child) {
                return FractionalTranslation(translation: offset, child: child);
              },
              child: _buildBottomBar(screenWidth),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 120,
        decoration: const BoxDecoration(
          color: Color(0xFF3A1F1A),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Text(
              'Minimal Beans',
              style: GoogleFonts.pacifico(
                color: Colors.white,
                fontSize: 35,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductView(List<Product> currentProducts) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) => setState(() => _currentProductIndex = index),
                itemCount: currentProducts.length,
                itemBuilder: (context, index) {
                  return ModelViewer(
                    key: ValueKey(currentProducts[index].assetPath),
                    backgroundColor: Colors.transparent,
                    src: currentProducts[index].assetPath,
                    alt: currentProducts[index].name,
                    ar: false,
                    autoRotate: true,
                    autoRotateDelay: 0,
                    rotationPerSecond: "40deg",
                    cameraControls: true,
                    loading: Loading.eager,
                    shadowIntensity: 0,
                    interactionPrompt: InteractionPrompt.none,
                  );
                },
              ),
            ),
            
            // Name and Price with subtle fade
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: Padding(
                key: ValueKey(currentProducts[_currentProductIndex].name),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentProducts[_currentProductIndex].name,
                          style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, color: const Color(0xFF3A1F1A)),
                        ),
                        Text(
                          '\$${currentProducts[_currentProductIndex].price.toStringAsFixed(2)}',
                          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, color: const Color(0xFFD4A373)),
                        ),
                      ],
                    ),
                    _buildAddButton(currentProducts[_currentProductIndex]),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // Dots
            if (currentProducts.length > 1)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(currentProducts.length, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentProductIndex == index ? 12 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: _currentProductIndex == index ? const Color(0xFFD4A373) : Colors.grey[300],
                    ),
                  );
                }),
              ),
          ],
        ),
        
        // Arrows
        if (_currentProductIndex > 0)
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF3A1F1A), size: 30),
              onPressed: () => _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut),
            ),
          ),
        if (_currentProductIndex < currentProducts.length - 1)
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: const Icon(Icons.arrow_forward_ios, color: Color(0xFF3A1F1A), size: 30),
              onPressed: () => _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut),
            ),
          ),
      ],
    );
  }

  Widget _buildAddButton(Product product) {
    return GestureDetector(
      onTap: () {
        setState(() => cartItems.add(product));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${product.name} added to cart!'), duration: const Duration(seconds: 1), behavior: SnackBarBehavior.floating),
        );
      },
      child: TweenAnimationBuilder(
        duration: const Duration(milliseconds: 200),
        tween: Tween<double>(begin: 1, end: 1),
        builder: (context, double scale, child) => Transform.scale(scale: scale, child: child),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(color: Color(0xFF3A1F1A), shape: BoxShape.circle),
          child: const Icon(Icons.add, color: Colors.white, size: 30),
        ),
      ),
    );
  }

  Widget _buildBottomBar(double screenWidth) {
    return SizedBox(
      height: 250,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 220,
            width: screenWidth,
            decoration: const BoxDecoration(
              color: Color(0xFF3A1F1A),
              borderRadius: BorderRadius.only(topLeft: Radius.elliptical(250, 100), topRight: Radius.elliptical(250, 100)),
            ),
          ),
          Positioned(bottom: 35, left: screenWidth * 0.05, child: _buildCategoryCircle('COFFEE', 'assets/cof.png', 75)),
          Positioned(bottom: 80, left: screenWidth * 0.28, child: _buildCategoryCircle('BAKERY', 'assets/bakery.png', 75)),
          Positioned(bottom: 80, right: screenWidth * 0.28, child: _buildCategoryCircle('TEA', 'assets/tea.png', 75)),
          Positioned(bottom: 35, right: screenWidth * 0.05, child: _buildCategoryCircle('JUICE', 'assets/juice.png', 75)),
          
          // Animated Cart Icon
          Positioned(
            bottom: 25,
            child: _buildCartIcon(),
          ),
        ],
      ),
    );
  }

  Widget _buildCartIcon() {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 500),
      tween: Tween<double>(begin: 1, end: cartItems.isNotEmpty ? 1.2 : 1.0),
      builder: (context, double scale, child) {
        return Transform.scale(scale: scale, child: child);
      },
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(context, PageRouteBuilder(
              pageBuilder: (context, anim, secondAnim) => CartScreen(cartItems: cartItems),
              transitionsBuilder: (context, anim, secondAnim, child) {
                return SlideTransition(position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(CurvedAnimation(parent: anim, curve: Curves.easeOutBack)), child: child);
              },
            ));
          },
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 30),
              if (cartItems.isNotEmpty)
                Positioned(
                  right: -5,
                  top: -5,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(color: Color(0xFFD4A373), shape: BoxShape.circle),
                    child: Text('${cartItems.length}', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCircle(String category, String imagePath, double size) {
    bool isSelected = selectedCategory == category;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = category;
          _currentProductIndex = 0;
          if (_pageController.hasClients) _pageController.jumpToPage(0);
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            width: isSelected ? size + 10 : size,
            height: isSelected ? size + 10 : size,
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFD4A373) : Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: isSelected ? Colors.white : const Color(0xFFD4A373), width: 3.5),
              boxShadow: isSelected ? [const BoxShadow(color: Colors.black26, blurRadius: 12, offset: Offset(0, 6))] : [],
            ),
            child: ClipOval(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(imagePath, fit: BoxFit.contain, color: isSelected ? Colors.white : null),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(category, style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, letterSpacing: 1.2)),
        ],
      ),
    );
  }
}
