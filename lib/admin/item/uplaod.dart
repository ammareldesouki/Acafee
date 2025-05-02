import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';



class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  File? _image;

  final ImagePicker _picker = ImagePicker();

  // لرفع الصورة من المعرض أو الكاميرا
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery); // أو ImageSource.camera

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      // حفظ الصورة في مجلد التطبيق (ولكن ليس في assets)
      _saveImage(pickedFile);
    }
  }

  // حفظ الصورة في مجلد معين داخل جهاز المستخدم (غير مرتبط بـ assets)
  Future<void> _saveImage(XFile pickedFile) async {
    // الحصول على المسار المناسب لتخزين الصور
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/images/drinks/';
    final imagePath = Directory(path);

    if (!await imagePath.exists()) {
      imagePath.create(recursive: true); // إنشاء المجلد إذا لم يكن موجودًا
    }

    final fileName = pickedFile.name;
    final newFile = await File(pickedFile.path).copy('$path$fileName');
    print("تم حفظ الصورة في: ${newFile.path}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('رفع صورة')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image != null
                ? Image.file(_image!, width: 200, height: 200)
                : const Text('لم يتم اختيار صورة بعد'),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('اختيار صورة'),
            ),
          ],
        ),
      ),
    );
  }
}
