#!/bin/bash

# Lloyd Alex Porter
# StudentID: 2007666
# Parameter to File Bash Script, for MOD003218 Operating Systems


# Set Array to every Parameter
array=($@)
# Get number of Parameters
parameterCount=${#array[*]}


# Append to File
function_appendToFile () {
	echo
	echo "Appending parameters to file..."
	timestamp=$(date +"%d/%m/%Y@%H:%M:%S")
	echo $timestamp - $userName: >> $fileName
	for ((x=0; x<parameterCount; ++x)); do
		printf '%s\n' "${array[x]}" >> $fileName
	done
	echo >> $fileName
	echo "Successfully appended to file."
	function_exitProgram
}

# More Options for the User
function_moreOptions () {
	echo
	echo "What would you like to do instead?"
	select answerOptions in "Append to File" "Change save file" "Cancel"
	do
		case $answerOptions in
			"Append to File" )
				function_appendToFile
				break;;
			"Change save file" )
				echo
				echo "Choose a new file name."
				function_nameOfFile
				break;;
			Cancel )
				echo
				function_exitProgram
				exit;;
		esac
	done
}

# Ask what to do when file exists
function_whenFileExists () {
	echo
	echo "Do you want to overwrite the existing file?"
	select answerOverwrite in "Yes" "More Options" "Cancel"
	do
		case $answerOverwrite in
			Yes )
				rm $fileName
				break;;
			"More Options" )
				function_moreOptions
				break;;
			Cancel )
				echo
				function_exitProgram
				exit;;
		esac
	done
}

# Does File already exist?
function_checkFileExistance () {
	if [ -f "$fileName" ]; then
		echo
		echo "$fileName already exists."
		function_whenFileExists
	fi
}

# What to name the File
function_nameOfFile () {
	fileName=
	while [ -z $fileName ]
	do
		echo
		echo "What do you want to name the file? (exclude .txt)"
		fileName=
		read -p "File name: " fileName
		fileName=${fileName// /_}
	done
	fileName=$fileName.txt
	function_checkFileExistance
}

# Write each Parameter to a File
function_writeToFile () {
	echo
	echo "Writing parameters to file..."
	timestamp=$(date +"%d/%m/%Y@%H:%M:%S")
	echo $timestamp - $userName: > $fileName
	for ((x=0; x<parameterCount; ++x)); do
		printf '%s\n' "${array[x]}" >> $fileName
	done
	echo >> $fileName
	echo "Successfully written to file."
}

# Exit the Program
function_exitProgram () {
	echo
	echo "Thank you for using this program."
	exit
}

# Gets the users name
function_usersName () {
	userName=
	while [ -z $userName ]
	do
		echo
		echo "What is your name?"
		userName=
		read -p "User: " userName
		userName=${userName// /_}
	done
}

# Beginning of the Program
function_programBegins () {
	echo "Welcome, this program saves parameters to a file."
	echo
	echo "Do you want to save parameters to a file?"
	select answerSave in "Yes" "No"
	do
		case $answerSave in
			Yes )
				function_usersName
				function_nameOfFile
				function_writeToFile
				break;;
			No )
				function_exitProgram
				exit;;
		esac
	done
}

# Checks whether any parameters are passed,
# controls whether program runs or not.
if [ $# -eq 0 ]; then
	echo "No arguments supplied,"
	echo "program is dependant on parameters/arguments."
else
	echo
	function_programBegins
	function_exitProgram
fi
