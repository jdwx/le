include(CheckIncludeFile)
include(CheckSymbolExists)

set(CONFIG ${CMAKE_CURRENT_BINARY_DIR}/config.h)

file(WRITE ${CONFIG} "// DO NOT EDIT THIS FILE MANUALLY! It's generated by cmake.\n")

# Define to enable multibyte support.
file(APPEND ${CONFIG} "#define USE_MULTIBYTE_CHARS 1\n")

# Define to 1 if you have the <unistd.h> header file.
check_include_file("unistd.h" HAVE_UNISTD_H)
if(HAVE_UNISTD_H)
    file(APPEND ${CONFIG} "#define HAVE_UNISTD_H 1\n")
endif()

# Define to 1 if you have the <dirent.h> header file, and it defines `DIR'.
check_include_file("dirent.h" HAVE_DIRENT_H)
if(HAVE_DIRENT_H)
    file(APPEND ${CONFIG} "#define HAVE_DIRENT_H 1\n")
endif()

# Define to 1 if you have the <linux/tiocl.h> header file.
check_include_file("linux/tiocl.h" HAVE_LINUX_TIOCL_H)
if(HAVE_LINUX_TIOCL_H)
    file(APPEND ${CONFIG} "#define HAVE_LINUX_TIOCL_H 1\n")
endif()

# Define to 1 if you have <alloca.h> and it should be used (not on Ultrix).
check_include_file("alloca.h" HAVE_ALLOCA_H)
if(HAVE_ALLOCA_H)
    file(APPEND ${CONFIG} "#define HAVE_ALLOCA_H 1\n")
endif()

# Define to 1 if you have the <sys/ioctl.h> header file.
check_include_file("sys/ioctl.h" HAVE_SYS_IOCTL_H)
if(HAVE_SYS_IOCTL_H)
    file(APPEND ${CONFIG} "#define HAVE_SYS_IOCTL_H 1\n")
endif()

# Define to 1 if you have the <sys/mman.h> header file.
check_include_file("sys/mman.h" HAVE_SYS_MMAN_H)
if(HAVE_SYS_MMAN_H)
    file(APPEND ${CONFIG} "#define HAVE_SYS_MMAN_H 1\n")
endif()

# Define to 1 if you have the <sys/mount.h> header file.
check_include_file("sys/mount.h" HAVE_SYS_MOUNT_H)
if(HAVE_SYS_MOUNT_H)
    file(APPEND ${CONFIG} "#define HAVE_SYS_MOUNT_H 1\n")
endif()

# Define to 1 if you have the <sys/param.h> header file.
check_include_file("sys/param.h" HAVE_SYS_PARAM_H)
if(HAVE_SYS_PARAM_H)
    file(APPEND ${CONFIG} "#define HAVE_SYS_PARAM_H 1\n")
endif()

# Define to 1 if you have the <sys/syslimits.h> header file.
check_include_file("sys/syslimits.h" HAVE_SYS_SYSLIMITS_H)
if(HAVE_SYS_SYSLIMITS_H)
    file(APPEND ${CONFIG} "#define HAVE_SYS_SYSLIMITS_H 1\n")
endif()

# Define to 1 if you have the <sys/times.h> header file.
check_include_file("sys/times.h" HAVE_SYS_TIMES_H)
if(HAVE_SYS_TIMES_H)
    file(APPEND ${CONFIG} "#define HAVE_SYS_TIMES_H 1\n")
endif()

# Define to 1 if you have the `fchmod' function.
check_symbol_exists(fchmod "sys/stat.h" HAVE_FCHMOD)
if(HAVE_FCHMOD)
    file(APPEND ${CONFIG} "#define HAVE_FCHMOD 1\n")
endif()

# Define to 1 if you have the `ftruncate' function.
check_symbol_exists(ftruncate "unistd.h" HAVE_FTRUNCATE)
if(HAVE_FTRUNCATE)
    file(APPEND ${CONFIG} "#define HAVE_FTRUNCATE 1\n")
endif()

# Define to 1 if you have the `mmap' function.
check_symbol_exists(mmap "sys/mman.h" HAVE_MMAP)
if(HAVE_MMAP)
    file(APPEND ${CONFIG} "#define HAVE_MMAP 1\n")
endif()

# Define to 1 if you have the `times' function.
check_symbol_exists(times "sys/times.h" HAVE_TIMES)
if(HAVE_TIMES)
    file(APPEND ${CONFIG} "#define HAVE_TIMES 1\n")
endif()

# Define to 1 if you have the `strcoll' function and it is properly defined.
check_symbol_exists(strcoll "string.h" HAVE_STRCOLL)
if(HAVE_STRCOLL)
    file(APPEND ${CONFIG} "#define HAVE_STRCOLL 1\n")
endif()

# Define if you have <langinfo.h> and nl_langinfo(CODESET).
check_include_file("langinfo.h" HAVE_LANGINFO_H)
check_symbol_exists(nl_langinfo "langinfo.h" HAVE_NL_LANGINFO)
if(HAVE_LANGINFO_H AND HAVE_NL_LANGINFO)
    file(APPEND ${CONFIG} "#define HAVE_LANGINFO_CODESET 1\n")
endif()
