#WebsocketRails::BaseControllerを継承
 class WebsocketChatController < WebsocketRails::BaseController
   def message_recieve
      # クライアントからのメッセージを取得
     recieve_message = message()

     # websocket_chatイベントで接続しているクライアントにブロードキャスト
     broadcast_message(:websocket_chat, recieve_message)
  end

end
