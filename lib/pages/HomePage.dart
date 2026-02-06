import 'package:flutter/material.dart';
import 'bookmark_page.dart';
import 'profile_page.dart';
import 'place_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Map<String, String>> places = const [
    {
      'name': 'Galle Fort',
      'location': 'Southern Province, Sri Lanka',
      'image': 'assets/galle_fort.png',
    },
    {
      'name': 'Sigiriya Rock',
      'location': 'Matale, Sri Lanka',
      'image': 'assets/sigiriya.png',
    },
    {
      'name': 'Nine Arch Bridge',
      'location': 'Ella, Sri Lanka',
      'image': 'assets/nine_arch.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), 
      body: _selectedIndex == 0 ? _homeContent() : _otherPages(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        elevation: 0,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blueAccent,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.explore_outlined), activeIcon: Icon(Icons.explore), label: "Explore"),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark_outline), activeIcon: Icon(Icons.bookmark), label: "Saved"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  Widget _homeContent() {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        const SliverAppBar(
          floating: true,
          title: Text("Explore Sri Lanka", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          backgroundColor: Color(0xFFF8F9FA),
          elevation: 0,
          centerTitle: false,
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildPlaceCard(places[index]),
              childCount: places.length,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceCard(Map<String, String> place) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PlaceDetailsPage(place: place))),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha:0.05), blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: Image.asset(
                place['image']!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, e, s) => Container(height: 200, color: Colors.blue.withValues(alpha:0.1), child: const Icon(Icons.image_outlined)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(place['name']!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(place['location']!, style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
                    ],
                  ),
                  const CircleAvatar(
                    backgroundColor: Color(0xFFE3F2FD),
                    child: Icon(Icons.arrow_forward_ios, size: 14, color: Colors.blueAccent),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _otherPages() {
    return _selectedIndex == 1 ? const BookmarkPage() : const ProfilePage();
  }
}