#!/bin/zsh

# Check if zlang is already installed
if [[ -f "/private/etc/paths.d/zlang" ]] && [[ -z "$1" ]]; then
	echo "zlang is already installed. Add version parameter to override this error."
	exit 8
fi

# Actual localizing
export GIT_LATEST_URL="https://raw.githubusercontent.com/410-dev/eBash2/main/latest";
export GIT_RELEASE_URL="https://github.com/410-dev/eBash2/releases/download/";

echo "Preparing zlang environment..."

if [[ -z "$1" ]]; then
	export runtimeVersionRequest="latest"
else
	export runtimeVersionRequest="$1"
fi

echo "Requested Runtime: $runtimeVersionRequest"

if [[ "$runtimeVersionRequest" == "latest" ]]; then
	echo "Downloading latest version data..."
	export runtimeVersionRequest=$(curl -Ls "$GIT_LATEST_URL")
fi

echo "Downloading runtime: $runtimeVersionRequest"
sudo curl -L --progress-bar "${GIT_RELEASE_URL}/${runtimeVersionRequest}/eBash2-${runtimeVersionRequest}.zip" -o "/tmp/zlang.zip"
if [[ ! $? == 0 ]]; then
	echo "Failed downloading runtime."
	unset GIT_LATEST_URL GIT_RELEASE_URL runtimeVersionRequest	
	exit 6
fi

if [[ -z "$(file "/tmp/zlang.zip" | grep "Zip archive data")" ]]; then
	echo "Downloaded file is broken. (Not zip archive)"
	exit 5
fi

if [[ -z "$2" ]]; then
	export INSTALLDIR="/usr/local/zlang"
	echo "To save, the tool needs superuser permission."
	sudo echo -n ""
	if [[ $? == 0 ]]; then
		echo "Granted."
	else
		echo "Failed granting superuser permission."
		unset GIT_LATEST_URL GIT_RELEASE_URL runtimeVersionRequest INSTALLDIR
		exit 7
	fi
else
	export INSTALLDIR="$2"
fi

echo "Unpacking..."
sudo mkdir -p "$INSTALLDIR"
sudo unzip -qo "/tmp/zlang.zip" -d "$INSTALLDIR"
if [[ ! $? == 0 ]]; then
	echo "Failed unpacking."
	unset GIT_LATEST_URL GIT_RELEASE_URL runtimeVersionRequest INSTALLDIR
	exit 4
fi
sudo rm -rf "$INSTALLDIR/__MACOSX"

# If it is not localizing runtime
if [[ -z "$2" ]]; then
	# Add to bashrc
	echo "Adding zlang loader to bashrc..."
	if [[ -z "$(cat ~/.bashrc | grep "ZLANG_HOME=")" ]]; then
		echo "# Load zlang" >> ~/.bashrc
		echo "export ZLANG_HOME=\"$INSTALLDIR\"" >> ~/.bashrc
		echo "if [[ -f "\"$INSTALLDIR/zlang-linker\"" ]]; then source "$INSTALLDIR"/zlang-linker; fi" >> ~/.bashrc
	fi

	# Add to Path
	echo "Adding zlang-linker to path..."
	sudo chmod +x "$INSTALLDIR"/zlang-linker
	sudo chmod +x "$INSTALLDIR"/uninstall-zlang
	sudo rm -rf "$INSTALLDIR/bin"
	sudo mkdir -p "$INSTALLDIR/bin"
	sudo ln -s "$INSTALLDIR/zlang-linker" "$INSTALLDIR/bin/zlang-linker"
	sudo ln -s "$INSTALLDIR/uninstall-ebash" "$INSTALLDIR/bin/uninstall-ebash"
	echo "$INSTALLDIR/bin" | sudo tee -a "/private/etc/paths.d/zslang" > /dev/null

	# Generate receipt
	echo "Generating receipt..."
	echo "/private/etc/paths.d/zlang" | sudo tee -a "$INSTALLDIR/receipt" >/dev/null
	echo "$INSTALLDIR" | sudo tee -a "$INSTALLDIR/receipt" > /dev/null
fi

echo "Cleaning up..."
sudo chown -R "$(echo $(whoami))" "$INSTALLDIR"
sudo rm -rf "/tmp/zlang.zip"

unset GIT_LATEST_URL GIT_RELEASE_URL runtimeVersionRequest INSTALLDIR
echo "Done!"
