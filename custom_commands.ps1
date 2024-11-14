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
        # COMANDOS GLOBAIS
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

        "st" {
            st @args
            return
        }

        "lastC" {
            if (Get-History -Count 1){
                $lastC = (Get-History -Count 1).CommandLine
                Write-Host "último comando digitado: $lastC"
            }elseif ((Get-History -Count 1).CommandLine -eq "cc a"){
                Write-Host "o último comando digitado foi: cd"
                Write-Host "executar push?"
            }else{
                Write-Host "não há comandos no histórico"
            }
            return
        }
        
        Default { mensagem_de_erro $comando }
    }
}

startup @args