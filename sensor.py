# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#         https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import random
import socket
import sys
import time
import datetime
import time
import json

from colors import bcolors

ADDR = ''
PORT = 10000
# Create a UDP socket
client_sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

server_address = (ADDR, PORT)

# python ./sensor.py $DEV $LAT $LON $H2S $NH3 $TEMP $HUMID

device_id = sys.argv[1]
lat = sys.argv[2]
lon = sys.argv[3]
hs = sys.argv[4]
nh = sys.argv[5]
temp = sys.argv[6]
humid = sys.argv[7]

if not device_id:
    sys.exit('The device id must be specified.')

print('Bringing up device {}'.format(device_id))


# return message received
def send_command(sock, message, log=True):
    sock.sendto(message, server_address)

    # Receive response
    response, _ = sock.recvfrom(4096)
    return response


def make_message(device_id, action, data=''):
    if data:
        return '{{ "device" : "{}", "action":"{}", "data" : "{}" }}'.format(
            device_id, action, data)
    else:
        return '{{ "device" : "{}", "action":"{}" }}'.format(device_id, action)


def run_action(action):
    message = make_message(device_id, action)
    if not message:
        return
    print('Sending data: {}'.format(message))
    event_response = send_command(client_sock, message.encode())
    print('Response {}'.format(event_response.decode("utf-8")))


def main():

    try:
        random.seed()
        run_action('detach')
        run_action('attach')

        h_base = float(humid)
        t_base = float(temp)
        #lat = float(lat)
        #lon = float(lon)
        h2s_base = float(hs)
        nh3_base = float(nh)

        while True:
            h = h_base + random.uniform(-1, 1)
            t = t_base + random.uniform(-1, 1)
            h2s = h2s_base + random.uniform(-0.01, 0.01)
            nh3 = nh3_base + random.uniform(-0.01, 0.01)

            temperature_f = t * 0.95
            h = "{:.3f}".format(h)
            t = "{:.3f}".format(temperature_f)
            ts = time.time()
            date_time = datetime.datetime.fromtimestamp(
                ts).strftime('%Y-%m-%d %H:%M:%S')
            data = {
                "Latitude":lat,
                "Longitude": lon,
                "H2S":h2s,
                "NH3":nh,
                "Temperatura": t,
                "Wilgotnosc": h,
                "Device_id": device_id,
                "Timestamp": date_time
            }

            data_out=json.dumps(data)

            message = make_message(
                device_id, 'event', data
            ).encode()
#'{\"temp\":\"{}\", \"humid\":\"{}\", \"h2s\":\"{}\", \"nh3\":\"{}\", \"lat\":\"{}\", \"lon\":{}\", \"timestamp\":\"{}\"}'.format(t, h, h2s, nh3, lat, lon, date_time)
            send_command(client_sock, message, False)
            time.sleep(2)
    finally:
        print('Closing socket')
        client_sock.close()


if __name__ == "__main__":
    main()
