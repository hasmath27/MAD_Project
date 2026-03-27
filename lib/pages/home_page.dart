import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/models/place_model.dart';
import 'package:project/pages/explore_page.dart';
import 'package:project/pages/place_detail_page.dart';
import 'package:project/pages/profile_page.dart';
import 'package:project/pages/trip_page.dart';
import 'package:project/pages/wishlist_page.dart';
import 'package:project/services/place_service.dart';
import 'package:project/theme/app_theme.dart';


const List<String> categories = [
  'All',
  'Beach',
  'Mountain',
  'Forest',
  'City',
  'Desert',
];
const Map<String, String> categoryEmoji = {
  'All': '🌍',
  'Beach': '🏖️',
  'Mountain': '⛰️',
  'Forest': '🌿',
  'City': '🌆',
  'Desert': '🏜️',
};

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _tab = 1;
  String _category = 'All';
  List<PlaceModel> _places = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final data = await PlaceService.fetchAll(category: _category);
      setState(() => _places = data);
    } catch (e) {
      _showError('Failed to load places');
    } finally {
      setState(() => _loading = false);
    }
  }

  void _showError(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: GoogleFonts.poppins()),
        backgroundColor: Colors.red.shade400,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  Future<void> _toggleFav(PlaceModel p) async {
    try {
      await PlaceService.toggleFavorite(p.id, p.isFavorite);
      // Update locally without full reload for instant UI feedback
      setState(() {
        final idx = _places.indexWhere((x) => x.id == p.id);
        if (idx != -1) {
          _places[idx].isFavorite = !_places[idx].isFavorite;
        }
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              p.isFavorite
                  ? '${p.name} removed from wishlist'
                  : '${p.name} added to wishlist ❤️',
              style: GoogleFonts.poppins(),
            ),
            backgroundColor: AppTheme.teal,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.all(16),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      _showError('Failed to update wishlist');
    }
  }

  Widget _homeBody() {
    final featured = _places.where((p) => p.rating >= 4.8).toList();

    return SafeArea(
      child: RefreshIndicator(
        color: AppTheme.teal,
        onRefresh: _load,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            // ── Header ──────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '👋 Hello, Traveler!',
                        style: GoogleFonts.poppins(
                          color: AppTheme.grey,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        'Where to next?',
                        style: GoogleFonts.playfairDisplay(
                          color: AppTheme.dark,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  // Avatar
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppTheme.teal, width: 2),
                      image: const DecorationImage(
                        image: NetworkImage('https://i.pravatar.cc/150?img=47'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ── Search bar ──────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: () => setState(() => _tab = 0),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.search_rounded,
                        color: AppTheme.teal,
                        size: 22,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Search destinations...',
                        style: GoogleFonts.poppins(
                          color: AppTheme.grey,
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppTheme.teal,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.tune_rounded,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ── Category chips ──────────────────────────
            SizedBox(
              height: 42,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, i) {
                  final cat = categories[i];
                  final sel = _category == cat;
                  return GestureDetector(
                    onTap: () {
                      setState(() => _category = cat);
                      _load();
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: sel ? AppTheme.teal : Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: sel
                                ? AppTheme.teal.withOpacity(0.3)
                                : Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Text(
                        '${categoryEmoji[cat]} $cat',
                        style: GoogleFonts.poppins(
                          color: sel ? Colors.white : AppTheme.grey,
                          fontWeight: sel ? FontWeight.w600 : FontWeight.w400,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // ── Loading ─────────────────────────────────
            if (_loading)
              const SizedBox(
                height: 200,
                child: Center(
                  child: CircularProgressIndicator(color: AppTheme.teal),
                ),
              )
            else ...[
              // ── Featured section ─────────────────────
              if (featured.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Featured ✨',
                        style: GoogleFonts.poppins(
                          color: AppTheme.dark,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => setState(() => _tab = 0),
                        child: Text(
                          'See all →',
                          style: GoogleFonts.poppins(
                            color: AppTheme.teal,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  height: 270,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: featured.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 16),
                    itemBuilder: (_, i) => _FeaturedCard(
                      place: featured[i],
                      onFav: () => _toggleFav(featured[i]),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],

              // ── Discover Places section ──────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Discover Places 🗺️',
                      style: GoogleFonts.poppins(
                        color: AppTheme.dark,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${_places.length} places',
                      style: GoogleFonts.poppins(
                        color: AppTheme.grey,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              if (_places.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Center(
                    child: Column(
                      children: [
                        const Text('🌍', style: TextStyle(fontSize: 50)),
                        const SizedBox(height: 12),
                        Text(
                          'No places found',
                          style: GoogleFonts.poppins(color: AppTheme.grey),
                        ),
                      ],
                    ),
                  ),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _places.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 14),
                  itemBuilder: (_, i) => _DiscoverCard(
                    place: _places[i],
                    onFav: () => _toggleFav(_places[i]),
                  ),
                ),
            ],

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      const ExplorePage(),
      _homeBody(),
      WishlistPage(onGoHome: () => setState(() => _tab = 1)),
      const TripPage(),
      const ProfilePage(),
    ];

    return Scaffold(
      backgroundColor: AppTheme.lightBg,
      body: IndexedStack(index: _tab, children: pages),
      bottomNavigationBar: _BottomNav(
        current: _tab,
        onTap: (i) => setState(() => _tab = i),
      ),
    );
  }
}

// ── Bottom Nav ─────────────────────────────────────────────
class _BottomNav extends StatelessWidget {
  final int current;
  final Function(int) onTap;
  const _BottomNav({required this.current, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        'icon': Icons.explore_outlined,
        'active': Icons.explore,
        'label': 'Explore',
      },
      {'icon': Icons.home_outlined, 'active': Icons.home, 'label': 'Home'},
      {
        'icon': Icons.favorite_border,
        'active': Icons.favorite,
        'label': 'Wishlist',
      },
      {
        'icon': Icons.card_travel_outlined,
        'active': Icons.card_travel,
        'label': 'Trip',
      },
      {
        'icon': Icons.person_outline,
        'active': Icons.person,
        'label': 'Profile',
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (i) {
              final sel = current == i;
              return GestureDetector(
                onTap: () => onTap(i),
                behavior: HitTestBehavior.opaque,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: sel
                            ? AppTheme.teal.withOpacity(0.12)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        sel
                            ? items[i]['active'] as IconData
                            : items[i]['icon'] as IconData,
                        color: sel ? AppTheme.teal : AppTheme.grey,
                        size: 24,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      items[i]['label'] as String,
                      style: GoogleFonts.poppins(
                        color: sel ? AppTheme.teal : AppTheme.grey,
                        fontSize: 10,
                        fontWeight: sel ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

// ── Featured Card (no edit/delete) ────────────────────────
class _FeaturedCard extends StatelessWidget {
  final PlaceModel place;
  final VoidCallback onFav;
  const _FeaturedCard({required this.place, required this.onFav});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => PlaceDetailPage(place: place)),
      ),
      child: Container(
        width: 210,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background image
              Image.network(
                place.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Container(color: AppTheme.tealLight),
                loadingBuilder: (ctx, child, progress) {
                  if (progress == null) return child;
                  return Container(
                    color: AppTheme.tealLight,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppTheme.teal,
                        strokeWidth: 2,
                      ),
                    ),
                  );
                },
              ),
              // Gradient overlay
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Color(0xDD000000)],
                    stops: [0.4, 1.0],
                  ),
                ),
              ),
              // Rating badge — top left
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.teal,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: Colors.white,
                        size: 12,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        place.rating.toStringAsFixed(1),
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Heart / wishlist — top right
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: onFav,
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      place.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: place.isFavorite ? Colors.red : AppTheme.teal,
                      size: 16,
                    ),
                  ),
                ),
              ),
              // Info — bottom
              Positioned(
                bottom: 14,
                left: 14,
                right: 14,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place.name,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_rounded,
                          color: AppTheme.teal,
                          size: 13,
                        ),
                        const SizedBox(width: 3),
                        Expanded(
                          child: Text(
                            '${place.location}, ${place.country}',
                            style: GoogleFonts.poppins(
                              color: Colors.white70,
                              fontSize: 11,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${place.price.toInt()}/night',
                          style: GoogleFonts.poppins(
                            color: AppTheme.teal,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            place.category,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Discover Card (no edit/delete) ────────────────────────
class _DiscoverCard extends StatelessWidget {
  final PlaceModel place;
  final VoidCallback onFav;
  const _DiscoverCard({required this.place, required this.onFav});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => PlaceDetailPage(place: place)),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Place image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                bottomLeft: Radius.circular(18),
              ),
              child: Image.network(
                place.imageUrl,
                width: 115,
                height: 120,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 115,
                  height: 120,
                  color: AppTheme.tealLight,
                  child: const Icon(
                    Icons.image_not_supported,
                    color: AppTheme.teal,
                  ),
                ),
                loadingBuilder: (ctx, child, progress) {
                  if (progress == null) return child;
                  return Container(
                    width: 115,
                    height: 120,
                    color: AppTheme.tealLight,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppTheme.teal,
                        strokeWidth: 2,
                      ),
                    ),
                  );
                },
              ),
            ),
            // Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(13),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name + heart
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            place.name,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: onFav,
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: Icon(
                              place.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              key: ValueKey(place.isFavorite),
                              color: place.isFavorite
                                  ? Colors.red
                                  : AppTheme.teal,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    // Location
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_rounded,
                          color: AppTheme.teal,
                          size: 13,
                        ),
                        const SizedBox(width: 2),
                        Expanded(
                          child: Text(
                            '${place.location}, ${place.country}',
                            style: GoogleFonts.poppins(
                              color: AppTheme.grey,
                              fontSize: 11,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    // Rating + distance
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: AppTheme.teal,
                          size: 14,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          place.rating.toStringAsFixed(1),
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          width: 3,
                          height: 3,
                          decoration: const BoxDecoration(
                            color: AppTheme.grey,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          place.distance,
                          style: GoogleFonts.poppins(
                            color: AppTheme.grey,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Price + Book Now
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${place.price.toInt()}/night',
                          style: GoogleFonts.poppins(
                            color: AppTheme.teal,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PlaceDetailPage(place: place),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.teal,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 6,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            'Book Now',
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
