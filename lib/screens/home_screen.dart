import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _image; // Stores the uploaded image
  final picker = ImagePicker();
  String? _diagnosisResult; // Stores the fake diagnosis result

  // Function to pick image
  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _diagnosisResult = null; // Reset analysis result on new upload
      });
    }
  }

  // Function to analyze the uploaded image
  void _analyzeImage() {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please upload an image first')),
      );
      return;
    }

    // Simulated detection result
    setState(() {
      _diagnosisResult = '''
DR Detected
Severity: Moderate
Found in: Right Eye
      ''';
    });

    // Show pop-up
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Analysis Result'),
          content: Text(
            'DR Detected\nSeverity: Moderate\nFound in: Right Eye',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detection Page'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Welcome Box with Image
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(color: Colors.blueAccent.withOpacity(0.3), blurRadius: 8, spreadRadius: 2)
                ],
              ),
              child: Column(
                children: [
                  Image.asset('lib/assets/retinopathy.png', height: 80),
                  SizedBox(height: 10),
                  Text(
                    'Welcome to SeeWell!',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),

            // Upload Image Button
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: Icon(Icons.upload, size: 28),
              label: Text('Upload Retinal Image', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                backgroundColor: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 20),

            // Display uploaded image inside a box
            _image != null
                ? Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blueAccent, width: 1),
                      boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 3)],
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(_image!, height: 200, fit: BoxFit.cover),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Uploaded: Retinal Image',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  )
                : Image.asset('lib/assets/diabetes-test.png', height: 200),

            SizedBox(height: 20),

            // Analyze Image Button
            ElevatedButton.icon(
              onPressed: _analyzeImage,
              icon: Icon(Icons.search, size: 28),
              label: Text('Analyze Image for DR Detection', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                backgroundColor: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 25),

            // Display the DR detection result below the button (if available)
            if (_diagnosisResult != null)
              Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  _diagnosisResult!,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}