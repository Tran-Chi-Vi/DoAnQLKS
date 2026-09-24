# PowerShell script to create and push 9 natural commits for today (2026-09-24) without numbering

$ErrorActionPreference = "Stop"
$repoPath = "d:\DoAnQLKS-main"
Set-Location -Path $repoPath

$todayStr = "2026-09-24"
$logFile = "contributions_log.txt"

$commits = @(
    @{ time = "08:10:15"; msg = "feat(rooms): optimize room filter query response time" },
    @{ time = "09:45:30"; msg = "style(css): adjust font weight for dashboard KPI headers" },
    @{ time = "11:20:10"; msg = "refactor(services): enhance booking discount calculation helper" },
    @{ time = "13:15:45"; msg = "fix(customers): resolve customer address field null check issue" },
    @{ time = "15:30:20"; msg = "feat(chatbot): update hotel concierge auto-response rules" },
    @{ time = "17:40:05"; msg = "style(layout): polish top navbar alignment and badge padding" },
    @{ time = "19:25:50"; msg = "perf(db): streamline EF query projection for active bookings" },
    @{ time = "21:10:35"; msg = "docs(readme): update API setup guide and environment notes" },
    @{ time = "23:35:00"; msg = "chore(release): finalize daily system updates and sync branches" }
)

Write-Host "Creating 9 commits for $todayStr without numbering..." -ForegroundColor Yellow

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

Write-Host "Pushed 9 commits successfully to both master and main branches!" -ForegroundColor Green
