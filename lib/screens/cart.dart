import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home.dart';
import 'order.dart'; // Import OrderScreen

class CartScreen extends StatefulWidget {
  final List<Product> cartItems;
  const CartScreen({super.key, required this.cartItems});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with SingleTickerProviderStateMixin {
  String selectedSize = 'MEDIUM';
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  // Calculate dynamic total price
  double get totalPrice {
    return widget.cartItems.fold(0, (sum, item) => sum + item.price);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Top Bar
          Positioned(
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
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Cart Items List
          Positioned(
            top: 130,
            left: 0,
            right: 0,
            bottom: 280,
            child: widget.cartItems.isEmpty
                ? const Center(child: Text('Your cart is empty'))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: widget.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = widget.cartItems[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item.name,
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF3A1F1A),
                              ),
                            ),
                            Text(
                              '\$${item.price.toStringAsFixed(2)}',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFD4A373),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),

          // Bottom Curved Section with Animation
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SlideTransition(
              position: _offsetAnimation,
              child: Container(
                height: 280,
                width: screenWidth,
                decoration: const BoxDecoration(
                  color: Color(0xFF3A1F1A),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.elliptical(250, 100),
                    topRight: Radius.elliptical(250, 100),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    // Size Selection
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildSizeOption('LARGE'),
                        _buildSizeOption('MEDIUM'),
                        _buildSizeOption('SMALL'),
                      ],
                    ),
                    const SizedBox(height: 30),
                    // Dynamic Total Price and Order Button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${totalPrice.toStringAsFixed(2)}', // Dynamic Total with $
                            style: GoogleFonts.pacifico(
                              color: Colors.white,
                              fontSize: 28,
                            ),
                          ),
                          _buildOrderButton(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Back Button
          Positioned(
            top: 50,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSizeOption(String size) {
    bool isSelected = selectedSize == size;
    return GestureDetector(
      onTap: () => setState(() => selectedSize = size),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? null : Colors.white,
          gradient: isSelected
              ? const LinearGradient(
                  colors: [Color(0xFFD1FFED), Color(0xFF90C8FF)],
                )
              : null,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          size,
          style: GoogleFonts.poppins(
            color: isSelected ? const Color(0xFF3A1F1A) : Colors.grey[600],
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildOrderButton() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderScreen(
              cartItems: widget.cartItems,
              totalPrice: totalPrice,
              selectedSize: selectedSize,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFD1FFED), Color(0xFF90C8FF)],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          'Order',
          style: GoogleFonts.pacifico(
            color: const Color(0xFF3A1F1A),
            fontSize: 22,
          ),
        ),
      ),
    );
  }
}
