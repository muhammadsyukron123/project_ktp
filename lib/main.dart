import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:project_ktp/data/model/person_hive_model.dart';
import 'package:project_ktp/presentation/create_page.dart';

import 'data/datasource/hive_data_source.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  // Open Hive box and run the app
  // await Hive.openBox(HiveDataSource.boxName);
  await Hive.initFlutter();
  final hiveDataSource = HiveDataSource();
  await hiveDataSource.init();
  Hive.registerAdapter(PersonHiveModelAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: CreatePage(),
    );
  }
}


