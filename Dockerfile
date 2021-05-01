FROM alpine:3

RUN set -ex && \

	apk --no-cache add --virtual runtime-dependencies \
		libgcc libstdc++ libffi libftdi1 readline \
		graphviz python3 perl tcl boost make bash && \

	apk --no-cache add --virtual build-dependencies \
		git mercurial clang build-base autoconf bison \
		flex flex-dev gawk tcl-dev python3-dev libffi-dev \
		libftdi1-dev readline-dev gperf cmake boost-dev eigen-dev && \

	git clone --depth 1 https://github.com/YosysHQ/icestorm.git /tmp/icestorm && \
	cd /tmp/icestorm && \
	make -j$(nproc) && \
	make install && \

	git clone --depth 1 https://github.com/YosysHQ/nextpnr /tmp/nextpnr && \
	cd /tmp/nextpnr && \
	sed -i 's/-O3/-O3 -U_FORTIFY_SOURCE/' CMakeLists.txt && \
	cmake -DARCH=ice40 -DCMAKE_INSTALL_PREFIX=/usr/local -DEigen3_DIR=/usr/share/cmake/Modules . && \
	make -j$(nproc) && \
	make install && \

	git clone --depth 1 https://github.com/YosysHQ/yosys.git /tmp/yosys && \
	cd /tmp/yosys && \
	make -j$(nproc) && \
	make install && \

	apk del --purge build-dependencies && \
	rm -rf /var/cache/apk/* && \
	rm -rf /tmp/* && \

	adduser -D -u 1000 user

USER user

# vim: ts=4
