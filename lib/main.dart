import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:run_away/application/category/product_in_brand/product_in_brand_bloc.dart';
import 'package:run_away/application/home_page/all_products/all_products_bloc.dart';
import 'package:run_away/application/home_page/home_choice/brand_choice_bloc.dart';
import 'package:run_away/application/home_page/popular_picks/popular_product_bloc.dart';
import 'package:run_away/application/product_details/product_view/product_view_bloc.dart';
import 'package:run_away/application/wishlist/fav_icon/fav_icon_bloc.dart';
import 'package:run_away/application/wishlist/wishlist_products/wishlist_products_bloc.dart';
import 'package:run_away/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'application/cart/cart_button_bloc/cart_button_bloc.dart';
import 'application/cart/cart_view/cart_view_bloc.dart';
import 'application/search/search_product/seearch_product_bloc.dart';
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
        BlocProvider(create: (context) => BrandChoiceBloc()),
        BlocProvider(create: (context) => PopularProductBloc()),
        BlocProvider(create: (context) => AllProductsBloc()),
        BlocProvider(create: (context) => FavIconBloc()),
        BlocProvider(create: (context) => WishlistProductsBloc()),
        BlocProvider(create: (context) => SearchProductBloc()),
        BlocProvider(create: (context) => ProductViewBloc()),
        BlocProvider(create: (context) => ProductInBrandBloc()),
        BlocProvider(create: (context) => CartButtonBloc()),
        BlocProvider(create: (context) => CartViewBloc()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.grey,
          // useMaterial3: true,
          scaffoldBackgroundColor: Colors.grey[200],
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
