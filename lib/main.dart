import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'screens/onboarding_screen.dart'; // Import OnboardingScreen

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    cameras = await availableCameras();
  } catch (e) {
    debugPrint('Gagal menginisialisasi kamera: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PILAH.IN',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF137516)),
        useMaterial3: true,
      ),
      // Set OnboardingScreen sebagai halaman awal aplikasi
      home: const OnboardingScreen(),
    );
  }
}