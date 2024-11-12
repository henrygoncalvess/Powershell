$modulos_path = Join-Path -Path $PSScriptRoot -ChildPath "modules"
$comandos_git_path = Join-Path -Path $modulos_path -ChildPath "git_functions.psm1"
$comandos_globais_path = Join-Path -Path $modulos_path -ChildPath "global_functions.psm1"

Import-Module -Name $comandos_git_path
Import-Module -Name $comandos_globais_path

# comandos globais
upgrade_posh
help

# comandos git
git_pull

switch($comando){
    "log" {
        if ($o -and $quantidade){
            git log --oneline -$quantidade
        } elseif ($o) {
            git log --oneline -5
        } elseif ($quantidade){
            git log -$quantidade
        } else{
            git log -5
        }
    }

    "st"{
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
                Write-Host "operação cancelada"
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
                Write-Host "operação cancelada"
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

    # default {
    #     Write-Host "`nComando inválido. Digite" -ForegroundColor Red -NoNewline
    #     Write-Host " cc help" -ForegroundColor Green -NoNewline
    #     Write-Host " para ver a lista de comandos.`n" -ForegroundColor Red
    # }
}