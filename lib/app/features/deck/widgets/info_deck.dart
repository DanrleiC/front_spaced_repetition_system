import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:front_spaced_repetition_system/app/utils/colors_app.dart';

class InfoDeck extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController descriptionController;

  const InfoDeck({
    super.key,
    required this.nameController,
    required this.descriptionController,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: ColorsApp.cardBackgound,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _Header(),
            const SizedBox(height: 16),
            _buildTextField(
              controller: nameController,
              label: 'Nome do Deck',
              hint: 'Digite o nome do deck',
              icon: Icons.title,
            ),
            const SizedBox(height: 12),
            _buildTextField(
              controller: descriptionController,
              label: 'Descrição',
              hint: 'Descrição do deck',
              icon: Icons.description,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        errorStyle: const TextStyle(fontWeight: FontWeight.bold),
        labelText: label,
        hintText: hint,
        hintStyle: const TextStyle(color: ColorsApp.labelField),
        labelStyle: const TextStyle(color: ColorsApp.labelField),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: ColorsApp.borderField),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: ColorsApp.borderField),
        ),
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: ColorsApp.fieldBackground,
        prefixIcon: Icon(icon, color: ColorsApp.labelField),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(FontAwesomeIcons.penToSquare, size: 20, color: ColorsApp.mainMagent),
        SizedBox(width: 8),
        Text(
          'Informações do Deck',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
