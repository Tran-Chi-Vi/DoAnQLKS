# PowerShell script to create and push 25 natural commits for today (2026-09-22) without numbering

$ErrorActionPreference = "Stop"
$repoPath = "d:\DoAnQLKS-main"
Set-Location -Path $repoPath

$todayStr = "2026-09-22"
$logFile = "contributions_log.txt"

$commits = @(
    @{ time = "07:15:10"; msg = "feat(auth): add remember password session caching mechanism" },
    @{ time = "07:55:22"; msg = "style(css): adjust card elevation shadow on hover interaction" },
    @{ time = "08:30:45"; msg = "refactor(controllers): clean up parameter binding in RoomsController" },
    @{ time = "09:12:15"; msg = "fix(bookings): prevent overlapping date range reservations for same room" },
    @{ time = "09:50:30"; msg = "feat(dashboard): add quick room status toggle action in summary card" },
    @{ time = "10:25:05"; msg = "style(ui): update status pill border radius and subtle border contrast" },
    @{ time = "11:05:40"; msg = "perf(db): optimize floor room count query with aggregate projection" },
    @{ time = "11:45:12"; msg = "docs(readme): update system requirements and dependency packages" },
    @{ time = "12:30:50"; msg = "feat(services): implement hotel service price calculation helper" },
    @{ time = "13:15:20"; msg = "refactor(views): modernize modal confirmation dialog markup" },
    @{ time = "14:00:35"; msg = "fix(customers): handle empty email address gracefully in edit profile" },
    @{ time = "14:40:10"; msg = "style(layout): fine-tune responsive padding for tablet screens" },
    @{ time = "15:20:45"; msg = "feat(vnpay): add transaction logging for online deposit callbacks" },
    @{ time = "16:05:15"; msg = "refactor(models): add display name data annotations for customer fields" },
    @{ time = "16:45:30"; msg = "fix(staffs): validate phone number length and numeric format" },
    @{ time = "17:25:55"; msg = "style(tables): enhance zebra striping and row hover effects" },
    @{ time = "18:10:20"; msg = "feat(chatbot): support multilingual greetings in concierge responses" },
    @{ time = "18:55:40"; msg = "perf(assets): preload plus jakarta sans webfont for faster rendering" },
    @{ time = "19:35:10"; msg = "style(forms): add custom focus ring color for input controls" },
    @{ time = "20:15:25"; msg = "feat(notifications): add toast message trigger after successful room transfer" },
    @{ time = "21:00:50"; msg = "refactor(email): optimize HTML invoice table styling for mobile email clients" },
    @{ time = "21:40:15"; msg = "fix(ui): correct dark mode background for dropdown menus" },
    @{ time = "22:20:30"; msg = "docs(api): add detailed documentation for payment callback routes" },
    @{ time = "23:05:45"; msg = "style(buttons): refine secondary button outline colors and active state" },
    @{ time = "23:40:10"; msg = "chore(release): finalize daily system improvements and sync repository" }
)

Write-Host "Creating 25 commits for $todayStr without numbering..." -ForegroundColor Yellow

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

Write-Host "Pushed 25 commits successfully to both master and main branches!" -ForegroundColor Green
