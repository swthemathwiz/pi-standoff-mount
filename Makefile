#
# Copyright (c) Stewart Whitman, 2020-2021.
#
# File:    Makefile
# Project: Raspberry PI Mount
# License: CC BY-NC-SA 4.0 (Attribution-NonCommercial-ShareAlike)
# Desc:    Makefile for directory
#

NAME = pi-standoff-mount

OPENSCAD = openscad

SRCS = \
	pi-standoff-mount.scad \
	rounded.scad \
	smidge.scad \

BUILDS = \
	pi-standoff-mount.scad \

EXTRAS = \
	Makefile \
	README.md \
	LICENSE.txt \

TARGETS = $(BUILDS:.scad=.stl)

IMAGES = $(BUILDS:.scad=.png)

SOURCEZIP = $(NAME)-source.zip

DEPDIR := .deps
DEPFLAGS = -d $(DEPDIR)/$*.d

COMPILE.scad = $(OPENSCAD) -o $@ $(DEPFLAGS)
RENDER.scad = $(OPENSCAD) -o $@

all: $(TARGETS)

images: $(IMAGES)

%.stl : %.scad
%.stl : %.scad $(DEPDIR)/%.d | $(DEPDIR)
	$(COMPILE.scad) $<

%.png : %.scad
	$(RENDER.scad) $<

$(SOURCEZIP): $(EXTRAS) $(SRCS) $(BUILDS)
	(for F in $^; do echo $$F ; done) | zip -@ - > $@

source: $(SOURCEZIP)

clean:
	rm -f *.stl *.bak *.png $(SOURCEZIP)

distclean: clean
	rm -rf $(DEPDIR)

$(DEPDIR): ; @mkdir -p $@

DEPFILES := $(TARGETS:%.stl=$(DEPDIR)/%.d)
$(DEPFILES):

include $(wildcard $(DEPFILES))
