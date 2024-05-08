#!/bin/bash

###############################################
# Author: Kajal
# Date: 8th May, 2024
#
# Version: v1
#
# This script will report the users details of github repository
#
# Before running this file export below values of your github username and token
#
# export username="sinhakajal"
# export token="<create or find token from github browser>"
#
#run the file with 2 argument
#
# run ./list.sh <Organization_Name> <Repo_Name>
#
# check for this url - https://github.com/kubernetes/kubernetes/
# https://github.com/kubernetes<ORGANIZATION_NAME>/kubernetes<REPO_NAME>/
#
###############################################

# set -x

# in case of no/bad argument passed

# GitHub API URL
API_URL="https://api.github.com"

# GitHub username and personal access token
USERNAME=$username
TOKEN=$token

# User and Repository information
REPO_OWNER=$1
REPO_NAME=$2

# Function to make a GET request to the GitHub API
function github_api_get {
    local endpoint="$1"
    local url="${API_URL}/${endpoint}"

    # Send a GET request to the GitHub API with authentication
    curl -s -u "${USERNAME}:${TOKEN}" "$url"
}

# Function to list users with read access to the repository
function list_users_with_read_access {
    local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/collaborators"

    # Fetch the list of collaborators on the repository
    collaborators="$(github_api_get "$endpoint" | jq -r '.[] | select(.permissions.pull == true) | .login')"

    # Display the list of collaborators with read access
    if [[ -z "$collaborators" ]]; then
        echo "No users with read access found for ${REPO_OWNER}/${REPO_NAME}."
    else
        echo "Users with read access to ${REPO_OWNER}/${REPO_NAME}:"
        echo "$collaborators"
    fi
}

# helper function in case of any user just running this file without going through this once ($# = count number of argument)
function helper { 
    expected_cmd_arg=2
    if [[ $# -ne $expected_cmd_arg ]]; then
	echo "Please execute the script with required number of arguments"
	echo "asd"
    fi
}

# Main script
helper

echo "Listing users with read access to ${REPO_OWNER}/${REPO_NAME}..."
list_users_with_read_access
