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
            Write-Host "`n`n`n"
        }else{
            Write-Host "`t`tParâmetros:" -ForegroundColor Blue -NoNewline
            Write-Host "        nenhum" -ForegroundColor Cyan
            Write-Host "`n`n`n"
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
            break
        }
    }
}

function vscode {
    function pergunta_vscode {
        Clear-Host
        Write-Host "Deseja abrir o " -ForegroundColor Cyan -NoNewline
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
    }

    function pergunta_escolha_de_pastas {
        $resposta = $null
        $quantidade_de_opcoes = ((Get-ChildItem -Force).Length - 1)
        $regex = ""

        if ($quantidade_de_opcoes -le 9){
            $regex = "^[0-$quantidade_de_opcoes]$"
        }elseif ($quantidade_de_opcoes -ge 10){
            $dezena = $quantidade_de_opcoes.ToString().Substring(0, 1)
            $unidade = $quantidade_de_opcoes.ToString().Substring(1, 1)
            $regex = "^(?:[0-9]|[0-$dezena][0-$unidade])$"
        }


        while ($resposta -ne "exit"){
            Clear-Host
            Write-Host "Caminho atual: " -ForegroundColor Cyan -NoNewline
            Write-Host (Get-Location).Path
            Write-Host "`nOpcões disponíveis para o caminho atual:`n" -ForegroundColor Cyan
            Write-Host "[ d ] `t`tDigitar caminho de pasta/arquivo manualmente"
            Write-Host "[ exit ] `tsair`n"

            if ($resposta -ne "d"){
                $opcoes_disponiveis = (Get-ChildItem -Force)

                $nomes_de_opcao = @()

                for ($c = 0; $c -lt $opcoes_disponiveis.Count; $c++) {
                    if ($opcoes_disponiveis[$c].PSIsContainer){
                        Write-Host "[ $c ]`t`t.\$($opcoes_disponiveis[$c].Name)" -ForegroundColor Green
                        $nomes_de_opcao += "$($opcoes_disponiveis[$c].Name)"
                    }else{
                        Write-Host "[ $c ]`t`t.\$($opcoes_disponiveis[$c].Name)" -ForegroundColor Yellow
                        $nomes_de_opcao += "$($opcoes_disponiveis[$c].Name)"
                    }
                }

                if ($resposta -match $regex) {
                    $inteiro = $resposta -as [int]

                    $caminho_atual = Get-Location
                    $novo_caminho = Join-Path -Path $caminho_atual -ChildPath $nomes_de_opcao[$inteiro]

                    Write-Host "`nabrindo Visual Studio Code em:" -ForegroundColor Yellow
                    Write-Host $novo_caminho

                    code ".\$($nomes_de_opcao[$inteiro])"

                    if((Get-Item $novo_caminho).PSIsContainer -eq $true){
                        Set-Location -Path "$novo_caminho"
                    }
                    break
                    
                } else {
                    Write-Host "`nopção inválida." -ForegroundColor Red
                }

                Write-Host "`n>_ " -ForegroundColor Magenta -NoNewline
                $resposta = Read-Host
            }else{
                digitar_caminho
                break
            }
        }
    }

    function digitar_caminho {
        $caminho = $null

        while ($true) {
            Clear-Host
            Write-Host $caminho
            Write-Host "<- [ voltar ]`n" -ForegroundColor Yellow
            Write-Host "Caminho atual: " -ForegroundColor Cyan -NoNewline
            Write-Host (Get-Location).Path

            Write-Host "`nDigite o caminho da pasta/arquivo" -ForegroundColor Green
            Write-Host "Exemplos:" -ForegroundColor Cyan
            Write-Host "    C:\Users\usuario\Documentos" -ForegroundColor DarkBlue
            Write-Host "    .\Documentos" -ForegroundColor DarkBlue

            if ($caminho -eq "C:\Users\octan\OneDrive\Documentos"){
                Write-Host "caminho válido"
                # code caminho
                # Set-Location -Path caminho
                break
            }elseif ($caminho -eq "voltar"){
                Clear-Host
                pergunta_escolha_de_pastas
                break
            }else{
                Write-Host "`ncaminho ou opção inválida" -ForegroundColor Red
            }

            Write-Host "`n>_ " -ForegroundColor Magenta -NoNewline
            $caminho = Read-Host
        }
    }

    $escolha = $null

    while ($escolha -ne "n"){
        pergunta_vscode
        $escolha = Read-Host

        if ($escolha -eq "s"){
            Write-Host "`nabrindo Visual Studio Code..."
            code .
            break
        }
        elseif ($escolha -eq "e"){
            pergunta_escolha_de_pastas
            break
        }
    }
}