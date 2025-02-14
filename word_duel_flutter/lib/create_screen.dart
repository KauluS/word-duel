import 'package:flutter/material.dart';

class CreateScreen extends StatelessWidget {
  const CreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffoldを使うことで、ステータスバーや戻るボタンへの対応が容易になります
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
                      Row(
                        children: [
                          _buildNavItem(context, 'Home', route: '/'),
                          const SizedBox(width: 36),
                          _buildNavItem(context, 'Explore', route: '/explore'),
                          const SizedBox(width: 36),
                          _buildNavItem(context, 'Create', isActive: true),
                        ],
                      ),
                      const SizedBox(width: 32),
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
            // メインコンテンツ部分：Create用フォーム
            Expanded(
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 160, vertical: 20),
                child: Center(
                  child: Container(
                    width: 960,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: const Color(0xFFE5E8EA)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Create a New Game',
                          style: TextStyle(
                            color: Color(0xFF0C161C),
                            fontSize: 28,
                            fontFamily: 'Lexend',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // ゲームタイトルの入力欄
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Game Title',
                            labelStyle: const TextStyle(
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF0C161C),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // 説明文の入力欄
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Description',
                            labelStyle: const TextStyle(
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF0C161C),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          maxLines: 3,
                        ),
                        const SizedBox(height: 20),
                        // ゲームモードの入力欄
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Game Mode',
                            labelStyle: const TextStyle(
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF0C161C),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        // 作成ボタン
                        Container(
                          width: double.infinity,
                          height: 48,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF1E93E0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Create Game',
                              style: TextStyle(
                                color: Color(0xFFF7F9F9),
                                fontSize: 16,
                                fontFamily: 'Lexend',
                                fontWeight: FontWeight.w700,
                                height: 1.50,
                              ),
                            ),
                          ),
                        ),
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

  // ナビゲーション項目ウィジェット
  Widget _buildNavItem(BuildContext context, String title,
      {bool isActive = false, String? route}) {
    return InkWell(
      onTap: () {
        if (route != null && !isActive) {
          Navigator.pushNamed(context, route);
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

  // アイコンコンテナウィジェット
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
}
