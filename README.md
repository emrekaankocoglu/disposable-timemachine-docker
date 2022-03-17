# disposable-timemachine-docker
Temporary backups with Apple Time Machine, accessible with a Wireguard tunnel-containerized with Docker
## Why?
A friend of mine who works at a repair shop dealing with Apple computers asked me if they can create temporary backups that will be deleted once the repair job is done and the customer is satisfied with the data integrity. Since there exists no backup solution better than Apple's Time Machine for Macs, we opted for a TM-capable SMB share in a virtual machine for the ease of deleting all the content once they are done with it. An additional VPN layer was added for making it remotely user-accessible in case of a conflict.


To make the solution more resource efficient, the conversion from a VM to a Docker container is done -since they were running out of CPU threads-.

## Usage
Edit the docker-compose file - please refer to [linuxserver/docker-wireguard](https://github.com/linuxserver/docker-wireguard) on how-.


Use ``` docker-compose run . <name> ``` to deploy.


Connect to the Samba share after connecting to the Wireguard tunnel created using the local IP adress -the first address of the internal subnet specified for Wireguard server- as a guest.


