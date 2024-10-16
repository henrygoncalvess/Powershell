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

    }

    "help" {
        Write-Host "=== Lista de Comandos Disponíveis: ===" -ForegroundColor Magenta
        Write-Host "`n1. cc log" -ForegroundColor Cyan -NoNewline
        Write-Host " - informação dos commits do git" -ForegroundColor Yellow
        Write-Host "   Parâmetros:"
        Write-Host "     -o" -ForegroundColor Green -NoNewline
        Write-Host "   (Opcional)   logs com apenas uma linha.   Padrão: logs com descrição."
        Write-Host "     [quantidade]" -ForegroundColor Green -NoNewline
        Write-Host "   (Opcional)   quantidade específica de logs.   Padrão: 5 logs."

        Write-Host "`n2. cc stt" -ForegroundColor Cyan -NoNewline
        Write-Host " - status do workingDirectory e Stage." -ForegroundColor Yellow
    }

    default { Write-Host 'Comando inválido. Digite "cc help" para ver a lista de comandos.' }
}