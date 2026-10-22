# Discord webhook target for simple messages.
# Never hard-code a webhook in a public repository - pass it in instead:
#   $env:DISCORD_WEBHOOK_URL = "https://discord.com/api/webhooks/..."
$DiscordWebhookUrl = $env:DISCORD_WEBHOOK_URL

if (-not $DiscordWebhookUrl) {
    $DiscordWebhookUrl = Read-Host "Discord webhook URL"
}

$message = "FOUND VIRUS X134xTROJEN"

try {
    $payload = @{ content = $message } | ConvertTo-Json -Compress
    Invoke-RestMethod -Uri $DiscordWebhookUrl -Method Post -ContentType "application/json" -Body $payload | Out-Null
    Write-Host "Sent Discord message: $message"
} catch {
    Write-Host "Could not send the message: $($_.Exception.Message)" -ForegroundColor Red
}