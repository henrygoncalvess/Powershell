# Scripts Powershell

- Comandos personalizados
- Automatização de tarefas
- Comandos em Português

### licença e tecnologias utilizadas

<img src="https://img.shields.io/github/license/henrygoncalvess/Powershell?style=for-the-badge&labelColor=gray&color=97ca00"> <a href="https://learn.microsoft.com/en-us/powershell/"><img src="https://img.shields.io/badge/powershell-7.5-blue?style=for-the-badge&logo=powershell&logoColor=darkblue&labelColor=gray"></a>
  
<details open="open">
<summary>Tabela de Conteúdos</summary>
  
- [Instrução de instalação](#instrução-de-instalação)
  - [Clonando Repositório](#clonando-repositório)
  - [Pré-requisitos](#pré-requisitos)
  - [Etapas](#etapas)
- [Instrução de uso](#instrução-de-uso)
  - [Em qualquer diretório](#em-qualquer-diretório)
  - [Comandos GIT simplificados](#comandos-git-simplificados)
- [Contribuição](#contribuição)
  
</details>

## Instrução de instalação

### Clonando Repositório
No Terminal, certifique de que você está na pasta onde vai ficar o repositório

```pasta\do\repo\clonado```
``` bash
git clone https://github.com/henrygoncalvess/Powershell.git
```

<br>

### Pré-requisitos
Sistema operacional: Windows

- **Powershell** - [Tutorial de instalação](https://learn.microsoft.com/pt-br/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.4)

<!-- - **Node.js** - [Tutorial de instalação](https://nodejs.org/pt) -->

<br>

### Etapas

#### 1. Execute o Powershell como Administrador para habilitar a execução de scripts:

``` powershell
Set-ExecutionPolicy RemoteSigned
```

#### 2. Feche o Powershell e Execute novamente

#### 3. Abra seu perfil de usuário com seu editor de código preferido:

> [!note]
> se o arquivo não existir, ele será criado automaticamente.

``` powershell
# Visual Studio Code
code $PROFILE
```
``` powershell
# Notepad ++
notepad $PROFILE
```

#### 4. dentro do perfil do usuário, digite a seguinte linha de código:

> [!important]
> substitua " [ ] " com suas informações de arquivo

`...\WindowsPowerShell\Microsoft.PowerShell_profile.ps1`
``` powershell
Set-Alias -Name cc -Value ['C:\pasta\do\repo\clonado\Powershell\custom_commands.ps1']
```
`exemplo`
![code](https://github.com/user-attachments/assets/7236ff39-5543-4d7a-9a46-b9046e4536e1)


<br>

## Instrução de uso
No Powershell, teste o funcionamento executando um dos comandos abaixo.

Lista de comandos e suas funcionalidades:

### Em qualquer diretório

COMANDO | RETORNO
:---: | :---:
**cc help** | lista com todos os comandos e parâmetros disponíveis

<br>

### Comandos GIT simplificados

> [!important]
> Utilizar apenas dentro de repositórios

![image](https://github.com/user-attachments/assets/bcd34f4d-1132-497b-9281-56f8b62b9303)

<br>

## Contribuição

### Como contribuir com o projeto?
em andamento...
