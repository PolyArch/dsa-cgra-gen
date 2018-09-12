#set fo [open ./lib_container_umc28.tcl "w"]

#########################################################################################

set manully_add_path "/home/sihao/Synopsys/UMC_28nm/ManuallyAddLibrary"

set lib_path "/home/sihao/Synopsys/UMC_28nm"
#set lib_path ""

set MajorFeature "HighDensity"
# HighDensity , HighSpeed , UltraHighDensity

set LibraryFeature "LogicLibrary"
# LogicLibrary HPCLibrary PowerOptimizationKit

set Process "30nm"
# 30nm 35nm 40nm

set DesignDirection "HPC_plus"
# HPC_plus , HPC , HLP

set VT "SVT"
# HVT , LVT , SVT

set FileType "liberty"
# liberty , docs , ...

set modelType "ccs"
# ccs , nlsm

set cellType "ff"
# ff , ss , tt

set voltage "*"
# 0p99 , 0p81 , 0p9v

set temperature "*"
# 0 , 125 , 40

#########################################################################################

set target_db $lib_path/$MajorFeature/LogicLibrary/$Process/$DesignDirection/$VT/$FileType/$modelType/*$cellType*$voltage*$temperature*.db

set hpc_db $lib_path/$MajorFeature/HPCLibrary/$Process/$DesignDirection/$VT/$FileType/$modelType/*$cellType*$voltage*$temperature*.db
set PowerOpti_db $lib_path/$MajorFeature/PowerOptimizationKit/$Process/$DesignDirection/$VT/$FileType/$modelType/*$cellType*$voltage*$temperature*.db

#########################################################################################

set target_lib_list [eval [list exec ls ] [glob $target_db $manully_add_path/*.db ]]

set link_lib_list [eval [list exec ls ] [glob $PowerOpti_db $target_db ]]

#########################################################################################

set TARGET_LIBRARY_FILES [lsearch -all -inline $target_lib_list *.db*]

set ADDITIONAL_LINK_LIB_FILES [lsearch -all -inline $link_lib_list *.db*]

#########################################################################################
