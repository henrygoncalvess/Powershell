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
                $resposta = Read-Host "Tem certeza que deseja remover todos os arquivos do Stage? (s/n)"
            }

            if ($resposta -eq "s") {
                git reset .
            } else {
                Write-Host "operação cancelada"
            }
        }
        
        elseif ($rt) {
            while ($resposta -notmatch "^[sn]$") {
                $resposta = Read-Host "Tem certeza que deseja desfazer as alterações de todos os arquivos do diretório atual?"
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
        function colorir {
            param (
                [string]$texto,
                [string]$cor = "White",
                [string]$no_new_line
            )

            if ([string]::IsNullOrEmpty($no_new_line)){
                Write-Host $texto -ForegroundColor $cor
            }else{
                Write-Host $texto -ForegroundColor $cor -NoNewline
            }
        }

        # $comando, $funcao, $parametro, $descricao
        function descrever_comando ($comando, $funcao) {
            Write-Host "`n`n-- $comando" -ForegroundColor Cyan -NoNewline
            Write-Host "`t[<opções>]" -ForegroundColor DarkGray -NoNewline
            Write-Host "`t$funcao`n" -ForegroundColor Yellow
        }

        colorir "`n====== Lista de Comandos Disponíveis ======" Blue
        colorir "`n   opcional: []     obrigatório: <>" Magenta

        descrever_comando "upgrade-posh" "atualizar"
        
        # --- --- C O M A N D O --- ---
        colorir "`n-- cc log" Cyan ' '
        colorir "`t[<opções>]" DarkGray ' '
        colorir "`tinformações dos commits do git`n" Yellow


        colorir "     [-o]" Green ' '
        colorir "`t`tlogs com apenas uma linha"

        colorir "     [quantidade]" Green ' '
        colorir "`tquantidade específica de logs"


        # --- --- C O M A N D O --- ---
        colorir "`n`n-- cc st" Cyan ' '
        colorir "`t[<opções>]" DarkGray ' '
        colorir "`tStatus, WorkingDirectory, Stage, Mudanças`n" Yellow


        colorir "     [-rs] <arquivo>" Green ' '
        colorir "`tremove todos os arquivos do Stage sem alterar o WorkingDirectory"

        colorir "     [-rt] <arquivo>" Green ' '
        colorir "`tdescarta todas as alterações do WorkingDirectory"

        colorir "     [-d] <arquivo>" Green ' '
        colorir "`tmostra as mudanças do Stage pro WorkingDirectory"

        colorir "     [-s]" Green ' '
        colorir "`t`tmostra as mudanças do último commit pro Stage"

        colorir "`n"
    }

    default {
        Write-Host "`n Comando inválido. Digite" -ForegroundColor Red -NoNewline
        Write-Host " cc help" -ForegroundColor Green -NoNewline
        Write-Host " para ver a lista de comandos.`n" -ForegroundColor Red
    }
}