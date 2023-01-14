Function verifyProfile($userName){
    $checkForUser = (Get-LocalUser).Name -Contains $userName
    
    if ($checkForUser -eq $False) { 
        return $False
    } ElseIf ($checkForUser -eq $True) { 
        return $True
    }
}
Function verifyGroup($userName){
    $checkForUser = (Get-LocalGroup).Name -Contains $userName
    
    if ($checkForUser -eq $False) { 
        return $False
    } ElseIf ($checkForUser -eq $True) { 
        return $True
    }
}
function Show-Menu(){

    Clear-Host
    Write-Host "=====Optiuni====="
    Write-Host "1: Optiuni Users & Groups."
    Write-Host "2: Optiuni Foldere si fisiere."
    Write-Host "Q: Quit."
}

function menuSwitch($num){
    switch($num){
        1 {switchUserGroup; break }

    }
}

function userGroupMenu{
    Clear-Host
    Write-Host "=====Optiuni====="
    Write-Host "1: Creati user nou."
    Write-Host "2: Stergeti user."
    Write-Host "3: Creati grup nou."
    Write-Host "4: Adaugati user in grup."
    Write-Host "5: Stergeti user din grup."
    Write-Host "6: Stergeti grup."
    Write-Host "7: Afisati toti utilizatorii."
    Write-Host "8: Afisati toate grupurile de utilizatori."
    Write-Host "Q: Quit."
}
function adaugaUser{
    Clear-Host;
    $user= Read-Host "Numele noului utilizator";
    $prof = verifyProfile($user)
    if($prof -eq $False){
        $pass= Read-Host "Parola (daca doriti)" -AsSecureString;
        if($null -eq $pass)
            {
            New-LocalUser $user -NoPassword;
            Enable-LocalUser -Name $user
            Write-Host "Utilizatorul $user a fost creat!"
            Start-Sleep -Seconds 2
        }else{
            New-LocalUser $user -Password $pass
            Enable-LocalUser -Name $user;
            Write-Host "Utilizatorul $user a fost creat!"
            Start-Sleep -Seconds 2
            }   
    }else{
        Write-Host "Utilizatorul deja exista!"
        Start-Sleep -Seconds 2
    }  
}
function stergeUser{
    Clear-Host;
    $user = Read-Host "Numele utilizatorului"
    $prof = verifyProfile($user)
    if($prof -eq $False){
        Write-Host "Utilizatorul nu exista!"
    }else{
        Remove-LocalUser -Name $user
        Write-Host "Utilizatorul $user a fost sters!"
        Start-Sleep -Seconds 2
    }
}

function grupNou{
    Clear-Host;
    $user = Read-Host "Numele noului grupului"
    $ver = verifyGroup($user)
    if($ver -eq $True){
        Write-Host "Grupul deja exista!"
        Start-Sleep -Seconds 2
    }else{
        New-LocalGroup $user
        Write-Host "Grupul a fost creat!"
        Start-Sleep -Seconds 2
    }
}
function adUserInGrup{
    Clear-Host;
    $user= Read-Host "Numele utilizatorului"
    $verUser = verifyProfile($user)
    if($verUser -eq $False){
        Write-Host "Nu exista user-ul!"
        Start-Sleep -Seconds 2
        return;
    }
    $grup = Read-Host "Numele grupului"
    $verGrup = verifyGroup($grup)
    if ($verGrup -eq $False) {
        Write-Host "Nu exista grup-ul!"
        Start-Sleep -Seconds 2
        return;
    }else{
        Add-LocalGroupMember -Group $grup -Member $user;
        Write-Host "$user a fost adaugat in grupul $grup"
        Start-Sleep -Seconds 2;
    }

}
function reUserDinGrup{
    Clear-Host;
    $user= Read-Host "Numele utilizatorului"
    $verUser = verifyProfile($user)
    if($verUser -eq $False){
        Write-Host "Nu exista user-ul!"
        Start-Sleep -Seconds 2
        return;
    }
    $grup = Read-Host "Numele grupului"
    $verGrup = verifyGroup($grup)
    if ($verGrup -eq $False) {
        Write-Host "Nu exista grup-ul!"
        Start-Sleep -Seconds 2
        return;
    }else{
        Remove-LocalGroupMember -Group $grup -Member $user;
        Write-Host "$user a fost sters din grupul $grup"
        Start-Sleep -Seconds 2;
    }

}

function grupSterge{
    Clear-Host;
    $user = Read-Host "Numele grupului"
    $ver = verifyGroup($user)
    if($ver -eq $True){
        Remove-LocalGroup $user
        Write-Host "Grup sters!"
        Start-Sleep -Seconds 2
    }else{
        Write-Host "Grupul NU exista!"
        Start-Sleep -Seconds 2
    }
}
function totiUser{
    Clear-Host;
    (Get-LocalUser).Name;
    Start-Sleep -Seconds 5;
}
function toateGrupurile{
    Clear-Host;
    (Get-LocalGroup).Name;
    Start-Sleep -Seconds 5;
}
function switchUserGroup(){
    while($num -ne "Q"){
    userGroupMenu
    $num = Read-Host "Optiune"
    switch($num){
        1 {adaugaUser; break; }
        2 {stergeUser; break; }
        3 {grupNou; break;}
        4 {adUserInGrup;break;}
        5 {reUserDinGrup;break;}
        6 {grupSterge; break;}
        7 {totiUser;break;}
        8 {toateGrupurile;break;}
    }
    }
}

while($userOption -ne "Q"){
 Show-Menu
 $userOption= Read-Host "Alegeti optiunea"
 menuSwitch($userOption)
}