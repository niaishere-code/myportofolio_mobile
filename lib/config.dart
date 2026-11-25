/// Base URL of the Django REST Framework backend.
///
/// Defaults to `http://10.0.2.2:8000` (IP address of local development machine from Android emulator).
/// Override with `--dart-define=API_BASE_URL=http://localhost:8000` on Chrome/Web.
const String apiBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://10.0.2.2:8000',
);