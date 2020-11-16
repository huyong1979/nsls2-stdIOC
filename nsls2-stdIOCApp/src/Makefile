# adapted from the original Makefile (Makefile.orig), built on 64-bit Debian 9
TOP=../..

include $(TOP)/configure/CONFIG

# Build the IOC application
PROD_IOC = nsls2-stdIOC

# nsls2-stdIOC.dbd will be created and installed
DBD += nsls2-stdIOC.dbd

# nsls2-stdIOC.dbd will include these files:
nsls2-stdIOC_DBD += base.dbd

# NSLS-II standard moduels: autosave, devIocStats, caPutLog, reccaster 
# provided by EPICS Debian packages: epics-autosave-dev, epics-iocstats-dev, 
## epics-caputlog-dev, epics-recsync-dev
nsls2-stdIOC_DBD += asSupport.dbd
nsls2-stdIOC_DBD += devIocStats.dbd
nsls2-stdIOC_DBD += caPutLog.dbd
nsls2-stdIOC_DBD += reccaster.dbd

# the following are needed for asyn & StreamDevice  
## EPICS Debian packages: epics-asyn-dev, epics-calc-dev, epics-stream-dev, 
## for Base-3.15.6, 64-bit Debian 9: calc.dbd must be before stream.dbd
#nsls2-stdIOC_DBD += drvAsynIPPort.dbd
#nsls2-stdIOC_DBD += drvAsynSerialPort.dbd
#nsls2-stdIOC_DBD += asyn.dbd
#nsls2-stdIOC_DBD += calc.dbd
#nsls2-stdIOC_DBD += stream.dbd

# to use the Linux command 'system'
#nsls2-stdIOC_DBD += system.dbd

# nsls2-stdIOC_registerRecordDeviceDriver.cpp derives from nsls2-stdIOC.dbd
nsls2-stdIOC_SRCS += nsls2-stdIOC_registerRecordDeviceDriver.cpp

# Build the main IOC entry point where needed
nsls2-stdIOC_SRCS_DEFAULT += nsls2-stdIOCMain.cpp
nsls2-stdIOC_SRCS_vxWorks += -nil-

# link to NSLS-II standard libraries provided by EPICS Debian packages
nsls2-stdIOC_LIBS += autosave
nsls2-stdIOC_LIBS += devIocStats
nsls2-stdIOC_LIBS += caPutLog
nsls2-stdIOC_LIBS += reccaster

# the following are needed for asyn & StreamDevice 
## static build does not work for calc. So, use dynamic build for calc
## libsscan, libseq, libpv are already included in libcalc 
#nsls2-stdIOC_LIBS += asyn 
#nsls2-stdIOC_SYS_LIBS += calc
#nsls2-stdIOC_LIBS += stream

# Finally link IOC to the EPICS Base libraries
nsls2-stdIOC_LIBS += $(EPICS_BASE_IOC_LIBS)

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD EXTRA GNUMAKE RULES BELOW HERE

