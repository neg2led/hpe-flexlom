.PHONY: all clean web

BOARDS = KCORES-FlexibleLOM-Adapter KCORES-FlexibleLOM-Adapter-panel
GITREPO = https://github.com/neg2led/hpe-flexlom.git

BOARDSFILES = $(addprefix build/, $(BOARDS:=.kicad_pcb))
SCHFILES = $(addprefix build/, $(BOARDS:=.sch))
GERBERS = $(addprefix build/, $(BOARDS:=-gerber.zip))
JLCGERBERS = $(addprefix build/, $(BOARDS:=-jlcpcb.zip))

RADIUS=0.75

all: $(GERBERS) $(JLCGERBERS) build/web/index.html

build/KCORES-FlexibleLOM-Adapter.kicad_pcb: KCORES-FlexibleLOM-Adapter/KCORES-FlexibleLOM-Adapter.kicad_pcb build
	kikit panelize extractboard -s 79.35 123.20 96.3 30.250 $< $@

build/KCORES-FlexibleLOM-Adapter-panel.kicad_pcb: build/KCORES-FlexibleLOM-Adapter.kicad_pcb build
	kikit panelize grid --space 3 --gridsize 3 1 \
        --tabwidth 3 --tabheight 3 --htabs 2 --vtabs 1 \
        --panelsize 110 110 --framecutH \
        --vcuts --radius $(RADIUS) $< $@

%-gerber: %.kicad_pcb
	kikit export gerber $< $@

%-gerber.zip: %-gerber
	zip -j $@ `find $<`

%-jlcpcb: %.kicad_pcb
	kikit fab jlcpcb --no-assembly $< $@

%-jlcpcb.zip: %-jlcpcb
	zip -j $@ `find $<`

web: build/web/index.html

build:
	mkdir -p build

build/web: build
	mkdir -p build/web

build/web/index.html: build/web $(BOARDSFILES)
	kikit present boardpage \
		-d README.md \
		--name "KCORES FlexibleLOM to PCIe x8 adapter" \
		-b "KCORES FlexibleLOM to PCIe x8 adapter" "Single board" build/KCORES-FlexibleLOM-Adapter.kicad_pcb  \
		-b "KCORES FlexibleLOM to PCIe x8 adapter" "Panel of 3" build/KCORES-FlexibleLOM-Adapter-panel.kicad_pcb  \
		-r "KCORES-FlexibleLOM-Adapter/KCORES-FlexibleLOM-Adapter.png" \
		--repository "$(GITREPO)"\
		build/web

clean:
	rm -r build