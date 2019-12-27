#!../../bin/linux-x86_64/modbusApp
< envPathsB
dbLoadDatabase("../../dbd/modbus.dbd")
modbus_registerRecordDeviceDriver(pdbbase)

# Use the following commands for TCP/IP
#drvAsynIPPortConfigure(const char *portName,
#                       const char *hostInfo,
#                       unsigned int priority,
#                       int noAutoConnect,
#                       int noProcessEos);

# 电源地址
#drvAsynIPPortConfigure("DPU01","192.168.1.123:7000",0,1,1)

drvAsynIPPortConfigure("DPU01","192.168.1.200:502",0,1,1)

#modbusInterposeConfig(const char *portName,
#                      modbusLinkType linkType,
#                      int timeoutMsec, 
#                      int writeDelayMsec)
#var s7plcDebug  1
modbusInterposeConfig("DPU01",0,300,100)


# NOTE: We use octal numbers for the start address and length (leading zeros)
#       to be consistent with the PLC nomenclature.  This is optional, decimal
#       numbers (no leading zero) or hex numbers can also be used.
#       In these examples we are using slave address 0 (number after "Koyo2").



#drvModbusAsynConfigure("Mod1_BI",        "DPU01",     1, 3,  1000,  016,   0,  1,    "HMI")
#System_info
drvModbusAsynConfigure("Mod1_AI_Word",        "DPU01",    1, 3,  0,  8,   0,  100,    "HMI")

# 0x72开机104 0x70关机102 0x76消音108 0x75复位107 
drvModbusAsynConfigure("A0_Out_Word",        "DPU01",    1, 6,  0,  1,   0,  100,    "HMI")
#drvModbusAsynConfigure("BI_In_Word",      "DPU01", 0, 2,  0, 040,    0,  100, "Koyo")




#drvModbusAsynConfigure("Mod1_AO",        "DPU01",    1, 16,  0,  20,   5,  100,    "HMI")

# Enable ASYN_TRACEIO_HEX on octet server
#asynSetTraceIOMask("CJC",0,4)
# Enable ASYN_TRACE_ERROR and ASYN_TRACEIO_DRIVER on octet server
#asynSetTraceMask("Koyo2",0,9)

#dbLoadTemplate("lsj.substitutions")
#dbLoadTemplate("XM2.substitutions")
#dbLoadTemplate("XM3.substitutions")
#dbLoadTemplate("XM4.substitutions")
#dbLoadTemplate("XM5.substitutions")
#dbLoadTemplate("XM6.substitutions")
#dbLoadTemplate("XM7.substitutions")


iocInit

