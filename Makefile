#############################################################################
##  v      #                   The Coq Proof Assistant                     ##
## <O___,, #                INRIA - CNRS - LIX - LRI - PPS                 ##
##   \VV/  #                                                               ##
##    //   #  Makefile automagically generated by coq_makefile Vtrunk      ##
#############################################################################

# WARNING
#
# This Makefile has been automagically generated
# Edit at your own risks !
#
# END OF WARNING

#
# This Makefile was generated by the command line :
# coq_makefile -f Make 
#

.DEFAULT_GOAL := all

# This Makefile may take arguments passed as environment variables:
# COQBIN to specify the directory where Coq binaries resides;
# TIMECMD set a command to log .v compilation time;
# TIMED if non empty, use the default time command as TIMECMD;
# ZDEBUG/COQDEBUG to specify debug flags for ocamlc&ocamlopt/coqc;
# DSTROOT to specify a prefix to install path.

# Here is a hack to make $(eval $(shell works:
define donewline


endef
includecmdwithout@ = $(eval $(subst @,$(donewline),$(shell { $(1) | tr -d '\r' | tr '\n' '@'; })))
$(call includecmdwithout@,$(COQBIN)coqtop -config)

TIMED?=
TIMECMD?=
STDTIME=/usr/bin/time -f "$* (user: %U mem: %M ko)"
TIMER=$(if $(TIMED), $(STDTIME), $(TIMECMD))

vo_to_obj = $(addsuffix .o,\
  $(filter-out Warning: Error:,\
  $(shell $(COQBIN)coqtop -q -noinit -batch -quiet -print-mod-uid $(1))))

##########################
#                        #
# Libraries definitions. #
#                        #
##########################

COQLIBS?=\
  -R "." RulerCompassGeometry
COQDOCLIBS?=\
  -R "." RulerCompassGeometry

##########################
#                        #
# Variables definitions. #
#                        #
##########################


OPT?=
COQDEP?="$(COQBIN)coqdep" -c
COQFLAGS?=-q $(OPT) $(COQLIBS) $(OTHERFLAGS) $(COQ_XML)
COQCHKFLAGS?=-silent -o
COQDOCFLAGS?=-interpolate -utf8
COQC?=$(TIMER) "$(COQBIN)coqc"
GALLINA?="$(COQBIN)gallina"
COQDOC?="$(COQBIN)coqdoc"
COQCHK?="$(COQBIN)coqchk"
COQMKTOP?="$(COQBIN)coqmktop"

##################
#                #
# Install Paths. #
#                #
##################

ifdef USERINSTALL
XDG_DATA_HOME?="$(HOME)/.local/share"
COQLIBINSTALL=$(XDG_DATA_HOME)/coq
COQDOCINSTALL=$(XDG_DATA_HOME)/doc/coq
else
COQLIBINSTALL="${COQLIB}user-contrib"
COQDOCINSTALL="${DOCDIR}user-contrib"
COQTOPINSTALL="${COQLIB}toploop"
endif

######################
#                    #
# Files dispatching. #
#                    #
######################

VFILES:=A1_Plan.v\
  A2_Orientation.v\
  A3_Metrique.v\
  A4_Droite.v\
  A5_Cercle.v\
  A6_Intersection.v\
  B10_Longueur_Prop.v\
  B11_Angle_prop.v\
  B12_Tacticques_base.v\
  B1_Confondu_Prop.v\
  B2_Orient_Prop.v\
  B3_Alignes_Prop.v\
  B4_Droite_Def.v\
  B5_Entre_Prel.v\
  B6_Cercle_Def.v\
  B7_Triangle_Equilateral.v\
  B8_Point_Def.v\
  B9_Inegalite_Triang.v\
  C10_Milieu.v\
  C11_Mediatrice.v\
  C12_Angles_Opposes.v\
  C13_Angles_Supplem.v\
  C14_Angle_Droit.v\
  C15_Parallelogramm.v\
  C1_DemiDroite_Prop.v\
  C2_Entre_Prop.v\
  C3_Triangles_Egaux.v\
  C4_Triangles_non_degeneres_egaux.v\
  C5_Droite_Prop.v\
  C6_Parallele_Prop.v\
  C7_DroitesSecantesProp.v\
  C8_DroitesConfondues.v\
  C9_Triangles_Emboites.v\
  D1_DistanceProp.v\
  D2_Axe.v\
  D3_Triangle_Prop.v\
  D4_CongruenceProp.v\
  D5_ParalleleConst.v\
  D6_SumAnglesProp.v\
  D7_NonParalleles_Secantes.v\
  E1_Incidence.v\
  E2_Ordre.v\
  E3_Congruence.v\
  E4_Continuite.v\
  E5_Parallelisme.v

ifneq ($(filter-out archclean clean cleanall printenv,$(MAKECMDGOALS)),)
-include $(addsuffix .d,$(VFILES))
else
ifeq ($(MAKECMDGOALS),)
-include $(addsuffix .d,$(VFILES))
endif
endif

.SECONDARY: $(addsuffix .d,$(VFILES))

VO=vo
VOFILES:=$(VFILES:.v=.$(VO))
GLOBFILES:=$(VFILES:.v=.glob)
GFILES:=$(VFILES:.v=.g)
HTMLFILES:=$(VFILES:.v=.html)
GHTMLFILES:=$(VFILES:.v=.g.html)
OBJFILES=$(call vo_to_obj,$(VOFILES))
ALLNATIVEFILES=$(OBJFILES:.o=.cmi) $(OBJFILES:.o=.cmo) $(OBJFILES:.o=.cmx) $(OBJFILES:.o=.cmxs)
NATIVEFILES=$(foreach f, $(ALLNATIVEFILES), $(wildcard $f))
ifeq '$(HASNATDYNLINK)' 'true'
HASNATDYNLINK_OR_EMPTY := yes
else
HASNATDYNLINK_OR_EMPTY :=
endif

#######################################
#                                     #
# Definition of the toplevel targets. #
#                                     #
#######################################

all: $(VOFILES) 

quick: $(VOFILES:.vo=.vio)

vio2vo:
	$(COQC) $(COQDEBUG) $(COQFLAGS) -schedule-vio2vo $(J) $(VOFILES:%.vo=%.vio)
checkproofs:
	$(COQC) $(COQDEBUG) $(COQFLAGS) -schedule-vio-checking $(J) $(VOFILES:%.vo=%.vio)
gallina: $(GFILES)

html: $(GLOBFILES) $(VFILES)
	- mkdir -p html
	$(COQDOC) -toc $(COQDOCFLAGS) -html $(COQDOCLIBS) -d html $(VFILES)

gallinahtml: $(GLOBFILES) $(VFILES)
	- mkdir -p html
	$(COQDOC) -toc $(COQDOCFLAGS) -html -g $(COQDOCLIBS) -d html $(VFILES)

all.ps: $(VFILES)
	$(COQDOC) -toc $(COQDOCFLAGS) -ps $(COQDOCLIBS) -o $@ `$(COQDEP) -sort -suffix .v $^`

all-gal.ps: $(VFILES)
	$(COQDOC) -toc $(COQDOCFLAGS) -ps -g $(COQDOCLIBS) -o $@ `$(COQDEP) -sort -suffix .v $^`

all.pdf: $(VFILES)
	$(COQDOC) -toc $(COQDOCFLAGS) -pdf $(COQDOCLIBS) -o $@ `$(COQDEP) -sort -suffix .v $^`

all-gal.pdf: $(VFILES)
	$(COQDOC) -toc $(COQDOCFLAGS) -pdf -g $(COQDOCLIBS) -o $@ `$(COQDEP) -sort -suffix .v $^`

validate: $(VOFILES)
	$(COQCHK) $(COQCHKFLAGS) $(COQLIBS) $(notdir $(^:.vo=))

beautify: $(VFILES:=.beautified)
	for file in $^; do mv $${file%.beautified} $${file%beautified}old && mv $${file} $${file%.beautified}; done
	@echo 'Do not do "make clean" until you are sure that everything went well!'
	@echo 'If there were a problem, execute "for file in $$(find . -name \*.v.old -print); do mv $${file} $${file%.old}; done" in your shell/'

.PHONY: all archclean beautify byte clean cleanall gallina gallinahtml html install install-doc install-natdynlink install-toploop opt printenv quick uninstall userinstall validate vio2vo

####################
#                  #
# Special targets. #
#                  #
####################

byte:
	$(MAKE) all "OPT:=-byte"

opt:
	$(MAKE) all "OPT:=-opt"

userinstall:
	+$(MAKE) USERINSTALL=true install

install:
	cd "." && for i in $(VOFILES) $(VFILES) $(GLOBFILES) $(NATIVEFILES) $(CMOFILES) $(CMIFILES) $(CMAFILES); do \
	 install -d "`dirname "$(DSTROOT)"$(COQLIBINSTALL)/RulerCompassGeometry/$$i`"; \
	 install -m 0644 $$i "$(DSTROOT)"$(COQLIBINSTALL)/RulerCompassGeometry/$$i; \
	done

install-doc:
	install -d "$(DSTROOT)"$(COQDOCINSTALL)/RulerCompassGeometry/html
	for i in html/*; do \
	 install -m 0644 $$i "$(DSTROOT)"$(COQDOCINSTALL)/RulerCompassGeometry/$$i;\
	done

uninstall_me.sh: Makefile
	echo '#!/bin/sh' > $@
	printf 'cd "$${DSTROOT}"$(COQLIBINSTALL)/RulerCompassGeometry && rm -f $(VOFILES) $(VFILES) $(GLOBFILES) $(NATIVEFILES) $(CMOFILES) $(CMIFILES) $(CMAFILES) && find . -type d -and -empty -delete\ncd "$${DSTROOT}"$(COQLIBINSTALL) && find "RulerCompassGeometry" -maxdepth 0 -and -empty -exec rmdir -p \{\} \;\n' >> "$@"
	printf 'cd "$${DSTROOT}"$(COQDOCINSTALL)/RulerCompassGeometry \\\n' >> "$@"
	printf '&& rm -f $(shell find "html" -maxdepth 1 -and -type f -print)\n' >> "$@"
	printf 'cd "$${DSTROOT}"$(COQDOCINSTALL) && find RulerCompassGeometry/html -maxdepth 0 -and -empty -exec rmdir -p \{\} \;\n' >> "$@"
	chmod +x $@

uninstall: uninstall_me.sh
	sh $<

clean::
	rm -f $(OBJFILES) $(OBJFILES:.o=.native) $(NATIVEFILES)
	find . -name .coq-native -type d -empty -delete
	rm -f $(VOFILES) $(VOFILES:.vo=.vio) $(GFILES) $(VFILES:.v=.v.d) $(VFILES:=.beautified) $(VFILES:=.old)
	rm -f all.ps all-gal.ps all.pdf all-gal.pdf all.glob $(VFILES:.v=.glob) $(VFILES:.v=.tex) $(VFILES:.v=.g.tex) all-mli.tex
	- rm -rf html mlihtml uninstall_me.sh

cleanall:: clean
	rm -f $(patsubst %.v,.%.aux,$(VFILES))

archclean::
	rm -f *.cmx *.o

printenv:
	@"$(COQBIN)coqtop" -config
	@echo 'OCAMLFIND =	$(OCAMLFIND)'
	@echo 'PP =	$(PP)'
	@echo 'COQFLAGS =	$(COQFLAGS)'
	@echo 'COQLIBINSTALL =	$(COQLIBINSTALL)'
	@echo 'COQDOCINSTALL =	$(COQDOCINSTALL)'

Makefile: Make
	mv -f $@ $@.bak
	"$(COQBIN)coq_makefile" -f $< -o $@


###################
#                 #
# Implicit rules. #
#                 #
###################

$(VOFILES): %.vo: %.v
	$(COQC) $(COQDEBUG) $(COQFLAGS) $*

$(GLOBFILES): %.glob: %.v
	$(COQC) $(COQDEBUG) $(COQFLAGS) $*

$(VFILES:.v=.vio): %.vio: %.v
	$(COQC) -quick $(COQDEBUG) $(COQFLAGS) $*

$(GFILES): %.g: %.v
	$(GALLINA) $<

$(VFILES:.v=.tex): %.tex: %.v
	$(COQDOC) $(COQDOCFLAGS) -latex $< -o $@

$(HTMLFILES): %.html: %.v %.glob
	$(COQDOC) $(COQDOCFLAGS) -html $< -o $@

$(VFILES:.v=.g.tex): %.g.tex: %.v
	$(COQDOC) $(COQDOCFLAGS) -latex -g $< -o $@

$(GHTMLFILES): %.g.html: %.v %.glob
	$(COQDOC) $(COQDOCFLAGS)  -html -g $< -o $@

$(addsuffix .d,$(VFILES)): %.v.d: %.v
	$(COQDEP) $(COQLIBS) "$<" > "$@" || ( RV=$$?; rm -f "$@"; exit $${RV} )

$(addsuffix .beautified,$(VFILES)): %.v.beautified:
	$(COQC) $(COQDEBUG) $(COQFLAGS) -beautify $*

# WARNING
#
# This Makefile has been automagically generated
# Edit at your own risks !
#
# END OF WARNING

