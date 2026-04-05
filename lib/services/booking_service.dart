import 'package:project/main.dart';
import 'package:project/models/booking_model.dart';

class BookingService {
  static const String _table = 'bookings';

  // ── READ ALL ──────────────────────────────────────────
  static Future<List<BookingModel>> fetchAll() async {
    final response = await supabase
        .from(_table)
        .select()
        .order('created_at', ascending: false);
    return (response as List).map((e) => BookingModel.fromJson(e)).toList();
  }

  // ── CREATE ────────────────────────────────────────────
  static Future<BookingModel> create(BookingModel booking) async {
    final response =
        await supabase.from(_table).insert(booking.toJson()).select().single();
    return BookingModel.fromJson(response);
  }

  // ── UPDATE STATUS ─────────────────────────────────────
  static Future<void> updateStatus(String id, String status) async {
    await supabase.from(_table).update({'status': status}).eq('id', id);
  }

  // ── DELETE ────────────────────────────────────────────
  static Future<void> delete(String id) async {
    await supabase.from(_table).delete().eq('id', id);
  }
}
