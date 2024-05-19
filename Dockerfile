### DEEL 1: instructies voor het BUILDen van de IMAGE
FROM ubuntu:20.04
# We starten vanaf de bestaande “ubuntu”-image (tag: 20.04)
# deze image wordt van de registry (Docker Hub) gehaald.
RUN apt update
ENV DEBIAN_FRONTEND=noninteractive
# Bovenstaande lijn is nodig omdat er anders naar de timezone gevraagd wordt
# tijdens de installatie van Apache
RUN apt install -y apache2
RUN apt install -y php
COPY html /var/www/html/
# Kopieer de inhoud van “html” (op de host)
# naar “/var/www/html” (in de image).
### DEEL 2: extra details voor bij het RUNNEN van een CONTAINER
WORKDIR /var/www/html/
# Directory waar je terecht komt als je inlogt op een draaiende container
EXPOSE 80/tcp
# Binnen deze image/container zal poort 80 (over TCP) gebruikt worden.
# Je kan deze poort beschikbaar maken vanop de host met:
# "docker run –d –t -p [<host-ip>:]<host-port>:80 <image>"
# Bijvoorbeeld: docker run –d –t –p 8123:80 zal poort 80 van binnen
# de docker container forwarden naar poort 8123 op de docker host.
# (vergelijk dit met de port-forwarding bij VirtualBox)
# Dit EXPOSE-commando is niet strikt noodzakelijk, maar het is goed
# om dit toch te gebruiken in de Docker file
# (als documentatie voor andere developers)
CMD service apache2 start && bash
# Met CMD geef je het commando op dat moet uitgevoerd worden
# bij het STARTEN (of RUNNEN) van de CONTAINER.
# Er kan slechts één CMD-lijn staan in een Dockerfile.
# (Verwar CMD niet met RUN)
# (RUN-lijnen worden uitgevoerd bij het BUILDEN van de IMAGE)
# (de CMD-lijn wordt uitgevoerd bij het RUNNEN van een CONTAINER)
#
# “systemctl” is niet geïnstalleerd op deze Ubuntu,
# daarom gebruiken we “service” als alternatief.
# De “&& bash” is belangrijk omdat de container anders zou stoppen
# na het uitvoeren van “service apache2 start”.
# Het commando “bash” blijft immers “hangen”,
# tot je binnen bash “exit” tikt.
