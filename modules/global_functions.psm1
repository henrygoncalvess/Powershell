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

        Write-Host "cc $comando" -ForegroundColor Magenta

        Write-Host "`t`tExemplo:      " -ForegroundColor DarkGreen -NoNewline
        Write-Host "     $exemplo" -ForegroundColor Green

        Write-Host "`t`tDescrição:         " -ForegroundColor DarkYellow -NoNewline
        Write-Host $descricao -ForegroundColor Yellow

        if ($null -ne $parametros){
            Write-Host "`t`tParâmetros:" -ForegroundColor Blue
            foreach ($item in $parametros){
                Write-Host "`t`t        $($item.PSObject.Properties.Name)" -ForegroundColor Cyan -NoNewline
                Write-Host "`t`t        $($item.PSObject.Properties.Value)"
            }
            Write-Host
            Write-Host
            Write-Host
            Write-Host
        }else{
            Write-Host "`t`tParâmetros:" -ForegroundColor Blue -NoNewline
            Write-Host "        nenhum" -ForegroundColor Cyan
            Write-Host
            Write-Host
            Write-Host
            Write-Host
        }
    }

    Write-Host "############################ Lista de comandos disponíveis ############################" -ForegroundColor Blue
    Write-Host "`n`t`t`tOPCIONAL: []     OBRIGATÓRIO: <>" -ForegroundColor DarkGray

    descrever_comando "log" "informações dos commits do git" "\cc log -o 3" @(
        [PSCustomObject]@{
            "[-o]" = "`tlogs com apenas uma linha"
        },
        [PSCustomObject]@{
            "[quantidade]" = "quantidade específica de logs"
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
            "[-d]" = "`tmostra as mudanças do Stage pro WorkingDirectory"
        },
        [PSCustomObject]@{
            "[-s]" = "`tmostra as mudanças do último commit pro Stage"
        }
    )

    descrever_comando "p" 'executa um pull, trazendo todas as alterações do repositório remoto' "\cc p"
    
    descrever_comando "upgrade-posh" 'Atualiza o "Oh-My-Posh"' "\cc upgrade-posh"
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

function vscode {
    $escolha = $null

    while ($escolha -ne "n"){
        Write-Host 'Deseja abrir o ' -ForegroundColor Cyan -NoNewline
        Write-Host 'Visual Studio Code ' -ForegroundColor Green -NoNewline
        Write-Host 'na pasta atual?' -ForegroundColor Cyan
        Write-Host '[s] ' -ForegroundColor Yellow -NoNewline
        Write-Host 'abrir na pasta atual'
        Write-Host '[n] ' -ForegroundColor Yellow -NoNewline
        Write-Host 'sair'
        Write-Host '[e] ' -ForegroundColor Yellow -NoNewline
        Write-Host 'escolher caminho de pasta/arquivo'
        Write-Host
        Write-Host ">_ " -ForegroundColor Magenta -NoNewline
        $escolha = Read-Host

        if ($escolha -eq "s"){
            Write-Host 'abrindo Visual Studio Code...'
            code .
            break
        }elseif ($escolha -eq "e"){
            Write-Host 'Digite o caminho da pasta/arquivo:' -ForegroundColor Cyan
            Write-Host ">_ " -ForegroundColor Magenta -NoNewline
            $caminho = Read-Host

            code $caminho
            break
        }
    }
}