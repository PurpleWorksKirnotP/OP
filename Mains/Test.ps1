# Discord webhook target for simple messages
$DiscordWebhookUrl = "https://discord.com/api/webhooks/1530928693797720144/lhZAucu75x4yogM7VrXeKwL8I_9wR667mgpEo8Spvhy9_wiYr1XsN7I71H6T3AZE30ls"
$message = "FOUND VIRUS X134xTROJEN"

$payloadJson = @{ content = $message } | ConvertTo-Json -Compress

curl.exe -sS -X POST -H "Content-Type: application/json" -d $payloadJson $DiscordWebhookUrl | Out-Null

Write-Host "Sent Discord message: $message"