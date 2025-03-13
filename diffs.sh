#!/bin/sh
helm repo add cloudbees https://charts.cloudbees.com/public/cloudbees
helm repo update

echo "* Deleting any lingering tgz files..."
rm *.tgz

read -p ":: Please enter the version of your current Helm chart: " oldver
if [[ -z "$oldver" ]]; then
  echo "* No input provided. Exiting."
  exit 1
fi

echo "Cleaning up any old files..."
rm -r ./latest
rm -r ./$oldver

echo "* Pulling latest version..."
helm pull cloudbees/cloudbees-core -d .

mkdir ./latest
tar -xzf *.tgz -C ./latest

echo "* Deleting latest tgz..."
rm *.tgz

echo "* Pulling chart version $oldver..."
helm pull cloudbees/cloudbees-core -d . --version $oldver

mkdir ./$oldver
tar -xzf *.tgz -C ./$oldver

echo "* Deleting $oldver tgz..."
rm *.tgz

git diff --no-index latest/cloudbees-core/values.yaml $oldver/cloudbees-core/values.yaml

echo "* Cleaning up..."
rm -r ./latest
rm -r ./$oldver