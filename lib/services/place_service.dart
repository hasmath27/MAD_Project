import 'package:image_picker/image_picker.dart';
import 'package:project/main.dart';
import 'package:project/models/place_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class PlaceService {
  static const String _table = 'places';
  static const String _bucket = 'place-images';

  // ── READ ALL ──────────────────────────────────────────
  static Future<List<PlaceModel>> fetchAll({String? category}) async {
    var query = supabase
        .from(_table)
        .select()
        .order('created_at', ascending: false);

    final response = await query;
    final list = (response as List).map((e) => PlaceModel.fromJson(e)).toList();

    if (category != null && category != 'All') {
      return list.where((p) => p.category == category).toList();
    }
    return list;
  }

  // ── READ ONE ──────────────────────────────────────────
  static Future<PlaceModel?> fetchById(String id) async {
    final response = await supabase.from(_table).select().eq('id', id).single();
    return PlaceModel.fromJson(response);
  }

  // ── READ FAVORITES ────────────────────────────────────
  static Future<List<PlaceModel>> fetchFavorites() async {
    final response = await supabase
        .from(_table)
        .select()
        .eq('is_favorite', true)
        .order('created_at', ascending: false);
    return (response as List).map((e) => PlaceModel.fromJson(e)).toList();
  }

  // ── SEARCH ────────────────────────────────────────────
  static Future<List<PlaceModel>> search(String query) async {
    final response = await supabase
        .from(_table)
        .select()
        .or(
          'name.ilike.%$query%,country.ilike.%$query%,location.ilike.%$query%',
        )
        .order('created_at', ascending: false);
    return (response as List).map((e) => PlaceModel.fromJson(e)).toList();
  }

  // ── CREATE ────────────────────────────────────────────
  static Future<PlaceModel> create(PlaceModel place) async {
    final response = await supabase
        .from(_table)
        .insert(place.toJson())
        .select()
        .single();
    return PlaceModel.fromJson(response);
  }

  // ── UPDATE ────────────────────────────────────────────
  static Future<PlaceModel> update(String id, Map<String, dynamic> data) async {
    final response = await supabase
        .from(_table)
        .update(data)
        .eq('id', id)
        .select()
        .single();
    return PlaceModel.fromJson(response);
  }

  // ── TOGGLE FAVORITE ───────────────────────────────────
  static Future<void> toggleFavorite(String id, bool current) async {
    await supabase.from(_table).update({'is_favorite': !current}).eq('id', id);
  }

  // ── DELETE ────────────────────────────────────────────
  static Future<void> delete(String id) async {
    await supabase.from(_table).delete().eq('id', id);
  }

  // ── UPLOAD IMAGE ──────────────────────────────────────
  static Future<String?> uploadImage(XFile imageFile) async {
    try {
      final bytes = await imageFile.readAsBytes();
      final fileExt = imageFile.path.split('.').last;
      final fileName = '${const Uuid().v4()}.$fileExt';

      await supabase.storage
          .from(_bucket)
          .uploadBinary(
            fileName,
            bytes,
            fileOptions: FileOptions(contentType: 'image/$fileExt'),
          );

      return supabase.storage.from(_bucket).getPublicUrl(fileName);
    } catch (e) {
      return null;
    }
  }
}
