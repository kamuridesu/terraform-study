import subprocess as sp
import os
import pathlib
import sys


def runCommand(*args) -> dict:
    """run cli commands on shell and retrieves the result
    Return -> A dict with the following keys/values:
     - A boolean "status" key that tells if the command returned 0
     - A string "data" key that holds the output (stdout or stderr)
     """
    process = sp.Popen([*args], stdout=sp.PIPE, stdin=sp.PIPE, stderr=sp.PIPE)
    out, err = process.communicate()
    if process.returncode != 0:
        return {"status": False, "data": err.decode("utf-8")}
    return {"status": True, "data": out.decode("utf-8")}


def processOutputError(error_message: str) -> dict:
    """Processes the error message to get what resources needs to be imported
    Parameter:
    - error_message: str -> A string containing the error message to be processed
    Return -> A dict with the following keys/values:
    - A boolean "status" key that tells if the command returned 0 or there's nothing to import
    - A string "data" key that holds the output (stdout or stderr) or "Nothing to import"
    """
    separated_by_spaces = error_message.split(" ")
    id = separated_by_spaces[6].strip("\"")  # the resource id is on the 6 value of the list
    resource = separated_by_spaces[36].split(",")[0] # the resource is on the 6 value of the list
    imported = {}
    if resource == "cannot":  # if the resource is cannot, that means that we don't have resources to import
        # this needs more polishment, as it takes the error message that i've been facing while writing this script
        imported['status'] = False
        imported['data'] = "Nothing to import"
    else:
        imported = runCommand("terraform", "import", "-var-file=variables.tfvars", "-no-color", resource, id)
    if imported['status'] is False:
        # if returns an error prints the error
        print(imported['data'])
    return imported


def checkImportState():
    # first we generate a plan file, this is not needed
    plan = runCommand("terraform", "plan", "-var-file=variables.tfvars", "-no-color", "-out=test.plan")
    # then run the apply, without the -auto-approve bc some may not want to change their existing infrastructure
    successful = runCommand("terraform", "apply", "-no-color", "test.plan")
    if successful["status"] is False:
        imported_success = processOutputError(successful['data'])
        if imported_success['status']:
            # if the resource is imported, runs again to check if there are more resources to be imported as well
            print("Resource imported!")
            checkImportState()
        else:
            # if not, prints the output data and leave.
            print(imported_success['data'])


if __name__ == "__main__":
    checkImportState()
