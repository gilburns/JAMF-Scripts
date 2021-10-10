#!/bin/sh
####################################################################################################
#
# Remove Torrent Apps From Computer
#
#	Purpose: Modify the list of bundleIDs to search for and remove any application
#            installed anywhere on the computer with the bundleID. 
#
#            Static search for any app on the system with Torrent in the name. 
#
####################################################################################################
#
# HISTORY
#
#	Version 1.0.0, 09-Jun-2021, Gil Burns
#	Version 1.0.1, 13-Jun-2021, Gil Burns added code for name = Transmission
#	Version 1.0.2, 15-Jun-2021, Gil Burns added logging to JAMF results
#
####################################################################################################


####################################################################################################
#
# Define the Variables
#
####################################################################################################

#
# List of bundle IDs to search for and remove
#
read -d '' AppListID <<_EOF_
com.bitlord
com.bittorrent.BitTorrent
com.bitTorrent.btweb
com.bittorrent.uTorrent
com.bitTorrent.utweb
com.eltima.Folx3
com.google.Chrome.app.Default-anhdpjpojoipgpmfanmedjghaligalgb
com.google.Chrome.app.Default-icocmgpofpimcojhefbcfbdldkmndpgj
io.webtorrent.webtorrent
nl.tudelft.tribler
org.deluge
org.freedownloadmanager.fdm6
org.m0k.transmission
org.qbittorrent.qBittorrent
_EOF_


#
# Location to log activity
#
LogFile="/Library/Logs/RemoveTorrentApps.log"

TimeStamp=$(printf '%s %s\n' "$(date)")

echo "---------------------------------------------------" >> "$LogFile"
echo "--                                               --" >> "$LogFile"
echo "    Starting check for torrent applications" >> "$LogFile"
echo "    $TimeStamp" >> "$LogFile"
echo "--                                               --" >> "$LogFile"
echo "---------------------------------------------------" >> "$LogFile"

echo "Starting check for torrent applications"
echo "$TimeStamp"


####################################################################################################
#
# Define the Functions
#
####################################################################################################

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Find and remove app installation
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

findAppInstallationByName() {
	
	appInstalledTest=$(/usr/bin/mdfind 'kMDItemKind == "Application" && kMDItemFSName == "*torrent*"c')
	
	if [ ! -z "${appInstalledTest}" ]; then
		echo "  torrent apps ARE installed" >> "$LogFile"
		echo "  -------------------------------" >> "$LogFile"
		echo "  torrent apps ARE installed"
		
		while IFS= read -r line; do
			echo "     Remove app from computer…" >> "$LogFile"
			echo "          ${line}" >> "$LogFile"
			echo "     Remove app from computer…"
			echo "          ${line}"
			/bin/rm -R "${line}"
	
		done <<< "$appInstalledTest"

	fi

}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Find and remove Transmission app installation
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

findTransmissionAppInstallationByName() {
	
	appInstalledTest=$(/usr/bin/mdfind 'kMDItemKind == "Application" && kMDItemFSName == "Transmission.app"c')
	
	if [ ! -z "${appInstalledTest}" ]; then
		echo "  Transmission apps ARE installed" >> "$LogFile"
		echo "  -------------------------------" >> "$LogFile"
		echo "  Transmission apps ARE installed"
		
		while IFS= read -r line; do
			echo "     Remove app from computer…" >> "$LogFile"
			echo "          ${line}" >> "$LogFile"
			echo "     Remove app from computer…"
			echo "          ${line}"
			/bin/rm -R "${line}"
	
		done <<< "$appInstalledTest"

	fi

}


findAppInstallationByID() {
	local bundleIDToCheck="$1"

	appInstalledTest=$( /usr/bin/mdfind kMDItemCFBundleIdentifier="${bundleIDToCheck}" )

	if [ ! -z "${appInstalledTest}" ]; then
		echo "  ${bundleIDToCheck} IS installed" >> "$LogFile"
		echo "  -------------------------------" >> "$LogFile"
		echo "  ${bundleIDToCheck} IS installed"
		
		while IFS= read -r line; do
			echo "     Remove app from computer…" >> "$LogFile"
			echo "          ${line}" >> "$LogFile"
			echo "     Remove app from computer…"
			echo "          ${line}"
			/bin/rm -R "${line}"
	
		done <<< "$appInstalledTest"

	fi

}

####################################################################################################
#
# Remove torrent Apps by Name
#
####################################################################################################

echo "Searching for app named: torrent" >> "$LogFile"
echo "Searching for app named: torrent"

findAppInstallationByName

####################################################################################################
#
# Remove Transmission Apps by Name
#
####################################################################################################

echo "Searching for app named: Transmission" >> "$LogFile"
echo "Searching for app named: Transmission"

findTransmissionAppInstallationByName
	

####################################################################################################
#
# Remove Apps by CFBundleIdentifier
#
####################################################################################################

echo "Searching App Bundle ID list..." >> "$LogFile"
echo "Searching App Bundle ID list..."

while IFS= read -r bundleID; do
	echo "Searching for bundle ID: $bundleID" >> "$LogFile"
	echo "Searching for bundle ID: $bundleID"
	findAppInstallationByID "$bundleID"	
done <<< "$AppListID"

chmod +r "$LogFile"


echo "Run Complete" >> "$LogFile"
echo "---------------------------------------------------" >> "$LogFile"
echo " " >> "$LogFile"
echo " " >> "$LogFile"
echo "Run Complete"

exit 0