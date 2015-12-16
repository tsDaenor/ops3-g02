## Verslag Loadtesting: Simple LAMP

### Hardware specificaties LAMP server:

* 3 GB RAM
* 1 CPU

### Loadtest 1: Average load

#### Test scenario
* 5 users per seconde
* Visit home page -> 2 random pages-> Home page -> 3 random pages

###### Resultaat

![resultsimplelampavarage](average load simple lamp.PNG)

### Loadtest 2: High load

#### Test Scenario
* 25 users per seconde
* Visit home page -> 2 random pages-> Home page -> 3 random pages

###### Resultaat

![resultsimplelamphigh](high load simple lamp.PNG)

### Loadtest 3: Page bash

#### Test scenario 1
* 10 users per second
* Visit only the home page
 
###### Resultaat

![resultsimplelamppagebash10](10users per seconde single page.PNG)

#### Test scenario 2
* 15 users per second
* Visit only the home page

###### Resultaat

![resultsimplelamppagebash15](15users per seconde single page.PNG)

#### Test scenario 3
* 25 users per second
* Visit only the home page

###### Resultaat

![resultsimplelamppagebash25](25users per seconde single page.PNG)
###### CPU
![resultsimplelamppagebash25cpu](25users per seconde single page cpu use.PNG)
###### Memory
![resultsimplelamppagebash25mem](25users per seconde single page mem use.PNG)
###### MySql database
![resultsimplelamppagebash25sql](25users per seconde single page sql selects per sec.PNG)

#### Test scenario 4
* 50 users per second
* Visit only the home page

###### Resultaat

![resultsimplelamppagebash50](50users per seconde single page.PNG)
###### CPU
![resultsimplelamppagebash50cpu](50users per seconde single page cpu use.PNG)
###### Memory
![resultsimplelamppagebash50mem](50users per seconde single page mem use.PNG)
###### MySql database
![resultsimplelamppagebash50sql](50users per seconde single page sql selects per sec.PNG)

### Loadtest 4: Crash test

#### Test Scenario
* Vanaf 50 tot 150 users per seconde
* Visit only the home page
* Uitzoeken wanneer de server zou crashen
 
###### Resultaat

###### CPU
![resultsimplelampcrashtestcpu](test to crash cpu (150).PNG)
###### Memory
![resultsimplelampcrashtestmem](test to crash memory (150).PNG)
###### MySql database
![resultsimplelampcrashtestcpu](test to crash sql select (150).PNG)
