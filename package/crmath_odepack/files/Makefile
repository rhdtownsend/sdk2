# $Id$

ifeq ($(shell uname -s),Darwin)
MARCH = -march=armv8.2-a
endif

FC=gfortran
FFLAGS=-O2 $(MARCH) -ffp-contract=off -fopenmp -fPIC -std=legacy -I${DEST_ROOT}/include/

all : libodepack.a

libodepack.a : odepack.o opkda1.o opkda2-no-blas.o opkdmain.o opksa1.o opksa2-no-blas.o opksmain.o
	ar crv $@ $^
	ranlib $@

%.o : %.f
	${FC} ${FFLAGS} -c $<

%.o : %.f90
	${FC} ${FFLAGS} -c $<

clean :
	rm -f *.a *.o *.mod
