import 'package:flutter/material.dart';
import 'login_screen.dart'; // Import LoginScreen untuk navigasi logout

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // Fungsi untuk menampilkan Dialog Konfirmasi Logout
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: const Color(0xFFFFF0F0), // Warna background dialog soft red
        title: const Text(
          'Konfirmasi Keluar',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF137516),
          ),
        ),
        content: const Text(
          'Apakah kamu yakin ingin keluar dari akun ini?',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: Colors.black87),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          // Tombol Batal / Tidak
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF66BB6A),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            onPressed: () => Navigator.pop(context), // Tutup dialog
            child: const Text(
              'Tidak',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 8),
          // Tombol Ya (Logout)
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD32F2F), // Warna merah pemicu logout
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            onPressed: () {
              Navigator.pop(context); // Tutup dialog konfirmasi
              // Navigasi & hapus seluruh riwayat stack ke LoginScreen
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false,
              );
            },
            child: const Text(
              'Ya',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            children: [
              // 1. Foto Profil & Nama
              const CircleAvatar(
                radius: 50,
                backgroundColor: Color(0xFF137516),
                child: Icon(Icons.person, size: 60, color: Colors.white),
              ),
              const SizedBox(height: 12),
              const Text(
                'Dhafin',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'dhafinuyee@gmail.com',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 24),

              // 2. Card Ringkasan Aktivitas (5 Barang, 8 Hari Aktif)
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF59D),
                        borderRadius: BorderRadius.circular(16),
                      ),
                     child: const Column(
                        children: [
                          Text(
                            '5',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF137516),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Barang dipilah',
                            style: TextStyle(fontSize: 12, color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF59D),
                        borderRadius: BorderRadius.circular(16),
                      ),
              child: const Column(
                        children: [
                          Text(
                            '8',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF137516),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Hari aktif',
                            style: TextStyle(fontSize: 12, color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // 3. Opsi Menu Profil
              _buildProfileTile(
                icon: Icons.favorite,
                iconColor: Colors.green,
                title: 'Koleksi Favorite',
                onTap: () {},
              ),
              _buildProfileTile(
                icon: Icons.notifications,
                iconColor: Colors.green,
                title: 'Notifikasi',
                onTap: () {},
              ),
              _buildProfileTile(
                icon: Icons.help_outline,
                iconColor: Colors.green,
                title: 'Tentang PILAH.IN',
                onTap: () {},
              ),
              const Divider(height: 32, thickness: 1),

              // 4. Tombol Logout / Keluar (Ditambahkan)
              _buildProfileTile(
                icon: Icons.logout,
                iconColor: const Color(0xFFD32F2F),
                title: 'Keluar',
                titleColor: const Color(0xFFD32F2F),
                onTap: () => _showLogoutDialog(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Widget Item List Menu Profil
  Widget _buildProfileTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    Color titleColor = Colors.black87,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: iconColor),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: titleColor,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }
}