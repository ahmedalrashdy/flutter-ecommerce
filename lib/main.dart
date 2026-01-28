import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_ecommerce/core/errors/failures.dart';
import 'package:super_ecommerce/core/services/network_service.dart';
import 'package:super_ecommerce/core/theme/theme_controller.dart';
import 'core/bindings/app_binding.dart';
import 'core/constants/app_routes.dart';
import 'core/controllers/locale_controller.dart';
import 'l10n/app_localizations.dart';
import 'shared features/auth/presentation/controllers/auth_controller.dart';
import 'core/services/api_service.dart';
import 'core/services/hive_service.dart';
import 'core/services/secure_storage_service.dart';
import 'core/services/simple_cache_service.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'data/repositories/product_repository.dart';
import 'routes.dart';
import 'shared features/auth/data/repository/auth_repository.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

typedef CustomResultAsync<T> = Future<Either<Failure, T>>;
typedef CustomResult<T> = Either<Failure, T>;
void main() async {
  final Logger logger = Logger(
    printer: PrettyPrinter(
      colors: true,
      // printTime: true,
    ),
  );

  Get.put(logger, permanent: true);

  await dotenv.load(fileName: ".env");
  await Get.putAsync(() => HiveService().init(), permanent: true);
  await Get.putAsync<SimpleCacheService>(() async => SharedPreferencesService(
        sharedPreferences: await SharedPreferences.getInstance(),
      ));

  Get.put(http.Client(), permanent: true);
  Get.lazyPut<NetworkService>(() =>
      NetworkServiceImplWithICCP(internetConnection: InternetConnection()));
  Get.put<ApiService>(
      ApiServiceImpByHttp(client: Get.find(), networkService: Get.find()));
  Get.put<SecureStorageService>(SecureStorageServiceImplWithSecureStorage());
  Get.put<AuthRepository>(AuthRepositoryImp(
      secStorage: Get.find(),
      apiService: Get.find(),
      simpleCacheService: Get.find()));

  await Get.putAsync(() => AuthController().init(), permanent: true);
  Get.put<ProductRepository>(ProductRepositoryImpWithHttp(
      apiService: Get.find(), hiveService: Get.find()));

  Stripe.publishableKey = dotenv.env["STRIPE_PUBLISHABLE_KEY"]!;

  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SuperEcommerce());
}

class SuperEcommerce extends StatelessWidget {
  const SuperEcommerce({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());
    final LocaleController localeController = Get.put(LocaleController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeController.themeMode,
      theme: themeController.lightTheme,
      darkTheme: themeController.darkTheme,
      initialRoute: AppRoute.onBoarding,
      initialBinding: AppBinding(),
      getPages: routes,
      locale: localeController.appLocale,
      onGenerateTitle: (context) {
        final localizations = AppLocalizations.of(context);
        return "App Title" ?? 'Loading...';
      },
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
