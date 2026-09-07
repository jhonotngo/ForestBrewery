# 🍺 Forest Brewery Explorer 🍺

A Flutter mobile app for exploring breweries from the Open Brewery DB API, built as a technical assessment for Forest.

## How to Run

### Prerequisites
- Flutter 3.x (tested on 3.13+)
- Dart 3.x
- iOS 12.0+ or Android API 21+
- Geolocator permissions for distance feature

### Quick Setup (Automated - Recommended) ✨

We provide a setup script that handles everything automatically:

```bash
# Clone the repository
git clone https://github.com/jhonotngo/ForestBrewery.git
cd ForestBrewery

# Run the setup script
sh flutterinit.sh
```

The script will:
- ✅ Clean the project
- ✅ Install dependencies
- ✅ Update CocoaPods (macOS/iOS)
- ✅ Generate code (DTOs, mocks)
- ✅ Analyze code
- ✅ Run tests
- ✅ Launch the app

### Manual Setup (If script fails)

If the automated script encounters issues, follow these manual steps:

```bash
# Clone the repository
git clone https://github.com/jhonotngo/ForestBrewery.git
cd forest_brewery_test

# Install dependencies
flutter pub get

# (macOS only) Update CocoaPods
cd ios
pod install
cd ..

# Generate code (DTOs, mocks)
dart run build_runner build --delete-conflicting-outputs

# Analyze code
flutter analyze

# Run tests
flutter test

# Run the app
flutter run
```

### Run Tests Specifically
```bash
# All tests
flutter test

# Bloc tests only
flutter test test/features/breweries/presentation/bloc/

# With coverage
flutter test --coverage
```

---

## What I Completed ✅

### Core Features (Requirements 1-5)

#### 1. **Brewery List Screen · Build a paginated list**
- ✅ Paginated infinite scroll (20 breweries per page)
- ✅ Displays: Name, Brewery Type, City
- ✅ Loading, Error, and Empty states
- ✅ No silent failures (all errors shown to user)

#### 2. **Brewery Detail Screen · Selecting an item should navigate to a detail screen that fetches**
- ✅ Navigate via 'go_router' when tapping an item
- ✅ Fetch brewery details from API
- ✅ Display: Name, Address, Phone, Website
- ✅ Clickable website links ('url_launcher')
- ✅ Graceful error handling

#### 3. **Architecture (Clean + Feature-First)**
```
lib/
├── core/
│   ├── di/service_locator.dart (GetIt)
│   ├── exceptions/ (typed exceptions)
│   ├── services/ (GeolocatorService)
│   └── utils/ (Constants and Haversine)
├── features/breweries/
│   ├── data/ (DTOs, repositories)
│   ├── domain/ (entities, usecases)
│   └── presentation/ (BLoC, pages, widgets)
└── main.dart
```
- ✅ Feature-first modular structure
- ✅ Repository pattern with DTO → Entity mapping
- ✅ Dependency injection (GetIt)
- ✅ No service locator calls from widgets

#### 4. **Error Handling**
- ✅ Typed exceptions (LocationException, NetworkException, ServerException)
- ✅ Bloc converts exceptions to user-facing states (BreweryListError)
- ✅ No empty catch blocks (all catch blocks do something meaningful)
- ✅ Show list without distances if location fails

#### 5. **Testing**
- ✅ **9 tests**:
  - 3 Unit tests (SearchBreweriesUseCase)
  - 3 Bloc tests (Loading → Success, Loading → Error, Loading → Empty)
  - 3 Widget tests (SearchBarWidget render, button visibility, search callback)
- ✅ Mocked repository using 'mocktail'
- ✅ 'bloc_test' for state transitions

### Bonus Features

#### ✅ **Distance Feature** (Chosen Bonus)
- Request location permission via Geolocator
- Calculate brewery distances using Haversine formula
- Sort breweries by distance (tap 'location_on' icon)
- Handle permission errors
- Display distances in list (when available)

---

## What You Intentionally Left Out ❌

### Bonus Features (Not Implemented)
1. **Map (Mapbox)**
   - Would add map view with brewery markers
   - Would allow selecting brewery by tapping marker
   - **Decision:** Complex dependency, opted for Distance (more core to app)

2. **Offline Support (Caching)**
   - Would cache last successful response
   - Would show cache on app restart
   - **Decision:** Requires SharedPreferences/Hive; prioritized working features

3. **Search with Debounce** (Partial)
   - Search functionality: ✅ YES
   - Debounce transformer: ❌ NOT YET
   - **Decision:** Search works without debounce; added to use the search API call added in the document

---

## Trade-Offs Made 🔄

### 1. **Search Without Debounce**
   - **Trade-off:** Simpler immediate search vs. fewer API calls
   - **Rationale:** User controls search via button + Enter, not typing, the debounce is a bonus

### 2. **Distance as Optional Feature**
   - **Trade-off:** Always request location permission (even if not using sort) vs. on-demand
   - **Rationale:** Simpler UX, show the distance info in main the list on start; permission only requested on app start if enabled

### 3. **Repository Pattern Strictness**
   - **Trade-off:** No caching in repository vs. fetch every time
   - **Rationale:** API is fast, caching adds complexity, offline support is a bonus

### 4. **Testing: Breadth Over Depth**
   - **Trade-off:** 9 quick tests vs. exhaustive tests
   - **Rationale:** Forest says "don't spend time on full coverage"

### 5. **UI: Functional Over Polished**
   - **Trade-off:** Simple Material design vs. custom animations/themes
   - **Rationale:** Focus on architecture and logic

---

## What You Would Improve With More Time ⏱️

### High Priority

1. **Add Debounce to Search**
   - Reduces API calls on rapid typing
   - Improves perceived performance

2. **Add GetBreweriesUseCase Test**
   - Mirror of SearchBreweriesUseCase test
   - Completes unit test coverage

### Medium Priority

3. **Implement Offline Caching**
   - Use SharedPreferences or Hive
   - Cache last successful brewery list
   - Show cache on app restart, refresh if online

4. **Add More Widget Tests**
   - BreweryTile widget
   - BreweryListPage BlocBuilder integration
   - Error state UI

5. **Polish UI**
   - Add loading skeletons
   - Animated transitions
   - Better error messages with retry buttons

### Lower Priority

6. **Implement Map Feature**
   - Integrate Mapbox SDK
   - Show brewery markers
   - Tap marker to navigate to detail

7. **Analytics & Logging**
   - Track user interactions
   - Log errors for debugging

---

## Tech Stack

| Layer | Technology |
|-------|-----------|
| State Management | Flutter BLoC 8.0 |
| Navigation | go_router 12.0 |
| HTTP | Dio 5.3 |
| Dependency Injection | GetIt 7.6 |
| Serialization | json_serializable 6.7 |
| Testing | bloc_test, mocktail |
| Location | Geolocator 9.0 |
| URL Launching | url_launcher 6.2 |

---

## Notes

- **API:** Open Brewery DB (`https://api.openbrewerydb.org/v1`)
- **No API Key Required:** Public API
- **Test Approach:** Happy path + error scenarios, not edge cases
- **Null Safety:** Enabled; proper null handling throughout
- **Linting:** Flutter recommended rules applied
