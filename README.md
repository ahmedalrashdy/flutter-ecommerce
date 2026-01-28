# Super Ecommerce 🛍️📱  
**Production-minded E‑Commerce app built with Flutter** — from onboarding ➜ authentication ➜ product discovery ➜ cart ➜ checkout ➜ orders ➜ profile/settings.  
This project was built as a portfolio-grade showcase of **real-world mobile engineering**: layered architecture, reliable networking & error handling, local persistence, UX polish, and scalable feature organization.

---

## ✨ What this app demonstrates (for engineers)
- **Layered structure**: `core` (shared utilities/services) + `data` (models/repositories) + `presentation` (UI/controllers) + `shared features` (auth/onboarding).
- **Robust API client** with:
  - connectivity guard (prevents pointless calls while offline),
  - centralized response parsing,
  - typed exceptions ➜ typed failures ➜ `Either<Failure, T>` results.
- **Security-minded auth flow**:
  - tokens stored in **Secure Storage**,
  - Authorization header managed in one place.
- **Fast UI**:
  - image caching + shimmer placeholders,
  - targeted widget rebuilds (GetX `GetBuilder` IDs),
  - `IndexedStack` + lazy page instantiation to keep state and avoid extra rebuilds.
- **Real mobile features**:
  - **Stripe PaymentSheet** checkout,
  - address management with **Google Maps + Geolocator** and permission handling,
  - theme + language preferences persisted locally.

> 💡 If you're reviewing this for hiring: this codebase is intentionally structured to reflect patterns used in production apps (not just “screens stitched together”).

---

## ✅ Key Features
### 🧭 User Experience
- Onboarding (shown once, then skipped automatically).
- Home with categories + offers carousel + sticky headers + nested tabs.
- Product details (gallery, pricing, UI for ratings/reviews).
- Favorites (persisted locally, instantly reflected across the app).
- Cart (quantity updates, remove items, clean UX).
- Checkout via Stripe PaymentSheet.
- Orders: active / cancelled / completed + tracking UI.
- Profile & Settings:
  - Dark/Light mode
  - Arabic / English localization

### 🔐 Authentication
- Login / Register
- OTP verification
- Forgot password + reset flow
- Logout + token cleanup

---

## 🧰 Tech Stack
**Flutter / Dart**

- **State management & navigation**: GetX (`get`)  
- **Networking**: `http` + `internet_connection_checker_plus`  
- **Functional result model**: `dartz` (`Either`)  
- **Local persistence**:
  - Hive (`hive_flutter`) for favorites
  - SharedPreferences for lightweight settings
  - Secure Storage for auth tokens
- **Payments**: `flutter_stripe`  
- **Maps & location**: `google_maps_flutter`, `geolocator`  
- **UI/UX**:
  - `cached_network_image` + `shimmer`
  - `lottie`
  - `flutter_slidable`
  - `carousel_slider`
  - `timeline_tile`
- **Localization**: ARB + `flutter_localizations` + `intl`  
- **Logging**: `logger`  
- **Env config**: `flutter_dotenv`

---

## 🧱 Architecture at a glance
```
lib/
  core/                 # services, errors, theme, shared widgets, helpers
  data/                 # models + repositories (API + local storage)
  presentation/         # screens + GetX controllers
  shared features/      # auth + onboarding (feature-isolated)
  l10n/                 # AR/EN localizations (ARB)
  main.dart             # DI bootstrapping + app root
  routes.dart           # GetX routes + middleware
assets/
  images/ fonts/ lottie/ langs/
```

### Data flow
UI (Widgets) → GetX Controllers → Repositories → ApiService / Local Storage  
Errors: HTTP → Exceptions → Failures → `Either` → UI message/snackbar

---

## 🚀 Run Locally
### 1) Prerequisites
- Flutter SDK (Dart `^3.5.0`)
- Android Studio / Xcode
- A REST backend that matches the endpoints in `lib/core/constants/api_endpoints.dart`

### 2) Install deps
```bash
flutter pub get
```

### 3) Environment file
This app loads `.env` on startup (`main.dart`). Create a file named `.env` in the project root:

```env
STRIPE_PUBLISHABLE_KEY=pk_test_xxxxxxxxxxxxxxxxx
```

### 4) API Base URL
The base URL is currently set inside:
`lib/core/services/api_service.dart`

```dart
static const String _baseUrl = 'http://10.0.2.2:8000/api/v1/';
```

- `10.0.2.2` = Android emulator loopback to your machine.
- For physical device or production, change it to your server IP/domain.

### 5) Google Maps setup
Because the app uses Google Maps:
- Add your Maps API key to:
  - `android/app/src/main/AndroidManifest.xml`
  - `ios/Runner/Info.plist`

### 6) Run
```bash
flutter run
```

---

## 🔌 Backend contract (high-level)
Endpoints are defined in: `lib/core/constants/api_endpoints.dart`  
Includes:
- Auth (login/register/otp/reset/logout)
- Categories + subcategories
- Products (best seller / recent / top rated / by category / retrieve)
- Cart (list / add / delete)
- Addresses (create / list / delete)
- Payment intent (for Stripe)
- Orders (list / cancel)

> Backend implementation is not part of this repository — the app is designed to integrate cleanly with a REST API.

---

## 🧩 Notable Engineering Highlights
- **Centralized API error mapping** (400/401/403/404/422/429/5xx handled explicitly)  
  ➜ keeps UI logic clean and consistent.
- **Connectivity-aware networking**  
  ➜ avoids “fake loading” when the device is offline.
- **Token lifecycle handling** (secure storage + API header injection)  
  ➜ realistic auth implementation.
- **Optimized UI rebuilds** (GetBuilder IDs + lazy tab/page instantiation)  
  ➜ smoother scrolling and better perceived performance.
- **Offline-first favorites** (Hive persistence + in-memory cache)  
  ➜ instant UX even before fetching again.

---

## 📦 Build
```bash
flutter build apk
flutter build ios
```

---

## 🛣️ Roadmap (nice-to-have improvements)
- Add unit/widget tests + CI workflow
- Externalize API base URL into `.env` or build flavors
- Improve demo assets (screenshots + GIFs)
- Finalize a production-ready order tracking integration (backend-driven)

---

## 📄 License
No license file included yet — add a `LICENSE` if you plan to open-source this publicly.

---

### Author
**Ahmed Mohammed Alrashdy**  
If you'd like, I can also craft a **GitHub-friendly project description**, pinned repo summary, and a short **portfolio landing section** matching this README. 🚀
