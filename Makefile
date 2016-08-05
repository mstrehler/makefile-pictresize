# Makefile for handling pictures
#
# Reducing the size (number of pixels) of a picture by shrinking should be the
# very last step of image processing. More important is reducing the size by
# cutting meaningless edges or chosing the perfect image detail. For example:
# solution A is better than solution B.
#
# Original
# +----------------+
# |                |
# |                |    A cutting        B shrinking
# |       *        |    +-----------+    +-----------+
# |      ***       |    |     *     |    |           |
# |     *****      |    |    ***    |    |           |
# |    *******     |    |   *****   |    |     *     |
# |                |    |  *******  |    |    ***    |
# +----------------+    +-----------+    +-----------+
# 
# However, sometimes shrinking the includet pictures can drastically reduce
# the final size of the pdf. Specially if a lot of jpg files are includet in a
# beamer presentation,
#
#  
 
# Check, if 'convert' (part of the ImageMagick packet) is installed:
# http://www.imagemagick.org/
CONVINSTALLED := $(shell command -v convert 2> /dev/null)

# Maximum width and height of the pictures.
# quality hight: 1500x1000, good 1000x660, low 750x500
MAXWIDTH := 1000
MAXHEIGHT := 660

# variables with directory names
# Project Folder
# |
# +--figuresorig: pict1.jpg pict2.jpg pict3.jpg ... pictn.jpg
# |
# +--figures:
FIGURES := figures
ORIGINALS := figuresorig

# The Makefile creates a list of the jpg files in the directory 'figuresoriginal'.
# Change the path of every item of the list from 'figuresoriginal' to 'figures'.
# This second list is then used as Makefile target.
JPGBIG := $(wildcard $(ORIGINALS)/*.jpg)
JPGNAMES := $(notdir $(JPGBIG))
JPG := $(addprefix $(FIGURES)/,$(JPGNAMES))

all: $(JPG)

$(JPG):
ifndef CONVINSTALLED
	$(warning "convert is not available -- please install ImageMagick!")
else
	@echo "shrinking $(@F) ..."
	@convert $(ORIGINALS)/$(@F) -resize $(MAXWIDTH)x$(MAXHEIGHT)\> $@
	@echo "done"
endif

