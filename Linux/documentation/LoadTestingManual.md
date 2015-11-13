## Handleiding: Load testing

###gebruik apache jmeter

alles onder het stuk test plan is het complete script.

#####hieronder vind je 3 types acties.

* managers & defaults,
  deze zorgen ervoor dat u bijvoorbeeld u cookies goed geinstalleerd staan en kunnen met de defaults er ook voor zorgen dat al u basisinstellingen juist staan bvb. server en poort
    * cache manager: hiermee kan je de cache clearen elke iteratie, hiermee boots je elke iteratie een nieuwe user na
    * cookie manager: deze neemt alles in verband met cookies voor zijn rekening
    * http request defaults: alle http requests in het test plan zullen deze default waarden krijgen
* thread groups bootsen users na, in de thread group tab zelf kunt u instellen hoeveel users u wil (threads), hoeveel keer het herhaalt moet worden (loop count) en hoeveel seconden het duurd voor alle users gedeployed zijn (ramp up period) deze ramp up period is lineair7
  binnen de threads vinden we nog:
    * http requests: bootsen een pagina laden na
    * constant timer: hiermee kunnen we delay tussen het uitvoeren van vershillende stappen
    * loop controller: loops invoeren om de stappen die niet veranderen te herhalen
* listeners geven u data weer in de format dat je wil.
    * results tree: geeft elke request weer en welk antwoord er op gekomen is, dit word vooral gebruikt om te debuggen
    * graph results: geeft een grafiek weer van de load time (met gemiddelde, min, max en mediaan) maar is niet zo user friendly
    * results in table: geeft de data waarmee de grafiek is opgebouwd weer in tabelvorm
    * summary report: geeft data weer voor elke test




###Load tests

#####data validation

* Download Time below 0.1 s : User feels that the system is reacting instantaneously.
* Download Time below 1.0 s : User experiences a slight delay but he is still focused on the current website.
* Download Time below 10 s : This is the maximum time a user keeps focused on a website, but his attention might already be distracted.
* Download Time above 10 s : User is most likely distracted from the current website and looses interest.



#####Realistische load (gemiddeld gebruik)

* gemiddelde aantal paginas per bezoek: 7
* sessies/uur: 10000
* sessie duratie: 6min 30sec

#####Realistische load (hoog gebruik)

* gemiddelde aantal paginas per bezoek: 3
* sessies/uur: 100000
* sessie duratie: 3min

#####page bash

* gemiddelde aantal paginas per bezoek: 1
* sessies/uur: 250000
* sessie duratie: 1min
