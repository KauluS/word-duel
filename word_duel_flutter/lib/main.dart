import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() {
  runApp(WordDuelApp());
}

class WordDuelApp extends StatelessWidget {
  const WordDuelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Word Duel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // 初期画面はログイン画面
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/home': (context) => HomeScreen(),
        '/waiting': (context) => WaitingScreen(),
        '/battle': (context) => BattleScreen(),
        '/battleResult': (context) => BattleResultScreen(),
      },
    );
  }
}

// ================== ログイン画面 ==================
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  void _login() {
    if (_formKey.currentState!.validate()) {
      // ログイン処理を実装した後、ホーム画面へ遷移する例
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ログイン'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'メールアドレス'),
                onChanged: (val) => email = val,
                validator: (val) =>
                    (val == null || val.isEmpty) ? 'メールアドレスを入力してください' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'パスワード'),
                obscureText: true,
                onChanged: (val) => password = val,
                validator: (val) =>
                    (val == null || val.isEmpty) ? 'パスワードを入力してください' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                child: Text('ログイン'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: Text('アカウント作成はこちら'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ================== アカウント作成画面 ==================
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  SignupScreenState createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String confirmPassword = '';

  void _signup() {
    if (_formKey.currentState!.validate()) {
      // アカウント作成処理を実装した後、ホーム画面へ遷移する例
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('アカウント作成'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'メールアドレス'),
                onChanged: (val) => email = val,
                validator: (val) =>
                    (val == null || val.isEmpty) ? 'メールアドレスを入力してください' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'パスワード'),
                obscureText: true,
                onChanged: (val) => password = val,
                validator: (val) =>
                    (val == null || val.isEmpty) ? 'パスワードを入力してください' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'パスワード確認'),
                obscureText: true,
                onChanged: (val) => confirmPassword = val,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'パスワード確認を入力してください';
                  } else if (val != password) {
                    return 'パスワードが一致しません';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _signup,
                child: Text('アカウント作成'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ================== ホーム画面 ==================
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // 各タブ用のウィジェット（ここでは簡単なプレースホルダー）
  final List<Widget> _pages = [
    ScorePage(),
    RankingPage(),
    ProfilePage(),
    SettingsPage(),
    NotificationsPage(),
  ];

  void _onSelectPage(int index) {
    setState(() {
      _currentIndex = index;
    });
    Navigator.pop(context); // Drawer を閉じる
  }

  // アプリバーに対戦画面へ遷移するボタンも追加例
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ホーム'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'メニュー',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.score),
              title: Text('スコア'),
              onTap: () => _onSelectPage(0),
            ),
            ListTile(
              leading: Icon(Icons.leaderboard),
              title: Text('ランキング'),
              onTap: () => _onSelectPage(1),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('プロフィール'),
              onTap: () => _onSelectPage(2),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('設定'),
              onTap: () => _onSelectPage(3),
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('通知'),
              onTap: () => _onSelectPage(4),
            ),
          ],
        ),
      ),
      body: _pages[_currentIndex],
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // 対戦マッチング画面へ遷移
          Navigator.pushNamed(context, '/waiting');
        },
        label: Text('対戦開始'),
        icon: Icon(Icons.play_arrow),
      ),
    );
  }
}

// ホーム画面の各タブ用プレースホルダーウィジェット
class ScorePage extends StatelessWidget {
  const ScorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('スコア表示'));
  }
}

class RankingPage extends StatelessWidget {
  const RankingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('ランキング表示'));
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('プロフィール表示'));
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('設定表示'));
  }
}

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('通知表示'));
  }
}

// ================== マッチング（待機）画面 ==================
class WaitingScreen extends StatefulWidget {
  const WaitingScreen({super.key});

  @override
  WaitingScreenState createState() => WaitingScreenState();
}

class WaitingScreenState extends State<WaitingScreen> {
  late WebSocketChannel channel;

  @override
  void initState() {
    super.initState();
    _connectWebSocket();
  }

  /// WebSocket 接続の初期化とメッセージ受信の処理を別メソッドに切り出し
  void _connectWebSocket() {
    // ※実際のサーバー URL に合わせて変更してください
    channel = WebSocketChannel.connect(Uri.parse('ws://localhost:8080'));

    channel.stream.listen((message) {
      // 受信メッセージが String でない場合は文字列に変換
      String messageStr;
      if (message is String) {
        messageStr = message;
      } else if (message is List<int>) {
        messageStr = utf8.decode(message);
      } else {
        messageStr = message.toString();
      }
      debugPrint('Received: $messageStr');

      try {
        final decoded = jsonDecode(messageStr);
        // サーバー側から送信されたメッセージが name_received の場合、対戦相手の名前を取得
        if (decoded['type'] == 'name_received') {
          _showMatchSuccessDialog(decoded['name']);
        }
      } catch (e) {
        debugPrint('JSON decode error: $e');
      }
    });

    // シミュレーション用：5秒後に対戦相手の名前 "Alice" を送信
    Future.delayed(Duration(seconds: 5), () {
      channel.sink.add(jsonEncode({'name': 'Alice'}));
    });
  }

  /// マッチング成功時のポップアップを表示し、OK押下後に対戦画面へ遷移
  void _showMatchSuccessDialog(String opponentName) {
    showDialog(
      context: context,
      barrierDismissible: false, // ユーザーがダイアログ外をタップして閉じないようにする
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('マッチング成功'),
          content: Text('対戦相手: $opponentName が見つかりました！'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // ポップアップを閉じる
                Navigator.pushReplacementNamed(context, '/battle');
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('マッチング中'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('対戦相手を探しています...'),
          ],
        ),
      ),
    );
  }
}

// ================== 対戦画面 ==================
class BattleScreen extends StatefulWidget {
  const BattleScreen({super.key});

  @override
  BattleScreenState createState() => BattleScreenState();
}

class BattleScreenState extends State<BattleScreen> {
  final TextEditingController _controller = TextEditingController();
  List<String> usedWords = [];

  void _submitWord() {
    String word = _controller.text.trim();
    if (word.isNotEmpty) {
      setState(() {
        usedWords.add(word);
      });
      _controller.clear();
      // ここでしりとりのルールチェックや対戦ロジックを実装可能
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('対戦中'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('英単語でしりとりを行ってください'),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: usedWords.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(usedWords[index]),
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: '単語を入力',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _submitWord,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

// ================== 対戦結果画面 ==================
class BattleResultScreen extends StatelessWidget {
  // サンプル用の固定データ（実際は対戦後の結果データを渡す）
  final List<String> usedWords;
  final List<String> battleHistory;

  const BattleResultScreen({
    super.key,
    this.usedWords = const ['apple', 'elephant', 'tiger'],
    this.battleHistory = const ['勝ち', '負け', '勝ち'],
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('対戦結果'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('使用した単語:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: usedWords.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(usedWords[index]),
                );
              },
            ),
            Divider(),
            Text('対戦履歴:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: battleHistory.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('試合 ${index + 1}: ${battleHistory[index]}'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
