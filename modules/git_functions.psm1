function git_pull {
    git pull origin main
}

function log{
    param (
        [switch]$o = $false,
        [string]$quantidade
    )
    
    if ($o -and $quantidade){
        git log --oneline -$quantidade
    }
    elseif ($true -eq $o) {
        git log --oneline -5
    }
    elseif ($false -eq $o -and $quantidade) {
        git log -$quantidade
    }
    else{
        git log -5
    }
}

function st {
    param (
        [switch]$rs,
        [switch]$rt,
        [switch]$d,
        [switch]$s
    )

    $resposta = $null
    if ($rs){
        while ($resposta -notmatch "^[sn]$") {
            Write-Host 'Tem certeza que deseja remover todos os arquivos do Stage?' -ForegroundColor Cyan -NoNewline
            Write-Host ' [s/n]: ' -ForegroundColor Yellow -NoNewline
            $resposta = Read-Host
        }

        if ($resposta -eq "s") {
            git reset .
        } else {
            Write-Host "operação cancelada" -ForegroundColor Yellow
        }
    }
    
    elseif ($rt) {
        while ($resposta -notmatch "^[sn]$") {
            Write-Host 'Tem certeza que deseja desfazer as alterações de todos os arquivos do diretório atual?' -ForegroundColor Cyan -NoNewline
            Write-Host ' [s/n]: ' -ForegroundColor Yellow -NoNewline
            $resposta = Read-Host
        }

        if ($resposta -eq "s") {
            git restore .
        } else {
            Write-Host "operação cancelada" -ForegroundColor Yellow
        }
    }
    
    elseif ($d){
        Write-Host "`n   mudanças do Stage pro WorkingDirectory`n" -ForegroundColor Yellow
        git diff .
    }
    
    elseif ($s){
        Write-Host "`n   mudanças do último commit pro Stage`n" -ForegroundColor Yellow
        git diff --staged
    }

    else{
        git status
    }
}