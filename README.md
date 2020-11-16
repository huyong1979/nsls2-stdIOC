NSLS-II Standard IOC: 

1) standardized Makefile: it includes autosave, devIocStats, caPutLog, reccaster, 
    (and asyn & StreamDevice if needed);

2) standardized st.cmd:  it sets EPICS environment; loads records for devIocStats, 
    reccaster, autosave; configures autosave, access security, caPutLog, etc.; 

3) standardized config: see the file 'config' for details;
