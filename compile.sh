#!/bin/bash

for i in *.s; do
	basename=`echo $i | cut -f 1 -d '.'`
	nasm -f elf64 -o obj/$basename.o $i
done

ld obj/*.o -o bin
