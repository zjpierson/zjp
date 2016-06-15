# Makefile for CSC300 PA#1 (paint program) using OpenGL.

# Author: John M. Weiss, Ph.D.
# Written Sep 19, 2013.

# Usage:  make target1 target2 ...

#-----------------------------------------------------------------------

# GNU C/C++ compiler and linker:
LINK = g++

# Turn on optimization and warnings:
#CFLAGS = -Wall -O -g
#CXXFLAGS = $(CFLAGS)

# OpenGL libraries for Linux
#GL_LIBS = -lglut -lGLU -lGL -lm

#-----------------------------------------------------------------------

# Specific targets:

# MAKE allows the use of "wildcards", to make writing compilation instructions
# a bit easier. GNU make uses $@ for the target and $^ for the dependencies.

calc:	calculator.o
	$(LINK) -o calc $^ 

#-----------------------------------------------------------------------

clean:
	rm -f *.o *~ 

cleanall:
	rm -f *.o *~ calc

