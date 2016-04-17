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
