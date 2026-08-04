import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:cut_count/features/services/providers/services_provider.dart';
import 'package:cut_count/data/database/isar_service.dart';
import 'package:cut_count/data/models/service_model.dart';
import 'package:isar_community/isar.dart';

// --- MOCK CLASSES ---
// By extending Mock, we create "fake" versions of our dependencies. 
// This allows us to test the ServicesProvider without needing a real database connection!
class MockIsarService extends Mock implements IsarService {}
class MockIsar extends Mock implements Isar {}

// We need a fake ServiceModel for mocktail to use as a fallback when matching arguments in functions.
class FakeServiceModel extends Fake implements ServiceModel {}

void main() {
  
  // setUpAll runs ONCE before all tests in this file.
  setUpAll(() {
    // Register our fake class so mocktail knows how to handle it internally.
    registerFallbackValue(FakeServiceModel());
  });

  group('ServicesProvider Tests', () {
    late MockIsarService mockIsarService;
    
    // setUp runs before EVERY individual test.
    // We use it to ensure we start with a clean, fresh state each time.
    setUp(() {
      mockIsarService = MockIsarService();
      
      // We must tell our mock what to return when its methods are called!
      // Here we tell it: "When db is accessed, return a mock Isar object"
      when(() => mockIsarService.db).thenAnswer((_) async => MockIsar());
    });

    test('Provider should load empty list when database is empty initially', () async {
      // 1. Arrange
      // Tell the mock database to return an empty list when getAllServices is called.
      when(() => mockIsarService.getAllServices()).thenAnswer((_) async => []);
      
      // Tell the mock database to just complete successfully when saveService is called
      // (Because the provider tries to seed default services when empty).
      when(() => mockIsarService.saveService(any())).thenAnswer((_) async {});

      // 2. Act
      // Initializing the provider automatically calls _init(), which calls getAllServices().
      final provider = ServicesProvider(mockIsarService);
      
      // We wait a tiny bit to let the async _init() function finish.
      await Future.delayed(Duration.zero);

      // 3. Assert
      // Because we returned [] from getAllServices, the provider generates default services, 
      // then calls getAllServices again. Since we mocked getAllServices to always return [],
      // the final list will be empty in this specific test scenario.
      expect(provider.services.isEmpty, true);
      
      // Verify that the provider actually asked the database for the services!
      // This is incredibly useful for making sure your logic is actually running.
      verify(() => mockIsarService.getAllServices()).called(greaterThan(0));
    });

    test('Provider should add a service and refresh the list', () async {
      // 1. Arrange
      final fakeService = ServiceModel()..name = 'Test Service'..price = 100.0;
      
      // Setup the mock to return a list containing our fake service.
      when(() => mockIsarService.getAllServices()).thenAnswer((_) async => [fakeService]);
      when(() => mockIsarService.saveService(any())).thenAnswer((_) async {});

      final provider = ServicesProvider(mockIsarService);
      await Future.delayed(Duration.zero);

      // 2. Act
      final newService = ServiceModel()..name = 'New Service';
      await provider.addService(newService);

      // 3. Assert
      // Verify that saveService was called exactly once with our newService
      verify(() => mockIsarService.saveService(newService)).called(1);
      
      // Verify that the provider fetched the updated list after saving
      verify(() => mockIsarService.getAllServices()).called(greaterThan(1));
    });
  });
}
