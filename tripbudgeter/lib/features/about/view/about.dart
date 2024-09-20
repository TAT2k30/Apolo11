import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('About Us'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Image.asset(
                    'assets/logo.png', // Đường dẫn đến logo của dự án nếu có
                    height: 100,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Welcome to Trip Budgeter!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Trip Budgeter is your ultimate travel companion designed to help you effectively manage your travel expenses. Whether you\'re planning a weekend getaway or a month-long adventure, Trip Budgeter ensures that you stay within budget while enjoying every moment of your trip.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Non-Functional Requirements',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '''
1. **Safe to use**: The mobile app should not result in any malicious downloads or
unnecessary file downloads.
                
2. **Accessible**: The mobile app should have clear and legible fonts, user-interface
elements, and navigation elements.
                
3. **User-friendly**: The mobile app should be easy to navigate with clear menus and other
elements and easy to understand.
                
4. **Operability**: The mobile app should be reliable and efficient.
                
5. **Performance**: The mobile app should demonstrate high value of performance through
speed and throughput. In simple terms, the mobile app should have minimal load time
and smooth page redirection.

6. **Scalability:**: The system architecture and infrastructure should be designed to handle
increasing user traffic, data storage, and feature expansions.

7. **Security:**: The mobile app should implement adequate security measures such as
authentication. For example, only registered users can access certain features.
                ''',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Our Mission',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'At Trip Budgeter, our mission is to help travelers focus more on the joy of traveling and less on the stress of managing finances. We believe that with the right tools, anyone can travel smartly and make the most out of their adventures without breaking the bank.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Contact Us',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '''
If you have any questions, feedback, or suggestions, feel free to reach out to us:

Email: support@tripbudgeter.com
Phone: +1-800-TRIP-BUD
Address: 123 Travel Lane, Adventure City, TX 75000
                ''',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 24),
                const Center(
                  child: Text(
                    'Thank you for choosing Trip Budgeter!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
