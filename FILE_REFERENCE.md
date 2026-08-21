# ServiceWala — Complete Folder Structure & File Reference

> Every file in `lib/` and `assets/` explained — what it does, why it exists, and how it fits into the app.

---

## Architecture Overview

ServiceWala follows **Clean Architecture** with a **feature-first** folder layout:

```
lib/
├── main.dart              ← App entry point
├── app/                   ← App-level setup (MaterialApp, providers)
├── core/                  ← Shared code used by ALL features
│   ├── constants/         ← App-wide fixed values
│   ├── theme/             ← Colors, fonts, design tokens
│   ├── utils/             ← Helper functions
│   ├── errors/            ← Exception/failure types
│   ├── extensions/        ← Dart extension methods
│   ├── network/           ← Connectivity checks
│   ├── services/          ← 3rd-party SDK wrappers
│   ├── routing/           ← GoRouter config
│   └── widgets/           ← Reusable UI components
└── features/              ← One folder per app feature
    └── <feature>/
        ├── data/          ← API calls, JSON models, repository implementations
        ├── domain/        ← Business entities, abstract repos, use cases
        └── presentation/  ← Screens, widgets, Riverpod providers
```

Each feature's three layers:

| Layer | Folder | Purpose |
|---|---|---|
| **Data** | `data/datasources/` | Talks to Supabase / APIs |
| | `data/models/` | JSON ↔ Dart conversion (fromJson/toJson) |
| | `data/repositories/` | Implements the domain repository interface |
| **Domain** | `domain/entities/` | Pure Dart classes (no framework deps) |
| | `domain/repositories/` | Abstract interfaces (contracts) |
| | `domain/usecases/` | Single-action business logic classes |
| **Presentation** | `presentation/providers/` | Riverpod state management |
| | `presentation/screens/` | Full-page UI screens |
| | `presentation/widgets/` | Smaller UI components for this feature |

---

## Assets

| Path | Purpose |
|---|---|
| `assets/images/` | App logo, onboarding illustrations, placeholder images |
| `assets/icons/` | SVG icons for service categories (electrician, plumber, etc.) |
| `assets/fonts/` | Custom font files (Poppins or chosen font family) |
| `assets/animations/` | Lottie JSON animations (loading spinner, success, error, location) |

---

## `lib/main.dart`

The entry point. Calls `runApp()`. Initializes Supabase, wraps the app in `ProviderScope` (Riverpod), and launches `App()`.

---

## `lib/app/`

| File | Purpose |
|---|---|
| `app.dart` | The root `MaterialApp.router` widget. Sets theme, GoRouter, locale. This is what `main.dart` runs. |
| `app_providers.dart` | Top-level Riverpod providers that the entire app needs (auth state, current user, theme mode, etc.). |

---

## `lib/core/constants/`

| File | Purpose |
|---|---|
| `app_constants.dart` | App name, tagline, default city (Amritsar), default lat/lng, Supabase URL/key, Agora App ID, pagination size, timeout durations. **Single source of truth for all fixed values.** |
| `api_endpoints.dart` | Supabase table names (`users`, `bookings`, etc.), Edge Function names (`create-booking`, `generate-agora-token`), and Storage bucket names (`avatars`, `documents`). |
| `asset_paths.dart` | String constants for every asset file path (`assets/images/logo.png`, `assets/icons/electrician.svg`, etc.) so you never hardcode paths in widgets. |
| `enums.dart` | All app-wide enums: `UserRole` (customer/provider), `BookingStatus` (pending/accepted/inProgress/completed/cancelled), `ServiceCategory`, `VerificationStatus`, `CallStatus`, etc. |

---

## `lib/core/theme/`

| File | Purpose |
|---|---|
| `app_theme.dart` | Defines brand colors, `ThemeData` for light and dark modes, button styles, input decoration, card styles, bottom nav styling, spacing/radius/elevation tokens. |
| `app_text_styles.dart` | Named `TextStyle` constants: `h1`–`h4`, `bodyLarge`/`bodyMedium`/`bodySmall`, `labelLarge`/`labelMedium`, `button`, `caption`, `price`, `rating`. |

---

## `lib/core/utils/`

| File | Purpose |
|---|---|
| `validators.dart` | Input validation functions: `isValidPhone()`, `isValidEmail()`, `isValidOTP()`, `isValidName()`, `isNotEmpty()`. Used by auth forms, profile forms, booking forms. |
| `formatters.dart` | Display formatting: format phone numbers, format currency (₹), format dates ("21 Aug 2026"), format time ("1:30 PM"), format distance ("2.3 km"). |
| `helpers.dart` | Miscellaneous utility functions: show snackbar, launch URL, copy to clipboard, calculate distance between two lat/lng points, generate random booking IDs. |
| `logger.dart` | Centralized logging wrapper. Prints structured debug/info/error logs in dev mode. Can be swapped for Crashlytics/Sentry in production. |
| `debouncer.dart` | A `Debouncer` class to rate-limit search queries and location updates. Prevents excessive API calls when user types in search bar. |

---

## `lib/core/errors/`

| File | Purpose |
|---|---|
| `exceptions.dart` | Exception classes thrown by the data layer: `AuthException`, `NetworkException`, `NotFoundException`, `PermissionException`, `LocationException`, `BookingException`, `CallingException`, `StorageException`. |
| `failures.dart` | Failure classes used in the domain layer: `ServerFailure`, `AuthFailure`, `NetworkFailure`, `CacheFailure`, `LocationFailure`, `ValidationFailure`, `BookingFailure`, `CallingFailure`. Repositories catch exceptions and return failures. |

---

## `lib/core/extensions/`

| File | Purpose |
|---|---|
| `context_extensions.dart` | Extension on `BuildContext` for quick access: `context.screenWidth`, `context.screenHeight`, `context.theme`, `context.showSnackBar()`, `context.pushNamed()`. |
| `string_extensions.dart` | Extension on `String`: `capitalize()`, `isValidEmail`, `isValidPhone`, `toTitleCase()`, `initials` (for avatar fallback). |
| `datetime_extensions.dart` | Extension on `DateTime`: `timeAgo` ("5 min ago"), `formattedDate` ("21 Aug 2026"), `formattedTime` ("1:30 PM"), `isToday`, `isTomorrow`. |

---

## `lib/core/network/`

| File | Purpose |
|---|---|
| `network_info.dart` | Checks if the device has internet connectivity. Used before making API calls to show offline error immediately instead of waiting for timeout. |

---

## `lib/core/services/`

Wrappers around third-party SDKs. The rest of the app never imports SDK packages directly — it goes through these services.

| File | Purpose |
|---|---|
| `supabase/supabase_service.dart` | Initializes Supabase client. Provides methods for auth (signIn, signUp, signOut, onAuthStateChange), database queries (select, insert, update, delete, realtime subscriptions), and storage (upload, download, getPublicUrl). |
| `location/location_service.dart` | Wraps GPS/location APIs. Methods: `getCurrentLocation()`, `startLocationStream()`, `stopLocationStream()`, `checkPermission()`, `requestPermission()`. Used by tracking feature and booking feature (for customer address). |
| `notifications/notification_service.dart` | Wraps Firebase Cloud Messaging (FCM). Methods: `initialize()`, `getToken()`, `onMessage()`, `onBackgroundMessage()`, `showLocalNotification()`. Handles foreground and background push notifications. |
| `calling/agora_service.dart` | Wraps Agora Voice SDK. Methods: `initEngine()`, `joinChannel()`, `leaveChannel()`, `muteLocalAudio()`, `setVolume()`, `onUserJoined()`, `onUserLeft()`. Enables in-app voice calls without exposing phone numbers. |
| `storage/storage_service.dart` | Wraps Supabase Storage for file uploads. Methods: `uploadImage()`, `uploadDocument()`, `deleteFile()`, `getPublicUrl()`. Used by profile photos, verification documents, review images. |

---

## `lib/core/routing/`

| File | Purpose |
|---|---|
| `app_router.dart` | GoRouter configuration. Defines all routes, nested routes, redirects (e.g., redirect to login if not authenticated, redirect to role selection if no role set). Guards routes based on auth state and user role (customer vs provider). |
| `route_names.dart` | Named string constants for every route path: `/splash`, `/onboarding`, `/login`, `/home`, `/booking/:id`, `/provider/:id`, `/tracking/:bookingId`, etc. Prevents typos in navigation. |

---

## `lib/core/widgets/`

Reusable UI components shared across multiple features.

| File | Purpose |
|---|---|
| `custom_button.dart` | Styled button with loading state, icon support, primary/secondary/outline variants. Used everywhere. |
| `custom_text_field.dart` | Styled text input with label, validation error display, prefix/suffix icons, password visibility toggle. |
| `loading_indicator.dart` | Centered loading spinner with optional message text. Shown during API calls. |
| `error_widget.dart` | Error state UI: error icon + message + "Retry" button. Shown when API calls fail. |
| `empty_state_widget.dart` | Empty state UI: illustration + message + optional action button. Shown when lists are empty (no bookings, no reviews, etc.). |
| `rating_bar.dart` | Displays star ratings (1–5). Can be read-only (provider profile) or interactive (write review). |
| `service_card.dart` | Card displaying a service category with icon, name, and tap action. Used on home screen grid. |
| `provider_card.dart` | Card displaying a provider's avatar, name, rating, distance, and service type. Used in provider lists. |
| `booking_status_badge.dart` | Small colored badge showing booking status (Pending = orange, Accepted = green, In Progress = blue, etc.). |
| `custom_app_bar.dart` | Styled app bar with optional back button, title, and action buttons. Consistent across all screens. |
| `avatar_widget.dart` | Circular avatar image with fallback to user initials. Handles network images and loading states. |
| `confirmation_dialog.dart` | Modal dialog for confirming destructive actions: "Cancel Booking?", "Sign Out?", etc. |

---

## Features

---

### `lib/features/auth/` — Authentication

Handles registration, login, OTP, and role selection for both customers and providers.

| File | Purpose |
|---|---|
| **Data Layer** | |
| `data/datasources/auth_remote_datasource.dart` | Calls Supabase Auth: `signInWithPhone()`, `verifyOTP()`, `signUpWithEmail()`, `signOut()`, `getCurrentSession()`. |
| `data/models/user_model.dart` | JSON-serializable user model with `fromJson()` / `toJson()`. Maps Supabase `auth.users` + `public.users` table data. Fields: id, name, email, phone, role, avatar_url, created_at. |
| `data/repositories/auth_repository_impl.dart` | Implements `AuthRepository`. Calls datasource, catches exceptions, returns success/failure. |
| **Domain Layer** | |
| `domain/entities/user_entity.dart` | Pure `UserEntity` class. No Supabase dependency. Properties: id, name, email, phone, role, avatarUrl, isVerified. |
| `domain/repositories/auth_repository.dart` | Abstract `AuthRepository` interface: `signIn()`, `signUp()`, `signOut()`, `getCurrentUser()`, `verifyOTP()`. |
| `domain/usecases/sign_in.dart` | Executes sign-in logic. Validates input, calls repository, returns user or failure. |
| `domain/usecases/sign_up.dart` | Executes sign-up logic. Creates user in Supabase Auth + inserts profile row in public.users table. |
| `domain/usecases/sign_out.dart` | Signs user out, clears local session. |
| `domain/usecases/get_current_user.dart` | Returns the currently authenticated user, or null if not logged in. Used by router guards. |
| **Presentation Layer** | |
| `presentation/providers/auth_provider.dart` | Riverpod providers: `authStateProvider`, `currentUserProvider`, `signInProvider`, `signUpProvider`. Manages auth state across the app. |
| `presentation/screens/splash_screen.dart` | First screen shown on launch. Displays logo, checks auth status, routes to onboarding/login/home. |
| `presentation/screens/onboarding_screen.dart` | 3-page intro carousel for first-time users. Explains what ServiceWala does. "Get Started" button leads to login. |
| `presentation/screens/login_screen.dart` | Phone number input + "Send OTP" button. Optional email/password login. Social login buttons. |
| `presentation/screens/signup_screen.dart` | Registration form: name, email, phone, password. For new users. |
| `presentation/screens/otp_verification_screen.dart` | 4–6 digit OTP input. Timer for resend. Verifies phone number via Supabase. |
| `presentation/screens/role_selection_screen.dart` | "Are you a Customer or Service Provider?" choice screen. Shown after first sign-up. Sets user role in database. |
| `presentation/widgets/auth_form.dart` | Shared form layout used by login and signup screens (input fields, validation, submit button). |
| `presentation/widgets/social_login_button.dart` | Google/Apple sign-in button widget with icon and styling. |

---

### `lib/features/home/` — Home / Dashboard

The main screen customers and providers see after login.

| File | Purpose |
|---|---|
| **Data Layer** | |
| `data/datasources/home_remote_datasource.dart` | Fetches home page data from Supabase: featured services, nearby providers, promotional banners. |
| `data/models/banner_model.dart` | Model for promotional banners: image URL, title, action URL, display order. |
| `data/repositories/home_repository_impl.dart` | Implements home repository. Combines banner data + service categories + nearby providers into one response. |
| **Domain Layer** | |
| `domain/entities/banner_entity.dart` | Pure entity for home screen banners. |
| `domain/repositories/home_repository.dart` | Abstract interface: `getHomeData()`, `getBanners()`, `getNearbyProviders()`. |
| `domain/usecases/get_home_data.dart` | Fetches all data needed for the home screen in one call. |
| **Presentation Layer** | |
| `presentation/providers/home_provider.dart` | Riverpod providers for home screen state, loading, refresh. |
| `presentation/screens/customer_home_screen.dart` | **Customer view**: search bar, service category grid, nearby providers, active booking status card, banners. |
| `presentation/screens/provider_home_screen.dart` | **Provider view**: today's jobs, incoming requests, earnings summary, online/offline toggle. |
| `presentation/widgets/service_category_grid.dart` | Grid of service category cards (Electrician, Plumber, etc.) with icons. Tapping one navigates to providers list. |
| `presentation/widgets/nearby_providers_list.dart` | Horizontal scrollable list of nearby available providers with avatar, name, rating, distance. |
| `presentation/widgets/home_banner.dart` | Auto-scrolling promotional banner carousel at top of home screen. |
| `presentation/widgets/search_bar_widget.dart` | Search input that filters services and providers. Uses debouncer to avoid excessive queries. |

---

### `lib/features/services/` — Service Browsing

Browse and select service categories, find providers offering that service.

| File | Purpose |
|---|---|
| **Data Layer** | |
| `data/datasources/services_remote_datasource.dart` | Queries Supabase for service categories and providers filtered by category, location, rating. |
| `data/models/service_category_model.dart` | Model for service categories: id, name, icon, description, provider_count. |
| `data/models/service_model.dart` | Model for individual service offerings by a provider: id, name, category_id, price_range, description. |
| `data/repositories/services_repository_impl.dart` | Implements services repository with caching of categories. |
| **Domain Layer** | |
| `domain/entities/service_category_entity.dart` | Pure entity for a service category. |
| `domain/entities/service_entity.dart` | Pure entity for a specific service a provider offers. |
| `domain/repositories/services_repository.dart` | Abstract: `getCategories()`, `getProvidersByService()`, `searchServices()`. |
| `domain/usecases/get_categories.dart` | Fetches all available service categories. |
| `domain/usecases/get_providers_by_service.dart` | Fetches providers that offer a specific service, sorted by distance/rating. |
| **Presentation Layer** | |
| `presentation/providers/services_provider.dart` | Riverpod providers for category list, filtered providers, search state. |
| `presentation/screens/services_list_screen.dart` | Full list of service categories. Tap a category to see available providers. |
| `presentation/screens/service_detail_screen.dart` | Detailed view of a service category: description, list of providers offering it, filters (price, rating, distance). |
| `presentation/widgets/service_filter_bar.dart` | Filter/sort bar: sort by price, rating, distance. Filter by availability. |
| `presentation/widgets/service_list_tile.dart` | Individual service category row with icon, name, provider count, chevron. |

---

### `lib/features/provider_profile/` — Provider Profiles

View and edit service provider profiles, verification status.

| File | Purpose |
|---|---|
| **Data Layer** | |
| `data/datasources/provider_remote_datasource.dart` | Fetches/updates provider data from Supabase: profile info, services offered, documents, availability. |
| `data/models/provider_model.dart` | Provider model: id, user_id, business_name, services, experience_years, rating, total_reviews, is_verified, location, availability_status. |
| `data/repositories/provider_repository_impl.dart` | Implements provider repository. |
| **Domain Layer** | |
| `domain/entities/provider_entity.dart` | Pure provider entity with all profile fields. |
| `domain/repositories/provider_repository.dart` | Abstract: `getProviderById()`, `updateProfile()`, `uploadDocument()`, `toggleAvailability()`. |
| `domain/usecases/get_provider_details.dart` | Fetches a provider's full profile including reviews and services. |
| `domain/usecases/update_provider_profile.dart` | Updates provider's profile info, services, or availability. |
| **Presentation Layer** | |
| `presentation/providers/provider_profile_provider.dart` | Riverpod providers for provider detail state, edit state, availability toggle. |
| `presentation/screens/provider_detail_screen.dart` | **Customer sees this**: provider's photo, name, rating, experience, services offered, reviews, "Book Now" button, "Call" button. |
| `presentation/screens/provider_edit_screen.dart` | **Provider sees this**: edit own profile — update photo, business name, services, experience, working hours. |
| `presentation/widgets/provider_info_card.dart` | Card showing provider name, rating, experience, services count. Used in listings. |
| `presentation/widgets/provider_reviews_section.dart` | Section on provider detail page showing recent reviews with ratings. |
| `presentation/widgets/verification_badge.dart` | Green checkmark badge shown next to verified providers' names. |

---

### `lib/features/booking/` — Service Booking

Create, manage, accept/reject, and track bookings.

| File | Purpose |
|---|---|
| **Data Layer** | |
| `data/datasources/booking_remote_datasource.dart` | Supabase calls: insert booking, update status, fetch by user/provider, realtime subscription for status changes. |
| `data/models/booking_model.dart` | Booking model: id, customer_id, provider_id, service_id, status, scheduled_date, address, notes, price, created_at, updated_at. |
| `data/repositories/booking_repository_impl.dart` | Implements booking repository with realtime status updates via Supabase Realtime. |
| **Domain Layer** | |
| `domain/entities/booking_entity.dart` | Pure booking entity. |
| `domain/repositories/booking_repository.dart` | Abstract: `createBooking()`, `cancelBooking()`, `updateStatus()`, `getBookingsForUser()`, `getBookingsForProvider()`, `streamBookingUpdates()`. |
| `domain/usecases/create_booking.dart` | Validates booking details, creates booking in DB, sends notification to provider. |
| `domain/usecases/cancel_booking.dart` | Cancels a booking (only if status is pending/accepted), notifies the other party. |
| `domain/usecases/update_booking_status.dart` | Provider accepts/rejects/completes a booking. Updates DB, sends push notification to customer. |
| `domain/usecases/get_user_bookings.dart` | Fetches all bookings for the current user (customer or provider), with filters. |
| **Presentation Layer** | |
| `presentation/providers/booking_provider.dart` | Riverpod providers: booking list, create booking state, booking detail stream, active booking. |
| `presentation/screens/booking_form_screen.dart` | **Customer fills this**: select date/time, enter address, add notes, confirm service. "Book Now" submits. |
| `presentation/screens/booking_confirmation_screen.dart` | Success screen after booking: shows booking ID, provider info, scheduled time, status = Pending. |
| `presentation/screens/booking_detail_screen.dart` | Full booking details with live status, provider info, map, call button, cancel button. Status updates in real-time via Supabase Realtime. |
| `presentation/screens/my_bookings_screen.dart` | **Customer view**: list of all bookings with tabs (Upcoming, Past, Cancelled). |
| `presentation/screens/provider_requests_screen.dart` | **Provider view**: incoming booking requests with Accept/Reject buttons. Active jobs list. |
| `presentation/widgets/booking_card.dart` | Card showing booking summary: service, provider/customer name, date, status badge. |
| `presentation/widgets/booking_status_timeline.dart` | Vertical timeline showing booking progression: Requested → Accepted → Provider En Route → In Progress → Completed. |
| `presentation/widgets/date_time_picker.dart` | Custom date/time picker widget for scheduling a booking. |

---

### `lib/features/tracking/` — Live Location Tracking

Track provider's real-time location on a map during active bookings.

| File | Purpose |
|---|---|
| **Data Layer** | |
| `data/datasources/tracking_remote_datasource.dart` | Reads/writes location data via Supabase Realtime. Provider sends location updates, customer subscribes. |
| `data/models/location_model.dart` | Location model: latitude, longitude, heading, speed, timestamp, provider_id, booking_id. |
| `data/repositories/tracking_repository_impl.dart` | Implements tracking repository. Handles Supabase Realtime channels for live location. |
| **Domain Layer** | |
| `domain/entities/location_entity.dart` | Pure location entity. |
| `domain/repositories/tracking_repository.dart` | Abstract: `startTracking()`, `stopTracking()`, `getLocationStream()`, `updateProviderLocation()`. |
| `domain/usecases/start_tracking.dart` | Provider starts broadcasting location. Subscribes to Supabase Realtime channel. |
| `domain/usecases/stop_tracking.dart` | Provider stops broadcasting. Closes Realtime channel. |
| `domain/usecases/get_live_location.dart` | Customer subscribes to provider's live location stream for a specific booking. |
| **Presentation Layer** | |
| `presentation/providers/tracking_provider.dart` | Riverpod providers for live location stream, ETA, map camera position. |
| `presentation/screens/live_tracking_screen.dart` | Full-screen Google Map showing provider's live location, customer's location, route line, ETA. |
| `presentation/widgets/map_widget.dart` | Google Maps widget wrapper with ServiceWala-styled map theme. |
| `presentation/widgets/provider_location_marker.dart` | Custom animated marker showing provider's avatar moving on the map. |
| `presentation/widgets/eta_display.dart` | Bottom card overlay showing estimated arrival time, distance remaining. |

---

### `lib/features/calling/` — In-App Voice Calling

Agora-powered voice calling between customer and provider (no phone numbers exposed).

| File | Purpose |
|---|---|
| **Data Layer** | |
| `data/datasources/calling_remote_datasource.dart` | Calls Supabase Edge Function to generate Agora token. Logs call records in DB. |
| `data/models/call_model.dart` | Call model: id, caller_id, receiver_id, booking_id, channel_name, status, duration, started_at, ended_at. |
| `data/repositories/calling_repository_impl.dart` | Implements calling repository. Manages Agora token generation + call logging. |
| **Domain Layer** | |
| `domain/entities/call_entity.dart` | Pure call entity. |
| `domain/repositories/calling_repository.dart` | Abstract: `startCall()`, `endCall()`, `getCallHistory()`, `generateToken()`. |
| `domain/usecases/start_call.dart` | Generates Agora token, creates call record, joins Agora channel. Sends push notification to receiver. |
| `domain/usecases/end_call.dart` | Leaves Agora channel, updates call record with duration, notifies other party. |
| **Presentation Layer** | |
| `presentation/providers/calling_provider.dart` | Riverpod providers for call state, duration timer, mute/speaker state. |
| `presentation/screens/voice_call_screen.dart` | Full-screen call UI: other person's name/avatar, call duration timer, mute/speaker/end buttons. Incoming call overlay. |
| `presentation/widgets/call_controls.dart` | Row of circular buttons: Mute, Speaker, End Call. Animated press states. |
| `presentation/widgets/call_timer.dart` | Live-updating call duration display ("02:34"). |

---

### `lib/features/reviews/` — Ratings & Reviews

Customers rate and review providers after completed bookings.

| File | Purpose |
|---|---|
| **Data Layer** | |
| `data/datasources/reviews_remote_datasource.dart` | Supabase calls: insert review, fetch reviews by provider, fetch reviews by customer. |
| `data/models/review_model.dart` | Review model: id, booking_id, customer_id, provider_id, rating (1-5), comment, images, created_at. |
| `data/repositories/reviews_repository_impl.dart` | Implements reviews repository. Also updates provider's average rating after new review. |
| **Domain Layer** | |
| `domain/entities/review_entity.dart` | Pure review entity. |
| `domain/repositories/reviews_repository.dart` | Abstract: `submitReview()`, `getProviderReviews()`, `getMyReviews()`. |
| `domain/usecases/submit_review.dart` | Validates review (must have completed booking), saves to DB, recalculates provider avg rating. |
| `domain/usecases/get_provider_reviews.dart` | Fetches paginated reviews for a provider, sorted by newest first. |
| **Presentation Layer** | |
| `presentation/providers/reviews_provider.dart` | Riverpod providers for reviews list, submit state, rating selection. |
| `presentation/screens/write_review_screen.dart` | Star rating selector + text comment + optional photo upload. Shown after booking is completed. |
| `presentation/screens/reviews_list_screen.dart` | Full scrollable list of all reviews for a provider. |
| `presentation/widgets/review_card.dart` | Individual review: customer name/avatar, star rating, comment text, date. |
| `presentation/widgets/star_rating_input.dart` | Interactive 5-star row — tap or drag to set rating. Used in write review screen. |

---

### `lib/features/notifications/` — Push Notifications

FCM push notifications for booking updates, new requests, promotions.

| File | Purpose |
|---|---|
| **Data Layer** | |
| `data/datasources/notifications_remote_datasource.dart` | Fetches notification history from Supabase. Saves FCM token to user profile. |
| `data/models/notification_model.dart` | Notification model: id, user_id, title, body, type (booking/promotion/system), data (JSON payload), is_read, created_at. |
| `data/repositories/notifications_repository_impl.dart` | Implements notifications repository. |
| **Domain Layer** | |
| `domain/entities/notification_entity.dart` | Pure notification entity. |
| `domain/repositories/notifications_repository.dart` | Abstract: `getNotifications()`, `markAsRead()`, `markAllAsRead()`, `getUnreadCount()`. |
| `domain/usecases/get_notifications.dart` | Fetches paginated notification list for current user. |
| `domain/usecases/mark_as_read.dart` | Marks single or all notifications as read. Updates unread badge count. |
| **Presentation Layer** | |
| `presentation/providers/notifications_provider.dart` | Riverpod providers for notification list, unread count badge, push handling. |
| `presentation/screens/notifications_screen.dart` | List of all notifications with read/unread styling. Tap to navigate to relevant screen (e.g., booking detail). |
| `presentation/widgets/notification_tile.dart` | Individual notification row: icon by type, title, body, time ago, unread dot indicator. |

---

### `lib/features/chat/` — In-App Messaging (Future)

Real-time chat between customer and provider via Supabase Realtime.

| File | Purpose |
|---|---|
| **Data Layer** | |
| `data/datasources/chat_remote_datasource.dart` | Supabase Realtime for live messages. Insert/fetch messages, create conversation records. |
| `data/models/message_model.dart` | Message model: id, conversation_id, sender_id, text, image_url, type, created_at, is_read. |
| `data/models/conversation_model.dart` | Conversation model: id, booking_id, customer_id, provider_id, last_message, last_message_at, unread_count. |
| `data/repositories/chat_repository_impl.dart` | Implements chat repository with Supabase Realtime subscriptions. |
| **Domain Layer** | |
| `domain/entities/message_entity.dart` | Pure message entity. |
| `domain/entities/conversation_entity.dart` | Pure conversation entity. |
| `domain/repositories/chat_repository.dart` | Abstract: `sendMessage()`, `getMessages()`, `getConversations()`, `streamMessages()`. |
| `domain/usecases/send_message.dart` | Sends a chat message, updates conversation's last_message, sends push to recipient. |
| `domain/usecases/get_conversations.dart` | Fetches all chat conversations for the current user. |
| **Presentation Layer** | |
| `presentation/providers/chat_provider.dart` | Riverpod providers for conversations list, active chat messages stream, send state. |
| `presentation/screens/conversations_screen.dart` | List of all chat conversations: other person's name/avatar, last message preview, time, unread badge. |
| `presentation/screens/chat_screen.dart` | Full chat view: message bubbles, text input, send button, image attachment. Real-time updates. |
| `presentation/widgets/message_bubble.dart` | Chat bubble: different style for sent vs received, timestamp, read receipt. |
| `presentation/widgets/chat_input_bar.dart` | Bottom bar with text field, attachment button, send button. |

---

### `lib/features/profile/` — User Profile & Settings

View/edit own profile, app settings, support.

| File | Purpose |
|---|---|
| **Data Layer** | |
| `data/datasources/profile_remote_datasource.dart` | Fetches/updates user profile from Supabase public.users table. Uploads avatar to storage. |
| `data/models/profile_model.dart` | Profile model: id, name, email, phone, avatar_url, address, city, role, created_at. |
| `data/repositories/profile_repository_impl.dart` | Implements profile repository. |
| **Domain Layer** | |
| `domain/entities/profile_entity.dart` | Pure profile entity. |
| `domain/repositories/profile_repository.dart` | Abstract: `getProfile()`, `updateProfile()`, `uploadAvatar()`, `deleteAccount()`. |
| `domain/usecases/get_profile.dart` | Fetches current user's profile data. |
| `domain/usecases/update_profile.dart` | Updates profile fields (name, email, phone, address, avatar). |
| **Presentation Layer** | |
| `presentation/providers/profile_provider.dart` | Riverpod providers for profile data, edit state, avatar upload progress. |
| `presentation/screens/profile_screen.dart` | Profile overview: avatar, name, phone, email, quick links (My Bookings, Reviews, Settings, Help, Logout). |
| `presentation/screens/edit_profile_screen.dart` | Edit form: change name, email, phone, address. Upload/change avatar photo. |
| `presentation/screens/settings_screen.dart` | App settings: dark mode toggle, notification preferences, language, privacy policy, terms, about, delete account. |
| `presentation/widgets/profile_header.dart` | Top section of profile screen: large avatar, name, phone, edit button. |
| `presentation/widgets/settings_tile.dart` | Individual settings row: icon, title, trailing (switch/chevron/value). |

---

## Technology Mapping

| What | Where it connects |
|---|---|
| **Supabase** | `core/services/supabase/` → used by every `data/datasources/` |
| **Google Maps** | `features/tracking/presentation/` → `map_widget.dart`, `live_tracking_screen.dart` |
| **Agora** | `core/services/calling/` → `features/calling/` |
| **FCM** | `core/services/notifications/` → `features/notifications/` |
| **Riverpod** | Every `presentation/providers/` folder |
| **GoRouter** | `core/routing/` → routes to every `presentation/screens/` |

---

## Total File Count

| Area | Files |
|---|---|
| `app/` | 2 |
| `core/` | 27 |
| `features/auth/` | 18 |
| `features/home/` | 12 |
| `features/services/` | 14 |
| `features/provider_profile/` | 13 |
| `features/booking/` | 18 |
| `features/tracking/` | 13 |
| `features/calling/` | 11 |
| `features/reviews/` | 12 |
| `features/notifications/` | 10 |
| `features/chat/` | 14 |
| `features/profile/` | 13 |
| `main.dart` | 1 |
| **Total** | **178** |

---

*This document is the single source of truth for what each file in ServiceWala is supposed to do. When you start coding a file, refer back here to understand its responsibility.*
