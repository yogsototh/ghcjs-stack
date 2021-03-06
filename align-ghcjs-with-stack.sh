#!/bin/bash



wget "http://ghcjs.luite.com/master-$(date +%Y%m%d).tar.gz" -O master.tar.gz


export RESOLVER=${R:-lts-5.1}
stack config set resolver $RESOLVER
export EXTRA=${E:-9005001}
mkdir cache

tar -zxf master.tar.gz

echo "do the work"
echo "resolver: $RESOLVER" > ghcjs-0.2.0/stack.yaml
echo "allow-newer: true" >> ghcjs-0.2.0/stack.yaml
sed "s/^Version:.*/Version:        0.2.0.$EXTRA/" < ghcjs.cabal1 > ghcjs-0.2.0/ghcjs.cabal
cp ghcjs-0.2.0/lib/cache/boot.tar .
tar -xf boot.tar
cp patches/* ghcjs-boot/patches

./fetch-packages.sh

cp ghcjs-boot/boot/* new-boot/
rm -r ghcjs-boot/boot
mv new-boot ghcjs-boot/boot

echo tar
tar -cf boot.tar ghcjs-boot
cp -f boot.tar ghcjs-0.2.0/lib/cache/
[ -d ghcjs-0.2.0.$EXTRA ] && rm -r ghcjs-0.2.0.$EXTRA
mv ghcjs-0.2.0 ghcjs-0.2.0.$EXTRA
tar -zcf archive.tar.gz ghcjs-0.2.0.$EXTRA


# upload somewhere
scp archive.tar.gz ghcjs-host:/var/www/ghcjs/$RESOLVER-$EXTRA.tar.gz
