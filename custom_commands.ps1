$modulos_path = Join-Path -Path $PSScriptRoot -ChildPath "modules"
$comandos_git_path = Join-Path -Path $modulos_path -ChildPath "git_functions.psm1"
$comandos_globais_path = Join-Path -Path $modulos_path -ChildPath "global_functions.psm1"

Import-Module -Name $comandos_git_path
Import-Module -Name $comandos_globais_path

function startup {
    param (
        [string]$comando
    )

    switch ($comando) {
        "help" {
            help
            return
        }

        "upgrade-posh" {
            upgrade_posh
            return
        }
    
        # COMANDOS GIT
        "p" {
            git_pull
            return
        }

        "log" {
            log @args
            return
        }
        
        Default { mensagem_de_erro $comando }
    }
}

startup @args

# switch($comando){
#     "st"{
#         $resposta = $null

#         if ($rs){
#             while ($resposta -notmatch "^[sn]$") {
#                 Write-Host 'Tem certeza que deseja remover todos os arquivos do Stage?' -ForegroundColor Cyan -NoNewline
#                 Write-Host ' [s/n]: ' -ForegroundColor Yellow -NoNewline
#                 $resposta = Read-Host
#             }

#             if ($resposta -eq "s") {
#                 git reset .
#             } else {
#                 Write-Host "operação cancelada"
#             }
#         }
        
#         elseif ($rt) {
#             while ($resposta -notmatch "^[sn]$") {
#                 Write-Host 'Tem certeza que deseja desfazer as alterações de todos os arquivos do diretório atual?' -ForegroundColor Cyan -NoNewline
#                 Write-Host ' [s/n]: ' -ForegroundColor Yellow -NoNewline
#                 $resposta = Read-Host
#             }

#             if ($resposta -eq "s") {
#                 git restore .
#             } else {
#                 Write-Host "operação cancelada"
#             }
#         }
        
#         elseif ($d){
#             Write-Host "`n   mudanças do Stage pro WorkingDirectory`n" -ForegroundColor Yellow
#             git diff .
#         }
        
#         elseif ($s){
#             Write-Host "`n   mudanças do último commit pro Stage`n" -ForegroundColor Yellow
#             git diff --staged
#         }

#         else{
#             git status
#         }
#     }
# }