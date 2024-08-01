import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        UserNameDisplay(),
        UpdateProfileButton(),
      ],
    );
  }
}

class UserNameDisplay extends StatelessWidget {
  const UserNameDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('User Name: John Doe');
  }
}

class UpdateProfileButton extends StatelessWidget {
  const UpdateProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Lógica de negocio para actualizar el perfil
        UserProfileService.updateUserProfile();
      },
      child: const Text('Update Profile'),
    );
  }
}

class UserProfileService {
  static void updateUserProfile() {
    // Código para actualizar el perfil del usuario
  }
}
