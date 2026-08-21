# ServiceWala — Step-by-Step Development Guide

> A practical roadmap: what to code first, what to code next, and why — with suggestions, tips, and pitfalls to avoid.

---

## How To Read This Guide

This guide is split into **10 phases**. Each phase builds on the previous one. **Do not skip ahead** — later phases depend on earlier ones working correctly.

For each phase, you'll see:
- 🎯 **Goal** — what you're trying to achieve
- 📁 **Files to code** — exact files, in order
- 💡 **Suggestions** — tips, packages to use, things to watch out for
- ✅ **Done when** — how to know the phase is complete

---

## Phase 0: Project Setup & Dependencies

🎯 **Goal**: Install all packages, configure Supabase, set up the project foundation.

### Step 1: Install packages

Run this in your project root:

```bash
flutter pub add supabase_flutter
flutter pub add flutter_riverpod
flutter pub add riverpod_annotation
flutter pub add go_router
flutter pub add google_maps_flutter
flutter pub add geolocator
flutter pub add geocoding
flutter pub add agora_rtc_engine
flutter pub add firebase_core
flutter pub add firebase_messaging
flutter pub add flutter_local_notifications
flutter pub add cached_network_image
flutter pub add image_picker
flutter pub add flutter_svg
flutter pub add lottie
flutter pub add shimmer
flutter pub add intl
flutter pub add url_launcher
flutter pub add connectivity_plus
flutter pub add shared_preferences
flutter pub add flutter_animate
flutter pub add google_fonts
```

Dev dependencies:

```bash
flutter pub add --dev riverpod_generator
flutter pub add --dev build_runner
flutter pub add --dev riverpod_lint
flutter pub add --dev flutter_lints
```

### Step 2: Set up Supabase project

1. Go to [supabase.com](https://supabase.com) → Create new project
2. Copy your **Project URL** and **anon key**
3. Paste them into `lib/core/constants/app_constants.dart`

### Step 3: Set up Firebase project (for FCM only)

1. Go to [Firebase Console](https://console.firebase.google.com) → Create project
2. Add Android app → download `google-services.json` → put in `android/app/`
3. Add iOS app → download `GoogleService-Info.plist` → put in `ios/Runner/`
4. Follow the FlutterFire setup instructions

### Step 4: Set up Agora account

1. Go to [agora.io](https://www.agora.io) → Create account → Create project
2. Copy **App ID** → paste into `app_constants.dart`
3. Enable **App Certificate** for token-based auth (needed for production)

### Step 5: Get Google Maps API key

1. Go to [Google Cloud Console](https://console.cloud.google.com)
2. Enable **Maps SDK for Android** and **Maps SDK for iOS**
3. Create API key → add to `android/app/src/main/AndroidManifest.xml` and `ios/Runner/AppDelegate.swift`

💡 **Suggestion**: Don't rush this phase. Get every API key working with a simple test before moving on. A broken Supabase connection at Phase 0 will waste hours in Phase 3.

✅ **Done when**: `flutter run` works, Supabase connects, no build errors.

---

## Phase 1: Core Layer (Code This First!)

🎯 **Goal**: Build the shared foundation that every feature will use. This is the most important phase — get it right and everything else becomes easier.

### Order to code:

```
1.  lib/core/constants/app_constants.dart        ← already has starter code
2.  lib/core/constants/api_endpoints.dart         ← already has starter code
3.  lib/core/constants/asset_paths.dart           ← already has starter code
4.  lib/core/constants/enums.dart                 ← define all enums NOW
5.  lib/core/errors/exceptions.dart               ← already has starter code
6.  lib/core/errors/failures.dart                 ← define failure types
7.  lib/core/theme/app_theme.dart                 ← already has starter code
8.  lib/core/theme/app_text_styles.dart           ← already has starter code
9.  lib/core/extensions/string_extensions.dart    ← quick utility
10. lib/core/extensions/context_extensions.dart   ← quick utility
11. lib/core/extensions/datetime_extensions.dart  ← quick utility
12. lib/core/utils/validators.dart                ← input validation
13. lib/core/utils/formatters.dart                ← display formatting
14. lib/core/utils/helpers.dart                   ← misc helpers
15. lib/core/utils/logger.dart                    ← debug logging
16. lib/core/utils/debouncer.dart                 ← for search
17. lib/core/network/network_info.dart            ← connectivity check
18. lib/core/services/supabase/supabase_service.dart  ← THE critical service
```

### What to put in `enums.dart`:

```dart
enum UserRole { customer, provider }

enum BookingStatus {
  pending,      // customer just booked
  accepted,     // provider accepted
  rejected,     // provider rejected
  enRoute,      // provider is on the way
  inProgress,   // provider arrived, working
  completed,    // work done
  cancelled,    // either party cancelled
}

enum ServiceCategory {
  electrician,
  plumber,
  vehicleRepair,
  carpenter,
  acRepair,
}

enum VerificationStatus { unverified, pending, verified, rejected }

enum AvailabilityStatus { online, offline, busy }

enum CallStatus { ringing, connected, ended, missed }

enum NotificationType { booking, promotion, system, chat }
```

### What to put in `supabase_service.dart`:

This is the **most important file in the entire core layer**. Everything talks to Supabase through this.

```dart
// Initialize in main.dart before runApp()
// Expose: client, auth, database query helpers, realtime, storage
// Keep it as a thin wrapper — DON'T put business logic here
```

💡 **Suggestions**:
- **Start `enums.dart` early**. You'll reference these enums in every single model and entity. Getting them wrong means refactoring everywhere later.
- **`supabase_service.dart` should be thin**. It should just expose the Supabase client and maybe a few convenience methods. Don't put query logic here — that goes in datasources.
- **Test `network_info.dart` on a real device**. Emulators sometimes report network differently than real phones.

✅ **Done when**: You can import any core file from any feature without errors. Supabase initializes on app start.

---

## Phase 2: Supabase Database Schema

🎯 **Goal**: Create all tables in Supabase before writing any feature code. You need the database to exist before your datasources can talk to it.

### Go to Supabase Dashboard → SQL Editor → Run these:

```sql
-- ============================================
-- USERS (extends Supabase auth.users)
-- ============================================
CREATE TABLE public.users (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  email TEXT,
  phone TEXT NOT NULL,
  role TEXT NOT NULL CHECK (role IN ('customer', 'provider')),
  avatar_url TEXT,
  city TEXT DEFAULT 'Amritsar',
  address TEXT,
  fcm_token TEXT,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- ============================================
-- PROVIDERS (extra profile for service providers)
-- ============================================
CREATE TABLE public.providers (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
  business_name TEXT,
  experience_years INTEGER DEFAULT 0,
  description TEXT,
  services TEXT[] NOT NULL,           -- array of service categories
  latitude DOUBLE PRECISION,
  longitude DOUBLE PRECISION,
  availability_status TEXT DEFAULT 'offline'
    CHECK (availability_status IN ('online', 'offline', 'busy')),
  verification_status TEXT DEFAULT 'unverified'
    CHECK (verification_status IN ('unverified', 'pending', 'verified', 'rejected')),
  document_urls TEXT[],
  rating DECIMAL(2,1) DEFAULT 0.0,
  total_reviews INTEGER DEFAULT 0,
  total_jobs INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now(),
  UNIQUE(user_id)
);

-- ============================================
-- SERVICES (service categories)
-- ============================================
CREATE TABLE public.services (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  description TEXT,
  icon_url TEXT,
  is_active BOOLEAN DEFAULT true,
  display_order INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- Seed initial services
INSERT INTO public.services (name, description, display_order) VALUES
  ('Electrician', 'Wiring, switches, fixtures, electrical repairs', 1),
  ('Plumber', 'Pipes, taps, leaks, bathroom fitting', 2),
  ('Vehicle Repair', 'Bike & car repair, mechanics, servicing', 3),
  ('Carpenter', 'Furniture repair, woodwork, fitting', 4),
  ('AC Repair', 'AC servicing, gas refill, installation', 5);

-- ============================================
-- BOOKINGS
-- ============================================
CREATE TABLE public.bookings (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  customer_id UUID NOT NULL REFERENCES public.users(id),
  provider_id UUID NOT NULL REFERENCES public.users(id),
  service_id UUID NOT NULL REFERENCES public.services(id),
  status TEXT NOT NULL DEFAULT 'pending'
    CHECK (status IN ('pending','accepted','rejected','enRoute',
                      'inProgress','completed','cancelled')),
  scheduled_date TIMESTAMPTZ NOT NULL,
  address TEXT NOT NULL,
  latitude DOUBLE PRECISION,
  longitude DOUBLE PRECISION,
  notes TEXT,
  price DECIMAL(10,2),
  cancellation_reason TEXT,
  cancelled_by UUID,
  completed_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- ============================================
-- REVIEWS
-- ============================================
CREATE TABLE public.reviews (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  booking_id UUID NOT NULL REFERENCES public.bookings(id),
  customer_id UUID NOT NULL REFERENCES public.users(id),
  provider_id UUID NOT NULL REFERENCES public.users(id),
  rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
  comment TEXT,
  image_urls TEXT[],
  created_at TIMESTAMPTZ DEFAULT now(),
  UNIQUE(booking_id)  -- one review per booking
);

-- ============================================
-- NOTIFICATIONS
-- ============================================
CREATE TABLE public.notifications (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES public.users(id),
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  type TEXT NOT NULL CHECK (type IN ('booking','promotion','system','chat')),
  data JSONB,          -- extra payload (booking_id, etc.)
  is_read BOOLEAN DEFAULT false,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- ============================================
-- CALLS (call history)
-- ============================================
CREATE TABLE public.calls (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  booking_id UUID REFERENCES public.bookings(id),
  caller_id UUID NOT NULL REFERENCES public.users(id),
  receiver_id UUID NOT NULL REFERENCES public.users(id),
  channel_name TEXT NOT NULL,
  status TEXT DEFAULT 'ringing'
    CHECK (status IN ('ringing','connected','ended','missed')),
  duration_seconds INTEGER DEFAULT 0,
  started_at TIMESTAMPTZ DEFAULT now(),
  ended_at TIMESTAMPTZ
);

-- ============================================
-- CONVERSATIONS & MESSAGES (for chat)
-- ============================================
CREATE TABLE public.conversations (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  booking_id UUID REFERENCES public.bookings(id),
  customer_id UUID NOT NULL REFERENCES public.users(id),
  provider_id UUID NOT NULL REFERENCES public.users(id),
  last_message TEXT,
  last_message_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE public.messages (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  conversation_id UUID NOT NULL REFERENCES public.conversations(id),
  sender_id UUID NOT NULL REFERENCES public.users(id),
  text TEXT,
  image_url TEXT,
  is_read BOOLEAN DEFAULT false,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- ============================================
-- LOCATION TRACKING (realtime)
-- ============================================
CREATE TABLE public.provider_locations (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  provider_id UUID NOT NULL REFERENCES public.users(id),
  booking_id UUID REFERENCES public.bookings(id),
  latitude DOUBLE PRECISION NOT NULL,
  longitude DOUBLE PRECISION NOT NULL,
  heading DOUBLE PRECISION,
  speed DOUBLE PRECISION,
  updated_at TIMESTAMPTZ DEFAULT now(),
  UNIQUE(provider_id)  -- one active location per provider
);

-- ============================================
-- ROW LEVEL SECURITY (RLS)
-- ============================================
ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.providers ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.bookings ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.reviews ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.notifications ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.calls ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.conversations ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.messages ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.provider_locations ENABLE ROW LEVEL SECURITY;

-- Basic RLS policies (expand these as needed)
-- Users can read their own data
CREATE POLICY "Users can read own data" ON public.users
  FOR SELECT USING (auth.uid() = id);

-- Users can update their own data
CREATE POLICY "Users can update own data" ON public.users
  FOR UPDATE USING (auth.uid() = id);

-- Everyone can read services
CREATE POLICY "Anyone can read services" ON public.services
  FOR SELECT USING (true);

-- Customers can read any provider
CREATE POLICY "Anyone can read providers" ON public.providers
  FOR SELECT USING (true);

-- Providers can update own profile
CREATE POLICY "Providers can update own profile" ON public.providers
  FOR UPDATE USING (auth.uid() = user_id);

-- Enable Realtime for key tables
ALTER PUBLICATION supabase_realtime ADD TABLE public.bookings;
ALTER PUBLICATION supabase_realtime ADD TABLE public.provider_locations;
ALTER PUBLICATION supabase_realtime ADD TABLE public.messages;
```

💡 **Suggestions**:
- **Run this SQL in order** — tables reference each other, so order matters.
- **RLS is critical for security**. The basic policies above are a starting point. Add more granular policies as you build each feature (e.g., "customer can only see own bookings").
- **Enable Realtime on `bookings`, `provider_locations`, and `messages`** — these are the tables that need live updates.
- **Don't forget Storage buckets**: Go to Supabase → Storage → Create buckets: `avatars`, `documents`, `review-images`.

✅ **Done when**: All tables exist in Supabase, you can insert a test row manually and see it.

---

## Phase 3: Auth Feature (Code This Second!)

🎯 **Goal**: Users can sign up, log in, verify OTP, and choose their role. This is the gateway to everything else — nothing works without auth.

### Order to code:

```
1.  lib/features/auth/domain/entities/user_entity.dart          ← start with domain
2.  lib/features/auth/domain/repositories/auth_repository.dart   ← abstract contract
3.  lib/features/auth/domain/usecases/sign_in.dart
4.  lib/features/auth/domain/usecases/sign_up.dart
5.  lib/features/auth/domain/usecases/sign_out.dart
6.  lib/features/auth/domain/usecases/get_current_user.dart
7.  lib/features/auth/data/models/user_model.dart               ← then data layer
8.  lib/features/auth/data/datasources/auth_remote_datasource.dart
9.  lib/features/auth/data/repositories/auth_repository_impl.dart
10. lib/features/auth/presentation/providers/auth_provider.dart  ← then presentation
11. lib/features/auth/presentation/screens/splash_screen.dart
12. lib/features/auth/presentation/screens/onboarding_screen.dart
13. lib/features/auth/presentation/screens/login_screen.dart
14. lib/features/auth/presentation/screens/otp_verification_screen.dart
15. lib/features/auth/presentation/screens/signup_screen.dart
16. lib/features/auth/presentation/screens/role_selection_screen.dart
17. lib/features/auth/presentation/widgets/auth_form.dart
18. lib/features/auth/presentation/widgets/social_login_button.dart
```

### Why this order?

**Domain first** → You define *what* auth does without caring *how*.
**Data second** → You implement the *how* (Supabase calls).
**Presentation last** → You build the UI that uses both.

This way, if you change from Supabase to Firebase Auth later, you only rewrite the data layer. Domain and presentation stay the same.

### At the same time, set up routing:

```
19. lib/core/routing/route_names.dart
20. lib/core/routing/app_router.dart
21. lib/app/app_providers.dart
22. lib/app/app.dart
23. lib/main.dart                    ← rewrite to use ProviderScope + App
```

### Also code these shared widgets (you'll need them immediately):

```
24. lib/core/widgets/custom_button.dart
25. lib/core/widgets/custom_text_field.dart
26. lib/core/widgets/loading_indicator.dart
```

💡 **Suggestions**:
- **Use Supabase phone auth** (OTP via SMS) for login. It's the simplest and most natural for Indian users.
- **The `role_selection_screen` is crucial**. After first sign-up, user MUST choose customer or provider. Store this in the `users` table. Your router should redirect here if `role` is null.
- **Don't build social login yet**. Get phone/OTP working first. Add Google login in a later iteration.
- **Test sign-up → OTP → role selection → home redirect** end-to-end before moving to Phase 4.
- **Common mistake**: Forgetting to create the user row in `public.users` after Supabase Auth sign-up. Supabase Auth creates a row in `auth.users` but NOT in your `public.users` table. You need to do that yourself (or use a Supabase database trigger).

✅ **Done when**: You can sign up with phone → verify OTP → select role → land on home screen. Sign out and sign back in works. App remembers login on restart.

---

## Phase 4: Home Screen + Service Browsing

🎯 **Goal**: Customer sees service categories on home screen, can tap one and see providers.

### Order to code:

```
-- Home Feature --
1.  lib/features/home/domain/entities/banner_entity.dart
2.  lib/features/home/domain/repositories/home_repository.dart
3.  lib/features/home/domain/usecases/get_home_data.dart
4.  lib/features/home/data/models/banner_model.dart
5.  lib/features/home/data/datasources/home_remote_datasource.dart
6.  lib/features/home/data/repositories/home_repository_impl.dart
7.  lib/features/home/presentation/providers/home_provider.dart
8.  lib/features/home/presentation/widgets/search_bar_widget.dart
9.  lib/features/home/presentation/widgets/service_category_grid.dart
10. lib/features/home/presentation/widgets/home_banner.dart
11. lib/features/home/presentation/widgets/nearby_providers_list.dart
12. lib/features/home/presentation/screens/customer_home_screen.dart

-- Services Feature --
13. lib/features/services/domain/entities/service_category_entity.dart
14. lib/features/services/domain/entities/service_entity.dart
15. lib/features/services/domain/repositories/services_repository.dart
16. lib/features/services/domain/usecases/get_categories.dart
17. lib/features/services/domain/usecases/get_providers_by_service.dart
18. lib/features/services/data/models/service_category_model.dart
19. lib/features/services/data/models/service_model.dart
20. lib/features/services/data/datasources/services_remote_datasource.dart
21. lib/features/services/data/repositories/services_repository_impl.dart
22. lib/features/services/presentation/providers/services_provider.dart
23. lib/features/services/presentation/widgets/service_list_tile.dart
24. lib/features/services/presentation/widgets/service_filter_bar.dart
25. lib/features/services/presentation/screens/services_list_screen.dart
26. lib/features/services/presentation/screens/service_detail_screen.dart

-- More shared widgets --
27. lib/core/widgets/service_card.dart
28. lib/core/widgets/provider_card.dart
29. lib/core/widgets/empty_state_widget.dart
30. lib/core/widgets/error_widget.dart
```

💡 **Suggestions**:
- **For the home screen**, use a `RefreshIndicator` (pull-to-refresh). Users expect it.
- **Use shimmer loading** (`shimmer` package) instead of a boring spinner while data loads. It looks much more polished.
- **Cache service categories locally** using `shared_preferences`. They rarely change, so no need to fetch from Supabase every time.
- **The customer home screen is the FIRST thing users see after login**. Make it look beautiful. Spend time on it.
- **Provider home screen** (`provider_home_screen.dart`) can wait until Phase 6. Build customer flow first.

✅ **Done when**: Customer logs in → sees home with service category grid → taps "Electrician" → sees list of providers (even if dummy data for now).

---

## Phase 5: Provider Profiles

🎯 **Goal**: Customers can view provider profiles. Providers can edit their own profile.

### Order to code:

```
1.  lib/features/provider_profile/domain/entities/provider_entity.dart
2.  lib/features/provider_profile/domain/repositories/provider_repository.dart
3.  lib/features/provider_profile/domain/usecases/get_provider_details.dart
4.  lib/features/provider_profile/domain/usecases/update_provider_profile.dart
5.  lib/features/provider_profile/data/models/provider_model.dart
6.  lib/features/provider_profile/data/datasources/provider_remote_datasource.dart
7.  lib/features/provider_profile/data/repositories/provider_repository_impl.dart
8.  lib/features/provider_profile/presentation/providers/provider_profile_provider.dart
9.  lib/features/provider_profile/presentation/widgets/verification_badge.dart
10. lib/features/provider_profile/presentation/widgets/provider_info_card.dart
11. lib/features/provider_profile/presentation/widgets/provider_reviews_section.dart
12. lib/features/provider_profile/presentation/screens/provider_detail_screen.dart
13. lib/features/provider_profile/presentation/screens/provider_edit_screen.dart

-- Shared widgets --
14. lib/core/widgets/avatar_widget.dart
15. lib/core/widgets/rating_bar.dart

-- Storage service (for avatar upload) --
16. lib/core/services/storage/storage_service.dart
```

💡 **Suggestions**:
- **Provider detail screen is where customers decide to book**. Show: photo, name, rating stars, experience years, services offered, reviews preview, "Book Now" button.
- **Provider edit screen**: Let providers upload a photo, set their business name, pick which services they offer (checkboxes), and write a description.
- **Verification**: For V1, just show the badge. Actual verification (document upload + admin review) can come later.
- **Don't forget**: When a provider signs up and selects role = provider, redirect them to `provider_edit_screen.dart` to set up their profile.

✅ **Done when**: Customer can view any provider's full profile. Provider can edit their own profile and upload a photo.

---

## Phase 6: Booking System (The Core Feature!)

🎯 **Goal**: Customer can book a provider. Provider can accept/reject. Both see booking status updates in real-time.

### Order to code:

```
1.  lib/features/booking/domain/entities/booking_entity.dart
2.  lib/features/booking/domain/repositories/booking_repository.dart
3.  lib/features/booking/domain/usecases/create_booking.dart
4.  lib/features/booking/domain/usecases/get_user_bookings.dart
5.  lib/features/booking/domain/usecases/update_booking_status.dart
6.  lib/features/booking/domain/usecases/cancel_booking.dart
7.  lib/features/booking/data/models/booking_model.dart
8.  lib/features/booking/data/datasources/booking_remote_datasource.dart
9.  lib/features/booking/data/repositories/booking_repository_impl.dart
10. lib/features/booking/presentation/providers/booking_provider.dart
11. lib/features/booking/presentation/widgets/date_time_picker.dart
12. lib/features/booking/presentation/widgets/booking_card.dart
13. lib/features/booking/presentation/widgets/booking_status_timeline.dart
14. lib/features/booking/presentation/screens/booking_form_screen.dart
15. lib/features/booking/presentation/screens/booking_confirmation_screen.dart
16. lib/features/booking/presentation/screens/booking_detail_screen.dart
17. lib/features/booking/presentation/screens/my_bookings_screen.dart
18. lib/features/booking/presentation/screens/provider_requests_screen.dart

-- Now build the provider home screen --
19. lib/features/home/presentation/screens/provider_home_screen.dart

-- Shared widget --
20. lib/core/widgets/booking_status_badge.dart
21. lib/core/widgets/confirmation_dialog.dart
```

### The booking flow:

```
Customer taps "Book Now" on provider profile
    → booking_form_screen (select date, time, address, notes)
    → create_booking usecase → inserts row in Supabase
    → booking_confirmation_screen (shows booking ID, status = pending)

Provider opens app
    → provider_home_screen / provider_requests_screen
    → sees new booking request
    → taps Accept or Reject
    → update_booking_status usecase → updates Supabase row

Customer's booking_detail_screen
    → subscribed to Supabase Realtime on this booking row
    → status automatically updates from "pending" to "accepted"
    → UI shows timeline progression
```

💡 **Suggestions**:
- **Supabase Realtime is your best friend here**. Subscribe to changes on the `bookings` table filtered by booking ID. When the provider accepts, the customer's screen updates instantly without refreshing.
- **The booking status timeline widget** is a great UX element. Show: Requested → Accepted → Provider En Route → In Progress → Completed as a vertical stepper.
- **Add cancellation logic carefully**: Only allow cancellation if status is `pending` or `accepted`. Once `inProgress`, no cancellation.
- **Common mistake**: Not handling the case where a provider rejects a booking. The customer needs to see "Rejected" and be able to book someone else.
- **Test with two devices/emulators** — one as customer, one as provider. This is the only way to properly test the real-time flow.

✅ **Done when**: Full flow works: Customer books → Provider gets the request → Provider accepts → Customer sees "Accepted" in real-time → Provider marks complete → Customer sees "Completed".

---

## Phase 7: Push Notifications

🎯 **Goal**: Users get push notifications for booking updates.

### Order to code:

```
1.  lib/core/services/notifications/notification_service.dart
2.  lib/features/notifications/domain/entities/notification_entity.dart
3.  lib/features/notifications/domain/repositories/notifications_repository.dart
4.  lib/features/notifications/domain/usecases/get_notifications.dart
5.  lib/features/notifications/domain/usecases/mark_as_read.dart
6.  lib/features/notifications/data/models/notification_model.dart
7.  lib/features/notifications/data/datasources/notifications_remote_datasource.dart
8.  lib/features/notifications/data/repositories/notifications_repository_impl.dart
9.  lib/features/notifications/presentation/providers/notifications_provider.dart
10. lib/features/notifications/presentation/widgets/notification_tile.dart
11. lib/features/notifications/presentation/screens/notifications_screen.dart
```

### How notifications work in ServiceWala:

```
Booking created → Supabase Database Trigger → calls Edge Function
    → Edge Function sends FCM push to provider's device
    → Provider sees notification: "New booking request from Rahul"

Provider accepts → same flow → Customer sees: "Your booking was accepted!"
```

💡 **Suggestions**:
- **You need a Supabase Edge Function** (or database webhook) to send FCM pushes. The Flutter app can't send pushes to other devices directly.
- **Save the FCM token** to the `users` table when the user logs in. The Edge Function reads this token to send the push.
- **Handle foreground notifications** (app is open) and **background notifications** (app is closed) differently. Use `flutter_local_notifications` for foreground.
- **Don't overcomplicate V1**: Just send notifications for booking status changes. Add promotional/system notifications later.

✅ **Done when**: Provider gets a push when customer books. Customer gets a push when provider accepts/rejects/completes.

---

## Phase 8: Reviews & Ratings

🎯 **Goal**: After a completed booking, customer can rate and review the provider.

### Order to code:

```
1.  lib/features/reviews/domain/entities/review_entity.dart
2.  lib/features/reviews/domain/repositories/reviews_repository.dart
3.  lib/features/reviews/domain/usecases/submit_review.dart
4.  lib/features/reviews/domain/usecases/get_provider_reviews.dart
5.  lib/features/reviews/data/models/review_model.dart
6.  lib/features/reviews/data/datasources/reviews_remote_datasource.dart
7.  lib/features/reviews/data/repositories/reviews_repository_impl.dart
8.  lib/features/reviews/presentation/providers/reviews_provider.dart
9.  lib/features/reviews/presentation/widgets/star_rating_input.dart
10. lib/features/reviews/presentation/widgets/review_card.dart
11. lib/features/reviews/presentation/screens/write_review_screen.dart
12. lib/features/reviews/presentation/screens/reviews_list_screen.dart
```

💡 **Suggestions**:
- **Show the review prompt automatically** when a booking status changes to `completed`. Use a bottom sheet or navigate to the review screen.
- **Update the provider's average rating** after each review. Use a Supabase database function or do it in the Edge Function.
- **One review per booking** — enforce with a UNIQUE constraint on `booking_id` in the reviews table (already in the schema above).

✅ **Done when**: Customer completes a booking → prompted to review → submits 4-star rating with comment → provider's profile shows updated rating.

---

## Phase 9: Live Tracking + Voice Calling

🎯 **Goal**: Customer sees provider's live location on a map. Customer and provider can voice call each other.

### Order to code (Tracking):

```
1.  lib/core/services/location/location_service.dart
2.  lib/features/tracking/domain/entities/location_entity.dart
3.  lib/features/tracking/domain/repositories/tracking_repository.dart
4.  lib/features/tracking/domain/usecases/start_tracking.dart
5.  lib/features/tracking/domain/usecases/stop_tracking.dart
6.  lib/features/tracking/domain/usecases/get_live_location.dart
7.  lib/features/tracking/data/models/location_model.dart
8.  lib/features/tracking/data/datasources/tracking_remote_datasource.dart
9.  lib/features/tracking/data/repositories/tracking_repository_impl.dart
10. lib/features/tracking/presentation/providers/tracking_provider.dart
11. lib/features/tracking/presentation/widgets/map_widget.dart
12. lib/features/tracking/presentation/widgets/provider_location_marker.dart
13. lib/features/tracking/presentation/widgets/eta_display.dart
14. lib/features/tracking/presentation/screens/live_tracking_screen.dart
```

### Order to code (Calling):

```
15. lib/core/services/calling/agora_service.dart
16. lib/features/calling/domain/entities/call_entity.dart
17. lib/features/calling/domain/repositories/calling_repository.dart
18. lib/features/calling/domain/usecases/start_call.dart
19. lib/features/calling/domain/usecases/end_call.dart
20. lib/features/calling/data/models/call_model.dart
21. lib/features/calling/data/datasources/calling_remote_datasource.dart
22. lib/features/calling/data/repositories/calling_repository_impl.dart
23. lib/features/calling/presentation/providers/calling_provider.dart
24. lib/features/calling/presentation/widgets/call_controls.dart
25. lib/features/calling/presentation/widgets/call_timer.dart
26. lib/features/calling/presentation/screens/voice_call_screen.dart
```

💡 **Suggestions**:
- **Tracking flow**: When provider accepts and taps "On My Way", start broadcasting location to `provider_locations` table via Supabase Realtime. Customer's map subscribes to that channel.
- **Don't send location too frequently**. Every 5–10 seconds is enough. More frequent = more Supabase usage = more cost.
- **Agora token generation MUST happen server-side** (Supabase Edge Function). Never put your Agora App Certificate in the Flutter app.
- **Voice calling is the hardest feature**. Save it for last. The booking flow works fine without it — users can always call via regular phone in V1.
- **Test on real devices**. Agora and Google Maps don't work properly on emulators.

✅ **Done when**: When booking is "En Route", customer opens map and sees provider's marker moving. Customer taps call button → voice call connects → both can talk.

---

## Phase 10: Profile, Chat & Polish

🎯 **Goal**: Remaining features + polish for launch.

### Order to code:

```
-- Profile --
1.  lib/features/profile/domain/entities/profile_entity.dart
2.  lib/features/profile/domain/repositories/profile_repository.dart
3.  lib/features/profile/domain/usecases/get_profile.dart
4.  lib/features/profile/domain/usecases/update_profile.dart
5.  lib/features/profile/data/models/profile_model.dart
6.  lib/features/profile/data/datasources/profile_remote_datasource.dart
7.  lib/features/profile/data/repositories/profile_repository_impl.dart
8.  lib/features/profile/presentation/providers/profile_provider.dart
9.  lib/features/profile/presentation/widgets/profile_header.dart
10. lib/features/profile/presentation/widgets/settings_tile.dart
11. lib/features/profile/presentation/screens/profile_screen.dart
12. lib/features/profile/presentation/screens/edit_profile_screen.dart
13. lib/features/profile/presentation/screens/settings_screen.dart

-- Chat (if time permits, otherwise launch without it) --
14-27. lib/features/chat/... (all files)
```

💡 **Suggestions**:
- **Chat is optional for V1 launch**. Users can communicate via voice call or the booking notes field. Add chat in V1.1.
- **Settings screen must have**: dark mode toggle, notification on/off, privacy policy link, terms link, about/version, logout, delete account.
- **Delete account** is required by Google Play and App Store policies. Don't skip it.
- **Polish checklist before launch**:
  - [ ] Loading states on every screen (shimmer or spinner)
  - [ ] Error states on every screen (retry button)
  - [ ] Empty states ("No bookings yet")
  - [ ] Pull-to-refresh on all list screens
  - [ ] Proper keyboard handling (scroll when keyboard opens)
  - [ ] Network error handling (show offline banner)
  - [ ] App icon and splash screen
  - [ ] Smooth page transitions

✅ **Done when**: The app feels complete and polished. No blank screens, no unhandled errors, smooth navigation everywhere.

---

## Summary: The Build Order

| Phase | What | Estimated Time |
|---|---|---|
| **0** | Project setup, API keys, packages | 1–2 days |
| **1** | Core layer (constants, theme, utils, services) | 2–3 days |
| **2** | Supabase database schema | 1 day |
| **3** | Auth (signup, login, OTP, role selection) | 4–5 days |
| **4** | Home screen + service browsing | 3–4 days |
| **5** | Provider profiles | 2–3 days |
| **6** | Booking system (the big one) | 5–7 days |
| **7** | Push notifications | 2–3 days |
| **8** | Reviews & ratings | 2–3 days |
| **9** | Live tracking + voice calling | 5–7 days |
| **10** | Profile, chat, polish | 3–5 days |
| | **Total** | **~30–45 days** |

> This timeline assumes you're working on it consistently. Could be faster if you're experienced with Flutter, slower if you're learning as you go. **Don't rush**. A solid Phase 3 (auth) and Phase 6 (booking) are worth spending extra time on.

---

## Common Mistakes to Avoid

| # | Mistake | Why it's bad | What to do instead |
|---|---|---|---|
| 1 | Jumping to UI without domain layer | You'll rewrite everything when requirements change | Always code domain → data → presentation |
| 2 | Hardcoding Supabase queries in widgets | Impossible to test, impossible to refactor | Use the repository pattern (datasource → repository → usecase → provider) |
| 3 | Skipping error handling | App crashes on bad network, empty responses | Every Supabase call should be in try/catch. Every provider should have loading/error/data states |
| 4 | Not testing with two devices | Can't verify real-time booking flow | Use one phone + one emulator, or two emulators |
| 5 | Building all features before testing any | You'll have 50 bugs at once | Build → test → fix → move on. Phase by phase. |
| 6 | Putting Agora App Certificate in Flutter code | Anyone can decompile your APK and steal it | Generate Agora tokens server-side (Supabase Edge Function) |
| 7 | Not enabling RLS in Supabase | Any user can read/write any data | Enable RLS on every table. Write policies for each operation. |
| 8 | Forgetting to save FCM token | Push notifications won't reach the user | Save token to `users` table on every login, refresh on token change |
| 9 | Not handling provider offline status | Customers try to book offline providers | Show online/offline status. Disable "Book Now" for offline providers. |
| 10 | Over-engineering V1 | You never launch | Build the minimum that proves the model works. Polish later. |

---

## Recommended Learning Resources

| Topic | Resource |
|---|---|
| Riverpod | [riverpod.dev](https://riverpod.dev) — official docs + code generation guide |
| GoRouter | [pub.dev/packages/go_router](https://pub.dev/packages/go_router) — examples section |
| Supabase + Flutter | [supabase.com/docs/guides/getting-started/quickstarts/flutter](https://supabase.com/docs/guides/getting-started/quickstarts/flutter) |
| Supabase Realtime | [supabase.com/docs/guides/realtime](https://supabase.com/docs/guides/realtime) |
| Supabase Edge Functions | [supabase.com/docs/guides/functions](https://supabase.com/docs/guides/functions) |
| Agora Voice | [docs.agora.io/en/voice-calling/get-started/get-started-sdk](https://docs.agora.io/en/voice-calling/get-started/get-started-sdk) |
| Clean Architecture in Flutter | Search "Reso Coder Clean Architecture" on YouTube |
| Google Maps Flutter | [pub.dev/packages/google_maps_flutter](https://pub.dev/packages/google_maps_flutter) |

---

*This guide is your development roadmap. Follow the phases in order. When you get stuck, re-read the relevant phase. When you feel like skipping ahead, don't — each phase depends on the ones before it. Good luck building ServiceWala!* 🚀
