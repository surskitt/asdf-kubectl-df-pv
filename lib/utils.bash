#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/yashbhutwala/kubectl-df-pv"
TOOL_NAME="kubectl-df-pv"
TOOL_TEST="df-pv --help"

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

curl_opts=(-fsSL)

# NOTE: You might want to remove this if kubectl-df-pv is not hosted on GitHub releases.
if [ -n "${GITHUB_API_TOKEN:-}" ]; then
	curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
	git ls-remote --tags --refs "$GH_REPO" |
		grep -o 'refs/tags/.*' | cut -d/ -f3- |
		sed 's/^v//' # NOTE: You might want to adapt this sed to remove non-version strings from tags
}

list_all_versions() {
	list_github_tags
}

download_release() {
	local version filename url
	version="$1"
	filename="$2"

	os="$(uname -s)"
	arch="$(uname -m)"

	if [[ "${arch}" == "i386" ]] ; then
		arch="386"
	fi

	if [[ "${arch}" == "x86_64" ]] ; then
		arch="amd64"
	fi

	system="${os,,}_${arch}"

	# TODO: Adapt the release URL convention for kubectl-df-pv
	url="$GH_REPO/archive/v${version}.tar.gz"
	# https://github.com/yashbhutwala/kubectl-df-pv/releases/download/v0.3.0/kubectl-df-pv_v0.3.0_linux_amd64.tar.gz
	url="${GH_REPO}/releases/download/v${version}/kubectl-df-pv_v${version}_${system}.tar.gz"

	echo "* Downloading $TOOL_NAME release $version..."
	curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}/bin"

	if [ "$install_type" != "version" ]; then
		fail "asdf-$TOOL_NAME supports release installs only"
	fi

	(
		mkdir -p "$install_path"
		cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path"

		# TODO: Assert kubectl-df-pv executable exists.
		local tool_cmd
		tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
		test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

		echo "$TOOL_NAME $version installation was successful!"
	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}
