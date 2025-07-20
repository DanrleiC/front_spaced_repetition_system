import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:front_spaced_repetition_system/app/features/login/widget/gradient_button.widget.dart';
import 'package:front_spaced_repetition_system/app/features/menu/controller/menu.controller.dart';
import 'package:front_spaced_repetition_system/app/features/menu/widgets/logout.dart';
import 'package:front_spaced_repetition_system/app/features/menu/widgets/logout_button.dart';
import 'package:front_spaced_repetition_system/app/features/menu/widgets/menu_section.dart';
import 'package:front_spaced_repetition_system/app/features/menu/widgets/modal_edit_profile.dart';
import 'package:front_spaced_repetition_system/app/features/menu/widgets/pic_profile_img.widget.dart';
import 'package:front_spaced_repetition_system/app/features/menu/widgets/username.dart';
import 'package:front_spaced_repetition_system/app/features/user/controller/user.controller.dart';
import 'package:front_spaced_repetition_system/app/repository/provider/api_service.provider.dart';
import 'package:front_spaced_repetition_system/app/utils/colors_app.dart';

class MenuScreen extends ConsumerStatefulWidget {
  const MenuScreen({super.key});

  @override
  ConsumerState<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends ConsumerState<MenuScreen> {
  late final UserNameNotifier userNameNotifier;

    @override
  void initState() {
    super.initState();
    userNameNotifier = UserNameNotifier();
    userNameNotifier.loadUsername(ref);
  }

  @override
  void dispose() {
    userNameNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: ColorsApp.cardBackgound,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const PicProfileImgWidget(),
                  const SizedBox(height: 16),
                  UsernameDisplay(username: userNameNotifier.usernameNotifier),
                  const SizedBox(height: 16),
                  GradientButton(
                    onPressed: () async =>ModalEditProfile.showEditUsernameDialog(context: context, username: userNameNotifier.usernameNotifier),
                    text: 'Editar Perfil',
                  )
                ],
              ),
            ),
            const SizedBox(height: 24),
            buildSection(),
            const SizedBox(height: 24),
            LogoutButton(
              onLogout: () => LogoutDialog(),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget buildSection() {
    return MenuSectionBuilder.buildMenuSection(
      title: 'Suporte',
      items: [
      MenuSectionBuilder.buildMenuItem(
        icon: FontAwesomeIcons.circleQuestion,
        title: 'Ajuda',
        onTap: () {},
      ),
      MenuSectionBuilder.buildMenuItem(
        icon: FontAwesomeIcons.envelope,
        title: 'Contato',
        onTap: () {},
      ),
      MenuSectionBuilder.buildMenuItem(
        icon: FontAwesomeIcons.star,
        title: 'Avaliar App',
        onTap: () {},
      ),
    ]);
  }
}