import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('sanity test', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1920, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: SafeArea(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Image.network(
                          'https://cdn.builder.io/api/v1/image/assets%2Ff1af6bdc9b6340ed933494acecf65fe5%2F35678fcd6a6440e0b559add086501a11?format=webp&width=800&height=1200',
                          width: 48,
                          height: 48,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          'AgendaPet',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(child: Center(child: Text('Hello'))),
            ],
          ),
        ),
      ));
      expect(tester.takeException(), isNull);
    });
  });
}
