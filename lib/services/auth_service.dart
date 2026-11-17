import 'package:bcrypt/bcrypt.dart';
import '../models/user_model.dart';
import 'api_service.dart';

class AuthService {
  static UserModel? currentUser;

  static bool get isLoggedIn => currentUser != null;
  static bool get isAdmin => currentUser?.role.toLowerCase() == 'admin';

  /// Melakukan login dengan memeriksa data user dari endpoint /user
  static Future<UserModel> login(String username, String password) async {
    final users = await ApiService.getUsers();

    // Cari user berdasarkan username (case-insensitive)
    UserModel? matchedUser;
    for (var u in users) {
      if (u.username.trim().toLowerCase() == username.trim().toLowerCase()) {
        matchedUser = u;
        break;
      }
    }

    if (matchedUser == null) {
      throw Exception('Username tidak ditemukan');
    }

    // Verifikasi password (bcrypt atau direct plain-text)
    bool isPasswordValid = false;
    if (matchedUser.password == password) {
      isPasswordValid = true;
    } else {
      try {
        isPasswordValid = BCrypt.checkpw(password, matchedUser.password);
      } catch (_) {
        isPasswordValid = false;
      }
    }

    if (!isPasswordValid) {
      throw Exception('Password salah');
    }

    currentUser = matchedUser;
    return matchedUser;
  }

  /// Logout user
  static void logout() {
    currentUser = null;
  }

  /// Update profil user saat ini
  static Future<void> updateCurrentProfile({
    required String nama,
    required String username,
    String? newPassword,
  }) async {
    if (currentUser == null || currentUser!.id == null) {
      throw Exception('User belum login');
    }

    final updated = UserModel(
      id: currentUser!.id,
      nama: nama,
      username: username,
      // Jika password baru tidak diisi, pertahankan password lama
      password: (newPassword != null && newPassword.isNotEmpty)
          ? newPassword
          : currentUser!.password,
      role: currentUser!.role,
    );

    await ApiService.updateUser(currentUser!.id!, updated);
    currentUser = updated;
  }
}

