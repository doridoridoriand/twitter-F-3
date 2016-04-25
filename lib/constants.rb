module Constants
  WRONG_FORMAT                  = '不正なフォーマットです'
  USER_ID_ALREADY_IN_USE        = 'すでにIDが使われています'
  LOGIN_INFORMATION_HAS_WRONG   = 'ユーザーIDまたはパスワードが間違っています'
  USER_ID_CAN_GET               = 'このIDは使用可能です'
  USER_NOT_FOUND                = 'ユーザーが存在しません'
  USER_ID_BROKEN                = 'ユーザーIDに英数字以外が混ざっています'
  UUID_NOT_FOUND                = '該当するユーザーが発見できませんでした'
  TOKEN_BROKEN                  = 'トークンが不正です'
  CONTENT_OVER_140              = 'つぶやき内容が140文字を超えています'
  TARGET_USER_ALREADY_FOLLOWED  = '指定したユーザーは既にフォローしています'
  TARGET_USER_NOT_FOLLOW_YET    = '指定したユーザーはまだフォローしていません'
  TWEET_NOT_FOUND_ERROR         = '指定したツイートは既に削除されているか、非公開にされているため用事できませんでした'
  TWEET_ALREADY_LIKED           = '指定したツイートは既にlikeしています'
  TWEET_NOT_LIKE_YET            = '指定したツイートはまだlikeしていません'
  TWEET_REPLY                   = 'ツイートにリプライがきました'
  TWEET_LIKED                   = 'ツイートがお気に入りされました'
  TWEET_RETWEETED               = 'ツイートがリツイートされました'

  ROOT_URL                      = 'http://192.168.33.10'

  ALPHABET_INTEGER_MATCHER      = /^[a-zA-Z0-9]+$/
end
