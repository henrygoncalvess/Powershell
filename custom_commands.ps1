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
                [string]$nnl
            )

            if ([string]::IsNullOrEmpty($nnl)){
                Write-Host $texto -ForegroundColor $cor
            }else{
                Write-Host $texto -ForegroundColor $cor -NoNewline
            }
        }

        colorir "`n`n====== Lista de Comandos Disponíveis ======" Blue
        colorir "`n   opcional: []     obrigatório: <>" Magenta


        
        # --- --- C O M A N D O --- ---
        colorir "`n-- cc log" Cyan ' '
        colorir " [-o] [quantidade]" DarkGray ' '
        colorir "   informações dos commits do git`n" Yellow


        colorir "     [-o]" Green ' '
        colorir "   logs com apenas uma linha"

        colorir "     [quantidade]" Green ' '
        colorir "   quantidade específica de logs"


        # --- --- C O M A N D O --- ---
        colorir "`n`n-- cc st" Cyan ' '
        colorir " [<opções>]" DarkGray ' '
        colorir "   Status, WorkingDirectory, Stage, Mudanças`n" Yellow


        colorir "     [-rs] <arquivo>" Green ' '
        colorir "   remove todos os arquivos do Stage sem alterar o WorkingDirectory"

        colorir "     [-rt] <arquivo>" Green ' '
        colorir "   descarta todas as alterações do WorkingDirectory"

        colorir "     [-d] <arquivo>" Green ' '
        colorir "   mostra as mudanças do Stage pro WorkingDirectory"

        colorir "     [-s]" Green ' '
        colorir "   mostra as mudanças do último commit pro Stage"

        colorir "`n`n"
    }

    default {
        Write-Host "`n Comando inválido. Digite" -ForegroundColor Red -NoNewline
        Write-Host " cc help" -ForegroundColor Green -NoNewline
        Write-Host " para ver a lista de comandos.`n" -ForegroundColor Red
    }
}