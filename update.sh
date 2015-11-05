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
  	package="python"
    fullVersion="$(curl -fsSL "http://archive.ubuntu.com/ubuntu/dists/trusty/main/binary-amd64/Packages.gz"                  | gunzip | awk -v pkgname=$package -F ': ' '$1 == "Package" { pkg = $2 } pkg == pkgname && $1 == "Version" { print $2 }' | sort -rV | head -n1 )"
  elif [ $version == "3.4" ]; then
  	package="python3.4"
  	fullVersion="$(curl -fsSL "http://archive.ubuntu.com/ubuntu/dists/trusty/main/binary-amd64/Packages.gz"                  | gunzip | awk -v pkgname=$package -F ': ' '$1 == "Package" { pkg = $2 } pkg == pkgname && $1 == "Version" { print $2 }' | sort -rV | head -n1 )"
  else
  	package="python${version}"
    fullVersion="$(curl -fsSL "http://ppa.launchpad.net/fkrull/deadsnakes/ubuntu/dists/trusty/main/binary-amd64/Packages.gz" | gunzip | awk -v pkgname=$package -F ': ' '$1 == "Package" { pkg = $2 } pkg == pkgname && $1 == "Version" { print $2 }' | sort -rV | head -n1 )"
	fi
	(
		set -x
		sed '
			s/%%MAJOR%%/'"$version"'/g;
			s/%%VERSION%%/'"$fullVersion"'/g;
			s!%%PACKAGE%%!'"$package"'!g;
		' Dockerfile.template > "$version/Dockerfile"
	)
done

