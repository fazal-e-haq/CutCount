import 'package:flutter_test/flutter_test.dart';
import 'package:cut_count/data/models/service_model.dart';
import 'package:cut_count/data/models/cut_record_model.dart';
import 'package:flutter/material.dart';

// The main() function is the entry point for all tests.
void main() {
  
  // A 'group' is used to organize multiple related tests together.
  // This makes the test output much easier to read in the terminal.
  group('Data Models Tests', () {
    
    // 'test' defines a single test case. 
    // The description string should explicitly state what you expect to happen.
    test('ServiceModel should store and retrieve data correctly', () {
      
      // The universally accepted testing pattern is: Arrange, Act, Assert (AAA).
      
      // 1. Arrange: Set up the objects and variables we need for the test.
      final service = ServiceModel()
        ..name = 'Fade Cut'
        ..price = 500.0
        ..iconCodePoint = Icons.content_cut.codePoint
        ..note = 'Basic fade';

      // 2. Act: Perform the action you are testing.
      // (For simple models, this just means reading the properties we just set).
      final name = service.name;
      final price = service.price;

      // 3. Assert: Verify the result matches our expectations.
      // If ANY expect() fails, this entire test fails.
      expect(name, 'Fade Cut');
      expect(price, 500.0);
      expect(service.note, 'Basic fade');
      expect(service.iconCodePoint, Icons.content_cut.codePoint);
    });

    test('CutRecordModel should store data correctly', () {
      // 1. Arrange
      final now = DateTime.now();
      final record = CutRecordModel()
        ..serviceName = 'Shave'
        ..price = 200.0
        ..timestamp = now;

      // 2. Act
      final name = record.serviceName;

      // 3. Assert
      expect(name, 'Shave');
      expect(record.price, 200.0);
      expect(record.timestamp, now);
    });
  });
}
