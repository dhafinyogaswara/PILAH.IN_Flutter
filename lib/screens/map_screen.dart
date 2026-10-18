import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Koordinat pusat peta (contoh: Bandung)
    final LatLng centerPoint = LatLng(-6.9175, 107.6191);

    // Daftar lokasi bank sampah
    final List<Map<String, dynamic>> bankSampahList = [
      {
        'name': 'Bank Sampah Induk Bandung',
        'location': LatLng(-6.9185, 107.6195),
        'address': 'Jl. Sadang Serang No. 12',
      },
      {
        'name': 'Bank Sampah Bersih Mandiri',
        'location': LatLng(-6.9210, 107.6250),
        'address': 'Jl. Riau No. 45',
      },
      {
        'name': 'TPS3R PILAH.IN Center',
        'location': LatLng(-6.9140, 107.6120),
        'address': 'Jl. Merdeka No. 8',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF137516)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Lokasi Bank Sampah',
          style: TextStyle(
            color: Color(0xFF137516),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: centerPoint,
          initialZoom: 13.5,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.flutter_application_1',
          ),
          MarkerLayer(
            markers: bankSampahList.map((spot) {
              return Marker(
                point: spot['location'],
                width: 50,
                height: 50,
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      builder: (context) => Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              spot['name'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF137516),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              spot['address'],
                              style: const TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF137516),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                icon: const Icon(Icons.navigation, color: Colors.white),
                                label: const Text(
                                  'Petunjuk Arah',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.location_on,
                    color: Color(0xFFD32F2F),
                    size: 40,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}