param (
    [string]$comando,
    [switch]$o,
    [string]$quantidade,

    [switch]$rs,
    [switch]$rt,
    [switch]$d,
    [switch]$s
)

switch($comando){
    "upgrade-posh"{
        $escolha = $null

        while ($escolha -ne "n"){
            Write-Host 'Deseja atualizar "' -ForegroundColor Cyan -NoNewline
            Write-Host 'Oh-My-Posh' -ForegroundColor Green -NoNewline
            Write-Host '"?' -ForegroundColor Cyan -NoNewline
            Write-Host ' [s/n]: ' -ForegroundColor Yellow -NoNewline
            $escolha = Read-Host

            if ($escolha -eq "s"){
                oh-my-posh upgrade --force
            }
        }
    }

    "p"{
        git pull origin main
    }

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

    "help" {
        function descrever_comando {
            param (
                [string]$comando,
                [string]$funcao,
                [string]$tabelacao_funcao,
                [PSCustomObject[]]$parametro_e_descricao = $null
            )

            # laranja = 255, 133, 3
            # ansiColor = `e[38;2;${r};${g};${b}m
            $laranja = "`e[38;2;255;133;3m"
            $fim = "`e[0m"

            Write-Host "`n`n-- cc " -ForegroundColor Cyan -NoNewline
            Write-Host "$laranja$comando$fim" -NoNewline
            if ($null -ne $parametro_e_descricao){
                Write-Host "`t[<opções>]" -ForegroundColor DarkGray -NoNewline
            }
            Write-Host "$tabelacao_funcao$funcao`n" -ForegroundColor Yellow

            foreach ($item in $parametro_e_descricao){
                Write-Host "     $($item.PSObject.Properties.Name)" -ForegroundColor Green -NoNewline
                Write-Host "$($item.PSObject.Properties.Value)"
            }
        }

        Write-Host "################# Lista de comandos personalizados disponíveis #################" -ForegroundColor Blue
        Write-Host "`n`t`t`topcional: []     obrigatório: <>" -ForegroundColor Magenta

        descrever_comando "upgrade-posh" 'ao iniciar o terminal pergunta se deseja atualizar "Oh-My-Posh"' `t`t

        descrever_comando "log" "informações dos commits do git" `t @(
            [PSCustomObject]@{
                "[-o]" = "`t`t`tlogs com apenas uma linha"
            },
            [PSCustomObject]@{
                "[quantidade]" = "`t`tquantidade específica de logs"
            }
        )

        descrever_comando "st" "Status, WorkingDirectory, Stage, Mudanças" `t @(
            [PSCustomObject]@{
                "[-rs]" = "`t`t`tremove todos os arquivos do Stage sem alterar o WorkingDirectory"
            },
            [PSCustomObject]@{
                "[-rt]" = "`t`t`tdescarta todas as alterações do WorkingDirectory"
            },
            [PSCustomObject]@{
                "[-d]" = "`t`t`tmostra as mudanças do Stage pro WorkingDirectory"
            },
            [PSCustomObject]@{
                "[-s]" = "`t`t`tmostra as mudanças do último commit pro Stage"
            }
        )

        Write-Host
    }

    default {
        Write-Host "`n Comando inválido. Digite" -ForegroundColor Red -NoNewline
        Write-Host " cc help" -ForegroundColor Green -NoNewline
        Write-Host " para ver a lista de comandos.`n" -ForegroundColor Red
    }
}