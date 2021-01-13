#!/bin/sh
TEMP_BRANCH=$(date +%s)
TARGET="${3}"
SOURCE="${2}"
FROM="${1}"
TMP_TGT="target-${TEMP_BRANCH}"
TMP_SRC="source-${TEMP_BRANCH}"

MERGE_MSG="Partial deployment of '${SOURCE}' into ${TARGET}"

git branch "${TMP_TGT}" "${TARGET}"
git branch "${TMP_SRC}" "${SOURCE}"
git rebase --onto "${TMP_TGT}" "${FROM}" "${TMP_SRC}"
REBASE_RESULT=$?
while [ $REBASE_RESULT -ne 0 ]; do
    echo "--- FIX ISSUES AND PRESS ANY KEY TO CONTINUE ---"
    read -r
    GIT_EDITOR=true git rebase --continue
    REBASE_RESULT=$?
done

git checkout "${TMP_TGT}"
git reset --hard "${TMP_SRC}"

git checkout "${TARGET}"
git merge --no-ff -m "${MERGE_MSG}" "${TMP_TGT}"

git branch -D "${TMP_TGT}" "${TMP_SRC}"
