# TeamF Twitter API

# Dependencies
- Ruby 2.2.3
- Sinatra 1.4.6
- MySQL 5.6
- Nginx 1.8.1

# webAPI Endpoints and Specification

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
    "token": "LbQqzSUrrmB1EOg8UpLZ62LxJhgxFdtS"
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
  "target_user_token": "xxxxxxxxxxxxxxx"
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
  "target_user_token": "xxxxxxxxxxxxxxx"
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
