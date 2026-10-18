import 'package:flutter/material.dart';
import 'camera_screen.dart';
import 'quiz_screen.dart';
import 'search_screen.dart';
import 'statistic_screen.dart';
import 'history_screen.dart';
import 'profile_screen.dart';
import 'category_detail_screen.dart';
import 'map_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Halaman untuk Bottom Navigation Bar
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      _buildHomeContent(),
      const SearchScreen(),
      const StatisticScreen(),
      const HistoryScreen(),
      const ProfileScreen(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF137516),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
        unselectedLabelStyle: const TextStyle(fontSize: 11),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Cari',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistik',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  // Tampilan Utama Tab Home
  Widget _buildHomeContent() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Header Pengguna & Avatar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
             const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Halo, Dhafin',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Mau pilah apa hari ini ?',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = 4; // Pindah ke tab Profil
                    });
                  },
                  child: const CircleAvatar(
                    radius: 22,
                    backgroundColor: Color(0xFF137516),
                    child: Icon(Icons.person, color: Colors.white, size: 26),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 2. Search Bar Ringkas
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = 1; // Pindah ke tab Cari
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF4CAF50), width: 1.5),
                ),
               child: const Row(
                  children: [
                    Icon(Icons.search, color: Color(0xFF4CAF50), size: 22),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Cari barang...',
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                    ),
                    Icon(Icons.qr_code_scanner, color: Color(0xFF4CAF50), size: 20),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 3. Banner Peta Bank Sampah Terdekat
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MapScreen()),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFF81C784)),
                ),
              child: const Row(
                  children: [
                    Icon(Icons.location_on, color: Color(0xFF137516), size: 28),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Lokasi Bank Sampah',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF137516),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Temukan TPS3R & bank sampah terdekat di sekitarmu',
                            style: TextStyle(fontSize: 11, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF137516)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 4. Banner Scanner Kamera Live
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CameraScreen()),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Color(0xFF4CAF50),
                        size: 26,
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Kenali dengan kamera',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Temukan cara mengelola barang dengan mudah',
                            style: TextStyle(fontSize: 11, color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),

            // 5. Banner Kuis PILAH.IN
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF59D),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF137516),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.help, color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kuis PILAH.IN 🎯',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF137516),
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Uji keahlianmu memilah sampah!',
                          style: TextStyle(fontSize: 11, color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF137516),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const QuizScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Mulai',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 6. Section Kategori Sampah
            const Text(
              'Kategori',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),

            // Grid Kategori (6 Kotak Hijau Muda)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFA5D6A7),
                borderRadius: BorderRadius.circular(20),
              ),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.9,
                children: [
                  _buildCategoryCard(
                    context,
                    title: 'Plastik',
                    iconPath: 'assets/images/asetpage_plastik.png',
                    description: 'Sampah berbahan plastik dengan jenis material dan tingkat daur ulang yang berbeda',
                    definitionText: 'Sampah plastik adalah limbah yang berasal dari bahan sintetis berbasis minyak bumi. Plastik memiliki sifat yang kuat, ringan, tahan air, dan mudah dibentuk, namun membutuhkan waktu sangat lama untuk terurai secara alami.',
                    managementSteps: [
                      'Pastikan dalam keadaan bersih dan kering.',
                      'Pisahkan berdasarkan jenis material jika diketahui, misalnya PET, PP, HDPE.',
                      'Kumpulkan dan simpan di tempat yang sesuai.',
                      'Setorkan ke bank sampah, pengepul, atau fasilitas daur ulang yang menerima plastik.'
                    ],
                    examples: ['Botol Plastik', 'Gelas Plastik', 'Kantong Plastik', 'Sedotan', 'Toples Plastik'],
                  ),
                  _buildCategoryCard(
                    context,
                    title: 'Kertas',
                    iconPath: 'assets/images/asetpage_kertas.png',
                    description: 'Sampah kertas merupakan limbah berbahan dasar serat selulosa dan dapat didaur ulang',
                    definitionText: 'Sampah kertas adalah barang bekas berbahan kertas atau karton yang sudah tidak digunakan, seperti koran, kardus, dan kertas tulis.',
                    managementSteps: [
                      'Pastikan dalam keadaan bersih dan kering.',
                      'Pisahkan kertas dari sampah organik dan bahan lainnya.',
                      'Lipat kertas agar lebih mudah disimpan.',
                      'Setorkan ke bank sampah atau fasilitas daur ulang.'
                    ],
                    examples: ['Kertas HVS', 'Koran Bekas', 'Kardus', 'Majalah Bekas', 'Karton'],
                  ),
                  _buildCategoryCard(
                    context,
                    title: 'Organik',
                    iconPath: 'assets/images/asetpage_organik.png',
                    description: 'Sampah organik merupakan limbah yang berasal dari makhluk hidup yang dapat terurai secara alami',
                    definitionText: 'Sampah organik adalah sampah yang berasal dari bahan alami, baik dari tumbuhan maupun hewan. Sampah ini dapat diolah menjadi kompos.',
                    managementSteps: [
                      'Pisahkan sampah organik dari sampah lainnya.',
                      'Tiriskan sisa makanan agar tidak terlalu basah.',
                      'Kumpulkan sampah organik dalam wadah khusus.',
                      'Olah menjadi kompos.'
                    ],
                    examples: ['Sisa Makanan', 'Kulit Buah', 'Daun Kering', 'Cangkang Telur', 'Ampas Kopi'],
                  ),
                  _buildCategoryCard(
                    context,
                    title: 'Kimia',
                    iconPath: 'assets/images/asetpage_kimia.png',
                    description: 'Sampah kimia merupakan sisa bahan yang mengandung zat kimia dan memerlukan penanganan khusus',
                    definitionText: 'Sampah kimia adalah sisa bahan yang mengandung zat kimia tertentu yang dapat bersifat berbahaya bagi lingkungan.',
                    managementSteps: [
                      'Kenali jenis bahan dan baca label peringatan.',
                      'Jangan mencampur bahan kimia yang berbeda.',
                      'Simpan dalam wadah aslinya yang tertutup rapat.',
                      'Serahkan kepada pengelola limbah B3.'
                    ],
                    examples: ['Sisa cat', 'Cairan pestisida', 'Pelarut kimia', 'Cairan pembersih', 'Baterai bekas'],
                  ),
                  _buildCategoryCard(
                    context,
                    title: 'Kaca',
                    iconPath: 'assets/images/asetpage_kaca.png',
                    description: 'Sampah kaca merupakan limbah berbahan kaca yang perlu ditangani dengan aman',
                    definitionText: 'Sampah kaca adalah barang berbahan kaca yang sudah tidak digunakan dan perlu ditangani dengan hati-hati agar tidak melukai.',
                    managementSteps: [
                      'Pisahkan sampah kaca dari jenis sampah lainnya.',
                      'Pastikan botol kaca atau stoples sudah kosong.',
                      'Bungkus pecahan kaca dengan bahan yang kuat.',
                      'Setorkan ke tempat pendaur ulang kaca.'
                    ],
                    examples: ['Botol Kaca', 'Stoples Kaca', 'Gelas Kaca', 'Pecahan Kaca', 'Bohlam Lampu'],
                  ),
                  _buildCategoryCard(
                    context,
                    title: 'Khusus',
                    iconPath: 'assets/images/asetpage_logam.png',
                    description: 'Sampah khusus/B3 yang memerlukan penanganan khusus agar tidak merusak lingkungan',
                    definitionText: 'Sampah khusus mencakup limbah elektronika, bahan medis, serta limbah berbahaya yang mengandung zat beracun.',
                    managementSteps: [
                      'Pisahkan dari sampah biasa.',
                      'Jangan dibongkar atau dirusak sendiri.',
                      'Simpan di tempat kering dan tertutup.',
                      'Serahkan ke drop box B3 atau bank sampah khusus.'
                    ],
                    examples: ['Lampu TL', 'Aki Bekas', 'Baterai HP', 'Termometer Air Raksa', 'Obat Kadaluarsa'],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 7. Barang yang sering dicari
            const Text(
              'Barang yang sering dicari',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                _buildQuickFindCard(
                  context,
                  title: 'Plastik',
                  iconPath: 'assets/images/icon_botolplastik.png',
                ),
                const SizedBox(width: 10),
                _buildQuickFindCard(
                  context,
                  title: 'Kertas',
                  iconPath: 'assets/images/icon_kardus.png',
                ),
                const SizedBox(width: 10),
                _buildQuickFindCard(
                  context,
                  title: 'Organik',
                  iconPath: 'assets/images/icon_daun.png',
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // Helper Widget Item Kartu Kategori Grid
  Widget _buildCategoryCard(
    BuildContext context, {
    required String title,
    required String iconPath,
    required String description,
    required String definitionText,
    required List<String> managementSteps,
    required List<String> examples,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryDetailScreen(
              title: 'Sampah $title',
              description: description,
              imagePath: iconPath,
              definitionText: definitionText,
              managementSteps: managementSteps,
              examples: examples,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              height: 42,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.recycling, size: 36, color: Color(0xFF137516)),
            ),
            const SizedBox(height: 6),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFF137516),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper Widget Item Barang yang Sering Dicari
  Widget _buildQuickFindCard(BuildContext context, {required String title, required String iconPath}) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedIndex = 1; // Buka tab pencarian
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF59D),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Image.asset(
                iconPath,
                height: 36,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.inventory_2_outlined, size: 32, color: Color(0xFF137516)),
              ),
              const SizedBox(height: 6),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF137516),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}