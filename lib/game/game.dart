// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_chess_board/flutter_chess_board.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   ChessBoardController controller = ChessBoardController();
//   int totalGameTimeInSeconds = 600; // 10 minutes
//   int whiteTimeInSeconds = 0;
//   int blackTimeInSeconds = 0;
//   Timer? gameTimer;
//   bool isCheckmate = false;
//   List<String> gameMoves = [];

//   @override
//   void initState() {
//     super.initState();
//     controller.addListener(() {
//       handleClockStart();
//       checkForCheckmate();
//     });
//   }

//   void startGameTimer() {
//     gameTimer?.cancel();
//     gameTimer = Timer.periodic(Duration(seconds: 1), (timer) {
//       setState(() {
//         if (blackTimeInSeconds > 0) {
//           blackTimeInSeconds--;
//         } else {
//           gameTimer?.cancel();
//           // Handle timeout for black player
//         }

//         if (whiteTimeInSeconds > 0) {
//           whiteTimeInSeconds--;
//         } else {
//           gameTimer?.cancel();
//           // Handle timeout for white player
//         }
//       });
//     });
//   }

//   void handleClockStart() {
//     if (controller.game.turn == Color.BLACK) {
//       if (gameTimer != null) {
//         gameTimer?.cancel();
//       }
//       startBlackClock();
//     } else if (controller.game.turn == Color.WHITE) {
//       if (gameTimer != null) {
//         gameTimer?.cancel();
//       }
//       startWhiteClock();
//     }
//   }

//   void startBlackClock() {
//     if (blackTimeInSeconds == 0) {
//       blackTimeInSeconds = totalGameTimeInSeconds;
//     }
//     gameTimer = Timer.periodic(Duration(seconds: 1), (timer) {
//       setState(() {
//         if (blackTimeInSeconds > 0) {
//           blackTimeInSeconds--;
//         } else {
//           gameTimer?.cancel();
//           // Handle timeout for black player
//         }
//       });
//     });
//   }

//   void startWhiteClock() {
//     if (whiteTimeInSeconds == 0) {
//       whiteTimeInSeconds = totalGameTimeInSeconds;
//     }
//     gameTimer = Timer.periodic(Duration(seconds: 1), (timer) {
//       setState(() {
//         if (whiteTimeInSeconds > 0) {
//           whiteTimeInSeconds--;
//         } else {
//           gameTimer?.cancel();
//           // Handle timeout for white player
//         }
//       });
//     });
//   }

//   void checkForCheckmate() {
//     if (controller.game.in_checkmate) {
//       setState(() {
//         isCheckmate = true;
//       });
//       gameTimer?.cancel(); // Stop the timer on checkmate
//       showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Text("Checkmate!"),
//             content: Text("Checkmate has occurred."),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: Text("OK"),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }

//   void updateSavedGameState() {
//     // Update saved game state here
//   }

//   void printGameState() {
//     print("Current Game State:");
//     for (int row = 0; row < 8; row++) {
//       String rowStr = "";
//       for (int col = 0; col < 8; col++) {
//         String piece = gameMoves.isNotEmpty ? gameMoves.last : "-";
//         rowStr += "$piece ";
//       }
//       print(rowStr);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text("Chess Game"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ClockWidget(timeInSeconds: blackTimeInSeconds),
//             Expanded(
//               child: ChessBoard(
//                 controller: controller,
//                 boardColor: BoardColor.brown,
//                 boardOrientation: PlayerColor.white,
//                 onMove: () => handleMoveCallback(),
//               ),
//             ),
//             ClockWidget(timeInSeconds: whiteTimeInSeconds),
//             if (isCheckmate)
//               Text(
//                 "Checkmate!",
//                 style: TextStyle(
//                   fontSize: 24.0,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.red,
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   void handleMoveCallback() {
//     String moveString = ''; // Update this with move information
//     gameMoves.add(moveString);
//     print("Move: $moveString");
//     if (controller.game!.turn == Color.BLACK) {
//       startBlackClock();
//     } else if (controller.game!.turn == Color.WHITE) {
//       startWhiteClock();
//     }
//     updateSavedGameState();
//     printGameState();
//   }
// }

// class ClockWidget extends StatelessWidget {
//   final int timeInSeconds;

//   const ClockWidget({Key? key, required this.timeInSeconds}) : super(key: key);

//   String formatTime(int seconds) {
//     int minutes = seconds ~/ 60;
//     int remainingSeconds = seconds % 60;
//     return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         color: Colors.blue,
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       child: Text(
//         formatTime(timeInSeconds),
//         style: TextStyle(
//           fontSize: 24.0,
//           fontWeight: FontWeight.bold,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
// }

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_chess_board/flutter_chess_board.dart';
// import 'package:firebase_core/firebase_core.dart';
// //import 'package:firebase_database/firebase_database.dart';

// // void main() async {
// //   // WidgetsFlutterBinding.ensureInitialized();
// //   // await Firebase.initializeApp();
// //   runApp(const MyApp());
// // }

// class MyApp1 extends StatelessWidget {
//   const MyApp1({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   ChessBoardController controller = ChessBoardController();
//   int totalGameTimeInSeconds = 600;
//   int whiteTimeInSeconds = 0;
//   int blackTimeInSeconds = 0;
//   Timer? gameTimer;
//   bool isCheckmate = false;
//   List<String> gameMoves = [];
//   //final DatabaseReference _database = FirebaseDatabase.instance.ref();

//   @override
//   void initState() {
//     super.initState();
//     controller.addListener(() {
//       handleClockStart();
//       checkForCheckmate();
//     });
//   }

//   // void updateSavedGameState() {
//   //   Map<String, dynamic> gameState = {
//   //     'blackTimeInSeconds': blackTimeInSeconds,
//   //     'whiteTimeInSeconds': whiteTimeInSeconds,
//   //     'isCheckmate': isCheckmate,
//   //     'gameMoves': gameMoves,
//   //   };

//   //   _database.child('gameState').set(gameState).then((_) {
//   //     print('Game state saved to Firebase.');
//   //   }).catchError((error) {
//   //     print('Failed to save game state: $error');
//   //   });
//   // }

//   void startGameTimer() {
//     gameTimer?.cancel();
//     gameTimer = Timer.periodic(Duration(seconds: 1), (timer) {
//       setState(() {
//         if (blackTimeInSeconds > 0) {
//           blackTimeInSeconds--;
//         } else {
//           gameTimer?.cancel();
//           // Handle timeout for black player
//         }

//         if (whiteTimeInSeconds > 0) {
//           whiteTimeInSeconds--;
//         } else {
//           gameTimer?.cancel();
//           // Handle timeout for white player
//         }
//       });
//     });
//   }

//   void handleClockStart() {
//     if (controller.game.turn == Color.BLACK) {
//       if (gameTimer != null) {
//         gameTimer?.cancel();
//       }
//       startBlackClock();
//     } else if (controller.game.turn == Color.WHITE) {
//       if (gameTimer != null) {
//         gameTimer?.cancel();
//       }
//       startWhiteClock();
//     }
//   }

//   void startBlackClock() {
//     if (blackTimeInSeconds == 0) {
//       blackTimeInSeconds = totalGameTimeInSeconds;
//     }
//     gameTimer = Timer.periodic(Duration(seconds: 1), (timer) {
//       setState(() {
//         if (blackTimeInSeconds > 0) {
//           blackTimeInSeconds--;
//         } else {
//           gameTimer?.cancel();
//           // Handle timeout for black player
//         }
//       });
//     });
//   }

//   void startWhiteClock() {
//     if (whiteTimeInSeconds == 0) {
//       whiteTimeInSeconds = totalGameTimeInSeconds;
//     }
//     gameTimer = Timer.periodic(Duration(seconds: 1), (timer) {
//       setState(() {
//         if (whiteTimeInSeconds > 0) {
//           whiteTimeInSeconds--;
//         } else {
//           gameTimer?.cancel();
//           // Handle timeout for white player
//         }
//       });
//     });
//   }

//   void checkForCheckmate() {
//     if (controller.game.in_checkmate) {
//       setState(() {
//         isCheckmate = true;
//       });
//       gameTimer?.cancel(); // Stop the timer on checkmate
//       showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Text("Checkmate!"),
//             content: Text("Checkmate has occurred."),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: Text("OK"),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }

//   void handleMoveCallback() {
//     String moveString = ''; // Update this with move information
//     gameMoves.add(moveString);
//     print("Move: $moveString");
//     if (controller.game!.turn == Color.BLACK) {
//       startBlackClock();
//     } else if (controller.game!.turn == Color.WHITE) {
//       startWhiteClock();
//     }
//     //updateSavedGameState();
//     printGameState();
//   }

//   void printGameState() {
//     print("Current Game State:");
//     for (int row = 0; row < 8; row++) {
//       String rowStr = "";
//       for (int col = 0; col < 8; col++) {
//         String piece = gameMoves.isNotEmpty ? gameMoves.last : "-";
//         rowStr += "$piece ";
//       }
//       print(rowStr);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text("Chess Game"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ClockWidget(timeInSeconds: blackTimeInSeconds),
//             Expanded(
//               child: ChessBoard(
//                 controller: controller,
//                 boardColor: BoardColor.brown,
//                 boardOrientation: PlayerColor.white,
//                 onMove: () => handleMoveCallback(),
//               ),
//             ),
//             ClockWidget(timeInSeconds: whiteTimeInSeconds),
//             if (isCheckmate)
//               Text(
//                 "Checkmate!",
//                 style: TextStyle(
//                   fontSize: 24.0,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.red,
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ClockWidget extends StatelessWidget {
//   final int timeInSeconds;

//   const ClockWidget({Key? key, required this.timeInSeconds}) : super(key: key);

//   String formatTime(int seconds) {
//     int minutes = seconds ~/ 60;
//     int remainingSeconds = seconds % 60;
//     return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         color: Colors.blue,
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       child: Text(
//         formatTime(timeInSeconds),
//         style: TextStyle(
//           fontSize: 24.0,
//           fontWeight: FontWeight.bold,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ChessBoardController controller = ChessBoardController();
  List<String> gameMoves = [];

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      handleMoveCallback();
    });
  }

  void handleMoveCallback() {
    String moveString = ''; // Update this with move information
    gameMoves.add(moveString);
    print("Move: $moveString");
    printGameState();
  }

  void printGameState() {
    print("Current Game State:");
    for (int row = 0; row < 8; row++) {
      String rowStr = "";
      for (int col = 0; col < 8; col++) {
        String piece = gameMoves.isNotEmpty ? gameMoves.last : "-";
        rowStr += "$piece ";
      }
      print(rowStr);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Chess Game"),
      ),
      body: Center(
        child: ChessBoard(
          controller: controller,
          boardColor: BoardColor.brown,
          boardOrientation: PlayerColor.white,
          onMove: () => handleMoveCallback(),
        ),
      ),
    );
  }
}
