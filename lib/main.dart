import 'package:e_commerce/common/widgets/bottom_bar.dart';
import 'package:e_commerce/constants/global_variables.dart';
import 'package:e_commerce/features/auth/screens/auth_screen.dart';
import 'package:e_commerce/features/auth/services/auth_service.dart';
import 'package:e_commerce/providers/user_provider.dart';
import 'package:e_commerce/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wakelock/wakelock.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _authService.getUserData(mounted: mounted, context: context);
  }

  @override
  Widget build(BuildContext context) {
    Wakelock.enable();
    return MaterialApp(
      title: 'E-Conm',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(primary: GlobalVariables.secondaryColor),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      onGenerateRoute: (settings) => generatedRoute(settings),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? const BottomBar() 
          : const AuthScreen(),
    );
  }
}
