#! /usr/bin/env bash
set -uvx
set -e
#beta=2057
beta=2060
cwd=`pwd`
rm -rf jint *.nupkg
git clone https://github.com/sebastienros/jint
cd jint
git checkout v3.0.0-beta-${beta}
cd Jint
cp ../../README.md ..
cp ../../Directory.Build.props .
mv Jint.csproj GScript.csproj || true
sed -i -e "s/BETA/${beta}/g" Directory.Build.props
rm -rf bin obj
find . -name "*.cs" -exec sed -i -e "s/Jint/GScript/g" {} +
dotnet pack -p:Configuration=Release -p:Platform="Any CPU"
cp -rp "bin/Any CPU/Release/GScript.3.0.0.${beta}.nupkg" $cwd/
cd $cwd
ls -lh *.nupkg
