import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mp_payment_client/presentation/main/screens/main_screen.dart';
import 'package:mp_payment_client/utils/colors/custom_colors.dart';

void main() async{
  await GetStorage.init('mp_payment');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        textSelectionTheme: const TextSelectionThemeData(
        cursorColor: CustomColors.mainColor,
        selectionColor: CustomColors.tertiaryColor,
        selectionHandleColor: CustomColors.secundaryColor,
      )
      ),
      home: MainScreen()
    );
  }
}