Clear-Host

[double[]] $Temperaturen = get-content C:\Lernsituation\Lernsit3\Temperaturen.txt 

[double[]] $Temperaturen = $Temperaturen | Sort-Object -Descending  

$Temperaturen

Write-Host
"Gesamtzahl der Temperaturen: " + $Temperaturen.count

Write-Host
Write-Host Höchsttemperatur ist: ($Temperaturen | Measure-Object -Maximum).Maximum 

Write-Host
Write-Host Tiefstemperatur ist: ($Temperaturen | Measure-Object -Minimum).Minimum

Write-Host
Write-Host Durchschnittstemperatur ist: ($Temperaturen | Measure-Object -Average).Average

# Write-Host Durchschnittstemperatur ist: (($Temperaturen | Measure-Object -Sum).Sum / ($Temperaturen.count))
# Write-Host Tiefstemperatur ist: $Temperaturen[$Temperaturen.count - 1]
# Write-Host Höchsttemperatur ist: $Temperaturen[0]

Write-Host

# Diese Variante bestimmt Differenzen in dem es einem Array $Ergebnis immer die weiteren
# Differenzen hinzufügt. Das ist aber sooo garnicht nötig in Powershell. Dazu 
# das nächste Beispiel - das Zauberwort heißt "Pipeline"
<#
[double[]] $Temperaturen = Get-Content C:\Lernsituation\Lernsit3\Temperaturen.txt
$Ergebnis = @()
for ($i = 0; $i -lt $Temperaturen.Length-1; $i++) {
    $Differenz = $Temperaturen[0 + $i] - $Temperaturen[1 + $i]
    Write-Host $Temperaturen[0 + $i] - $Temperaturen[1 + $i] = $Differenz
    $Ergebnis = $Ergebnis + $Differenz
}
#>

[double[]] $Temperaturen = Get-Content C:\Lernsituation\Lernsit3\Temperaturen.txt

$ergebnis = for ($i = 0; $i -lt $Temperaturen.Length-1; $i++) {
    $Differenz = [Math]::Abs($Temperaturen[1 + $i] - $Temperaturen[$i])
    # Write-Host $Temperaturen[1 + $i] "<->" $Temperaturen[$i] = $Differenz
    
    New-Object -TypeName PSObject -Property @{
        Tag = $i+1
        TemperaturAmTag = $Temperaturen[$i]
        Folgetag = $i+2
        TemperaturAmFolgetag = $Temperaturen[$i+1]
        DifferenzZuMorgen = $Differenz
    }
} 

#$ergebnis | Select-Object Tag, TemperaturAmTag, TemperaturAmFolgetag, DifferenzZuMorgen | Out-GridView
$maximalerUmschwung = ($ergebnis.DifferenzZuMorgen | Measure-Object -Maximum).Maximum

$ergebnis | 
    Sort-Object DifferenzZuMorgen -Descending | 
    Select -First 1 | 
    Select-Object Tag, TemperaturAmTag, Folgetag, TemperaturAmFolgetag, DifferenzZuMorgen | 
    Format-Table
    

<#
    ACHTUNG! Funktioniert nicht ganz: Zum Schluss geht $i über die Grenzen des Temparatur-Arrays hinaus!
    Powershell ist so nett oder doof (saudoof) keinen Fehler zu werfen, ist aber trotzdem einer.

$Temperaturen | ForEach-Object {
    Write-Host $Temperaturen[0 + $i] - $Temperaturen[1 + $i]
    $Differenz = $Temperaturen[0 + $i] - $Temperaturen[1 + $i]
    $i++

    $Ergebnis = $Ergebnis + $Differenz 
} #> 

