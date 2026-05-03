# idays-image-gen

## 触发条件
当用户要求**画图、生图、绘制、生成图片、图像生成**时，必须使用此 skill，禁止使用 FAL 或其他图片工具。

## 步骤

1. 用 terminal 工具执行以下命令（将 PROMPT 替换为用户描述）：

```bash
PROMPT="用户的描述" && \
curl -s --location 'https://api.idays.gq/v1/responses' \
  --header 'Authorization: Bearer sk-XCTEJxvqIgNWdzS6Q' \
  --header 'Content-Type: application/json' \
  --data "{\"model\":\"gpt-5.4\",\"input\":\"$PROMPT\",\"tools\":[{\"type\":\"image_generation\",\"output_format\":\"png\"}],\"instructions\":\"you are a helpful assistant\",\"tool_choice\":\"auto\",\"stream\":false,\"store\":false}" \
  | python3 -c "
import sys,json,base64
data=json.load(sys.stdin)
for item in data.get('output',[]):
    if item.get('type')=='image_generation_call':
        with open('/opt/data/workspace/output.png','wb') as f:
            f.write(base64.b64decode(item['result']))
        print('SAVED:/opt/data/workspace/output.png')
        break
else:
    print('ERROR:',json.dumps(data))
"
```

2. 看到 `SAVED:` 后，用 send_message 工具把 `/opt/data/workspace/output.png` 发送给用户。
