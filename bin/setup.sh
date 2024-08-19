#!/bin/bash
echo "**************************************************"
echo " Setting up TDD/BDD Final Project Environment"
echo "**************************************************"

# Homebrew: Install or update it if you don't have it already
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "*** Installing Python 3.9 and Virtual Environment"
brew install python@3.9

echo "*** Making Python 3.9 the default..."
# Assuming you want to set it as default for the current shell session
export PATH="/usr/local/opt/python@3.9/bin:$PATH" 

echo "*** Checking the Python version..."
python3.9 --version

echo "*** Creating a Python virtual environment"
python3.9 -m venv ~/venv

echo "*** Configuring the developer environment..."
echo "# TDD/BDD Final Project additions" >> ~/.bashrc
echo "export GITHUB_ACCOUNT=$GITHUB_ACCOUNT" >> ~/.bashrc
echo 'export PS1="\[\e]0;\u:\W\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ "' >> ~/.bashrc
echo "source ~/venv/bin/activate" >> ~/.bashrc

echo "*** Installing Selenium and Chrome for BDD" 

brew install sqlite chromium chromedriver python-selenium

echo "*** Installing Python depenencies..."
source ~/venv/bin/activate && python3.9 -m pip install --upgrade pip wheel
# Install psycopg2 directly, bypassing the wheel build
source ~/venv/bin/activate && pip install psycopg2-binary
source ~/venv/bin/activate && pip install -r requirements.txt

echo "*** Establishing .env file"
cp dot-env-example .env

echo "*** Starting the Postgres Docker container..."
make db

echo "*** Checking the Postgres Docker container..."
docker ps

echo "**************************************************"
echo " TDD/BDD Final Project Environment Setup Complete"
echo "**************************************************"
echo ""
echo "Use 'exit' to close this terminal and open a new one to initialize the environment"
echo ""
