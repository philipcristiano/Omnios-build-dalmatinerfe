PROJECT=dalmatinerfe
VERSION=0.3.3
PROJECT_VERSION=${VERSION}
REPO=https://gitlab.com/Project-FiFo/DalmatinerDB/dalmatinerfe.git
TARGET_DIRECTORY=/opt/dalmatinerdb
RELEASE_DIR=src/_build/default/rel

export TARGET_DIRECTORY

clone:
	git clone --branch ${VERSION} ${REPO} src
	cd src; git status

build:

	cd src; ./rebar3 release -d false # -d false: disable dev mode

package:
	@echo do packagey things!
	mkdir -p ${IPS_BUILD_DIR}/opt/ ${IPS_TMP_DIR} "${IPS_BUILD_DIR}/etc"
	mkdir -p ${IPS_BUILD_DIR}/data/${PROJECT}/etc
	echo ls ${RELEASE_DIR}
	mv ${RELEASE_DIR}/dfe/etc/${PROJECT}.conf.example ${IPS_BUILD_DIR}/data/${PROJECT}/etc/${PROJECT}.conf

  # Remove git files/dirs
	( find ${RELEASE_DIR} -type d -name ".git" && find ${RELEASE_DIR} -name ".gitignore" && find ${RELEASE_DIR} -name ".gitmodules" ) | xargs -d '\n' rm -rf
	cp -R ${RELEASE_DIR} ${IPS_BUILD_DIR}/opt/${PROJECT}
	rm -rf ${IPS_BUILD_DIR}/opt/${PROJECT}/${PROJECT}_release-*.tar.gz
	cp LICENSE.pkg ${IPS_BUILD_DIR}/

publish: ips-package
ifndef PKGSRVR
	echo "Need to define PKGSRVR, something like http://localhost:10000"
	exit 1
endif
	pkgsend publish -s ${PKGSRVR} -d ${IPS_BUILD_DIR} ${IPS_TMP_DIR}/pkg.pm5.final
	pkgrepo refresh -s ${PKGSRVR}

include erlang-ips.mk
