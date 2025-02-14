const WebSocket = require("ws");
const wss = new WebSocket.Server({ port: 8080 });

console.log("Word Duel WebSocketサーバーがポート8080で稼働中...");

wss.on("connection", (ws) => {
  console.log("プレイヤーが接続しました");

  ws.on("message", (message) => {
    console.log(`受信メッセージ: ${message}`);

    // 受信メッセージは JSON 形式と想定し、パースを試みる
    try {
      const data = JSON.parse(message);

      switch (data.type) {
        case "match_request":
          // 対戦開始リクエストを受信
          console.log("対戦開始リクエストを受信しました");
          // 全クライアントにマッチング中であることを通知
          broadcast(
            JSON.stringify({ type: "match_status", status: "マッチング中..." })
          );
          // シミュレーションとして、2秒後にマッチング成功の通知を送信
          setTimeout(() => {
            broadcast(
              JSON.stringify({ type: "match_found", opponent: "対戦相手" })
            );
            console.log("対戦相手が見つかりました");
          }, 2000);
          break;

        case "word_submission":
          // 対戦中の単語送信
          console.log(`送信された単語: ${data.word}`);
          broadcast(JSON.stringify({ type: "word_update", word: data.word }));
          break;

        default:
          // その他のメッセージはそのまま全クライアントに送信
          broadcast(message);
          break;
      }
    // 名前が追加された場合の処理
    if (data.name) {
      console.log(`プレイヤー名: ${data.name}`);
      ws.send(JSON.stringify({ type: "name_received", name: data.name }));
    }
    } catch (e) {
      console.error("メッセージのパースに失敗しました。:", e);
      // JSON 形式でない場合は、そのままブロードキャスト（必要に応じて処理を変更）
      broadcast(message);
    }
  });
});

/**
 * 接続中のすべてのクライアントにデータを送信します
 * @param {string} data 送信するデータ（文字列）
 */
function broadcast(data) {
  wss.clients.forEach((client) => {
    if (client.readyState === WebSocket.OPEN) {
      client.send(data);
    }
  });
}
