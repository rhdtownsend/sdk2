FC	    = gfortran -ffree-form
FC1         = gfortran -ffixed-form
OPTS0       = -O2 -fPIC
MODLIB      = -I./../lapack95_modules
OPTS1       = -c $(OPTS0)
OPTS3       = $(OPTS1) $(MODLIB)
OPTL        = -o 
OPTLIB      =
LAPACK_PATH = ../../lib
LAPACK95    = ../lapack95.a
LAPACK77    = $(LAPACK_PATH)/liblapack.a
TMG77       = $(LAPACK_PATH)/libtmg.a
BLAS        = $(LAPACK_PATH)/libblas.a
LIBS        = $(LAPACK95) $(TMG77) $(LAPACK77) $(BLAS)
SUF         = f90

XX = 'rm' -f $@; \
        'rm' -f $@.res; \
	$(FC) $(OPTS0) -o $@ $(MODLIB) $@.$(SUF) $(OPTLIB) $(LIBS); \
        $@ < $@.dat > $@.res; \
        'rm' -f $@

YY = $(FC) $(OPTS0) -o $@ $(MODLIB) $@.$(SUF) $(OPTLIB) $(LIBS)

.SUFFIXES: .f90 .f .o

.$(SUF).o: 
	$(FC) $(OPTS3) $<

.f.o:
	$(FC1) $(OPTS3) $<
