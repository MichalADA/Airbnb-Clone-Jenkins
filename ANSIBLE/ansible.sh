#!/bin/bash

# Aktualizacja listy pakietów
sudo apt update

# Instalacja oprogramowania umożliwiającego dodanie repozytorium zewnętrznego
sudo apt install software-properties-common

# Dodanie repozytorium Ansible
sudo add-apt-repository --yes --update ppa:ansible/ansible

# Instalacja Ansible
sudo apt install ansible -y
