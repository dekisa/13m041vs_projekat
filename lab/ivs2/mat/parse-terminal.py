#!/usr/bin/python

################################################################################
# This Python script is created for use in the Embedded Multiprocessor Systems #
# course on Master studies at the School of Electrical Engineering -           #
# - University of Belgrade and can be freely modified and redistributed.       #
# Version: 1.2                                                                 #
# Date: 9th November 2017.                                                     #
# ---------------------------------------------------------------------------- #
# Description:                                                                 #
# This is a Python script that can be used for reading data that is sent using #
# JTAG/Uart module on Altera Nios II system. Script wrapps nios2-termial       #
# application and parses received data.                                        #
# Several things are assumed:                                                  #
# * Implemented Nios II system sends START_STRING as indication that data      #
#   following it should be parsed                                              #
#   - START_STRING can be changed, but care needs to be taken when working     #
#     Windows OS, since when '\n' is sent from Nios II it is received as       #
#     '\r\n' through nios2-terminal application                                #
# * CPU sending data that needs to be parsed is CPU0                           #
#                                                                              #
# Current implementation only prints parsed data to stdout                     #
#                                                                              #
# Supported OS: Linux, Windows                                                 #
# Prerequirements: numpy                                                       #
################################################################################

import time
import os
import subprocess
import numpy as np


if os.name == "nt":
    START_STRING="PROGRAM START\r\n"
    NIOS2_TERMINAL_PATH=r"C:\intelFPGA_lite\17.0\quartus\bin64\nios2-terminal.exe"
else:
    START_STRING="PROGRAM START\n"
    NIOS2_TERMINAL_PATH=r"/home/strahinja/tools/intelFPGA_lite/17.0/quartus/bin/nios2-terminal"

def follow(thefile):
    """
    Generator function that reads 8 bytes at a time from Popen.
    If no data is available, it waits for 100ms and retries
    """
    while True:
        data = thefile.read(8)
        if len(data) == 0:
            time.sleep(0.1)
            continue
        yield data

def parse(data_generator):
    """
    Function for parsing data from nios2-terminal application.
    Receives generator function that reads data.

    Data is organized into 8 Byte packets in the following way:
    - byte  0   - 's'
    - bytes 1-2 - first data part
    - bytes 3-4 - second data part
    - bytes 5-6 - result
    - byte  7   - 't'
    """
    start_found = False             # flag that indicates that START_STRING is found
    prev_data = 0                   # used only for windows '\r\n' handling
    databuf = ''                    # buffer where received data is placed
    counter = 0                     # counter for current byte in packet
    for datas in data_generator:
        for data in datas:
            if start_found == False:
                databuf += data
                if databuf.find(START_STRING) >= 0:
                    start_found = True
                    databuf = ''
            else:
                if counter == 0:
                    assert(data == 's')
                    counter += 1
                elif counter == 9:
                    assert(data == 't')
                    pi_est = np.fromstring(databuf[:4], dtype='<f4')[0]
                    total = np.fromstring(databuf[4:], dtype='<u4')[0]
                    print "pi_est={:.6f}, took={} iterations".format(pi_est, total)
                    databuf = ''
                    counter = 0
                else:
                    if os.name == "nt":
                        if (ord(prev_data) == 13) and (ord(data) == 10):
                            databuf = databuf[:-1]
                            counter -= 1
                    databuf += data
                    counter += 1
            prev_data = data

if __name__ == '__main__':
    proc = subprocess.Popen([NIOS2_TERMINAL_PATH, '--no-quit-on-ctrl-d', '--instance=3'], stdin=subprocess.PIPE, stdout=subprocess.PIPE)
    try:
        logdata = follow(proc.stdout)
        parse(logdata)
    except Exception as e:
        print "Exception! {}".format(e)
        proc.terminate()
        proc.wait()
