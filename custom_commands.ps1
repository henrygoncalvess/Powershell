# $opcoes = @("1 - Histórico de commits", "2 - Listar um diretório", "3 - sair")
# $escolha = $null

# while ($escolha -ne "3") {
#     Write-Host "O que deseja fazer?"

#     foreach ($opcao in $opcoes) {
#         Write-Host $opcao
#     }

#     $escolha = Read-Host "Escolha uma opção"

#     switch ($escolha) {
#         "1" {
#             git log --oneline -6
#             Write-Host
#         }

#         "2" {
#             $dir = Read-Host "Digite o caminho do diretório"
#             Write-Host "Listando arquivos em: $dir"
#             Get-ChildItem -Path $dir
#         }

#         "3" { "Saindo..." }
#         default { Write-Host "Opção inválida. Tente novamente." }
#     }
# }

# if (-not [string]::IsNullOrEmpty($quantidade))

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
        Write-Host "log"
        Write-Host "stt"
    }

    default { Write-Host 'Comando inválido. Digite "cc help" para ver a lista de comandos.' }
}