import 'package:flutter/material.dart';
import '../models/quiz_model.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _isQuizStarted = false;
  bool _isLevelSelected = false;

  // Daftar 10 Soal Kuis PILAH.IN dengan Aset Sesuai Folder Assets
  final List<Question> _questions = [
    Question(
      id: 1,
      questionText: '1. Botol air mineral bekas umumnya terbuat dari material apa?',
      imagePath: 'assets/images/asetpage_plastik.png',
      options: ['A. Kaca', 'B. Plastik PET', 'C. Logam'],
      correctAnswerIndex: 1, // B
    ),
    Question(
      id: 2,
      questionText: '2. Kulit pisang termasuk jenis sampah apa?',
      imagePath: 'assets/images/asetpage_organik.png',
      options: ['A. Organik', 'B. Logam', 'C. Kaca'],
      correctAnswerIndex: 0, // A
    ),
    Question(
      id: 3,
      questionText: '3. Apa yang sebaiknya dilakukan sebelum botol plastik bekas dikumpulkan untuk didaur ulang?',
      imagePath: 'assets/images/icon_botolplasti.png',
      options: [
        'A. Diisi tanah',
        'B. Dibakar',
        'C. Dikosongkan dan dibersihkan seperlunya'
      ],
      correctAnswerIndex: 2, // C
    ),
    Question(
      id: 4,
      questionText: '4. Manakah contoh sampah kertas?',
      imagePath: 'assets/images/asetpage_kertas.png',
      options: ['A. Kaleng minuman', 'B. Kardus bekas', 'C. Kulit jeruk'],
      correctAnswerIndex: 1, // B
    ),
    Question(
      id: 5,
      questionText: '5. Pecahan kaca sebaiknya ditangani dengan cara apa?',
      imagePath: 'assets/images/asetpage_kaca.png',
      options: [
        'A. Dibungkus dengan aman dan diberi tanda',
        'B. Dicampur begitu saja dengan sampah lain',
        'C. Dipegang langsung'
      ],
      correctAnswerIndex: 0, // A
    ),
    Question(
      id: 6,
      questionText: '6. Baterai bekas sebaiknya dibuang ke mana?',
      imagePath: 'assets/images/icon_sampahberbahaya.png',
      options: [
        'A. Tempat sampah organik',
        'B. Tempat sampah kertas',
        'C. Tempat pengumpulan limbah khusus'
      ],
      correctAnswerIndex: 2, // C
    ),
    Question(
      id: 7,
      questionText: '7. Manakah tindakan terbaik untuk pakaian layak pakai yang sudah tidak digunakan?',
      imagePath: 'assets/images/iconpendukung.png',
      options: [
        'A. Langsung dibakar',
        'B. Didonasikan kepada orang yang membutuhkan',
        'C. Dibuang ke sungai'
      ],
      correctAnswerIndex: 1, // B
    ),
    Question(
      id: 8,
      questionText: '8. Kaleng minuman bekas umumnya termasuk sampah jenis apa?',
      imagePath: 'assets/images/asetpage_logam.png',
      options: ['A. Logam', 'B. Organik', 'C. Kertas'],
      correctAnswerIndex: 0, // A
    ),
    Question(
      id: 9,
      questionText: '9. Apa yang sebaiknya dilakukan terhadap sisa makanan yang masih aman dan layak dikonsumsi?',
      imagePath: 'assets/images/icon_daun.png',
      options: [
        'A. Langsung dibuang',
        'B. Dicampur dengan baterai bekas',
        'C. Dimanfaatkan atau dibagikan agar tidak terbuang'
      ],
      correctAnswerIndex: 2, // C
    ),
    Question(
      id: 10,
      questionText: '10. Mengapa kita perlu memilah sampah sebelum membuangnya?',
      imagePath: 'assets/images/logo_pilahin.png',
      options: [
        'A. Agar semua sampah tercampur',
        'B. Agar sampah lebih mudah dikelola dan didaur ulang',
        'C. Agar sampah semakin banyak'
      ],
      correctAnswerIndex: 1, // B
    ),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showWelcomeDialog();
    });
  }

  // 1. Pop-up Welcome Screen (icon_openingkuis.png)
  void _showWelcomeDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFF137516), width: 1.5),
                  ),
                  child: const Icon(Icons.close, color: Color(0xFF137516), size: 18),
                ),
              ),
            ),
            const Text(
              'Selamat Datang di Kuis PILAH.IN',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF137516),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Yuk uji pengetahuanmu tentang cara memilah dan menangani barang yang sudah tidak terpakai. Kenali jenisnya, pilah dengan tepat, dan tentukan tindakan yang sesuai!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.black54, height: 1.3),
            ),
            const SizedBox(height: 16),
            Image.asset(
              'assets/images/icon_openingkuis.png',
              height: 130,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.quiz,
                size: 80,
                color: Color(0xFF137516),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF137516),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    _isQuizStarted = true;
                  });
                },
                child: const Text(
                  'Mulai',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 2. Dialog Konfirmasi Keluar Kuis
  void _showExitDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: const Color(0xFFFFF0F0),
        title: const Text(
          'Apakah anda yakin untuk keluar dari kuis?',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            color: Color(0xFF137516),
            fontWeight: FontWeight.bold,
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF66BB6A),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Ya', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF137516),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text('Tidak', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  // 3. Dialog Jawaban Benar (icon_jawabanbenar.png)
  void _showCorrectAnswerDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/icon_jawabanbenar.png',
              height: 100,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.check_circle, color: Colors.green, size: 60),
            ),
            const SizedBox(height: 12),
            const Text(
              'Hore, Jawabanmu Benar!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF137516),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF137516),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  _nextQuestion();
                },
                child: const Text('Lanjut', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 4. Dialog Jawaban Salah (icon_jawabansalah.png)
  void _showWrongAnswerDialog(String correctAnswerText) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/icon_jawabansalah.png',
              height: 100,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.cancel, color: Colors.red, size: 60),
            ),
            const SizedBox(height: 12),
            const Text(
              'Waduh, Jawaban Kamu Kurang Tepat!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFFD32F2F),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Jawaban yang benar adalah:\n$correctAnswerText',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13, color: Colors.black87),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF137516),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  _nextQuestion();
                },
                child: const Text('Lanjut', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _answerQuestion(int selectedIndex) {
    final currentQ = _questions[_currentQuestionIndex];
    if (selectedIndex == currentQ.correctAnswerIndex) {
      _score += 10;
      _showCorrectAnswerDialog();
    } else {
      _showWrongAnswerDialog(currentQ.options[currentQ.correctAnswerIndex]);
    }
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      _showResultScreen();
    }
  }

  // 5. Pop-up Hasil Kuis Selesai (icon_kuisselesai.png)
  void _showResultScreen() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/icon_kuisselesai.png',
              height: 110,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.emoji_events, color: Colors.amber, size: 70),
            ),
            const SizedBox(height: 12),
            const Text(
              'Hore, Kamu Sudah Menyelesaikan Kuis Ini',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF137516),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF137516), width: 6),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$_score',
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFFFFA726),
                    ),
                  ),
                  const Text(
                    'Skor Sementara',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF137516),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF137516),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text('Selesai', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_isQuizStarted) {
      return const Scaffold(backgroundColor: Colors.white);
    }

    // Tampilan Screen 2: Pilih Level Kuis
    if (!_isLevelSelected) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.close, color: Color(0xFF137516)),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Pilih Level Kuis',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF137516),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Selesaikan level secara berurutan untuk melatih keahlianmu memilah sampah!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                  const SizedBox(height: 36),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        bool isUnlocked = index == 0;
                        return GestureDetector(
                          onTap: isUnlocked
                              ? () {
                                  setState(() {
                                    _isLevelSelected = true;
                                  });
                                }
                              : null,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            width: 75,
                            height: 75,
                            decoration: BoxDecoration(
                              color: isUnlocked
                                  ? const Color(0xFF137516)
                                  : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isUnlocked
                                    ? const Color(0xFF137516)
                                    : Colors.grey.shade300,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                isUnlocked
                                    ? const Text(
                                        '1',
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Icon(Icons.lock, color: Colors.grey, size: 22),
                                const SizedBox(height: 4),
                                Text(
                                  'Level ${index + 1}',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: isUnlocked ? Colors.white : Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    // Tampilan Screen 3: Pengerjaan Soal Kuis
    final currentQ = _questions[_currentQuestionIndex];
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress Bar & Close Icon
              Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: (_currentQuestionIndex + 1) / _questions.length,
                        backgroundColor: Colors.grey.shade200,
                        color: const Color(0xFF137516),
                        minHeight: 12,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  InkWell(
                    onTap: _showExitDialog,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFF137516), width: 1.5),
                      ),
                      child: const Icon(Icons.close, color: Color(0xFF137516), size: 18),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Wadah Gambar Soal
              Container(
                height: 180,
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.asset(
                  currentQ.imagePath,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.image_not_supported,
                    size: 80,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Pertanyaan Soal
              Text(
                currentQ.questionText,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF137516),
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 12),

              // Opsi Jawaban A, B, C
              Column(
                children: currentQ.options.map((opt) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        opt,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF137516),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const Spacer(),

              // Tombol Pilihan Jawaban A / B / C
              Row(
                children: List.generate(currentQ.options.length, (index) {
                  String label = String.fromCharCode(65 + index);
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4CAF50),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 0,
                        ),
                        onPressed: () => _answerQuestion(index),
                        child: Text(
                          label,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}