function mensagem_de_erro ($comando) {
    Write-Host "`n$comando " -ForegroundColor Yellow -NoNewline
    Write-Host "comando inválido. Digite" -ForegroundColor Red -NoNewline
    Write-Host " cc help" -ForegroundColor Green -NoNewline
    Write-Host " para ver a lista de comandos.`n" -ForegroundColor Red
}



function help {
    function descrever_comando {
        param (
            [string]$comando,
            [string]$descricao,
            [string]$exemplo,
            [PSCustomObject[]]$parametros = $null
        )

        Write-Host "cc $comando" -ForegroundColor Green

        Write-Host "`t`tDescrição         " -NoNewline
        Write-Host $descricao -ForegroundColor Yellow

        if ($null -ne $parametros){
            foreach ($item in $parametros){
                Write-Host "`t`tParâmetro" -NoNewline
                Write-Host "         $($item.PSObject.Properties.Name)" -ForegroundColor Cyan -NoNewline
                Write-Host "         $($item.PSObject.Properties.Value)"
            }
        }else{
            Write-Host "`t`tParâmetro" -NoNewline
            Write-Host "         nenhum" -ForegroundColor Cyan
        }

        Write-Host "`t`tExemplo      " -NoNewline
        Write-Host "     $exemplo`n`n"
    }

    Write-Host "############################ Lista de comandos disponíveis ############################" -ForegroundColor Blue
    Write-Host "`n`t`t`topcional: []     obrigatório: <>" -ForegroundColor Magenta

    descrever_comando "log" "informações dos commits do git" "\cc log -o 3" @(
        [PSCustomObject]@{
            "[-o]" = "`t`tlogs com apenas uma linha"
        },
        [PSCustomObject]@{
            "[quantidade]" = " quantidade específica de logs"
        }
    )

    descrever_comando "st" "Status, WorkingDirectory, Stage, Mudanças" "\cc st -d" @(
        [PSCustomObject]@{
            "[-rs]" = "`tremove todos os arquivos do Stage sem alterar o WorkingDirectory"
        },
        [PSCustomObject]@{
            "[-rt]" = "`tdescarta todas as alterações do WorkingDirectory"
        },
        [PSCustomObject]@{
            "[-d]" = "`t`tmostra as mudanças do Stage pro WorkingDirectory"
        },
        [PSCustomObject]@{
            "[-s]" = "`t`tmostra as mudanças do último commit pro Stage"
        }
    )

    descrever_comando "p" 'executa um pull, trazendo todas as alterações do repositório remoto' "\cc p"
    
    descrever_comando "upgrade-posh" 'ao iniciar o terminal pergunta se deseja atualizar "Oh-My-Posh"' "\cc upgrade-posh"
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