import 'package:flutter/material.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1280,
      height: 800,
      color: Colors.white,
      child: Column(
        children: [
          // ヘッダー部分（Word Duelのロゴとナビゲーション）
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
                    // ナビゲーション項目（Exploreがアクティブ）
                    Row(
                      children: [
                        _buildNavItem('Home', isActive: false),
                        const SizedBox(width: 36),
                        _buildNavItem('Explore', isActive: true),
                        const SizedBox(width: 36),
                        _buildNavItem('Create', isActive: false),
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
          // Explore画面のメインコンテンツ部分
          Expanded(
            child: Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 160, vertical: 20),
              child: Column(
                children: [
                  // 検索バー
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search games, topics, or players',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                      ),
                    ),
                  ),
                  // グリッド表示（Explore用のコンテンツ例）
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        childAspectRatio: 1.2,
                      ),
                      itemCount: 6, // サンプル項目の数
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 画像プレースホルダー
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(12),
                                    ),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.image,
                                      size: 40,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ),
                              ),
                              // タイトル
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  'Game Mode ${index + 1}',
                                  style: const TextStyle(
                                    color: Color(0xFF0C161C),
                                    fontSize: 16,
                                    fontFamily: 'Lexend',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ナビゲーション項目ウィジェット
  Widget _buildNavItem(String title, {bool isActive = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(
            color: isActive ? const Color(0xFF1E93E0) : const Color(0xFF0C161C),
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
