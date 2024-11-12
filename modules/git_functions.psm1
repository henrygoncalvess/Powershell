function git_pull {
    git pull origin main
}

function log{
    param (
        [switch]$o = $false,
        [string]$quantidade
    )
    
    if ($o -and $quantidade){
        git log --oneline -$quantidade
    }elseif ($true -eq $o) {
        git log --oneline -5
    }elseif ($false -eq $o -and $quantidade) {
        git log -$quantidade
    }else{
        git log -5
    }
}