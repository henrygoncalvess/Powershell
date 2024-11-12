function mensagem_de_erro ($argumento) {
    Write-Host "`n$argumento " -ForegroundColor Yellow -NoNewline
    Write-Host "comando inválido. Digite" -ForegroundColor Red -NoNewline
    Write-Host " cc help" -ForegroundColor Green -NoNewline
    Write-Host " para ver a lista de comandos.`n" -ForegroundColor Red
}



function help {
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

    descrever_comando "p" 'executa um pull, trazendo todas as alterações do repositório remoto' `t`t`t`t
    
    descrever_comando "upgrade-posh" 'ao iniciar o terminal pergunta se deseja atualizar "Oh-My-Posh"' `t`t

    Write-Host
}



function upgrade_posh {
    $escolha = $null

    while ($escolha -ne "n"){
        Write-Host 'Deseja atualizar "' -ForegroundColor Cyan -NoNewline
        Write-Host 'Oh-My-Posh' -ForegroundColor Green -NoNewline
        Write-Host '"?' -ForegroundColor Cyan -NoNewline
        Write-Host ' [s/n]: ' -ForegroundColor Yellow -NoNewline
        $escolha = Read-Host

        if ($escolha -eq "s"){
            oh-my-posh upgrade --force
            Write-Host '############################################################' -ForegroundColor Cyan
            Write-Host "Oh-My-Posh Atualizado com sucesso." -ForegroundColor Green
            Write-Host "Reinicie o terminal para que as atualizações sejam aplicadas" -ForegroundColor Green
            Write-Host '############################################################' -ForegroundColor Cyan
        }
    }
}