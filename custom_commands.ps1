$opcoes = @("1 - Histórico de commits", "2 - Listar um diretório", "3 - sair")
$escolha = $null

while ($escolha -ne "3") {
    Write-Host "O que deseja fazer?"

    foreach ($opcao in $opcoes) {
        Write-Host $opcao
    }

    $escolha = Read-Host "Escolha uma opção"

    switch ($escolha) {
        "1" {
            git log --oneline -6
            Write-Host
        }

        "2" {
            $dir = Read-Host "Digite o caminho do diretório"
            Write-Host "Listando arquivos em: $dir"
            Get-ChildItem -Path $dir
        }

        "3" { "Saindo..." }
        default { Write-Host "Opção inválida. Tente novamente." }
    }
}