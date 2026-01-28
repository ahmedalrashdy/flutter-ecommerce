# Super Ecommerce 🛍️📱
**A production-minded Flutter e-commerce app** showcasing real mobile engineering: clean feature separation, resilient networking, local persistence, and a polished checkout experience (Stripe).

<p align="center">
  <img alt="Flutter" src="https://img.shields.io/badge/Flutter-ready-02569B?logo=flutter&logoColor=white" />
  <img alt="Dart" src="https://img.shields.io/badge/Dart-^3.5.0-0175C2?logo=dart&logoColor=white" />
  <img alt="State" src="https://img.shields.io/badge/State%20Management-GetX-8A2BE2" />
  <img alt="Payments" src="https://img.shields.io/badge/Payments-Stripe-6772E5?logo=stripe&logoColor=white" />
</p>
---

## 🎬 Demo (Screenshots / GIF)
> Add real UI screenshots/GIFs for maximum impact in hiring reviews.

**Suggested structure**
```
docs/
  demo.gif
  screenshots/
    01_onboarding.png
    02_home.png
    03_product.png
    04_cart.png
    05_checkout.png
    06_orders.png
```

Then embed like:
```md
<img src="docs/screenshots/02_home.png" width="250" />
```

---

## ✅ Features
### 🧭 Product & Shopping
- Home (categories, offers carousel, product listings)
- Product details (images, pricing, interactions)
- Favorites (offline persistence using Hive)
- Cart (add/remove/update items)
- Orders (list + cancellation flow)

### 💳 Checkout
- Stripe PaymentSheet integration
- Payment intent creation via backend endpoint

### 📍 Address & Location
- Address creation flow
- Map picking (Google Maps) + Geolocator permissions

### 🔐 Authentication
- Login / Register
- OTP verification + resend
- Forgot / Reset password
- Logout + token cleanup

### ⚙️ Personalization
- Dark / Light mode (persisted)
- EN / AR localization (persisted)

---

## 🧰 Tech Stack
- **State management & navigation**: `get`
- **Networking**: `http` + `internet_connection_checker_plus`
- **Result type / error handling**: `dartz` (`Either`)
- **Local persistence**:
  - `hive_flutter` (favorites)
  - `shared_preferences` (simple settings/cache)
  - `flutter_secure_storage` (auth tokens)
- **Payments**: `flutter_stripe`
- **Maps & location**: `google_maps_flutter`, `geolocator`
- **UX polish**: `cached_network_image`, `shimmer`, `lottie`, `flutter_slidable`, `carousel_slider`
- **Localization**: `intl` + `flutter_localization` + ARB files
- **Logging**: `logger`
- **Env**: `flutter_dotenv`

---

## 🧱 Architecture
```
lib/
  core/                 # services, errors, theme, shared widgets, helpers
  data/                 # models + repositories (API + local storage)
  presentation/         # screens + GetX controllers
  shared features/      # auth + onboarding (feature-isolated)
  l10n/                 # AR/EN localizations (ARB + generated files)
  main.dart             # bootstrap + DI + app root
  routes.dart           # routes + middleware
```

### Typical flow
UI → GetX Controller → Repository → ApiService / Local Storage  
Errors: Exceptions → Failures → `Either` → UI message/snackbar

---

## 🚀 Getting Started
### 1) Prerequisites
- Flutter SDK (Dart `^3.5.0`)
- Android Studio / Xcode
- A REST backend implementing the endpoints in `lib/core/constants/api_endpoints.dart`

### 2) Install dependencies
```bash
flutter pub get
```

### 3) Configure environment variables
Create a `.env` file in the project root:
```env
STRIPE_PUBLISHABLE_KEY=pk_test_xxxxxxxxxxxxxxxxx
```

### 4) Configure API base URL
Current base URL is set inside:
`lib/core/services/api_service.dart`

```dart
static const String _baseUrl = 'http://192.168.0.5:8000/api/v1/';
```

✅ **Emulator tip:** use `http://10.0.2.2:8000/...` to hit your machine from Android emulator.  
✅ **Device tip:** use your LAN IP or domain.




---

## 🔌 Backend Contract (high-level)
Defined in: `lib/core/constants/api_endpoints.dart`



---

## 🧩 Engineering Highlights (what reviewers usually care about)
- **Connectivity-aware networking** (prevents wasted API calls while offline)
- **Centralized API error mapping** (keeps UI predictable)
- **Secure token storage** (`flutter_secure_storage`) + single-point header injection
- **Reusable async helper** (`handleCustomResultAsync`) to standardize loading/error/success paths




## 👤 Author
**Ahmed Mohammed Alrashdy**

