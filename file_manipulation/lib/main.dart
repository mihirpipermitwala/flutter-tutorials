import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyFileManipulationApp());
}

class MyFileManipulationApp extends StatefulWidget {
  const MyFileManipulationApp({Key? key}) : super(key: key);

  @override
  State<MyFileManipulationApp> createState() => _MyFileManipulationAppState();
}

class _MyFileManipulationAppState extends State<MyFileManipulationApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'File Manipulation Example',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('File Manipulation Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: const Text('Write and Read File with Bytes'),
                onPressed: () {
                  writeAndReadFileBytes();
                },
              ),
              ElevatedButton(
                child: const Text('Write and Read File with String'),
                onPressed: () {
                  writeAndReadFileString();
                },
              ),
              ElevatedButton(
                child: const Text('Write and Read File with Lines'),
                onPressed: () {
                  writeAndReadFileLines();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> writeToBytes(File file) async {
    List<int> bytes = [72, 101, 108, 108, 111]; // "Hello" in ASCII
    await file.writeAsBytes(bytes);
  }

  Future<void> writeToString(File file) async {
    String data = 'Hello, World!';
    await file.writeAsString(data);
  }

  Future<void> writeToLines(File file) async {
    String data = 'Hello\nWorld\nflutter';
    await file.writeAsString(data);
  }

  Future<void> writeAndReadFileBytes() async {
    await requestPermission();
    String directoryPath = await getDirectoryPath();

    File fileBytes = File('$directoryPath/exampleBytes.txt');
    await writeToBytes(fileBytes);

    //Reading A File with readAsBytes
    await readAsBytes(fileBytes);
  }

  Future<void> writeAndReadFileString() async {
    await requestPermission();
    String directoryPath = await getDirectoryPath();

    File fileString = File('$directoryPath/exampleString.txt');
    await writeToString(fileString);

    // Reading A File with readAsString
    await readAsString(fileString);
  }

  Future<void> writeAndReadFileLines() async {
    await requestPermission();
    String directoryPath = await getDirectoryPath();

    File fileLines = File('$directoryPath/exampleLines.txt');
    await writeToLines(fileLines);

    // Reading A File with readAsLines
    await readAsLines(fileLines);
  }

  Future<void> readAsLines(File file) async {
    List<String> lines = await file.readAsLines();
    for (String line in lines) {
      print(line);
    }
  }

  Future<void> readAsString(File file) async {
    String data = await file.readAsString();
    print(data);
  }

  Future<void> readAsBytes(File file) async {
    List<int> bytes = await file.readAsBytes();
    print(bytes);
  }

  Future<void> requestPermission() async {
    PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      // Permission granted
    } else if (status.isDenied) {
      // Permission denied
    } else if (status.isPermanentlyDenied) {
      // Permission permanently denied
    }
  }

  Future<String> getDirectoryPath() async {
    Directory directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
}
