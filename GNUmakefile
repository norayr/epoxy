VOC = /opt/voc/bin/voc
mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
mkfile_dir_path := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
build_dir_path := $(mkfile_dir_path)/build
current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))
BLD := $(mkfile_dir_path)/build
DPD  =  deps
DPS := $(mkfile_dir_path)/$(DPD)

all: get_deps build_deps buildEpoxy

get_deps:
	mkdir -p $(DPS)
	if [ -d $(DPS)/pipes ]; then cd $(DPS)/pipes; git pull; cd -; else cd $(DPS); git clone https://github.com/norayr/pipes; cd -; fi
	if [ -d $(DPS)/lists ]; then cd $(DPS)/lists; git pull; cd -; else cd $(DPS); git clone https://github.com/norayr/lists; cd -; fi
	if [ -d $(DPS)/Internet ]; then cd $(DPS)/Internet; git pull; cd -; else cd $(DPS); git clone https://github.com/norayr/Internet; cd -; fi
	if [ -d $(DPS)/time ]; then cd $(DPS)/time; git pull; cd -; else cd $(DPS); git clone https://github.com/norayr/time; cd -; fi

build_deps:
	mkdir -p $(mkfile_dir_path)
	cd $(CURDIR)/$(BUILD)
	make -f $(mkfile_dir_path)/$(DPD)/lists/GNUmakefile BUILD=$(BLD)
	make -f $(mkfile_dir_path)/$(DPD)/pipes/GNUmakefile BUILD=$(BLD)
	make -f $(mkfile_dir_path)/$(DPD)/Internet/GNUmakefile BUILD=$(BLD)
	make -f $(mkfile_dir_path)/$(DPD)/time/GNUmakefile BUILD=$(BLD)

buildEpoxy:
	cd $(BLD) && $(VOC) -s $(mkfile_dir_path)/src/epoxy.Mod
	cd $(BLD) && $(VOC) $(mkfile_dir_path)/src/testEpoxy.Mod -m

clean:
	if [ -d "$(BLD)" ]; then rm -rf $(BLD); fi
