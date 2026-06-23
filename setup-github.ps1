# =====================================================
# SCRIPT: Push hmdhycraft website lên GitHub
# Chạy trong PowerShell tại thư mục D:\ClaudeCodeTinhNghich\hmdhycraft
# =====================================================

# --- BƯỚC 1: Nhập GitHub username ---
$username = Read-Host "Nhap GitHub username cua ban"
$repoName = "hmdhycraft"

Write-Host ""
Write-Host "=== Khoi tao Git ===" -ForegroundColor Cyan

# Khởi tạo git nếu chưa có
if (-Not (Test-Path ".git")) {
    git init
    Write-Host "Da khoi tao git." -ForegroundColor Green
} else {
    Write-Host "Git da duoc khoi tao truoc do." -ForegroundColor Yellow
}

# --- BƯỚC 2: Thêm tất cả file và commit ---
Write-Host ""
Write-Host "=== Commit files ===" -ForegroundColor Cyan
git add .
git commit -m "Initial commit: hmdhycraft static website"
Write-Host "Da commit files." -ForegroundColor Green

# --- BƯỚC 3: Tạo repo trên GitHub (dùng gh CLI nếu có) ---
Write-Host ""
Write-Host "=== Tao GitHub repo ===" -ForegroundColor Cyan

$ghExists = Get-Command gh -ErrorAction SilentlyContinue
if ($ghExists) {
    Write-Host "Dang tao repo '$repoName' tren GitHub..." -ForegroundColor Cyan
    gh repo create $repoName --public --source=. --remote=origin --push
    Write-Host "Da push len GitHub thanh cong!" -ForegroundColor Green
} else {
    # Không có gh CLI - hướng dẫn tạo thủ công
    Write-Host "Chua co GitHub CLI. Lam theo huong dan sau:" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "1. Mo: https://github.com/new" -ForegroundColor White
    Write-Host "2. Repository name: $repoName" -ForegroundColor White
    Write-Host "3. Chon Public, KHONG tich README/gitignore" -ForegroundColor White
    Write-Host "4. Click 'Create repository'" -ForegroundColor White
    Write-Host ""
    Read-Host "Sau khi tao xong, nhan Enter de tiep tuc"

    # Add remote và push
    git remote remove origin 2>$null
    git remote add origin "https://github.com/$username/$repoName.git"
    git branch -M main
    git push -u origin main
    Write-Host "Da push len GitHub!" -ForegroundColor Green
}

Write-Host ""
Write-Host "=== HOAN THANH ===" -ForegroundColor Green
Write-Host "Repo cua ban: https://github.com/$username/$repoName" -ForegroundColor Cyan
Write-Host ""
Write-Host "Buoc tiep theo: Import vao Vercel tai https://vercel.com/new" -ForegroundColor Yellow
