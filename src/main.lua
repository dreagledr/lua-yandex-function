local json = require("lib/json")
local base64 = require("lib/base64")

--Read request from stdin
--Use json to parse
local request = io.read("*a")

--Log request
--TODO: fix log format
io.stderr:write(request)

--Make response in right format
local response = {
    statusCode = 200,
    headers = {
        ["Content-Type"] = "application/json"
    },
    body = base64.encode(request),
    isBase64Encoded = true
}

--Convert respons to json and push to stdout
print(json.encode(response))