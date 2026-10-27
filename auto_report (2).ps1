# auto_report.ps1 - Robot loc log tu dong SmartFarm
# Chay tu thu muc scripts/:  .\auto_report.ps1
# Neu bi chan boi ExecutionPolicy:
#   powershell -ExecutionPolicy Bypass -File .\auto_report.ps1

$logFile    = "..\data\log-he-thong.log"
$reportFile = "..\backup\bao-cao-su-co.txt"

# 1. Tieu de bao cao (dung > de tao moi/ghi de file bao cao)
Write-Output "BAO CAO SU CO HE THONG SMARTFARM" > $reportFile
Write-Output "Thoi gian tao bao cao: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" >> $reportFile
Write-Output "-----------------------------------------" >> $reportFile

# 2. Loc dong CRITICAL hoac ERROR bang Pipeline, noi them bang >>
Get-Content $logFile | Select-String -Pattern "CRITICAL|ERROR" >> $reportFile

# 3. Dem so dong loi bang Pipeline, ghi duoi dong "TONG SO SU CO:"
Write-Output "-----------------------------------------" >> $reportFile
Write-Output "TONG SO SU CO:" >> $reportFile
Get-Content $logFile | Select-String -Pattern "CRITICAL|ERROR" | Measure-Object | Select-Object -ExpandProperty Count >> $reportFile

Write-Output "Hoan thanh. Bao cao da luu tai: $reportFile"
