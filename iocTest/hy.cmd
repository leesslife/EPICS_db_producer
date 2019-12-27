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
#drvAsynIPPortConfigure("Koyo1","164.54.160.158:502",0,0,1)
#modbusInterposeConfig(const char *portName, 
#                      modbusLinkType linkType,
#                      int timeoutMsec, 
#                      int writeDelayMsec)


# Use the following commands for serial RTU or ASCII
#drvAsynSerialPortConfigure(const char *portName, 
#                           const char *ttyName,
#                           unsigned int priority, 
#                           int noAutoConnect,
#                           int noProcessEos);

drvAsynSerialPortConfigure("Koyo1", "/dev/ttyS1", 0, 0, 0)
asynSetOption("Koyo1",0,"baud","9600")
asynSetOption("Koyo1",0,"parity","none")
asynSetOption("Koyo1",0,"bits","8")
asynSetOption("Koyo1",0,"stop","1")
modbusInterposeConfig("Koyo1",1,1000,20)


# Read 8 words (128 bits).  Function code=3.
drvModbusAsynConfigure("K1_Xn_Word",     "Koyo1", 1, 3, 0000, 010,    0,  100, "Koyo")
drvModbusAsynConfigure("K1_Xn_Word",     "Koyo1", 1, 3, 0011, 005,    0,  100, "Koyo")

# Write 1 words (128 bits).  Function code=6.
drvModbusAsynConfigure("K1_Yn_Word", "Koyo1", 1, 6, 0010, 001,    0,  100, "Koyo")

asynSetTraceIOMask("Koyo1",0,4)
# Enable ASYN_TRACE_ERROR and ASYN_TRACEIO_DRIVER on octet server
#asynSetTraceMask("Koyo1",0,9)

# Enable ASYN_TRACEIO_HEX on modbus server
#asynSetTraceIOMask("K1_Yn_In_Bit",0,4)
# Enable all debugging on modbus server
#asynSetTraceMask("K1_Yn_In_Bit",0,255)
# Dump up to 512 bytes in asynTrace
#asynSetTraceIOTruncateSize("K1_Yn_In_Bit",0,512)

dbLoadTemplate("hy.substitutions")

iocInit

