import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:front_spaced_repetition_system/app/utils/colors_app.dart';

class MenuSectionBuilder {
  static Widget buildMenuSection({required String title, required  List<Widget> items}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorsApp.cardBackgound,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            child: Text(
              title,
              style: const TextStyle(
                color: ColorsApp.labelField,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ...items,
        ],
      ),
    );
  }

  static Widget buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: ColorsApp.labelField,
        size: 20,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: ColorsApp.freedom,
          fontSize: 16,
        ),
      ),
      trailing: const Icon(
        FontAwesomeIcons.chevronRight,
        color: ColorsApp.labelField,
        size: 16,
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
    );
  }
}
