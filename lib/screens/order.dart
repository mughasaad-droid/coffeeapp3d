import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home.dart';

class OrderScreen extends StatelessWidget {
  final List<Product> cartItems;
  final double totalPrice;
  final String selectedSize;

  const OrderScreen({
    super.key,
    required this.cartItems,
    required this.totalPrice,
    required this.selectedSize,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFD1FFED),
              Color(0xFF90C8FF),
            ],
          ),
        ),
        child: Stack(
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
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Order Confirmed Title
            Positioned(
              top: 160,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3A1F1A),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    'Order Confirmed',
                    style: GoogleFonts.pacifico(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ),

            // Order Details Section
            Positioned(
              top: 250,
              left: 20,
              right: 20,
              bottom: 100,
              child: Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order Details',
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF3A1F1A),
                      ),
                    ),
                    const Divider(color: Color(0xFFD4A373), thickness: 1),
                    const SizedBox(height: 10),
                    
                    // Items List
                    Expanded(
                      child: ListView.builder(
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  cartItems[index].name,
                                  style: GoogleFonts.poppins(fontSize: 16),
                                ),
                                Text(
                                  '\$${cartItems[index].price.toStringAsFixed(2)}',
                                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    
                    const Divider(color: Color(0xFFD4A373)),
                    
                    // Size and Time info
                    _buildDetailRow('Selected Size:', selectedSize),
                    _buildDetailRow('Estimated Time:', '15-20 Mins'),
                    
                    const SizedBox(height: 15),
                    
                    // Total Price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Amount:',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '\$${totalPrice.toStringAsFixed(2)}',
                          style: GoogleFonts.pacifico(
                            fontSize: 22,
                            color: const Color(0xFF3A1F1A),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Back to Home Button
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: Text(
                    'Back to Home',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF3A1F1A),
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.poppins(color: Colors.grey[700])),
          Text(value, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
