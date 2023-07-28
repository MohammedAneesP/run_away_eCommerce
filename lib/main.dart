import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:run_away/application/home_page/all_products/all_products_bloc.dart';
import 'package:run_away/application/home_page/home_choice/brand_choice_bloc.dart';
import 'package:run_away/application/home_page/popular_picks/popular_product_bloc.dart';
import 'package:run_away/core/color_constants/colors.dart';
import 'package:run_away/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'presentation/Screens/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

int? isViewed;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
  SharedPreferences pref = await SharedPreferences.getInstance();

  isViewed = pref.getInt("OnBoard");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BrandChoiceBloc(),
        ),
        BlocProvider(
          create: (context) => PopularProductBloc(),
          child: Container(),
        ),
        BlocProvider(
          create: (context) => AllProductsBloc(),
          child: Container(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.grey,
          //  useMaterial3: true,
          scaffoldBackgroundColor: Colors.grey[200],
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
