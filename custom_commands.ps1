param (
    [string]$comando,
    [switch]$o,
    [string]$quantidade
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

    "stt"{
        git status
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
        colorir "`n`n-- cc stt" Cyan ' '
        colorir " [<opções>]" DarkGray ' '
        colorir "   Status, WorkingDirectory, Stage, Mudanças`n" Yellow


        colorir "     [-rs] <arquivo>" Green ' '
        colorir "   remove o arquivo do Stage sem alterar o WorkingDirectory"

        colorir "     [-rt] <arquivo>" Green ' '
        colorir "   restaura WorkingDirectory"

        colorir "     [-d] <arquivo>" Green ' '
        colorir "   mudanças do Stage pro WorkingDirectory"

        colorir "     [-d] [-s]" Green ' '
        colorir "   mudanças do último commit pro Stage"

        colorir "`n`n"
    }

    default { colorir 'Comando inválido. Digite "cc help" para ver a lista de comandos.' }
}