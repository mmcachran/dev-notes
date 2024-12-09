#!/bin/bash
### Use "true" as parameter 4 for non-automatically overwriting installs.
### Particularly for Homebrew or something that uses this as a dependency.
### If run with no argument, it will re-install the latest version.

if [[ "$4" == "true" ]]; then
	if ! xcode-select  -p 2>&1 | grep -q error; then
		echo "XCode CLI Tools already installed"
		exit 0
	fi
	echo "Needs XCode tools"
fi

echo "Installing xcode tools"
# Installing the Xcode command line tools on 10.7.x or higher
osx_major_ver=$(/usr/bin/sw_vers -productVersion | /usr/bin/awk -F. '{print $1}')
osx_minor_ver=$(/usr/bin/sw_vers -productVersion | /usr/bin/awk -F. '{print $2}')
cmd_line_tools_temp_file="/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress"

## Installing the latest Xcode command line tools on 10.9.x or higher
# Create the placeholder file which is checked by the softwareupdate tool
# before allowing the installation of the Xcode command line tools.
touch "$cmd_line_tools_temp_file"

# Identify the correct update in the Software Update feed with "Command Line Tools" in the name for the OS version in question.
if [[ "$osx_major_ver" -lt 10 ]] || [[ "$osx_major_ver" -eq 10 ]] && [[ "$osx_minor_ver" -lt 9 ]]; then
	echo "Unsupported MacOS Version: ${osx_major_ver}.${osx_minor_ver}"
	exit 1
elif [[ "$osx_major_ver" -eq 10 ]] && [[ "$osx_minor_ver" -eq 9 ]]; then
	cmd_line_tools=$(softwareupdate -l | awk '/\*\ Command Line Tools/ { $1=$1;print }' | grep "Mavericks" | sed 's/^[[ \t]]*//;s/[[ \t]]*$//;s/*//' | cut -c 2-)
elif [[ "$osx_major_ver" -eq 10 ]] && [[ "$osx_minor_ver" -gt 9 ]] && [[ "$osx_minor_ver" -lt 15 ]]; then
	cmd_line_tools=$(/usr/sbin/softwareupdate --list 2>&1 | /usr/bin/awk -F"[*] " '/\* Command Line Tools/ {print $NF}' | \
    /usr/bin/sed 's/^ *//' | /usr/bin/tail -1)
else
	cmd_line_tools=$(/usr/sbin/softwareupdate --list 2>&1 | /usr/bin/awk -F: '/Label: Command Line Tools for Xcode/ {print $NF}' | \
	/usr/bin/sed 's/^ *//' | /usr/bin/tail -1)
fi

# Check to see if the softwareupdate tool has returned more than one Xcode
# command line tool installation option. If it has, use the last one listed
# as that should be the latest Xcode command line tool installer.
if (( $(grep -c . <<<"$cmd_line_tools") > 1 )); then
	cmd_line_tools_output="$cmd_line_tools"
	cmd_line_tools=$(printf "$cmd_line_tools_output" | tail -1)
fi

#Install the command line tools
softwareupdate -i "$cmd_line_tools" --verbose

# Remove the temp file
rm -f "$cmd_line_tools_temp_file"
