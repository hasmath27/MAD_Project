import 'package:flutter/material.dart';
import 'place_details_page.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({super.key});

  // Sample static data (Added 'image' key to match your HomePage data)
  final List<Map<String, String>> bookmarks = const [
    {
      'id': '1',
      'name': 'Galle Fort',
      'location': 'Southern Province, Sri Lanka',
      'description': 'Historic fort built by the Portuguese in the 16th century.',
      'image': 'assets/galle_fort.png',
    },
    {
      'id': '2',
      'name': 'Sigiriya Rock',
      'location': 'Matale, Sri Lanka',
      'description': 'Ancient rock fortress and palace ruins.',
      'image': 'assets/sigiriya.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text("My Saved Places", 
          style: TextStyle(color: Color(0xFF1A237E), fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      body: bookmarks.isEmpty ? _buildEmptyState() : _buildBookmarkList(),
    );
  }

  // UI for when there are bookmarks
  Widget _buildBookmarkList() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: bookmarks.length,
      itemBuilder: (context, index) {
        final place = bookmarks[index];
        return _buildBookmarkCard(context, place);
      },
    );
  }

  // Simplified Modern Bookmark Card
  Widget _buildBookmarkCard(BuildContext context, Map<String, String> place) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PlaceDetailsPage(place: place))),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha:0.04), blurRadius: 10, offset: const Offset(0, 4))
          ],
        ),
        child: Row(
          children: [
            // 1. SMALL PREVIEW IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                place['image'] ?? '',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, e, s) => Container(
                  width: 80, height: 80, color: Colors.blue.shade50,
                  child: const Icon(Icons.image, color: Colors.blueAccent),
                ),
              ),
            ),
            const SizedBox(width: 16),
            
            // 2. TEXT DETAILS
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    place['name']!,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          place['location']!,
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 3. REMOVE BUTTON
            IconButton(
              icon: const Icon(Icons.bookmark_remove_rounded, color: Colors.redAccent, size: 22),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Removed from bookmarks")),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Simple Empty State UI
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.bookmark_border_rounded, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          const Text("No bookmarks yet", 
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey)),
        ],
      ),
    );
  }
}