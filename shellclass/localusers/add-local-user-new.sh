#!/bin/bash

# make sure the script is being executed with superuser privileges
if [[ "${UID}" -ne 0 ]]
then
  echo "Error. You aren't superuser."
  exit 1
fi

if [[ "${#}" -lt 1 ]]
then
  echo "Usage: ${0} USER_NAME [COMMENT]..."
  exit 1
fi

# Ask for the user name
# read -p 'Enter the username to create: ' USER_NAME
USER_NAME="${1}"

shift
COMMENT="{@}"

PASSWORD=$(date +%s%N | sha256sum | head -c48)

# Create the user.
useradd -c "${COMMENT}" -m ${USER_NAME}


# Check to see if the useradd command succeeded.
# We don't want to tell the user than an account was created when it hasn't been.
if [[ "${?}" -ne 0 ]]
then
  echo 'The account could not be created.'
  exit 1
fi

# Set the password for the user.
echo ${PASSWORD} | passwd --stdin ${USER_NAME}

if [[ "${?}" -ne 0 ]]
then
  echo 'the password for the account could not be set.'
  exit 1
fi

# Force password change on first login.
passwd -e ${USER_NAME}

# Display the username, password, and the host where the user was created.
echo
echo 'username:'
echo "${USER_NAME}"
echo
echo 'password:'
echo "${PASSWORD}"
echo
echo 'host:'
echo "${HOSTNAME}"
exit 0
