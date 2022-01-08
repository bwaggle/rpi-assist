################################################################################
#
# gnuradio
#
################################################################################

GNURADIO39_VERSION = 3.9.4.0
GNURADIO39_SOURCE = v$(GNURADIO39_VERSION).tar.gz
GNURADIO39_SITE = https://github.com/gnuradio/gnuradio/archive/refs/tags
GNURADIO39_LICENSE = GPL-3.0+
GNURADIO39_LICENSE_FILES = COPYING

GNURADIO39_SUPPORTS_IN_SOURCE_BUILD = NO

# needed to determine site-packages path
ifeq ($(BR2_PACKAGE_PYTHON),y)
GNURADIO39_PYVER = $(PYTHON_VERSION_MAJOR)
else ifeq ($(BR2_PACKAGE_PYTHON3),y)
GNURADIO39_PYVER = $(PYTHON3_VERSION_MAJOR)
endif

GNURADIO39_DEPENDENCIES = \
	host-python3 \
	boost \
	log4cpp \
	gmp \
	volk

GNURADIO39_CONF_OPTS = \
	-DPYTHON_EXECUTABLE=$(HOST_DIR)/bin/python3 \
	-DENABLE_DEFAULT=OFF \
	-DENABLE_GNURADIO_RUNTIME=ON \
	-DENABLE_INTERNAL_VOLK=OFF \
	-DENABLE_TESTING=OFF \
	-DXMLTO_EXECUTABLE=NOTFOUND

# For third-party blocks, the gnuradio libraries are mandatory at
# compile time.
GNURADIO39_INSTALL_STAGING = YES

ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
GNURADIO39_CONF_OPTS += -DCMAKE_EXE_LINKER_FLAGS=-latomic
endif

ifeq ($(BR2_PACKAGE_ORC),y)
GNURADIO39_DEPENDENCIES += orc
GNURADIO39_CONF_OPTS += -DENABLE_ORC=ON
else
GNURADIO39_CONF_OPTS += -DENABLE_ORC=OFF
endif

ifeq ($(BR2_PACKAGE_GNURADIO39_ANALOG),y)
GNURADIO39_CONF_OPTS += -DENABLE_GR_ANALOG=ON
else
GNURADIO39_CONF_OPTS += -DENABLE_GR_ANALOG=OFF
endif

ifeq ($(BR2_PACKAGE_GNURADIO39_AUDIO),y)
ifeq ($(BR2_PACKAGE_ALSA_LIB),y)
GNURADIO39_DEPENDENCIES += alsa-lib
endif
ifeq ($(BR2_PACKAGE_PORTAUDIO),y)
GNURADIO39_DEPENDENCIES += portaudio
endif
GNURADIO39_CONF_OPTS += -DENABLE_GR_AUDIO=ON
else
GNURADIO39_CONF_OPTS += -DENABLE_GR_AUDIO=OFF
endif

ifeq ($(BR2_PACKAGE_GNURADIO39_BLOCKS),y)
GNURADIO39_CONF_OPTS += -DENABLE_GR_BLOCKS=ON
else
GNURADIO39_CONF_OPTS += -DENABLE_GR_BLOCKS=OFF
endif

ifeq ($(BR2_PACKAGE_GNURADIO39_CHANNELS),y)
GNURADIO39_CONF_OPTS += -DENABLE_GR_CHANNELS=ON
else
GNURADIO39_CONF_OPTS += -DENABLE_GR_CHANNELS=OFF
endif

ifeq ($(BR2_PACKAGE_GNURADIO39_CTRLPORT),y)
GNURADIO39_CONF_OPTS += -DENABLE_GR_CTRLPORT=ON
else
GNURADIO39_CONF_OPTS += -DENABLE_GR_CTRLPORT=OFF
endif

ifeq ($(BR2_PACKAGE_GNURADIO39_DIGITAL),y)
GNURADIO39_CONF_OPTS += -DENABLE_GR_DIGITAL=ON
else
GNURADIO39_CONF_OPTS += -DENABLE_GR_DIGITAL=OFF
endif

ifeq ($(BR2_PACKAGE_GNURADIO39_DTV),y)
GNURADIO39_CONF_OPTS += -DENABLE_GR_DTV=ON
else
GNURADIO39_CONF_OPTS += -DENABLE_GR_DTV=OFF
endif

ifeq ($(BR2_PACKAGE_GNURADIO39_FEC),y)
GNURADIO39_DEPENDENCIES += gsl
GNURADIO39_CONF_OPTS += -DENABLE_GR_FEC=ON
else
GNURADIO39_CONF_OPTS += -DENABLE_GR_FEC=OFF
endif

ifeq ($(BR2_PACKAGE_GNURADIO39_FFT),y)
GNURADIO39_DEPENDENCIES += fftw-single
GNURADIO39_CONF_OPTS += -DENABLE_GR_FFT=ON
else
GNURADIO39_CONF_OPTS += -DENABLE_GR_FFT=OFF
endif

ifeq ($(BR2_PACKAGE_GNURADIO39_FILTER),y)
GNURADIO39_CONF_OPTS += -DENABLE_GR_FILTER=ON
else
GNURADIO39_CONF_OPTS += -DENABLE_GR_FILTER=OFF
endif

ifeq ($(BR2_PACKAGE_GNURADIO39_PYTHON),y)
GNURADIO39_DEPENDENCIES += python3 python-numpy host-python-pybind \
	host-python-mako host-python-numpy
GNURADIO39_CONF_OPTS += -DENABLE_PYTHON=ON \
	-Dpybind11_DIR="$(shell $(HOST_DIR)/bin/pybind11-config --cmakedir)"

# mandatory to install python modules in site-packages and to use
# correct path for python libraries
GNURADIO39_CONF_OPTS += -DGR_PYTHON_RELATIVE=ON \
	-DGR_PYTHON_DIR=lib/python$(GNURADIO39_PYVER)/site-packages
else
GNURADIO39_CONF_OPTS += -DENABLE_PYTHON=OFF
endif

ifeq ($(BR2_PACKAGE_GNURADIO39_QTGUI),y)
GNURADIO39_DEPENDENCIES += qt5base python-pyqt5 qwt
GNURADIO39_CONF_OPTS += -DENABLE_GR_QTGUI=ON
else
GNURADIO39_CONF_OPTS += -DENABLE_GR_QTGUI=OFF
endif

ifeq ($(BR2_PACKAGE_GNURADIO39_TRELLIS),y)
GNURADIO39_CONF_OPTS += -DENABLE_GR_TRELLIS=ON
else
GNURADIO39_CONF_OPTS += -DENABLE_GR_TRELLIS=OFF
endif

ifeq ($(BR2_PACKAGE_GNURADIO39_UHD),y)
GNURADIO39_DEPENDENCIES += uhd
GNURADIO39_CONF_OPTS += -DENABLE_GR_UHD=ON
else
GNURADIO39_CONF_OPTS += -DENABLE_GR_UHD=OFF
endif

ifeq ($(BR2_PACKAGE_GNURADIO39_UTILS),y)
GNURADIO39_CONF_OPTS += -DENABLE_GR_UTILS=ON
else
GNURADIO39_CONF_OPTS += -DENABLE_GR_UTILS=OFF
endif

ifeq ($(BR2_PACKAGE_GNURADIO39_ZEROMQ),y)
GNURADIO39_DEPENDENCIES += cppzmq
ifeq ($(BR2_PACKAGE_GNURADIO39_PYTHON),y)
GNURADIO39_DEPENDENCIES += python-pyzmq
endif
GNURADIO39_CONF_OPTS += -DENABLE_GR_ZEROMQ=ON
else
GNURADIO39_CONF_OPTS += -DENABLE_GR_ZEROMQ=OFF
endif

$(eval $(cmake-package))
