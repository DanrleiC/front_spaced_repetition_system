import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:front_spaced_repetition_system/app/default_widgets/gradent_circle_icon.widget.dart';
import 'package:front_spaced_repetition_system/app/utils/colors_app.dart';
import 'package:image_picker/image_picker.dart';

class PicProfileImgWidget extends StatefulWidget {
  const PicProfileImgWidget({super.key});

  @override
  createState() => _PicProfileImgWidgetState();
}

class _PicProfileImgWidgetState extends State<PicProfileImgWidget> {
  String _selectedImagePath = '';

  void _showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: ColorsApp.cardBackgound,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: Text(
                  'Escolher Foto',
                  style: TextStyle(
                    color: ColorsApp.freedom,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            _buildListTile(
              icon: FontAwesomeIcons.photoFilm,
              label: 'Escolher da galeria',
              onTap: () {
                _pickImage(ImageSource.gallery);
                Navigator.pop(context);
              },
            ),

            _buildListTile(
              icon: FontAwesomeIcons.camera,
              label: 'Tirar uma foto',
              onTap: () {
                _pickImage(ImageSource.camera);
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: ColorsApp.freedom),
      title: Text(label, style: const TextStyle(color: ColorsApp.freedom)),
      onTap: onTap,
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _selectedImagePath = pickedFile.path;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nenhuma imagem selecionada'),
          backgroundColor: ColorsApp.cardBackgound,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => _showImagePickerOptions(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 60,
                  backgroundImage: _selectedImagePath.isEmpty
                    ? const NetworkImage('https://www.shutterstock.com/image-vector/vector-flat-illustration-grayscale-avatar-600nw-2264922221.jpg')
                    : kIsWeb
                    ? NetworkImage(_selectedImagePath) as ImageProvider<Object>?
                    : FileImage(File(_selectedImagePath)
                  ),
                ),
                GradientCircleIcon(
                  size: 30,
                  iconSize: 15,
                  assetPath: 'assets/camera.png',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}