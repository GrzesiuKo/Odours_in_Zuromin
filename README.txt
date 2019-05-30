1) JEDNORAZOWO w katalogu domowym wywołac komende

    openssl req -x509 -newkey rsa:2048 \
  -nodes -keyout rsa_private.pem -x509 -days 365 -out rsa_cert.pem -subj "/CN=unused"

2) Odpalić Gateway

    a. cd <folder z tymi pliakmi>
    b. ./start_gateway.sh

3) Odpalić sensory

    a. w drugiej sesji Cloud Shell
    b. ./create_start_devices.sh <plik z pomiarami>

    Przykład
        ./create_start_devices.sh pomiary_zur.csv

Potem można korzystać ze skrytu:
	./start_devices.sh <plik z pomiarami>

4) Aby zatrzymać wszystko (gateway oraz sensory):

    ./stop.sh

5)W pliku z pomiarami:
	a. Jedna linia to jeden sensor
	b. wartości oddzileane są  poprzez dwukropek :
	c. Legenda na gorze mówi o kolejności atrybutów, nie wolno usuwać tej linii
