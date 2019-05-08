class GetChatroomWithUsers
  def self.call(user1_id, user2_id)
    Chatroom.find_by_sql ["SELECT  chatrooms.* FROM chatrooms INNER JOIN chatroom_users ON chatrooms.id = chatroom_users.chatroom_id WHERE chatroom_users.user_id = ?  INTERSECT SELECT  chatrooms.* FROM chatrooms INNER JOIN chatroom_users ON chatrooms.id = chatroom_users.chatroom_id WHERE chatroom_users.user_id = ?", 1, 2]
  end
end