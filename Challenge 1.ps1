for ($a=1;$a -le 10;$a++){
    for ($b=1;$b -le 10;$b++){
        $inhalt=" $a * $b = $($a * $b) "
        while ($inhalt.Length -lt 15) {
            $inhalt = "." + $inhalt  
        }
        write-host " $inhalt " -NoNewline 
    }
    write-host
}
