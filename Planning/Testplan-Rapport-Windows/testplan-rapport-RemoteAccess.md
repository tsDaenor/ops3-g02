# Testplan en -rapport: remote acess
* Verantwoordelijke uitvoering: Bram Martens
* verantwoordelijke testen: Tomas Vercautter

## Testplan

Auteur(s) testplan: Bram Martens

* Na het uitvoeren van alle stappen in de manual moet het mogelijk zijn om vanop een andere computer de server te bedienen.
* In het registry controleren of fDenyTSConnections bestaat. Waarde 0 betekent dat Remote Desktop toegestaan is en een waarde 1 betekent dat enkel beveiligde verbidningen toegestaan zijn. Indien je een error krijgt klopt er iets niet. fDenyTSConnections zou waarde 0 moeten bevatten. Dit controleer je door het het volgende commando: `get-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server'-name "fDenyTSConnections"`.
* Er moet een rule toegevoegd zijn aan de firewall. Dit kunnen we controleren door het volgende commando: `get-netfirewallrule -DisplayGroup "Remote Desktop" | format-table Name, Enabled -autosize`. Indien enabled op true staat zijn de firewallrules correct.

## Testrapport

Auteur(s) testrapport: Tomas Vercautter

* Na het volgen van de manual was het inderdaad mogelijk om de server vanop een andere computer te bedienen. 
