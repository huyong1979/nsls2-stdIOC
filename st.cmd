#!./bin/linux-x86_64/nsls2-stdIOC

## Register all support components
dbLoadDatabase "dbd/nsls2-stdIOC.dbd"
nsls2_stdIOC_registerRecordDeviceDriver pdbbase

# NSLS-II EPICS environment (for Accelerator Controls)
epicsEnvSet("EPICS_BASE", "/usr/lib/epics")
epicsEnvSet("EPICS_CA_AUTO_ADDR_LIST", "NO")
epicsEnvSet("EPICS_CA_ADDR_LIST", "10.0.153.255")
# set EPICS_CA_MAX_ARRAY_BYTES close to Max. bytes of your waveform PVs 
#epicsEnvSet("EPICS_CA_MAX_ARRAY_BYTES", "10000000")

## Load record instances specifially for this application 
dbLoadTemplate "db/user.substitutions"

# Load record instances for devIocStats, reccaster, autosave 
dbLoadRecords("$(EPICS_BASE)/db/iocAdminSoft.db", "IOC=CS{$(IOCNAME)}")
dbLoadRecords("$(EPICS_BASE)/db/reccaster.db", "P=CS{$(IOCNAME)}RSync")
dbLoadRecords("$(EPICS_BASE)/db/save_restoreStatus.db", "P=CS{$(IOCNAME)}")
save_restoreSet_status_prefix("CS{$(IOCNAME)}")

# use commands to make sure the autosave directory "as" is writable: 
## mkdir -p as/save; mkdir -p as/req; chmod 1777 -R as;
set_savefile_path("${PWD}/as","/save")
set_requestfile_path("${PWD}/as","/req")
# 3 types of info node: autosaveFields_pass0, autosaveFields_pass1, autosaveFields
set_pass0_restoreFile("autosaveFields_pass0.sav")
set_pass1_restoreFile("autosaveFields_pass1.sav")
set_pass1_restoreFile("autosaveFields.sav")

# Access security control 
asSetFilename("/cf-update/acf/default.acf")

# IOC initialization
iocInit()

# Log when, where and who changed PV values
caPutLogInit("ioclog.cs.nsls2.local:7004", 1)

# dump PVs to a file
dbl > /cf-update/$(HOSTNAME).$(IOCNAME).dbl

# autosave
makeAutosaveFileFromDbInfo("${PWD}/as/req/autosaveFields_pass0.req", "autosaveFields_pass0")
create_monitor_set("autosaveFields_pass0.req", 30, "")
makeAutosaveFileFromDbInfo("${PWD}/as/req/autosaveFields_pass1.req", "autosaveFields_pass1")
create_monitor_set("autosaveFields_pass1.req", 30, "")
makeAutosaveFileFromDbInfo("${PWD}/as/req/autosaveFields.req", "autosaveFields")
create_monitor_set("autosaveFields.req", 30, "")

# execute python script(s)
#system "python ./python/hello-world.py &"
