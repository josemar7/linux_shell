#!/bin/bash
if [[ "${UID}" -ne 0 ]]
then
  "Error. You aren't a superuser!" >&2
  exit 1
fi

if [[ "${#}" -lt 1 ]]
then
  "Usage: ${0} USER_NAME [COMMENT]..." >&2
  exit 1
fi

USER_NAME="${1}"
shift
COMMENT="{@}"

PASSWORD=$(date +%s%N | sha256sum | head -c48)

useradd -c "${COMMENT}" -m ${USER_NAME} &> /dev/null

if [[ "${?}" -ne 0 ]]
then
  'The account could not be created.' >&2
  exit 1
fi

echo ${PASSWORD} | passwd --stdin ${USER_NAME} &> /dev/null

if [[ "${?}" -ne 0 ]]
then
  'the password for the account could not be set.' >&2
  exit 1
fi


passwd -e ${USER_NAME} &> /dev/null

echo 'username:'
echo "${USER_NAME}"
echo
echo 'password:'
echo "${PASSWORD}"
echo
echo 'host:'
echo "${HOSTNAME}"
exit 0
