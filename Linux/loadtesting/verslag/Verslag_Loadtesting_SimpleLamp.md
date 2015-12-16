## Verslag Loadtesting: Simple LAMP

### Hardware specificaties LAMP server:

* 3 GB RAM
* 1 CPU

### Loadtest 1: Average load

###### Test scenario
* 5 users
* isit home page -> 2 random pages-> Home page -> 3 random pages

###### Resultaat

![resultsimplelampavarage](average load simple lamp.PNG)

### Loadtest 2: High load

###### Test Scenario
* 25 users
* Visit home page -> 2 random pages-> Home page -> 3 random pages

###### Resultaat

![resultsimplelamphigh](high load simple lamp.PNG)

### Loadtest 3: Page bash

###### Test scenario 1
* 10 users per second
* Visit only the home page
 
###### Resultaat

![resultsimplelamppagebash10](10users per seconde single page.PNG)

###### Test scenario 2
* 15 users per second
* Visit only the home page

###### Resultaat

![resultsimplelamppagebash15](15users per seconde single page.PNG)

###### Test scenario 3
* 25 users per second
* Visit only the home page

###### Resultaat

![resultsimplelamppagebash25](25users per seconde single page.PNG)

###### Test scenario 4
* 50 users per second
* Visit only the home page

###### Resultaat

![resultsimplelamppagebash50](50users per seconde single page.PNG)

### Loadtest 4: Crash test

