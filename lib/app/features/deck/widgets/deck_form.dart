import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:front_spaced_repetition_system/app/utils/colors_app.dart';

class DeckForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController descriptionController;

  const DeckForm({
    super.key, 
    required this.formKey,
    required this.nameController,
    required this.descriptionController,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Nome',
              labelStyle: TextStyle(color: ColorsApp.freedom),
              border: const OutlineInputBorder(),
              prefixIcon: Icon(
                FontAwesomeIcons.pen,
                color: ColorsApp.freedom,
                size: 16,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira um nome';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: descriptionController,
            decoration: InputDecoration(
              labelText: 'Descrição',
              labelStyle: TextStyle(color: ColorsApp.freedom),
              border: const OutlineInputBorder(),
              prefixIcon: Icon(
                FontAwesomeIcons.solidFileLines,
                color: ColorsApp.freedom,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}