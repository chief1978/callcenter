import os

from dotenv import load_dotenv

load_dotenv()

QPANEL_USER = os.getenv('QPANEL_USER', 'qpanel_user')
QPANEL_PASSWORD = os.getenv('QPANEL_PWD', 'qpanel_password')
ASTERISK_HOST = os.getenv('ASTERISK_HOST', '127.0.0.1')
ATERISK_AMI_CONF_FILE = 'asterisk/etc/manager.conf'
statusUrl = os.getenv(
    'statusUrl', 'http://192.168.0.1:8080/api/v1/smev-client/getAppealState')
dealsUrl = os.getenv(
    'dealsUrl', 'http://192.168.0.1:8080/api/v1/smev-client/getAppealsList')
FASTAGI_CONF_FILE = 'fastagi/fastagi.properties'
ODBC_INI_FILE = 'asterisk/odbc.ini'
MYSQL_ROOT_PASSWORD = os.getenv('MYSQL_ROOT_PASSWORD', 'password')
MYSQL_DB = os.getenv('MYSQL_DB', 'asterisk')
MYSQL_HOST = os.getenv('MYSQL_HOST', '127.0.0.1')
MYSQL_USER = os.getenv('MYSQL_USER', 'root')

# Add qpanel config to asterisk ami configutation - manager.conf
with open(ATERISK_AMI_CONF_FILE, "r") as file:
    lines = file.readlines()

index = 0
for line in lines:
    if line == f'[{QPANEL_USER}]\n':
        break
    index += 1

if index == len(lines):
    lines.append(f'[{QPANEL_USER}]\n')
    lines.append(f'secret = {QPANEL_PASSWORD}\n')
    lines.append('deny=0.0.0.0/0.0.0.0\n')
    lines.append('permit=127.0.0.1/255.255.255.255\n')
else:
    lines[index] = f'[{QPANEL_USER}]\n'
    lines[index+1] = f'secret = {QPANEL_PASSWORD}]\n'
    lines[index+2] = 'deny=0.0.0.0/0.0.0.0\n'
    lines[index+3] = 'permit=127.0.0.1/255.255.255.255\n'

with open(ATERISK_AMI_CONF_FILE, "w") as file:
    file.writelines(lines)

print('ami config file patched succesfully.')

# Add fastagi properties
lines = []
lines.append('bindPort=4573\n')
lines.append('poolSize=20\n')
lines.append(f'statusUrl={statusUrl}\n')
lines.append(f'dealsUrl={dealsUrl}\n')
lines.append('userLogin=admin')

with open(FASTAGI_CONF_FILE, "w") as file:
    file.writelines(lines)

print('fastagi config file patched succesfully.')

# Add odbc ini config
lines = []
lines.append(f'[{MYSQL_DB}]\n')
lines.append('Description = MySQL connection to asterisk database\n')
lines.append('Driver = MariaDB\n')
lines.append(f'Database = {MYSQL_DB}\n')
lines.append(f'Server = {MYSQL_HOST}\n')
lines.append(f'User = {MYSQL_USER}\n')
lines.append(f'Password = {MYSQL_ROOT_PASSWORD}\n')
lines.append('Port = 3306\n')

with open(ODBC_INI_FILE, "w") as file:
    file.writelines(lines)

print('odbc ini file patched succesfully.')
