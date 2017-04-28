#!/bin/bash
set -e

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

versions=( "$@" )
if [ ${#versions[@]} -eq 0 ]; then
	versions=( */ )
fi
versions=( "${versions[@]%/}" )


for version in "${versions[@]}"; do
  if [ $version == "2.7" ]; then
  	fullPackage="python"
    fullVersion="$(curl -fsSL "http://archive.ubuntu.com/ubuntu/dists/xenial/main/binary-amd64/Packages.gz"                  | gunzip | awk -v pkgname=$fullPackage -F ': ' '$1 == "Package" { pkg = $2 } pkg == pkgname && $1 == "Version" { print $2 }' | sort -rV | head -n1 )"
  elif [ $version == "3.5" ]; then
  	fullPackage="python3.5"
  	fullVersion="$(curl -fsSL "http://archive.ubuntu.com/ubuntu/dists/xenial/main/binary-amd64/Packages.gz"                  | gunzip | awk -v pkgname=$fullPackage -F ': ' '$1 == "Package" { pkg = $2 } pkg == pkgname && $1 == "Version" { print $2 }' | sort -rV | head -n1 )"
  else
  	fullPackage="python${version}"
    fullVersion="$(curl -fsSL "http://ppa.launchpad.net/fkrull/deadsnakes/ubuntu/dists/xenial/main/binary-amd64/Packages.gz" | gunzip | awk -v pkgname=$fullPackage -F ': ' '$1 == "Package" { pkg = $2 } pkg == pkgname && $1 == "Version" { print $2 }' | sort -rV | head -n1 )"
	fi
	(
		set -x
		sed '
			s/%%PYTHON_MAJOR%%/'"$version"'/g;
			s/%%PYTHON_VERSION%%/'"$fullVersion"'/g;
			s!%%PYTHON_PACKAGE%%!'"$fullPackage"'!g;
		' Dockerfile.template > "$version/Dockerfile"
	)
done
