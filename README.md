# TeamF Twitter API

# Dependencies
- Ruby 2.2.3
- Sinatra 1.4.6
- MySQL 5.6
- Nginx 1.8.1

# webAPI Endpoints and Specification

## GET /
**Authorization Header Required**
[See RFC6750](https://tools.ietf.org/html/rfc6750)

`Authorization: Bearer xxxxxxxxxxxxxxx`

### Response
#### Token Verificated
```:json
[
  {
    "user_id": "Pasos2",
    "screen_name": "パソス",
    "content": "へい！",
    "tweet_detail_url": "http://192.168.33.10/527787da-e54b-4afb-8583-d603557f5679/7f87709bafdc71b63735",
    "created_at": "2016-04-16T16:38:27.000Z"
  }
]

```
#### Token Broken
```:json
{"error": "ユーザートークンが不正です"}
```

## POST /register
### Request Body
```:json
{
  "name": "username",
  "screenName": "ScreenName",
  "password": "password"
}
```

### Response
#### Register Succeed
```:json
{
  "result": true,
  "data": {
    "token": "LbQqzSUrrmB1EOg8UpLZ62LxJhgxFdtS",
    "screen_name": "あああああ"
  }
}
```
#### Register Fail
```:json
{
  "error": "error message"
}
```

## POST /login
### Request Body
```:json
{
  "name": "username",
  "password": "password"
}
```

### Response
#### Login Succeed
```:json
{
  "result": true,
  "data": {
    "token": "LbQqzSUrrmB1EOg8UpLZ62LxJhgxFdtS"
    "screen_name": "あああああ"
  }
}
```

#### Login Fail
```:json
{
  "error": "error message"
}
```

## POST /tweet
**Authorization Header Required**
[See RFC6750](https://tools.ietf.org/html/rfc6750)

`Authorization: Bearer xxxxxxxxxxxxxxx`

### Request Body
```:json
{
  "tweet": "tweet content (max 140 characters)"
}
```

### Response
#### Tweet Succeed
```:json
{"result": true}
```

#### Tweet Fail
```:json
{"error": "error message"}
```

## POST /follow
**Authorization Header Required**
[See RFC6750](https://tools.ietf.org/html/rfc6750)

`Authorization: Bearer xxxxxxxxxxxxxxx`

### Request Body
```:json
{
  "user_id": "xxxxxxxxxxxxxxx"
}
```

### Response
#### Follow Succeed
```:json
{"result": true}
```

#### Follow Fail
```:json
{"error": "error message"}
```

## POST /unfollow
**Authorization Header Required**
[See RFC6750](https://tools.ietf.org/html/rfc6750)

`Authorization: Bearer xxxxxxxxxxxxxxx`

### Request Body
```:json
{
  "user_id": "xxxxxxxxxxxxxxx"
}
```

### Response
#### Follow Succeed
```:json
{"result": true}
```

#### Follow Fail
```:json
{"error": "error message"}
```

## POST /check_user_id
### Request Body
```:json
{
  "user_id": "username"
}
```

### Response
```:json
{"error": "message (can use or not)"}
```

## POST /user_detail
**Authorization Header Required**
[See RFC6750](https://tools.ietf.org/html/rfc6750)

`Authorization: Bearer xxxxxxxxxxxxxxx`

### Request Body
```:json
{
  "user_id": "username"
}
```

or
```:json
{
  "token": "xxxxxxxxxxxxxxx"
}
```

### Response
```:json
{
    "user_id": "mofmofneko",
    "screen_name": "もふもふねこ"
}
```

## POST /logout
**Authorization Header Required**
[See RFC6750](https://tools.ietf.org/html/rfc6750)

`Authorization: Bearer xxxxxxxxxxxxxxx`

### Response
```:json
{"result": true}
```

## GET /following
**Authorization Header Required**
[See RFC6750](https://tools.ietf.org/html/rfc6750)

`Authorization: Bearer xxxxxxxxxxxxxxx`

### Response
```:json
[
  {
      "user_id": "mofmofneko",
      "screen_name": "もふもふねこ"
  }
]
```

## GET /followers
**Authorization Header Required**
[See RFC6750](https://tools.ietf.org/html/rfc6750)

`Authorization: Bearer xxxxxxxxxxxxxxx`

### Response
```:json
[
  {
      "user_id": "mofmofneko",
      "screen_name": "もふもふねこ"
  }
]
```

## GET /:user_id/with_recipes
URL example
`/mofmofneko/with_recipes`

### Response
#### User exist
```:json
[
  {
    "user_id": "Pasos2",
    "screen_name": "パソス",
    "content": "へい！",
    "tweet_detail_url": "http://192.168.33.10/527787da-e54b-4afb-8583-d603557f5679/7f87709bafdc71b63735",
    "created_at": "2016-04-16T16:38:27.000Z"
  }
]
```

#### User cannot found
```:json
{"error": "指定したユーザーは存在しませんでした"}
```

## POST /like
**Authorization Header Required**
[See RFC6750](https://tools.ietf.org/html/rfc6750)

`Authorization: Bearer xxxxxxxxxxxxxxx`

### Request
```:json
{
    "owner_uuid": "76a5138b-af95-4d00-81be-7001981caf8d",
    "entry_hex":  "4c8f9ea9d2d082d377c1"
}
```

### Response
#### Like Succeed
```:json
{"result": true}
```

#### Like Fail
```:json
{"error": "指定したツイートは既に削除されているか、非公開にされているため表示できませんでした"}
```

or

```:json
{"error": "指定したツイートは既にLikeしています"}
```

## POST /unlike
**Authorization Header Required**
[See RFC6750](https://tools.ietf.org/html/rfc6750)

`Authorization: Bearer xxxxxxxxxxxxxxx`

### Request
```:json
{
    "owner_uuid": "76a5138b-af95-4d00-81be-7001981caf8d",
    "entry_hex":  "4c8f9ea9d2d082d377c1"
}
```

### Response
#### Unlike Succeed
```:json
{"result": true}
```

#### Unlike Fail
```:json
{"error": "指定したツイートはまだlikeしていません"}
```
