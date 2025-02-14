import 'package:flutter/material.dart';
import 'explore_screen.dart';
import 'create_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Word Duel',
      home: const GalileoDesign(),
    );
  }
}

class GalileoDesign extends StatelessWidget {
  const GalileoDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffoldを利用することで、Navigatorのコンテキストが正しく確保されます
      body: Container(
        width: 1280,
        height: 800,
        color: Colors.white,
        child: Column(
          children: [
            // ヘッダー部分
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F9F9),
                border: Border.all(color: const Color(0xFFE5E8EA)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // ロゴとタイトル
                  Row(
                    children: [
                      SizedBox(
                        width: 16,
                        height: 16,
                        child: const Icon(Icons.ac_unit, size: 16),
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        'Word Duel',
                        style: TextStyle(
                          color: Color(0xFF0C161C),
                          fontSize: 18,
                          fontFamily: 'Lexend',
                          fontWeight: FontWeight.w700,
                          height: 1.28,
                        ),
                      ),
                    ],
                  ),
                  // ナビゲーションとユーザー情報
                  Row(
                    children: [
                      // ナビゲーション項目：Home（アクティブ）、Explore、Create
                      Row(
                        children: [
                          _buildNavItem(context, 'Home', isActive: true),
                          const SizedBox(width: 36),
                          _buildNavItem(
                            context,
                            'Explore',
                            screen: const ExploreScreen(),
                          ),
                          const SizedBox(width: 36),
                          _buildNavItem(
                            context,
                            'Create',
                            screen: const CreateScreen(),
                          ),
                        ],
                      ),
                      const SizedBox(width: 32),
                      // スコアとアイコン
                      Row(
                        children: [
                          Container(
                            width: 115,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: ShapeDecoration(
                              color: const Color(0xFF1E93E0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'Score: 1200',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFFF7F9F9),
                                  fontSize: 14,
                                  fontFamily: 'Lexend',
                                  fontWeight: FontWeight.w700,
                                  height: 1.50,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          _buildIconContainer(icon: Icons.person),
                          const SizedBox(width: 8),
                          _buildIconContainer(icon: Icons.notifications),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // メインコンテンツ部分
            Expanded(
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 160, vertical: 20),
                child: Center(
                  child: Container(
                    width: 960,
                    height: 695,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        // タイトルエリア
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(
                            top: 20,
                            left: 16,
                            right: 16,
                            bottom: 12,
                          ),
                          child: const Text(
                            'Compete in real-time English learning games',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF0C161C),
                              fontSize: 28,
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.w700,
                              height: 1.25,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // アクションボタン
                        _buildActionButton('Start a game', isPrimary: true),
                        const SizedBox(height: 12),
                        _buildActionButton('View profile', isPrimary: false),
                        const SizedBox(height: 12),
                        _buildActionButton('Check rankings', isPrimary: false),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// [screen] パラメータに指定されたウィジェットへ直接遷移します
  Widget _buildNavItem(BuildContext context, String title,
      {bool isActive = false, Widget? screen}) {
    return InkWell(
      onTap: () {
        if (!isActive && screen != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              color:
                  isActive ? const Color(0xFF1E93E0) : const Color(0xFF0C161C),
              fontSize: 14,
              fontFamily: 'Lexend',
              fontWeight: FontWeight.w500,
              height: 1.50,
            ),
          ),
          if (isActive)
            Container(
              margin: const EdgeInsets.only(top: 4),
              height: 2,
              width: 20,
              color: const Color(0xFF1E93E0),
            ),
        ],
      ),
    );
  }

  Widget _buildIconContainer({required IconData icon}) {
    return Container(
      width: 40,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: ShapeDecoration(
        color: const Color(0xFFE8EDF2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Center(
        child: Icon(
          icon,
          size: 20,
          color: const Color(0xFF0C161C),
        ),
      ),
    );
  }

  Widget _buildActionButton(String title, {required bool isPrimary}) {
    return Container(
      width: double.infinity,
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: ShapeDecoration(
        color: isPrimary ? const Color(0xFF1E93E0) : const Color(0xFFE8EDF2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color:
                isPrimary ? const Color(0xFFF7F9F9) : const Color(0xFF0C161C),
            fontSize: 16,
            fontFamily: 'Lexend',
            fontWeight: FontWeight.w700,
            height: 1.50,
          ),
        ),
      ),
    );
  }
}
