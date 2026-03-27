import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/models/place_model.dart';
import 'package:project/services/place_service.dart';
import 'package:project/theme/app_theme.dart';


const _categories = ['Beach', 'Mountain', 'Forest', 'City', 'Desert'];

class AddEditPlacePage extends StatefulWidget {
  final PlaceModel? place;
  const AddEditPlacePage({Key? key, this.place}) : super(key: key);

  @override
  State<AddEditPlacePage> createState() => _AddEditPlacePageState();
}

class _AddEditPlacePageState extends State<AddEditPlacePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtr = TextEditingController();
  final _locationCtr = TextEditingController();
  final _countryCtr = TextEditingController();
  final _descCtr = TextEditingController();
  final _priceCtr = TextEditingController();
  final _distanceCtr = TextEditingController();
  final _ratingCtr = TextEditingController();
  final _imageUrlCtr = TextEditingController();
  final _tagsCtr = TextEditingController();

  String _category = 'Beach';
  bool _isFavorite = false;
  bool _saving = false;
  bool _uploadingImage = false;
  String? _previewImageUrl;

  bool get _isEdit => widget.place != null;

  @override
  void initState() {
    super.initState();
    if (_isEdit) {
      final p = widget.place!;
      _nameCtr.text = p.name;
      _locationCtr.text = p.location;
      _countryCtr.text = p.country;
      _descCtr.text = p.description;
      _priceCtr.text = p.price.toString();
      _distanceCtr.text = p.distance;
      _ratingCtr.text = p.rating.toString();
      _imageUrlCtr.text = p.imageUrl;
      _tagsCtr.text = p.tags.join(', ');
      _category = p.category;
      _isFavorite = p.isFavorite;
      _previewImageUrl = p.imageUrl;
    }
  }

  @override
  void dispose() {
    _nameCtr.dispose();
    _locationCtr.dispose();
    _countryCtr.dispose();
    _descCtr.dispose();
    _priceCtr.dispose();
    _distanceCtr.dispose();
    _ratingCtr.dispose();
    _imageUrlCtr.dispose();
    _tagsCtr.dispose();
    super.dispose();
  }

  Future<void> _pickAndUploadImage() async {
    final picker = ImagePicker();
    final img = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (img == null) return;

    setState(() => _uploadingImage = true);
    try {
      final url = await PlaceService.uploadImage(img);
      if (url != null) {
        _imageUrlCtr.text = url;
        setState(() => _previewImageUrl = url);
      } else {
        _showError('Image upload failed');
      }
    } finally {
      setState(() => _uploadingImage = false);
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: GoogleFonts.poppins()),
        backgroundColor: Colors.red.shade400,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    if (_imageUrlCtr.text.trim().isEmpty) {
      _showError('Please add an image URL or upload an image');
      return;
    }

    setState(() => _saving = true);
    try {
      final tags = _tagsCtr.text
          .split(',')
          .map((t) => t.trim())
          .where((t) => t.isNotEmpty)
          .toList();

      final data = {
        'name': _nameCtr.text.trim(),
        'location': _locationCtr.text.trim(),
        'country': _countryCtr.text.trim(),
        'description': _descCtr.text.trim(),
        'image_url': _imageUrlCtr.text.trim(),
        'rating': double.tryParse(_ratingCtr.text) ?? 4.0,
        'price': double.tryParse(_priceCtr.text) ?? 0.0,
        'distance': _distanceCtr.text.trim(),
        'category': _category,
        'tags': tags,
        'is_favorite': _isFavorite,
      };

      if (_isEdit) {
        await PlaceService.update(widget.place!.id, data);
      } else {
        await PlaceService.create(
          PlaceModel(
            id: '',
            name: data['name'] as String,
            location: data['location'] as String,
            country: data['country'] as String,
            description: data['description'] as String,
            imageUrl: data['image_url'] as String,
            rating: data['rating'] as double,
            price: data['price'] as double,
            distance: data['distance'] as String,
            category: data['category'] as String,
            tags: data['tags'] as List<String>,
            isFavorite: data['is_favorite'] as bool,
          ),
        );
      }

      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      _showError('Error: $e');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightBg,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 8),
              ],
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppTheme.dark,
              size: 18,
            ),
          ),
        ),
        title: Text(
          _isEdit ? 'Edit Place' : 'Add New Place',
          style: GoogleFonts.playfairDisplay(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: AppTheme.dark,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: _saving ? null : _save,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: _saving ? AppTheme.grey : AppTheme.teal,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: _saving
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        'Save',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),
          children: [
            // Image preview / upload
            GestureDetector(
              onTap: _pickAndUploadImage,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: AppTheme.tealLight,
                  borderRadius: BorderRadius.circular(20),
                  image: _previewImageUrl != null
                      ? DecorationImage(
                          image: NetworkImage(_previewImageUrl!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: _uploadingImage
                    ? const Center(
                        child: CircularProgressIndicator(color: AppTheme.teal),
                      )
                    : _previewImageUrl == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.add_photo_alternate_rounded,
                            color: AppTheme.teal,
                            size: 48,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Tap to upload image',
                            style: GoogleFonts.poppins(
                              color: AppTheme.teal,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      )
                    : Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          margin: const EdgeInsets.all(12),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.edit_rounded,
                            color: AppTheme.teal,
                            size: 18,
                          ),
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 12),

            // OR paste URL
            _field(
              _imageUrlCtr,
              'Image URL (or upload above)',
              Icons.link_rounded,
              onChanged: (v) => setState(
                () => _previewImageUrl = v.trim().isEmpty ? null : v.trim(),
              ),
              required: false,
            ),

            const SizedBox(height: 20),
            _sectionLabel('Basic Info'),
            _field(_nameCtr, 'Place Name', Icons.place_rounded),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: _field(
                    _locationCtr,
                    'City',
                    Icons.location_city_rounded,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _field(_countryCtr, 'Country', Icons.flag_rounded),
                ),
              ],
            ),
            const SizedBox(height: 14),
            _field(
              _descCtr,
              'Description',
              Icons.description_rounded,
              maxLines: 3,
            ),

            const SizedBox(height: 20),
            _sectionLabel('Details'),
            Row(
              children: [
                Expanded(
                  child: _field(
                    _priceCtr,
                    'Price/night (\$)',
                    Icons.attach_money_rounded,
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _field(
                    _ratingCtr,
                    'Rating (0-5)',
                    Icons.star_rounded,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            _field(
              _distanceCtr,
              'Distance (e.g. 3.7 km)',
              Icons.near_me_rounded,
            ),
            const SizedBox(height: 14),
            _field(
              _tagsCtr,
              'Tags (comma separated)',
              Icons.label_rounded,
              required: false,
            ),

            const SizedBox(height: 20),
            _sectionLabel('Category'),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: _categories.map((cat) {
                final sel = _category == cat;
                return GestureDetector(
                  onTap: () => setState(() => _category = cat),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 9,
                    ),
                    decoration: BoxDecoration(
                      color: sel ? AppTheme.teal : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: sel ? AppTheme.teal : Colors.grey.shade200,
                      ),
                      boxShadow: sel
                          ? [
                              BoxShadow(
                                color: AppTheme.teal.withOpacity(0.3),
                                blurRadius: 8,
                              ),
                            ]
                          : [],
                    ),
                    child: Text(
                      cat,
                      style: GoogleFonts.poppins(
                        color: sel ? Colors.white : AppTheme.grey,
                        fontWeight: sel ? FontWeight.w600 : FontWeight.normal,
                        fontSize: 13,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            // Favorite toggle
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.favorite_rounded,
                    color: Colors.red,
                    size: 22,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Mark as Favorite',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Switch(
                    value: _isFavorite,
                    onChanged: (v) => setState(() => _isFavorite = v),
                    activeColor: AppTheme.teal,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Save button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saving ? null : _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.teal,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: _saving
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.5,
                        ),
                      )
                    : Text(
                        _isEdit ? 'Update Place' : 'Add Place',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(String label) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Text(
      label,
      style: GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        fontSize: 15,
        color: AppTheme.dark,
      ),
    ),
  );

  Widget _field(
    TextEditingController ctr,
    String hint,
    IconData icon, {
    int maxLines = 1,
    TextInputType? keyboardType,
    bool required = true,
    Function(String)? onChanged,
  }) {
    return TextFormField(
      controller: ctr,
      maxLines: maxLines,
      keyboardType: keyboardType,
      onChanged: onChanged,
      style: GoogleFonts.poppins(fontSize: 14),
      validator: required
          ? (v) => v == null || v.trim().isEmpty ? 'Required' : null
          : null,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.poppins(color: AppTheme.grey, fontSize: 13),
        prefixIcon: Icon(icon, color: AppTheme.teal, size: 20),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppTheme.teal, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 16,
        ),
      ),
    );
  }
}
