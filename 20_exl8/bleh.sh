#! /bin/bash

for ii in *log ; do
    i=${ii%.log}
    critic2 <<EOF
molecule $ii
write ${i}.xyz
EOF
done
