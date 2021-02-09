$subscription = (Get-WsusServer).GetSubscription()
$subscription.StartSynchronization()
Start-Sleep -Seconds 20

Write-Host "La synchronisation va commencer"

while($subscription.GetSynchronizationProgress().Phase -notlike 'NotProcessing')
{
    $subscription.GetSynchronizationProgress()
    Start-Sleep -Seconds 25
}

Write-Host "La synchronisation est terminée"

Get-WsusUpdate -Classification All -Approval AnyExceptDeclined | where {$_.Update.Title -like '*x64*' -and $_.Update.IsSuperseded -eq $false} | Approve-WsusUpdate -TargetGroupName "Tous les ordinateurs" -Action Install