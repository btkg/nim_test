import json

type
    Message* = object
        username*: string
        message*: string

    MessageParsingError* = object of Exception

proc parseMessage*(data: string): Message {.raises: [MessageParsingError, KeyError].} =
    var dataJson: JsonNode
    try:
        dataJson = parseJson(data)
    except JsonParsingError:
        raise newException(MessageParsingError, "Invalid JSON: " &
                           getCurrentExceptionMsg())
    except:
        raise newException(MessageParsingError, "Unknown error: " &
                           getCurrentExceptionMsg())

    if not dataJson.hasKey("username"):
        raise newException(MessageParsingError, "Username field missing")
    result.username = dataJson["username"].getStr()
    if result.username.len == 0:
        raise newException(MessageParsingError, "Username field is empty")

    if not dataJson.hasKey("message"):
        raise newException(MessageParsingError, "Message field missing")
    result.message = dataJson["message"].getStr()
    if result.message.len == 0:
        raise newException(MessageParsingError, "Message field is empty")


proc createMessage*(username, message: string): string =
    result = $(%{
        "username": %username,
        "message": %message
    }) & "\c\l"

when isMainModule:
    block:
        let data = """{"username": "John", "message": "Hello"}"""
        let parsed = parseMessage(data)
        doAssert parsed.message == "Hello"
        doAssert parsed.username == "John"


    block:
        let data = """foobar"""
        try:
            let parsed = parseMessage(data)
        except MessageParsingError:
            doAssert true
        except:
            doAssert false
