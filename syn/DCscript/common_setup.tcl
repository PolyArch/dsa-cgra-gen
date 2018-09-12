puts "RM-Info: Running script [info script]\n"

source -echo -verbose ./DCscript/lib_setup_umc28.tcl

##########################################################################################
# Variables common to all reference methodology scripts
# Script: common_setup.tcl
# Version: N-2017.09-SP4 (April 23, 2018)
# Copyright (C) 2007-2017 Synopsys, Inc. All rights reserved.
##########################################################################################

set DESIGN_NAME                   "FUFIFO_BP"  ;#  The name of the top-level design
#set DESIGN_NAME                    "DW_fp_div_inst"  ;#  The name of the top-level design
set DESIGN_FILE_NAME               "FUFIFO_BP"

#set DESIGN_Feature "_noMGRA"
#set DESIGN_Feature "_MGRA"
set DESIGN_Feature ""

set Period 1  ;# ns 1/Period = frequency (GHz)

#set Researcher "Jian_5by5"DW_fp_sub_inst
set Researcher "Vidushi_5by4"

#set sub_dir ""
set sub_dir "SPU/bits16/"

set REPORTS_DIR ./Reports/${Researcher}/${DESIGN_NAME}${DESIGN_Feature}/${MajorFeature}/${LibraryFeature}/${Process}/${DesignDirection}/${VT}/${cellType}/${voltage}/${temperature}
set RESULTS_DIR ./Results/${Researcher}/${DESIGN_NAME}${DESIGN_Feature}/${MajorFeature}/${LibraryFeature}/${Process}/${DesignDirection}/${VT}/${cellType}/${voltage}/${temperature}

set RTL_SOURCE_DIR "/home/sihao/IdeaProjects/CGRA_MGRA_BP/syn/VerilogFile"
set RTL_SOURCE_FILES  ${RTL_SOURCE_DIR}/${Researcher}/${sub_dir}${DESIGN_FILE_NAME}${DESIGN_Feature}.v      ;# Enter the list of source RTL files if reading from RTL

set DESIGN_REF_DATA_PATH          ""  ;#  Absolute path prefix variable for library/design data.
                                       #  Use this variable to prefix the common absolute path  
                                       #  to the common variables defined below.
                                       #  Absolute paths are mandatory for hierarchical 
                                       #  reference methodology flow.

##########################################################################################
# Hierarchical Flow Design Variables
##########################################################################################

#set HIERARCHICAL_DESIGNS           "Switch FUALU MuxN FUFIFO FUALU MuxN_FU" ;# List of hierarchical block design names "DesignA DesignB" ...

#set HIERARCHICAL_CELLS             "Switch* FUALU* MuxN_FU* FUFIFO* FUALU* MuxN*" ;# List of hierarchical block cell instance names "u_DesignA u_DesignB" ...

set HIERARCHICAL_DESIGNS           ""
set HIERARCHICAL_CELLS             ""

##########################################################################################
# Library Setup Variables
##########################################################################################

# For the following variables, use a blank space to separate multiple entries.
# Example: set TARGET_LIBRARY_FILES "lib1.db lib2.db lib3.db"

set ADDITIONAL_SEARCH_PATH        "/home/sihao/Synopsys/UMC_28nm/ManuallyAddLibrary"  ;#  Additional search path to be added to the default search path

set MIN_LIBRARY_FILES             ""  ;#  List of max min library pairs "max1 min1 max2 min2 max3 min3"...

set MW_REFERENCE_LIB_DIRS         ""  ;#  Milkyway reference libraries (include IC Compiler ILMs here)

set MW_REFERENCE_CONTROL_FILE     ""  ;#  Reference Control file to define the Milkyway reference libs

set TECH_FILE                     ""  ;#  Milkyway technology file
set MAP_FILE                      ""  ;#  Mapping file for TLUplus
set TLUPLUS_MAX_FILE              ""  ;#  Max TLUplus file
set TLUPLUS_MIN_FILE              ""  ;#  Min TLUplus file

set MIN_ROUTING_LAYER            ""   ;# Min routing layer
set MAX_ROUTING_LAYER            ""   ;# Max routing layer

set LIBRARY_DONT_USE_FILE        ""   ;# Tcl file with library modifications for dont_use
set LIBRARY_DONT_USE_PRE_COMPILE_LIST ""; #Tcl file for customized don't use list before first compile
set LIBRARY_DONT_USE_PRE_INCR_COMPILE_LIST "";# Tcl file with library modifications for dont_use before incr compile
##########################################################################################
# Multivoltage Common Variables
#
# Define the following multivoltage common variables for the reference methodology scripts 
# for multivoltage flows. 
# Use as few or as many of the following definitions as needed by your design.
##########################################################################################

set PD1                          ""           ;# Name of power domain/voltage area  1
set VA1_COORDINATES              {}           ;# Coordinates for voltage area 1
set MW_POWER_NET1                "VDD1"       ;# Power net for voltage area 1

set PD2                          ""           ;# Name of power domain/voltage area  2
set VA2_COORDINATES              {}           ;# Coordinates for voltage area 2
set MW_POWER_NET2                "VDD2"       ;# Power net for voltage area 2

set PD3                          ""           ;# Name of power domain/voltage area  3
set VA3_COORDINATES              {}           ;# Coordinates for voltage area 3
set MW_POWER_NET3                "VDD3"       ;# Power net for voltage area 3

set PD4                          ""           ;# Name of power domain/voltage area  4
set VA4_COORDINATES              {}           ;# Coordinates for voltage area 4
set MW_POWER_NET4                "VDD4"       ;# Power net for voltage area 4

puts "RM-Info: Completed script [info script]\n"

