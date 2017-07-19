# Virtuele DIY Linux routers!
Dit is een vingeroefening in Vagrant om een setje Linux routers op te spinnen en te kijken of hiermee de functionaliteit van bijvoorbeeld de NSX Edge is te benaderen. Ook zou zoiets gebruikt kunnen worden waar anders Vyatta o.i.d. toegepast wordt.

Waarom deze? Voordeel van een DIY router is de vrijheid in maatwerk en daarmee flexibiliteit van de oplossing. Nadeel is het volledige gebrek aan support en daarmee ook het eigenhandig uitvoeren van het onderhoud.

## Installatie
Wat heb je nodig om los te gaan met deze spullen?
* Installeer Vagrant
* Installeer Virtualbox
* git clone <deze repo>
* cd <deze repo>
* Vagrant up
* Vagrant ssh Router1 (of Router2 of Introuter)

## Design van het Vagrant netwerkje
Edge1 en Edge2 zijn twee redundante Edge routers en hangen aan het Internet (in dit geval is het Internet een Host-Only netwerk met de Virtualbox host). Het idee is dat deze Active/Passive of Active/Active werken en elkaars werk kunnen overnemen.

Daarachter ligt een "intern" subnet (noem het een DMZ oid) waaraan een enkele interne router hangt (Introuter). Deze interne router ontsluit een nog dieper gelegen subnetje wat in eerste instantie niet bekend is bij de beide Edge routers (routing protocol nodig dus..)

Virtualbox is een beetje een raar geval en dit Vagrant design heeft een grote afwijking met de realiteit. Normaal gaat de routing naar internet via alle routers naar buiten, maar nu heeft elke router een eigen Virtualbox NAT adapter met daarheen de default route, "internet" erachter en ook allemaal hetzelfde IP (10.0.2.15 dacht ik). Ik heb dit netwerk maar "mgmt" genoemd om het voor een management subnet te laten doorgaan, dat is in het echt vaak ook zo. Alleen de default gateway door het management VLAN is nogal funky. Wel is het makkelijk met deployen, Introuter kan zo simpel pakketten installeren. In een real life scenario wil je dit anders hebben natuurlijk!!!

## Ontwerp van de DIY box
De boxen zelf zijn op basis van Debian 9 (Ubuntu vertrouw ik niet 100%, die installeert nog wel eens meuk, en CentOS ben ik niet zo mee bekend). Ik gebruik de Bentobox ervan omdat daar de Virtualbox guest drivers al in zitten (nodig voor mounten host directory).

### Configuratie management boxen
Configuratie gebeurd via Salt vanuit Vagrant. Ik gebruik Salt omdat ik het ken. Dit kan net zo makkelijk met de Chef of Ansible plugin natuurlijk. Er gebeuren geen spannende dingen met Salt, alleen pakketjes installeren en config files parsen en plaatsen. Eenieder kan de files lezen en snappen wat er gebeurd en makkelijk dit nabouwen in je eigen favo config tool.

### software keuze
De boxen krijgen (een deel van) de onderstaande software voor de volgende functies:
* **BIRD** - voor de Routing protocollen. Ik gebruik OSPF. Quagga kon ook, maar BIRD is de industrie standaard tegenwoordig
* **iptables-persistent** - Voor firewalling en NAT doe ik gewoon iptables. Dit geeft de meeste flexibiliteit. Alternatieven kunnen zijn: firewalld of ufw. Beiden ben ik niet zo'n fan van, maar deze zijn prima te gebruiken in dit scenario.
* **OpenVPN** - Remote access inbellen. 
* **StrongSwan** - site to site VPN oplossing. Intersteunt IKEv1 en IKEv2
* **Failover** - Systeem om de Edges elkaar laten overnemen. Pacemaker gebruik ik daar nu voor, maar dit kan ook met Keelalived of kaal met Heartbeat (minder handig, maar kan).
