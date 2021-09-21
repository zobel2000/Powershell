function istprimzahl($zahl) {
    if ($zahl -le 1) {
        return $false
    }
    if ($zahl -in 2,3,5) {
        return $true
    }
    if (($zahl /2) -eq ([Math]::Round($zahl/2))) {
        return $false
    } 
    if (($zahl /3) -eq ([Math]::Round($zahl/3))) {
        return $false
    } 
    if (($zahl /5) -eq ([Math]::Round($zahl/5))) {
        return $false
    } 
    return $true
}
for ($i=0;$i -le 100;$i++) {
    if (istprimzahl $i) {
        write-host $i (istprimzahl $i) 
    }
}
