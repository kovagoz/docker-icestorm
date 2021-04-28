FROM alpine:3

RUN set -ex && \

	# Install runtime dependencies
	apk --no-cache add --virtual runtime-dependencies \
		libgcc libstdc++ libffi libftdi1 readline \
		graphviz python3 perl tcl make bash && \

	# Install build dependencies
	apk --no-cache add --virtual build-dependencies \
		git mercurial clang build-base autoconf bison \
		flex flex-dev gawk tcl-dev python libffi-dev \
		libftdi1-dev readline-dev gperf && \

	# Install IceStorm Tools
	git clone --depth 1 clone https://github.com/YosysHQ/icestorm.git /tmp/icestorm && \
	cd /tmp/icestorm && \
    make -j$(nproc) && \
	make install && \

	# Install NextPNR
	git clone --depth 1 https://github.com/YosysHQ/nextpnr /tmp/nextpnr && \
	cd /tmp/nextpnr && \
	cmake -DARCH=ice40 -DCMAKE_INSTALL_PREFIX=/usr/local . && \
	make -j$(nproc) && \
	make install && \

	# Install Yosys
	git clone --depth 1 https://github.com/YosysHQ/yosys.git /tmp/yosys && \
	cd /tmp/yosys && \
	make -j$(nproc) && \
	make install && \

	# Cleanup
	apk del --purge build-dependencies && \
	rm -rf /var/cache/apk/* && \
	rm -rf /tmp/* && \

	# Create an unprivileged user
	adduser -D -u 1000 user

USER user

# vim: ts=4
