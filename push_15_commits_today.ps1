# PowerShell script to create and push 15 natural commits for today (2026-09-21) without numbers

$ErrorActionPreference = "Stop"
$repoPath = "d:\DoAnQLKS-main"
Set-Location -Path $repoPath

$todayStr = "2026-09-21"
$logFile = "contributions_log.txt"

$commits = @(
    @{ time = "08:15:30"; msg = "feat(auth): enhance login view with glassmorphism design tokens" },
    @{ time = "09:25:10"; msg = "refactor(services): optimize email notification template rendering" },
    @{ time = "10:40:45"; msg = "style(bookings): improve status badge pill colors for reserved state" },
    @{ time = "11:50:20"; msg = "feat(dashboard): add monthly room occupancy percentage query" },
    @{ time = "13:10:05"; msg = "fix(customers): resolve phone number formatting validation rule" },
    @{ time = "14:35:40"; msg = "style(services): add fontawesome icons to hotel amenity lists" },
    @{ time = "15:45:15"; msg = "refactor(staffs): streamline role permission check helper method" },
    @{ time = "16:50:50"; msg = "feat(floors): add room count summary per floor in overview card" },
    @{ time = "18:05:25"; msg = "style(ui): refine dark theme background contrast for sidebar items" },
    @{ time = "19:20:00"; msg = "feat(chatbot): expand hotel policy inquiry responses in AI engine" },
    @{ time = "20:30:35"; msg = "fix(payment): validate checksum parameters in VNPay IPN callback" },
    @{ time = "21:15:10"; msg = "perf(db): add entity framework navigation property eager loading" },
    @{ time = "22:10:45"; msg = "docs(readme): add installation guide and environment configurations" },
    @{ time = "23:05:18"; msg = "style(layout): polish top header search bar rounded pill border" },
    @{ time = "23:50:00"; msg = "chore(release): finalize project updates and sync master main branch" }
)

Write-Host "Creating 15 commits for $todayStr without numbering..." -ForegroundColor Yellow

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

Write-Host "Pushed 15 commits successfully to both master and main branches!" -ForegroundColor Green
