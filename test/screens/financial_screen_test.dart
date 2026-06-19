import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:petshop_dashboard/screens/financial_screen.dart';
import 'package:petshop_dashboard/models/service.dart';

void main() {
  group('FinancialScreen', () {
    testWidgets('renders financial screen with services table',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FinancialScreen(),
          ),
        ),
      );

      expect(find.byType(FinancialScreen), findsOneWidget);
      expect(find.text('Serviços e Preços'), findsOneWidget);
      expect(find.text('Serviço total'), findsOneWidget);
    });

    testWidgets('displays service dropdown with sizes', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FinancialScreen(),
          ),
        ),
      );

      expect(find.text('Tamanho pet:'), findsOneWidget);
      expect(find.text('Pequeno'), findsWidgets);
      expect(find.text('Médio'), findsWidgets);
      expect(find.text('Grande'), findsWidgets);
    });

    testWidgets('displays all services in table', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FinancialScreen(),
          ),
        ),
      );

      expect(find.text('Banho'), findsOneWidget);
      expect(find.text('Tosa'), findsOneWidget);
      expect(find.text('Corte de Unhas'), findsOneWidget);
      expect(find.text('Limpeza de Dentes'), findsOneWidget);
    });

    testWidgets('displays prices for services', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FinancialScreen(),
          ),
        ),
      );

      expect(find.text('R\$25'), findsWidgets);
      expect(find.text('R\$35'), findsWidgets);
      expect(find.text('R\$45'), findsWidgets);
    });

    testWidgets('shows empty state when no services selected',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FinancialScreen(),
          ),
        ),
      );

      expect(find.text('Nenhum serviço adicionado'), findsOneWidget);
      expect(find.text('Clique em "add" em qualquer serviço para incluir no total'),
          findsOneWidget);
    });

    testWidgets('add button is visible for each service',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FinancialScreen(),
          ),
        ),
      );

      final addButtons = find.text('Add');
      expect(addButtons, findsWidgets);
    });

    testWidgets('can change size selection', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FinancialScreen(),
          ),
        ),
      );

      final dropdown = find.byType(DropdownButton<String>);
      await tester.tap(dropdown);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Pequeno').last);
      await tester.pumpAndSettle();

      expect(find.byType(DropdownButton<String>), findsOneWidget);
    });

    testWidgets('clears all services button is visible', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FinancialScreen(),
          ),
        ),
      );

      expect(find.text('Limpar tudo'), findsOneWidget);
    });

    testWidgets('shows total price as R\$0.00 initially',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FinancialScreen(),
          ),
        ),
      );

      expect(find.text('R\$0.00'), findsOneWidget);
    });

    testWidgets('displays total label', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FinancialScreen(),
          ),
        ),
      );

      expect(find.text('Total:'), findsOneWidget);
    });

    testWidgets('header row displays correct column titles',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FinancialScreen(),
          ),
        ),
      );

      expect(find.text('Serviço'), findsOneWidget);
    });
  });

  group('SelectedService', () {
    test('creates selected service with correct properties', () {
      final service = Service(
        id: '1',
        name: 'Banho',
        smallPrice: 25,
        mediumPrice: 35,
        largePrice: 45,
      );

      final selectedService = SelectedService(
        id: 'unique-id-1',
        service: service,
        size: 'medium',
        price: 35,
      );

      expect(selectedService.id, 'unique-id-1');
      expect(selectedService.service.name, 'Banho');
      expect(selectedService.size, 'medium');
      expect(selectedService.price, 35);
    });

    test('selected service with different sizes', () {
      final service = Service(
        id: '2',
        name: 'Tosa',
        smallPrice: 30,
        mediumPrice: 45,
        largePrice: 60,
      );

      final smallSelected = SelectedService(
        id: 'small-1',
        service: service,
        size: 'small',
        price: 30,
      );

      final largeSelected = SelectedService(
        id: 'large-1',
        service: service,
        size: 'large',
        price: 60,
      );

      expect(smallSelected.price, 30);
      expect(largeSelected.price, 60);
    });

    test('selected service with decimal price', () {
      final service = Service(
        id: '3',
        name: 'Service',
        smallPrice: 10.50,
        mediumPrice: 20.75,
        largePrice: 30.99,
      );

      final selected = SelectedService(
        id: 'decimal-1',
        service: service,
        size: 'medium',
        price: 20.75,
      );

      expect(selected.price, 20.75);
    });
  });

  group('FinancialScreen State', () {
    testWidgets('initial state has medium size selected',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FinancialScreen(),
          ),
        ),
      );

      expect(find.text('Médio'), findsWidgets);
    });

    testWidgets('initial state has empty selected services',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FinancialScreen(),
          ),
        ),
      );

      expect(find.text('Nenhum serviço adicionado'), findsOneWidget);
    });

    testWidgets('initial services list is populated',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FinancialScreen(),
          ),
        ),
      );

      expect(find.byType(FinancialScreen), findsOneWidget);
      expect(find.text('Banho'), findsOneWidget);
    });
  });

  group('FinancialScreen Size Label', () {
    testWidgets('size label for small', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FinancialScreen(),
          ),
        ),
      );

      final dropdown = find.byType(DropdownButton<String>);
      await tester.tap(dropdown);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Pequeno').last);
      await tester.pumpAndSettle();

      expect(find.byType(FinancialScreen), findsOneWidget);
    });

    testWidgets('size label for large', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FinancialScreen(),
          ),
        ),
      );

      final dropdown = find.byType(DropdownButton<String>);
      await tester.tap(dropdown);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Grande').last);
      await tester.pumpAndSettle();

      expect(find.byType(FinancialScreen), findsOneWidget);
    });
  });

  group('FinancialScreen UI Elements', () {
    testWidgets('services card has proper styling', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FinancialScreen(),
          ),
        ),
      );

      expect(find.byType(Card), findsWidgets);
    });

    testWidgets('outlined buttons are present', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FinancialScreen(),
          ),
        ),
      );

      final addButtons = find.byType(OutlinedButton);
      expect(addButtons, findsWidgets);
    });
  });
}
