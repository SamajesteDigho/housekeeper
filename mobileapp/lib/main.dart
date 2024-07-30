import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:housekeeper/brain/helpers/dependencies.dart';
import 'package:housekeeper/brain/routes/names.dart';
import 'package:housekeeper/brain/routes/pages.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: GetMaterialApp(
          title: 'HOUSEKEEPER',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
            useMaterial3: true,
          ),
          initialRoute: AppRoutes.initial,
          getPages: AppPages.pages,
        ),
      ),
    );
  }
}

class AppState extends ChangeNotifier {}
