import 'dart:async';
import 'package:flutter/material.dart';
import 'package:narail_city/ui/screens/home_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // ব্যাকগ্রাউন্ড কালার
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 🔹 লোগো
            // Image.asset(
            //   'assets/images/narail_logo.png', // আপনার লোগো path দিন
            //   height: 120,
            //   width: 120,
            // ),
            const SizedBox(height: 20),

            // 🔹 অ্যাপ নাম
            const Text(
              'Narail City',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
                letterSpacing: 1.2,
              ),
            ),

            const SizedBox(height: 8),

            // 🔹 ট্যাগলাইন
            const Text(
              'Discover • Connect • Explore',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 40),

            // 🔹 লোডার
            const CircularProgressIndicator(
              color: Colors.teal,
              strokeWidth: 2,
            ),
          ],
        ),
      ),
    );
  }
}
