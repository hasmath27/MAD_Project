import 'package:project/models/place_model.dart';

final List<PlaceModel> allPlaces = [
  PlaceModel(
    id: '1',
    name: 'Santorini Cliffs',
    location: 'Santorini',
    country: 'Greece',
    description:
        'Perched on volcanic cliffs above the deep blue Aegean Sea, Santorini is a dream destination with iconic white-washed buildings, blue-domed churches, and breathtaking sunsets that paint the sky in shades of gold and pink.',
    imageUrl:
        'https://images.unsplash.com/photo-1570077188670-e3a8d69ac5ff?w=800&q=80',
    rating: 4.9,
    price: 320,
    distance: '3.7 km',
    category: 'Beach',
    isFavorite: true,
    tags: ['Romantic', 'Scenic', 'Historic'],
  ),
  PlaceModel(
    id: '2',
    name: 'Bali Rice Terraces',
    location: 'Ubud',
    country: 'Indonesia',
    description:
        'The emerald-green rice terraces of Tegallalang cascade dramatically down the hillside, a UNESCO-recognized cultural landscape shaped by Balinese farmers for over a thousand years.',
    imageUrl:
        'https://images.unsplash.com/photo-1537953773345-d172ccf13cf1?w=800&q=80',
    rating: 4.7,
    price: 180,
    distance: '5.2 km',
    category: 'Forest',
    isFavorite: false,
    tags: ['Cultural', 'Nature', 'Spiritual'],
  ),
  PlaceModel(
    id: '3',
    name: 'Matterhorn Peak',
    location: 'Zermatt',
    country: 'Switzerland',
    description:
        'One of the highest peaks in the Alps, the Matterhorn rises 4,478 metres above sea level. Its iconic pyramid shape dominates the skyline and draws mountaineers and photographers from around the world.',
    imageUrl:
        'https://images.unsplash.com/photo-1469521669194-babb45599def?w=800&q=80',
    rating: 4.8,
    price: 450,
    distance: '9.8 km',
    category: 'Mountain',
    isFavorite: true,
    tags: ['Adventure', 'Skiing', 'Scenic'],
  ),
  PlaceModel(
    id: '4',
    name: 'Kyoto Bamboo Grove',
    location: 'Arashiyama',
    country: 'Japan',
    description:
        'Walk through a towering forest of bamboo stalks that sway gently in the breeze, creating a magical rustling sound. The Arashiyama Bamboo Grove is one of the most photographed spots in all of Japan.',
    imageUrl:
        'https://images.unsplash.com/photo-1545569341-9eb8b30979d9?w=800&q=80',
    rating: 4.6,
    price: 210,
    distance: '4.9 km',
    category: 'Forest',
    isFavorite: false,
    tags: ['Cultural', 'Peaceful', 'Nature'],
  ),
  PlaceModel(
    id: '5',
    name: 'Sahara Desert Camp',
    location: 'Merzouga',
    country: 'Morocco',
    description:
        'Experience the magic of sleeping under a canopy of a million stars in the heart of the Sahara. Ride camels over golden dunes at sunset and wake to a breathtaking desert dawn.',
    imageUrl:
        'https://images.unsplash.com/photo-1509316785289-025f5b846b35?w=800&q=80',
    rating: 4.5,
    price: 150,
    distance: '12.1 km',
    category: 'Desert',
    isFavorite: false,
    tags: ['Adventure', 'Camping', 'Unique'],
  ),
  PlaceModel(
    id: '6',
    name: 'Maldives Overwater Villa',
    location: 'North Malé Atoll',
    country: 'Maldives',
    description:
        'Wake up above the crystal-clear turquoise lagoon in a luxurious overwater bungalow. Dive into the warm Indian Ocean, snorkel alongside manta rays, and watch dolphins play at sunset.',
    imageUrl:
        'https://images.unsplash.com/photo-1573843981267-be1999ff37cd?w=800&q=80',
    rating: 5.0,
    price: 850,
    distance: '8.0 km',
    category: 'Beach',
    isFavorite: true,
    tags: ['Luxury', 'Romantic', 'Snorkeling'],
  ),
  PlaceModel(
    id: '7',
    name: 'Machu Picchu',
    location: 'Cusco Region',
    country: 'Peru',
    description:
        'The Lost City of the Incas sits dramatically on a mountain ridge above the Sacred Valley, shrouded in morning mist. This 15th-century citadel is one of the world\'s greatest archaeological sites.',
    imageUrl:
        'https://images.unsplash.com/photo-1587595431973-160d0d94add1?w=800&q=80',
    rating: 4.9,
    price: 280,
    distance: '15.3 km',
    category: 'Mountain',
    isFavorite: false,
    tags: ['Historic', 'Hiking', 'Wonder'],
  ),
  PlaceModel(
    id: '8',
    name: 'Dubai Skyline',
    location: 'Downtown Dubai',
    country: 'UAE',
    description:
        'Marvel at the futuristic skyline of Dubai, home to the world\'s tallest building, the Burj Khalifa. From rooftop pools to desert safaris, Dubai blends ancient tradition with ultra-modern luxury.',
    imageUrl:
        'https://images.unsplash.com/photo-1512453979798-5ea266f8880c?w=800&q=80',
    rating: 4.7,
    price: 380,
    distance: '6.4 km',
    category: 'City',
    isFavorite: false,
    tags: ['Luxury', 'Modern', 'Shopping'],
  ),
];

List<PlaceModel> get featuredPlaces =>
    allPlaces.where((p) => p.rating >= 4.8).toList();

List<PlaceModel> get favoritePlaces =>
    allPlaces.where((p) => p.isFavorite).toList();

List<PlaceModel> placesByCategory(String cat) => cat == 'All'
    ? allPlaces
    : allPlaces.where((p) => p.category == cat).toList();

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
