param([string]$Name,[string]$FilePath,[string[]]$CommandArguments=@(),[string]$OutputDirectory="build/diagnostics")
$ErrorActionPreference="Stop"
New-Item -ItemType Directory -Force $OutputDirectory | Out-Null
$watch=[Diagnostics.Stopwatch]::StartNew()
$code=1
try {
 & $FilePath @CommandArguments 2>&1 | Tee-Object (Join-Path $OutputDirectory "$Name.log")
 $code=$LASTEXITCODE
 if ($null -eq $code) { $code=0 }
} catch { $_ | Out-String | Add-Content (Join-Path $OutputDirectory "$Name.log") }
finally {
 $watch.Stop()
 $row=@{stage=$Name;exit_code=$code;seconds=[Math]::Round($watch.Elapsed.TotalSeconds,3)}
 ($row | ConvertTo-Json -Compress) | Add-Content (Join-Path $OutputDirectory "stages.jsonl")
 if ($env:GITHUB_STEP_SUMMARY) { "| $Name | $code | $($row.seconds) |" >> $env:GITHUB_STEP_SUMMARY }
}
exit $code
