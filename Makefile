.POSIX:

DEPS      = norayr/lists    \
	    norayr/pipes    \
	    norayr/Internet     \
	    norayr/time

GITHUB    = https://github.com/

ROOTDIR   = $$PWD

all: ${DEPS}
	@if [ ! -d build ]; then \
		mkdir build;     \
	fi
	@for i in $?; do                                 \
		cp -r   ${ROOTDIR}/build                 \
			${ROOTDIR}/deps/$${i#*/}/build;  \
		make -C ${ROOTDIR}/deps/$${i#*/};        \
		cp -r   ${ROOTDIR}/deps/$${i#*/}/build/* \
			${ROOTDIR}/build/;               \
	done
	@cd build && voc -s ${ROOTDIR}/../src/epoxy.Mod

tests:
	@if [ ! -d build ]; then      \
		echo Run make, first; \
		exit 1;
	fi
	@cd build && voc ${ROOTDIR}/../src/testEpoxy.Mod -m       \
		> /dev/null 2>&1                                  \
		|| (echo Failed to compile, have you run make?    \
			&& exit 1)
	@./build/testEpoxy                                        \
		> /dev/null 2>&1                                  \
		&& echo ${ROOTDIR}/build/testList: passed         \
		|| echo ${ROOTDIR}/build/testList: failed

${DEPS}:
	@for i in $@; do                                          \
		if [ -d deps/$${i#*/} ]; then                     \
			printf "Updating %s: " $${i#*/};          \
			git -C deps/$${i#*/} pull --ff-only       \
				${GITHUB}$$i > /dev/null 2>&1     \
				&& echo done                      \
				|| (echo failed && exit 1);       \
		else                                              \
			printf "Fetching %s: " $${i#*/};          \
			git clone ${GITHUB}$$i deps/$${i#*/}      \
				> /dev/null 2>&1                  \
				&& echo done                      \
				|| (echo failed && exit 1);       \
		fi                                                \
	done

clean:
	rm -rf build deps
