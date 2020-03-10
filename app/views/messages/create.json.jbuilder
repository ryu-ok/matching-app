json.created_at @message.created_at.strftime("%Y年%m月%d日 %H時%M分")
json.content @message.content
json.user_id @message.user.id
json.user_avatar @message.user.avatar_url