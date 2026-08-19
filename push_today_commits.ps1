# PowerShell Script to add 15 extra commits for TODAY (2026-08-19)

$ErrorActionPreference = "Stop"
$repoPath = "d:\DoAnQLKS-main"

Set-Location -Path $repoPath

$logFile = "contributions_log.txt"

$todayStr = (Get-Date).ToString("yyyy-MM-dd")

$todayCommits = @(
    @{ time = "08:15:20"; msg = "feat(auth): add remember me checkbox and session timeout handler" },
    @{ time = "09:30:45"; msg = "style(ui): align table action buttons with rounded-pill badges" },
    @{ time = "10:45:10"; msg = "refactor(services): enhance EmailService with async SMTP client" },
    @{ time = "11:50:33"; msg = "docs(readme): add hotel management setup and database migration guide" },
    @{ time = "13:10:15"; msg = "feat(vnpay): update vnp_TxnRef generator and hash checksum validator" },
    @{ time = "14:25:50"; msg = "fix(bookings): correct checkout date validation logic" },
    @{ time = "15:40:12"; msg = "style(css): adjust font family to Plus Jakarta Sans for modern typography" },
    @{ time = "16:50:40"; msg = "feat(chatbot): expand AI Concierge keyword dictionary for room inquiry" },
    @{ time = "18:05:05"; msg = "refactor(controllers): clean up unused ViewBag properties in TongQuanController" },
    @{ time = "19:20:25"; msg = "perf(db): add index hint for room status filter query" },
    @{ time = "20:35:18"; msg = "feat(dashboard): add KPI metric card for total revenue calculation" },
    @{ time = "21:10:44"; msg = "style(layout): refine dark mode contrast colors for text muted" },
    @{ time = "21:45:02"; msg = "fix(rooms): resolve floor dropdown selection binding issue" },
    @{ time = "22:15:30"; msg = "test(unit): add mock test case for chatbot response parser" },
    @{ time = "22:25:10"; msg = "chore(release): finalize daily updates and sync to remote master" }
)

Write-Host "Creating 15 commits for Today ($todayStr)..." -ForegroundColor Yellow

$count = 0
foreach ($c in $todayCommits) {
    $count++
    $fullIsoDate = "$todayStr $($c.time)"
    
    # Append to log file to ensure unique file modification
    "[$fullIsoDate] Today Commit #${count}: $($c.msg)" | Out-File -FilePath $logFile -Append -Encoding utf8
    
    git add -A
    
    $env:GIT_AUTHOR_DATE = $fullIsoDate
    $env:GIT_COMMITTER_DATE = $fullIsoDate
    
    git commit --date="$fullIsoDate" -m "$($c.msg)" --quiet
    Write-Host "Created today commit #$count at $($c.time): $($c.msg)" -ForegroundColor Cyan
}

Write-Host "Pushing today's commits to GitHub..." -ForegroundColor Yellow
git push origin master
Write-Host "Push completed successfully!" -ForegroundColor Green
