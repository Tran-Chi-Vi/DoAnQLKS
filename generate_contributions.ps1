# PowerShell Script to Generate 6 Months of Git Contributions (10 Commits/Day, ~1,800 Unique Commits)

$ErrorActionPreference = "Stop"
$repoPath = "d:\DoAnQLKS-main"

Write-Host "Initializing Git Repository..." -ForegroundColor Green
Set-Location -Path $repoPath

if (-not (Test-Path ".git")) {
    git init
    git branch -M master
}

# Create .gitignore if not exists
$gitignoreContent = @"
.vs/
bin/
obj/
packages/
*.user
*.suo
*.userosscache
*.sln.docstates
"@
Set-Content -Path ".gitignore" -Value $gitignoreContent

$verbs = @("feat", "fix", "style", "refactor", "docs", "perf", "test", "chore")
$modules = @("room", "booking", "customer", "payment", "service", "staff", "floor", "analytics", "chatbot", "email", "ui", "layout", "vnpay", "auth", "export")

$actionTemplates = @(
    "add visual status matrix for floor",
    "optimize database context query for entity",
    "enhance glassmorphic card design tokens",
    "fix null reference exception in details view",
    "update API response payload format",
    "refactor controller action logic for performance",
    "add dark light theme toggle support",
    "implement email notification HTML template",
    "integrate VietQR payment hash calculation",
    "add search filter bar for data tables",
    "update bootstrap responsive breakpoint layout",
    "add validation attribute for form inputs",
    "optimize C# linq query execution time",
    "refactor partial view rendering components",
    "add fontawesome icon assets",
    "implement AI Concierge rule matching engine",
    "update CSS variable color palette",
    "fix room transfer status update transition",
    "add export to CSV report utility",
    "enhance mobile drawer navigation responsiveness"
)

$startDate = (Get-Date).AddDays(-180)
$totalDays = 180
$commitsPerDay = 10
$commitCount = 0

Write-Host "Generating 1,800 unique commits over $totalDays days..." -ForegroundColor Yellow

# Ensure tracking file exists
$logFile = "contributions_log.txt"
if (-not (Test-Path $logFile)) {
    "Git Contribution Log" | Out-File -FilePath $logFile -Encoding utf8
}

for ($day = 0; $day -lt $totalDays; $day++) {
    $currentDayDate = $startDate.AddDays($day)
    
    # 10 realistic timestamps across the day
    $hours = @(8, 9, 10, 11, 13, 14, 15, 17, 19, 21)
    $minutes = @(12, 35, 48, 20, 15, 42, 05, 30, 18, 55)

    for ($i = 0; $i -lt $commitsPerDay; $i++) {
        $commitCount++
        
        $cHour = $hours[$i]
        $cMin = $minutes[$i]
        $commitDateObj = Get-Date -Year $currentDayDate.Year -Month $currentDayDate.Month -Day $currentDayDate.Day -Hour $cHour -Minute $cMin -Second ($i * 5)
        $isoDateStr = $commitDateObj.ToString("yyyy-MM-dd HH:mm:ss")
        
        # Build unique commit message
        $v = $verbs[$commitCount % $verbs.Count]
        $m = $modules[$commitCount % $modules.Count]
        $a = $actionTemplates[$commitCount % $actionTemplates.Count]
        $msg = "${v}(${m}): ${a} - patch #${commitCount}"
        
        # Update tracking log file
        "[$isoDateStr] Commit #${commitCount}: $msg" | Out-File -FilePath $logFile -Append -Encoding utf8
        
        # Stage files
        git add -A
        
        # Set Git Date Environment Variables
        $env:GIT_AUTHOR_DATE = $isoDateStr
        $env:GIT_COMMITTER_DATE = $isoDateStr
        
        # Commit with date
        git commit --date="$isoDateStr" -m "$msg" --quiet
    }
    
    if ($day % 20 -eq 0) {
        Write-Host "Progress: Day $day / $totalDays ($commitCount commits created)..." -ForegroundColor Cyan
    }
}

Write-Host "Completed generating $commitCount unique commits!" -ForegroundColor Green
Write-Host "Setting remote repository and pushing..." -ForegroundColor Yellow

git remote remove origin 2>$null
git remote add origin https://github.com/Tran-Chi-Vi/DoAnQLKS.git
Write-Host "Git remote configured to https://github.com/Tran-Chi-Vi/DoAnQLKS.git" -ForegroundColor Green
