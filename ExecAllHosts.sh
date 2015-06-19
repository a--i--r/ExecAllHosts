#!/bin/bash
SAVEIFS=$IFS
NEWIFS=$(echo -en "\n\b")
IFS=${NEWIFS}
EXEC_CMDS=(
'hostname'
)
for CMD in ${EXEC_CMDS[@]}
do

    if [[ ${#CMD} < 1 ]]; then
        continue
    fi
    for SERVER in $(cat /etc/hosts | \
        gawk '{print $2;}' | sort)
    do
        SSH_CMD=$(echo ssh ${SERVER})
        COMMAND=$(echo ${SSH_CMD} "\"${CMD}\"")
        IFS=${SAVEIFS}
        echo "EXEC ... : ${COMMAND}"
        echo ${COMMAND} | $(which bash)
        IFS=${NEWIFS}
    done
done
IFS=$SAVEIFS