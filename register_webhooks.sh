access_token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjaSI6Im9hdXRoY2xpZW50XzAwMDA5MEN5ekpXNkNLZWZxNngyeWYiLCJleHAiOjE0NDI2NzY0ODcsImlhdCI6MTQ0MjY1NDg4NywianRpIjoidG9rXzAwMDA5MEVQcW0ybGVxekUzVUd0SDciLCJ1aSI6InVzZXJfMDAwMDh3Q2c0Z3JTeTQ0bzViVzhxUCIsInYiOiIxIn0.AySL5aknbj9DGJJ3JJv54rMWYq5emYTyDhqi9MsU2Q4
account_id=acc_00008wCg4hfRyE3iacu3kn
url=https://mondohipdial.fwd.wf/_mondo/webhook

http --form POST "https://api.getmondo.co.uk/webhooks" \
    "Authorization: Bearer $access_token" \
    "account_id=$account_id" \
    "url=$url"
