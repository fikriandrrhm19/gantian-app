import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'controllers/auth_controller.dart';
import 'controllers/merchant_controller.dart';
import 'controllers/queue_controller.dart';
import 'services/notification_service.dart';
import 'views/home/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  ));

  await NotificationService.initialize();
  await NotificationService.requestPermission();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Timer? _globalSyncTimer;

  @override
  void dispose() {
    _globalSyncTimer?.cancel();
    super.dispose();
  }

  void _startGlobalDataSync(BuildContext context) {
    _globalSyncTimer?.cancel();
    _globalSyncTimer = Timer.periodic(const Duration(seconds: 10), (timer) async {
      final merchantCtx = context.read<MerchantController>();
      await merchantCtx.fetchMerchants();
      
      if (context.mounted) {
        context.read<QueueController>().updateQueuesFromMerchants(merchantCtx);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => MerchantController()),
        ChangeNotifierProvider(create: (_) => QueueController()),
      ],
      child: Builder(
        builder: (context) {
          _startGlobalDataSync(context);
          return MaterialApp(
            title: 'Gantian',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: const Color(0xffFAF8FF),
              primaryColor: const Color(0xff2563EB),
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xff2563EB),
                primary: const Color(0xff2563EB),
                secondary: const Color(0xff0057C2),
              ),
              fontFamily: 'Plus Jakarta Sans', 
            ),
            home: const HomeView(),
          );
        },
      ),
    );
  }
}