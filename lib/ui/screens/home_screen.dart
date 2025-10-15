import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:narail_city/ui/screens/Bank/bank_list_screens.dart';
import 'package:narail_city/ui/screens/ZilaProsason/zila_prosason_screen.dart' hide BankListScreens;

import 'Polish/polish_thana_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white, size: 30),
          onPressed: () {},
        ),
        title: const Text(
          'Narail City',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Banner Image
          BankImageCarousel(),

          // Scrolling Text Banner
          Container(
            height: 45,
            color: const Color(0xFF7CB342),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  color: Colors.red[700],
                  child: const Text(
                    'আপডেট',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        '  নারায় আপনাকে স্বাগতম  |  তুষ্ট নয় রুষ্টান, বাঁচা',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Service Title
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            color: const Color(0xFF7CB342),
            width: double.infinity,
            child: const Center(
              child: Text(
                'সার্ভিস সমূহ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Service Grid
          Expanded(
            child: Container(
              color: const Color(0xFF7CB342),
              padding: const EdgeInsets.all(8),
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                children: [
                  _buildServiceCard('👨', 'জেলা প্রশাসন',(){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ZilaProshasonScreen()));
                  }),
                  // _buildServiceCard('🏛️', 'পৌরসভা/ইউনিয়ন'),
                  _buildServiceCard('👮', 'থানা/পুলিশ',(){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> PolishThanaScreen()));
                  }),
                  // _buildServiceCard('🚒', 'ফায়ার সার্ভিস'),
                  // _buildServiceCard('🏥', 'হাসপাতাল'),
                  _buildServiceCard('🏦', 'Bank',(){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> BankListScreens()));
                  }),
                  // _buildServiceCard('🏫', 'শিক্ষা প্রতিষ্ঠান'),
                  // _buildServiceCard('👨‍💼', 'সাংবাদিক'),
                  // _buildServiceCard('👷', 'ডাক্তার'),
                  // _buildServiceCard('🚑', 'এম্বুলেন্স'),
                  // _buildServiceCard('👨‍✈️', 'ডেন্টাল কেয়ার'),
                  // _buildServiceCard('🐄', 'পশু হাসপাতাল'),
                  // _buildServiceCard('👨‍💼', 'উপদেষ্টা'),
                  // _buildServiceCard('🚗', 'গাড়ি'),
                  // _buildServiceCard('🌾', 'ভূমি সেবা'),

                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF00AEEF),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Message',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notification',
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(String emoji, String label,var onTab) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              emoji,
              style: const TextStyle(fontSize: 40),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class BankImageCarousel extends StatelessWidget {
  const BankImageCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> imageUrls = [
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYELlVs6HB_xhw_52Ae_HOM6t9JgDe2uxmUA&s',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHED9nffAEIpJjdeb6WkF42JSuJaUns6dGjA&s',
      'https://media.gettyimages.com/id/566456199/photo/bulls-graze-near-a-jute-field-eighty-percent-of-the-worlds-high-quality-jute-grows-in.jpg?s=612x612&w=0&k=20&c=vS5nQQBFHyV2ndzS1TUns393wuLiSLAg6mM-9dF-Nk8=',
      'https://propertyguide.com.bd/_next/image?url=https%3A%2F%2Fpropertyguide-store.s3.ap-southeast-1.amazonaws.com%2Fbikroy%2Fmedium_Untitled_design_25_8ab8e922b0.jpg&w=3840&q=75',
    ];

    return CarouselSlider.builder(
      itemCount: imageUrls.length,
      itemBuilder: (context, index, realIndex) {
        return SizedBox(
          width: MediaQuery.of(context).size.width, // 🔹 Full width
          child: Image.network(
            imageUrls[index],
            fit: BoxFit.cover, // 🔹 Fill the screen horizontally
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(child: CircularProgressIndicator());
            },
            errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.error, color: Colors.red),
          ),
        );
      },
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        enlargeCenterPage: false, // 🔹 Disable center zoom
        viewportFraction: 1.0, // 🔹 1.0 = full width
        enableInfiniteScroll: true,
        autoPlayInterval: const Duration(seconds: 4),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
      ),
    );
  }
}
