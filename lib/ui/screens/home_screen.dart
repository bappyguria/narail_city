import 'package:flutter/material.dart';
import 'package:narail_city/ui/screens/Bank/bank_list_screens.dart';
import 'package:narail_city/ui/screens/ZilaProsason/zila_prosason_screen.dart';

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
          Container(
            height: 220,
            width: double.infinity,
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //     image: NetworkImage(
            //       'https://images.unsplash.com/photo-1554224311-beee4c75701a?w=800',
            //     ),
            //     fit: BoxFit.cover,
            //   ),
            // ),
          ),

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
                  _buildServiceCard('⚡', 'Bank',(){
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