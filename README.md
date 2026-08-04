# Cut Count

![Cut Count Logo](assets/images/app_logo/CutCount-logo.png)

**Cut Count** is a dedicated, offline-first shop management app designed exclusively for barbers. It streamlines the daily workflow of recording cuts, tracking revenue, and analyzing monthly performance without the clutter of generic business tools.

## Why Cut Count?

Most barber shops still rely on notebooks or scattered phone notes, leading to forgotten cuts, miscalculated earnings, and inconsistent service pricing. Cut Count solves this by providing a unified, high-performance interface focused purely on barber shop operations.

With Cut Count, a barber can instantly answer:
- How many cuts did I complete today?
- What are my total earnings for the day/month?
- Which services are the most popular?
- How is my overall business performing over time?

---

## Key Features

- **Dashboard**: A quick daily overview of total cuts, total amount, recent activity, and quick-add service tiles.
- **Dynamic Services**: Create, edit, and delete services with custom names, prices, notes, and icons.
- **Advanced History**: View detailed daily and monthly breakdowns. The history uses **true deferred (lazy) loading** via Slivers, ensuring silky-smooth 120fps scrolling even with tens of thousands of records.
- **Analytics & Profile**: Graphical performance summaries powered by interactive `fl_chart` line and bar charts. Easily update your professional profile name and subtitle.
- **Customization**: Fully supports dynamic light/dark themes and multi-currency formatting (PKR, USD, INR, GBP, EUR).
- **Robust & Safe**: Comprehensive `try-catch` exception handling on all local database calls. The app displays graceful loading indicators during async operations and never silently crashes.

---

## Technical Stack & Architecture

This project is built using modern Flutter best practices, emphasizing performance, strict typing, and clean state management.

- **Framework**: Flutter (SDK ^3.12.2)
- **State Management**: `provider` (Scoped providers for History, Services, and Settings)
- **Local Database**: `isar_community` (High-performance, offline NoSQL database for Cut Records and Services)
- **Local Storage**: `shared_preferences` (For lightweight user settings and profile data)
- **Routing**: `go_router` (Declarative, URL-based routing)
- **UI & Layout**: 
  - `CustomScrollView` and `SliverMainAxisGroup` for infinite, memory-efficient scrolling.
  - `SafeArea` and `LayoutBuilder` for pixel-perfect responsiveness across all Android/iOS screen ratios.
- **Charts**: `fl_chart` (Animated, interactive data visualization)
- **Typography**: Custom hierarchical fonts (`Unbounded`, `Poppins`, `Inter`)

---

## Project Structure

```text
lib/
  core/
    constants/        Shared padding and dimension values (AppSizes)
    layout/           Phone and tablet breakpoint helpers
    theme/            Light and dark ColorScheme configurations
    widgets/          Reusable UI widgets (AppUi, CustomListTile, ReusableTextField)
  data/
    database/         Isar database initialization and CRUD operations
    models/           Isar schemas (ServiceModel, CutRecordModel)
  features/
    onboard/          Onboarding flow
    dashboard/        Dashboard summary cards and overview layout
    services/         Services state provider and management UI
    history/          History provider, charts, and lazy-loaded history lists
    profile/          All-time graphs, stats, and profile editing
    settings/         App preferences (currency, theme)
  routes/             Named routes and GoRouter configuration
```

---

## How To Run

1. Ensure you have the **Flutter SDK** installed (version 3.12.2 or higher).
2. Clone or open the project folder.
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. If you modify any database models, regenerate the Isar boilerplate:
   ```bash
   flutter pub run build_runner build
   ```
5. Run the app:
   ```bash
   flutter run
   ```

---

## Future Roadmap

The application architecture is designed to scale gracefully. Planned features include:
- Biometric unlock (Fingerprint/FaceID)
- Cloud backup and sync
- Receipt printer integrations
- Advanced multi-staff analytics
- Voice command support (e.g., "Add fade cut")
- Data export functionality (CSV/PDF)
