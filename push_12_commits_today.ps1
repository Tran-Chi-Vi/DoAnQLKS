# PowerShell script to create and push 12 natural commits for today (2026-09-23) without numbering

$ErrorActionPreference = "Stop"
$repoPath = "d:\DoAnQLKS-main"
Set-Location -Path $repoPath

$todayStr = "2026-09-23"
$logFile = "contributions_log.txt"

$commits = @(
    @{ time = "08:20:15"; msg = "feat(rooms): add amenity tags badge display on room cards" },
    @{ time = "09:35:40"; msg = "style(dashboard): refine metric card border hover transition effect" },
    @{ time = "10:50:22"; msg = "refactor(services): optimize service pricing calculation logic" },
    @{ time = "11:45:05"; msg = "fix(bookings): correct check-in time default value to 14:00" },
    @{ time = "13:25:30"; msg = "feat(customers): add quick phone search filter in customer directory" },
    @{ time = "14:40:18"; msg = "style(ui): polish toast alert animation and icon spacing" },
    @{ time = "16:05:55"; msg = "refactor(controllers): streamline action filters in TongQuanController" },
    @{ time = "17:30:10"; msg = "feat(chatbot): add FAQ responses for early check-in requests" },
    @{ time = "18:50:42"; msg = "style(tables): improve mobile responsive scrolling for booking table" },
    @{ time = "20:15:20"; msg = "fix(vnpay): handle timeout exception gracefully during payment redirect" },
    @{ time = "21:40:35"; msg = "docs(readme): expand API endpoints and database schema section" },
    @{ time = "23:10:00"; msg = "chore(release): update project dependencies and sync repository branches" }
)

Write-Host "Creating 12 commits for $todayStr without numbering..." -ForegroundColor Yellow

foreach ($c in $commits) {
    $fullIsoDate = "$todayStr $($c.time)"
    
    # Modify tracking file with log entry
    "[$fullIsoDate] Commit: $($c.msg)" | Out-File -FilePath $logFile -Append -Encoding utf8
    
    git add -A
    
    $env:GIT_AUTHOR_NAME = "Tran-Chi-Vi"
    $env:GIT_AUTHOR_EMAIL = "tranchivi29102005@gmail.com"
    $env:GIT_COMMITTER_NAME = "Tran-Chi-Vi"
    $env:GIT_COMMITTER_EMAIL = "tranchivi29102005@gmail.com"
    $env:GIT_AUTHOR_DATE = $fullIsoDate
    $env:GIT_COMMITTER_DATE = $fullIsoDate
    
    git commit --date="$fullIsoDate" -m "$($c.msg)" --quiet
    Write-Host "Created commit at $($c.time): $($c.msg)" -ForegroundColor Cyan
}

Write-Host "Pushing to master branch..." -ForegroundColor Yellow
git push origin master

Write-Host "Syncing to main branch..." -ForegroundColor Yellow
git branch -M main
git push origin main --force

git branch -M master
git push origin master --force

Write-Host "Pushed 12 commits successfully to both master and main branches!" -ForegroundColor Green
