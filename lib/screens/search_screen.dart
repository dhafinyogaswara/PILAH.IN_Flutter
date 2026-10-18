import 'package:flutter/material.dart';
import 'category_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  // Data barang yang bisa dicari beserta detail kategorinya
  final List<Map<String, dynamic>> _allItems = [
    {
      'name': 'Botol Plastik',
      'category': 'Plastik',
      'searchIcon': 'assets/images/icon_botolplastik.png',
      'detailImage': 'assets/images/asetpage_plastik.png',
      'description': 'Sampah berbahan plastik dengan jenis material dan tingkat daur ulang yang berbeda',
      'definitionText': 'Sampah plastik adalah limbah yang berasal dari bahan sintetis berbasis minyak bumi. Plastik memiliki sifat yang kuat, ringan, tahan air, dan mudah dibentuk, namun membutuhkan waktu sangat lama untuk terurai secara alami.',
      'managementSteps': [
        'Pastikan dalam keadaan bersih dan kering.',
        'Pisahkan berdasarkan jenis material jika diketahui, misalnya PET, PP, HDPE.',
        'Kumpulkan dan simpan di tempat yang sesuai.',
        'Setorkan ke bank sampah, pengepul, atau fasilitas daur ulang yang menerima plastik.'
      ],
      'examples': ['Botol Plastik', 'Gelas Plastik', 'Kantong Plastik', 'Sedotan', 'Toples Plastik'],
    },
    {
      'name': 'Botol Kaca',
      'category': 'Kaca',
      'searchIcon': 'assets/images/icon_botolkaca.png',
      'detailImage': 'assets/images/asetpage_kaca.png',
      'description': 'Sampah kaca merupakan limbah berbahan kaca yang perlu ditangani dengan aman',
      'definitionText': 'Sampah kaca adalah barang berbahan kaca yang sudah tidak digunakan dan perlu ditangani dengan hati-hati agar tidak melukai.',
      'managementSteps': [
        'Pisahkan sampah kaca dari jenis sampah lainnya.',
        'Pastikan botol kaca atau stoples sudah kosong.',
        'Bungkus pecahan kaca dengan bahan yang kuat.',
        'Setorkan ke tempat pendaur ulang kaca.'
      ],
      'examples': ['Botol Kaca', 'Stoples Kaca', 'Gelas Kaca', 'Pecahan Kaca', 'Bohlam Lampu'],
    },
    {
      'name': 'Kardus Bekas',
      'category': 'Kertas',
      'searchIcon': 'assets/images/icon_kardus.png',
      'detailImage': 'assets/images/asetpage_kertas.png',
      'description': 'Sampah kertas merupakan limbah berbahan dasar serat selulosa dan dapat didaur ulang',
      'definitionText': 'Sampah kertas adalah barang bekas berbahan kertas atau karton yang sudah tidak digunakan, seperti koran, kardus, dan kertas tulis.',
      'managementSteps': [
        'Pastikan dalam keadaan bersih dan kering.',
        'Pisahkan kertas dari sampah organik dan bahan lainnya.',
        'Lipat kertas agar lebih mudah disimpan.',
        'Setorkan ke bank sampah atau fasilitas daur ulang.'
      ],
      'examples': ['Kertas HVS', 'Koran Bekas', 'Kardus', 'Majalah Bekas', 'Karton'],
    },
    {
      'name': 'Sisa Makanan',
      'category': 'Organik',
      'searchIcon': 'assets/images/icon_daun.png',
      'detailImage': 'assets/images/asetpage_organik.png',
      'description': 'Sampah organik merupakan limbah yang berasal dari makhluk hidup yang dapat terurai secara alami',
      'definitionText': 'Sampah organik adalah sampah yang berasal dari bahan alami, baik dari tumbuhan maupun hewan. Sampah ini dapat diolah menjadi kompos.',
      'managementSteps': [
        'Pisahkan sampah organik dari sampah lainnya.',
        'Tiriskan sisa makanan agar tidak terlalu basah.',
        'Kumpulkan sampah organik dalam wadah khusus.',
        'Olah menjadi kompos.'
      ],
      'examples': ['Sisa Makanan', 'Kulit Buah', 'Daun Kering', 'Cangkang Telur', 'Ampas Kopi'],
    },
    {
      'name': 'Baterai Bekas',
      'category': 'Kimia / Khusus',
      'searchIcon': 'assets/images/icon_sampahberbahaya.png',
      'detailImage': 'assets/images/asetpage_kimia.png',
      'description': 'Sampah kimia merupakan sisa bahan yang mengandung zat kimia dan memerlukan penanganan khusus',
      'definitionText': 'Sampah kimia adalah sisa bahan yang mengandung zat kimia tertentu yang dapat bersifat berbahaya bagi lingkungan.',
      'managementSteps': [
        'Kenali jenis bahan dan baca label peringatan.',
        'Jangan mencampur bahan kimia yang berbeda.',
        'Simpan dalam wadah aslinya yang tertutup rapat.',
        'Serahkan kepada pengelola limbah B3.'
      ],
      'examples': ['Sisa cat', 'Cairan pestisida', 'Pelarut kimia', 'Cairan pembersih', 'Baterai bekas'],
    },
  ];

  List<Map<String, dynamic>> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = _allItems;
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredItems = _allItems.where((item) {
        final name = item['name'].toString().toLowerCase();
        final category = item['category'].toString().toLowerCase();
        return name.contains(query) || category.contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF137516)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Pencarian Barang',
          style: TextStyle(
            color: Color(0xFF137516),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            children: [
              // Search Input Box
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF4CAF50), width: 1.5),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Color(0xFF4CAF50), size: 26),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          hintText: 'Cari barang (misal: botol, kardus)...',
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    if (_searchController.text.isNotEmpty)
                      IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          _searchController.clear();
                        },
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Result List
              Expanded(
                child: _filteredItems.isEmpty
                    ? const Center(
                        child: Text(
                          'Barang tidak ditemukan',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _filteredItems.length,
                        itemBuilder: (context, index) {
                          final item = _filteredItems[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: BorderSide(color: Colors.grey.shade200),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              leading: Image.asset(
                                item['searchIcon'],
                                width: 48,
                                height: 48,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(
                                  Icons.inventory_2_outlined,
                                  size: 40,
                                  color: Color(0xFF4CAF50),
                                ),
                              ),
                              title: Text(
                                item['name'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                              subtitle: Text(
                                'Kategori: ${item['category']}',
                                style: const TextStyle(
                                  color: Color(0xFF4CAF50),
                                  fontSize: 13,
                                ),
                              ),
                              trailing: const Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Colors.grey,
                              ),
                              onTap: () {
                                // Navigasi ke Detail Kategori dengan data lengkap
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CategoryDetailScreen(
                                      title: 'Sampah ${item['category']}',
                                      description: item['description'],
                                      imagePath: item['detailImage'],
                                      definitionText: item['definitionText'],
                                      managementSteps: List<String>.from(item['managementSteps']),
                                      examples: List<String>.from(item['examples']),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}