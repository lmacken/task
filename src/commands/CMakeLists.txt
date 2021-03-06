cmake_minimum_required (VERSION 2.8)
include_directories (${CMAKE_SOURCE_DIR}
                     ${CMAKE_SOURCE_DIR}/src
                     ${CMAKE_SOURCE_DIR}/src/commands
                     ${CMAKE_SOURCE_DIR}/src/columns
                     ${TASK_INCLUDE_DIRS})

set (commands_SRCS Command.cpp        Command.h
                   CmdAdd.cpp         CmdAdd.h
                   CmdAnnotate.cpp    CmdAnnotate.h
                   CmdAppend.cpp      CmdAppend.h
                   CmdBurndown.cpp    CmdBurndown.h
                   CmdCalendar.cpp    CmdCalendar.h
                   CmdCommands.cpp    CmdCommands.h
                   CmdColor.cpp       CmdColor.h
                   CmdColumns.cpp     CmdColumns.h
                   CmdConfig.cpp      CmdConfig.h
                   CmdCount.cpp       CmdCount.h
                   CmdCustom.cpp      CmdCustom.h
                   CmdDelete.cpp      CmdDelete.h
                   CmdDenotate.cpp    CmdDenotate.h
                   CmdDiagnostics.cpp CmdDiagnostics.h
                   CmdDone.cpp        CmdDone.h
                   CmdDuplicate.cpp   CmdDuplicate.h
                   CmdEdit.cpp        CmdEdit.h
                   CmdExec.cpp        CmdExec.h
                   CmdExport.cpp      CmdExport.h
                   CmdHelp.cpp        CmdHelp.h
                   CmdHistory.cpp     CmdHistory.h
                   CmdIDs.cpp         CmdIDs.h
                   CmdImport.cpp      CmdImport.h
                   CmdInfo.cpp        CmdInfo.h
                   CmdLog.cpp         CmdLog.h
                   CmdLogo.cpp        CmdLogo.h
                   CmdMerge.cpp       CmdMerge.h
                   CmdModify.cpp      CmdModify.h
                   CmdPrepend.cpp     CmdPrepend.h
                   CmdProjects.cpp    CmdProjects.h
                   CmdPull.cpp        CmdPull.h
                   CmdPush.cpp        CmdPush.h
                   CmdReports.cpp     CmdReports.h
                   CmdShell.cpp       CmdShell.h
                   CmdShow.cpp        CmdShow.h
                   CmdStart.cpp       CmdStart.h
                   CmdStatistics.cpp  CmdStatistics.h
                   CmdStop.cpp        CmdStop.h
                   CmdSummary.cpp     CmdSummary.h
                   CmdSynch.cpp       CmdSynch.h
                   CmdTags.cpp        CmdTags.h
                   CmdTimesheet.cpp   CmdTimesheet.h
                   CmdUndo.cpp        CmdUndo.h
                   CmdUrgency.cpp     CmdUrgency.h
                   CmdVersion.cpp     CmdVersion.h)

add_library (commands STATIC ${commands_SRCS})

set (CMAKE_BUILD_TYPE debug)
set (CMAKE_CXX_FLAGS_DEBUG   "${CMAKE_CXX_FLAGS_DEBUG}   -ggdb3 -Wall")
set (CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -O3 -Wall")

#SET(CMAKE_BUILD_TYPE gcov)
#SET(CMAKE_CXX_FLAGS_GCOV "--coverage")
#SET(CMAKE_C_FLAGS_GCOV "--coverage")
#SET(CMAKE_EXE_LINKER_FLAGS_GCOV "--coverage")
