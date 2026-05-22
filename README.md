# Pet Shop Worker Dashboard - Flutter Version

A Flutter app for pet shop workers to manage schedules, view appointments, and manage pricing.

## Features

- **Login Screen**: Easy access to different dashboard sections
- **Schedule Screen**: View today's appointments with detailed booking information
- **Calendar Screen**: Browse appointments across different dates
- **Financial Screen**: Manage services and pricing for different pet sizes

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── providers/
│   └── app_state.dart       # State management with Provider
├── models/
│   ├── booking.dart         # Booking data model
│   └── service.dart         # Service data model
├── screens/
│   ├── app.dart             # Main app shell
│   ├── login_screen.dart    # Login/entry point
│   ├── schedule_screen.dart # Today's schedule view
│   ├── calendar_screen.dart # Calendar view
│   └── financial_screen.dart # Services & pricing
└── widgets/
    ├── header.dart          # App header with navigation
    └── booking_card.dart    # Booking detail card
```

## Getting Started

### Prerequisites

- Flutter SDK 3.0.0 or higher
- Dart SDK (comes with Flutter)

### Installation

1. **Clone the repository** (or extract the files)
   ```bash
   cd flutter_petshop_dashboard
   ```

2. **Get dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

   For web:
   ```bash
   flutter run -d chrome
   ```

## Dependencies

- **provider**: State management
- **intl**: Internationalization (Portuguese locale)
- **table_calendar**: Calendar widget
- **fl_chart**: Charts and graphs (for future financial features)
- **animations**: Smooth transitions

## Key Features Implemented

### Login Screen
- Logo display
- Navigation buttons to Schedule, Calendar, and Financial sections
- Clean UI with Portuguese language support

### Schedule Screen
- View today's bookings
- Expandable booking cards showing full details
- Status indicators (Upcoming, In Progress, Completed, Cancelled)
- Pet and owner information
- Service procedures list
- Notes/comments section

### Calendar Screen
- Monthly calendar view
- Appointment density indicators
- Selected date details
- Appointment count for each day
- Portuguese date formatting

### Financial Screen
- Service catalog with pricing for different pet sizes
- Add/remove services from total
- Real-time total calculation
- Pet size selector (Small, Medium, Large)
- Service management interface

## Architecture

### State Management
Uses Provider package for simple and efficient state management:
- `AppState` - Manages login status and current screen navigation

### Theming
- Material Design 3
- Blue color scheme matching the original design
- Responsive layout using Expanded and Flex

### Localization
- Portuguese (Brazil) date formatting using `intl` package
- All UI text in Portuguese

## Customization

### Changing Mock Data
- Bookings: Edit `lib/models/booking.dart`
- Services: Edit `lib/models/service.dart`
- Calendar data: Edit `_CalendarScreenState` in `lib/screens/calendar_screen.dart`

### Styling
- Colors: Modify `seedColor` in `lib/main.dart`
- Fonts: Add custom fonts in `pubspec.yaml` and update `fontFamily`

## Future Enhancements

- Backend integration for real appointment data
- Push notifications for upcoming appointments
- Photo gallery for pets
- Payment integration
- Analytics and reports
- Multi-user support
- Dark mode
- Appointment booking from customer side

## Building for Production

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## License

This project is a Flutter port of the original Pet Shop Dashboard React app.
