// import 'package:flutter/material.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
//
// // Main Function
// void main() {
//   runApp(const MyApp());
// }
//
// // Main Application Widget
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'QR Scanner',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const SimpleQRScannerScreen(),
//     );
//   }
// }
//
// // QR Scanner Screen Widget
// class SimpleQRScannerScreen extends StatefulWidget {
//   const SimpleQRScannerScreen({Key? key}) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() => _SimpleQRScannerScreenState();
// }
//
// // State Class for QR Scanner
// class _SimpleQRScannerScreenState extends State<SimpleQRScannerScreen> {
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   Barcode? result;
//   QRViewController? controller;
//
//   @override
//   void reassemble() {
//     super.reassemble();
//     controller?.pauseCamera();
//     controller?.resumeCamera();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('QR Scanner'),
//         centerTitle: true,
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             flex: 4,
//             child: QRView(
//               key: qrKey,
//               onQRViewCreated: _onQRViewCreated,
//               overlay: QrScannerOverlayShape(
//                 borderColor: Colors.blueAccent,
//                 borderRadius: 10,
//                 borderLength: 20,
//                 borderWidth: 5,
//                 cutOutSize: 250,
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Center(
//               child: result != null
//                   ? Text(
//                 'Result: ${result!.code}',
//                 style: TextStyle(fontSize: 18),
//               )
//                   : Text(
//                 'Scan a QR code',
//                 style: TextStyle(fontSize: 16, color: Colors.grey),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _onQRViewCreated(QRViewController controller) {
//     setState(() {
//       this.controller = controller;
//     });
//     controller.scannedDataStream.listen((scanData) {
//       setState(() {
//         result = scanData;
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
// }
