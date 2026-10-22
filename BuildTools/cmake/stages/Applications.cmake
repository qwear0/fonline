cmake_minimum_required(VERSION 3.22)

# Build applications and extend through AddStageHook(Applications Pre|Post <macro-name>)

# Applications
StatusMessage("Applications:")

if(NOT CMAKE_CROSSCOMPILING AND (FO_WINDOWS OR FO_LINUX OR FO_MAC))
    add_subdirectory("${CMAKE_CURRENT_SOURCE_DIR}/${FO_ENGINE_ROOT}/BuildTools/resource-pack-hash"
        "${CMAKE_CURRENT_BINARY_DIR}/ResourcePackHash")
endif()

if(FO_BUILD_CLIENT)
    if(NOT FO_BUILD_LIBRARY)
        AddExecutableApplication(${FO_DEV_NAME}_Client "${FO_ENGINE_ROOT}/Source/Applications/ClientApp.cpp"
            WIN32
            OUTPUT_DIR ${FO_CLIENT_OUTPUT}
            WORKING_DIRECTORY ${FO_OUTPUT_PATH}
            OUTPUT_NAME ${FO_DEV_NAME}_Client
            TESTING_APP 0
            LINK_LIBS AppFrontend ClientLib
            EXTRA_SOURCES ${FO_RC_FILE}
            WRITE_BUILD_HASH)

        if(FO_WINDOWS OR FO_LINUX OR FO_MAC)
            AddSharedApplication(${FO_DEV_NAME}_ClientLib "${FO_ENGINE_ROOT}/Source/Applications/ClientLib.cpp"
                OUTPUT_DIR ${FO_CLIENT_OUTPUT}
                OUTPUT_NAME ${FO_DEV_NAME}_ClientLib
                TESTING_APP 0
                LINK_LIBS PRIVATE AppFrontend ClientLib
                EXTRA_PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${FO_CLIENT_OUTPUT}
                NO_PREFIX
                WRITE_BUILD_HASH)

            add_custom_command(TARGET ${FO_DEV_NAME}_ClientLib POST_BUILD
                COMMAND ${CMAKE_COMMAND} -E copy_if_different
                    "$<TARGET_FILE:${FO_DEV_NAME}_ClientLib>"
                    "${FO_CLIENT_OUTPUT}/${FO_DEV_NAME}_Client${CMAKE_SHARED_LIBRARY_SUFFIX}"
                COMMENT "Copy client runtime library to host-derived module name")

            # A native client launch loads the sibling runtime module by default. Keep the
            # runnable host target from leaving a stale module next to a fresh executable
            add_dependencies(${FO_DEV_NAME}_Client ${FO_DEV_NAME}_ClientLib)

            AddExecutableApplication(${FO_DEV_NAME}_ClientHeadless "${FO_ENGINE_ROOT}/Source/Applications/ClientApp.cpp"
                OUTPUT_DIR ${FO_CLIENT_OUTPUT}
                WORKING_DIRECTORY ${FO_OUTPUT_PATH}
                OUTPUT_NAME ${FO_DEV_NAME}_ClientHeadless
                TESTING_APP 0
                HEADLESS_APP 1
                LINK_LIBS AppHeadless ClientLib
                WRITE_BUILD_HASH)

            AddSharedApplication(${FO_DEV_NAME}_ClientLibHeadless "${FO_ENGINE_ROOT}/Source/Applications/ClientLib.cpp"
                OUTPUT_DIR ${FO_CLIENT_OUTPUT}
                OUTPUT_NAME ${FO_DEV_NAME}_ClientLibHeadless
                TESTING_APP 0
                HEADLESS_APP 1
                LINK_LIBS PRIVATE AppHeadless ClientLib
                EXTRA_PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${FO_CLIENT_OUTPUT}
                NO_PREFIX
                WRITE_BUILD_HASH)

            add_custom_command(TARGET ${FO_DEV_NAME}_ClientLibHeadless POST_BUILD
                COMMAND ${CMAKE_COMMAND} -E copy_if_different
                    "$<TARGET_FILE:${FO_DEV_NAME}_ClientLibHeadless>"
                    "${FO_CLIENT_OUTPUT}/${FO_DEV_NAME}_ClientHeadless${CMAKE_SHARED_LIBRARY_SUFFIX}"
                COMMENT "Copy headless client runtime library to host-derived module name")

            add_dependencies(${FO_DEV_NAME}_ClientHeadless ${FO_DEV_NAME}_ClientLibHeadless)
        endif()
    else()
        AddSharedApplication(${FO_DEV_NAME}_Client "${FO_ENGINE_ROOT}/Source/Applications/ClientApp.cpp"
            OUTPUT_DIR ${FO_CLIENT_OUTPUT}
            OUTPUT_NAME ${FO_DEV_NAME}_Client
            TESTING_APP 0
            LINK_LIBS AppFrontend ClientLib
            WRITE_BUILD_HASH)
    endif()
endif()

if(FO_BUILD_SERVER)
    AddExecutableApplication(
        ${FO_DEV_NAME}_Server
        "${FO_ENGINE_ROOT}/Source/Applications/ServerApp.cpp"
        WIN32
        OUTPUT_DIR ${FO_SERVER_OUTPUT}
        WORKING_DIRECTORY ${FO_OUTPUT_PATH}
        OUTPUT_NAME ${FO_DEV_NAME}_Server
        TESTING_APP 0
        LINK_LIBS ServerLib ClientLib AppFrontend
        EXTRA_SOURCES ${FO_RC_FILE}
        WRITE_BUILD_HASH)

    if(FO_WINDOWS)
        AddExecutableApplication(
            ${FO_DEV_NAME}_ServerService
            "${FO_ENGINE_ROOT}/Source/Applications/ServerServiceApp.cpp"
            OUTPUT_DIR ${FO_SERVER_OUTPUT}
            WORKING_DIRECTORY ${FO_OUTPUT_PATH}
            OUTPUT_NAME ${FO_DEV_NAME}_ServerService
            TESTING_APP 0
            LINK_LIBS ServerLib ClientLib AppHeadless
            WRITE_BUILD_HASH)
    else()
        AddExecutableApplication(
            ${FO_DEV_NAME}_ServerDaemon
            "${FO_ENGINE_ROOT}/Source/Applications/ServerDaemonApp.cpp"
            OUTPUT_DIR ${FO_SERVER_OUTPUT}
            WORKING_DIRECTORY ${FO_OUTPUT_PATH}
            OUTPUT_NAME ${FO_DEV_NAME}_ServerDaemon
            TESTING_APP 0
            LINK_LIBS ServerLib ClientLib AppHeadless
            WRITE_BUILD_HASH)
    endif()
endif()

# Coverage integration processes reuse the instrumented libraries from the unit-test build
if(FO_BUILD_SERVER OR FO_CODE_COVERAGE)
    AddExecutableApplication(
        ${FO_DEV_NAME}_ServerHeadless
        "${FO_ENGINE_ROOT}/Source/Applications/ServerHeadlessApp.cpp"
        OUTPUT_DIR ${FO_SERVER_OUTPUT}
        WORKING_DIRECTORY ${FO_OUTPUT_PATH}
        OUTPUT_NAME ${FO_DEV_NAME}_ServerHeadless
        TESTING_APP 0
        LINK_LIBS ServerLib ClientLib AppHeadless
        WRITE_BUILD_HASH)
endif()

if(FO_BUILD_MAPPER)
    AddExecutableApplication(${FO_DEV_NAME}_Mapper "${FO_ENGINE_ROOT}/Source/Applications/MapperApp.cpp"
        WIN32
        OUTPUT_DIR ${FO_MAPPER_OUTPUT}
        WORKING_DIRECTORY ${FO_OUTPUT_PATH}
        OUTPUT_NAME ${FO_DEV_NAME}_Mapper
        TESTING_APP 0
        LINK_LIBS AppFrontend MapperLib ClientLib BakerLib
        EXTRA_SOURCES ${FO_RC_FILE}
        WRITE_BUILD_HASH)

    AddExecutableApplication(${FO_DEV_NAME}_AnimationViewer "${FO_ENGINE_ROOT}/Source/Applications/AnimationViewerApp.cpp"
        WIN32
        OUTPUT_DIR ${FO_ANIMATION_VIEWER_OUTPUT}
        WORKING_DIRECTORY ${FO_OUTPUT_PATH}
        OUTPUT_NAME ${FO_DEV_NAME}_AnimationViewer
        TESTING_APP 0
        LINK_LIBS AppFrontend AnimationViewerLib ClientLib BakerLib
        EXTRA_SOURCES ${FO_RC_FILE}
        WRITE_BUILD_HASH)

    AddExecutableApplication(${FO_DEV_NAME}_ParticleViewer "${FO_ENGINE_ROOT}/Source/Applications/ParticleViewerApp.cpp"
        WIN32
        OUTPUT_DIR ${FO_PARTICLE_VIEWER_OUTPUT}
        WORKING_DIRECTORY ${FO_OUTPUT_PATH}
        OUTPUT_NAME ${FO_DEV_NAME}_ParticleViewer
        TESTING_APP 0
        LINK_LIBS AppFrontend ParticleViewerLib ClientLib BakerLib
        EXTRA_SOURCES ${FO_RC_FILE}
        WRITE_BUILD_HASH)
endif()

if(FO_BUILD_ASCOMPILER)
    AddExecutableApplication(
        ${FO_DEV_NAME}_ASCompiler
        "${FO_ENGINE_ROOT}/Source/Applications/ASCompilerApp.cpp"
        OUTPUT_DIR ${FO_ASCOMPILER_OUTPUT}
        WORKING_DIRECTORY ${FO_OUTPUT_PATH}
        OUTPUT_NAME ${FO_DEV_NAME}_ASCompiler
        TESTING_APP 0
        LINK_LIBS AppHeadless BakerLib
        DEPENDS ${FO_GEN_DEPENDENCIES}
        WRITE_BUILD_HASH)
endif()

if(FO_MANAGED_SCRIPTING AND FO_BUILD_BAKER_LIB)
    AddExecutableApplication(
        ${FO_DEV_NAME}_ManagedScriptBaker
        "${FO_ENGINE_ROOT}/Source/Applications/ManagedScriptBakerApp.cpp"
        OUTPUT_DIR ${FO_BAKER_OUTPUT}
        WORKING_DIRECTORY ${FO_OUTPUT_PATH}
        OUTPUT_NAME ${FO_DEV_NAME}_ManagedScriptBaker
        TESTING_APP 0
        LINK_LIBS AppHeadless BakerLib
        DEPENDS ${FO_GEN_DEPENDENCIES}
        WRITE_BUILD_HASH)
endif()

if(FO_BUILD_BAKER OR FO_CODE_COVERAGE)
    AddExecutableApplication(${FO_DEV_NAME}_Baker "${FO_ENGINE_ROOT}/Source/Applications/BakerApp.cpp"
        OUTPUT_DIR ${FO_BAKER_OUTPUT}
        WORKING_DIRECTORY ${FO_OUTPUT_PATH}
        OUTPUT_NAME ${FO_DEV_NAME}_Baker
        TESTING_APP 0
        LINK_LIBS AppHeadless BakerLib
        WRITE_BUILD_HASH)

    if(TARGET FOnlineResourcePackHash)
        add_dependencies(${FO_DEV_NAME}_Baker FOnlineResourcePackHash)
    endif()

    if(FO_BUILD_BAKER AND NOT FO_WEB)
        AddSharedApplication(${FO_DEV_NAME}_BakerLib "${FO_ENGINE_ROOT}/Source/Applications/BakerLib.cpp"
            OUTPUT_DIR ${FO_BAKER_OUTPUT}
            OUTPUT_NAME ${FO_DEV_NAME}_BakerLib
            TESTING_APP 0
            LINK_LIBS PRIVATE AppHeadless BakerLib
            EXTRA_PROPERTIES
                RUNTIME_OUTPUT_DIRECTORY ${FO_BAKER_OUTPUT}
                CXX_VISIBILITY_PRESET hidden
                VISIBILITY_INLINES_HIDDEN YES
            NO_PREFIX
            WRITE_BUILD_HASH)

        if(FO_LINUX)
            # The baker is loaded into hosts built with different allocator/sanitizer settings. Keep
            # every implementation symbol local so the plugin cannot interpose its allocator or
            # engine globals on the host; FO_BakeResources is the complete C ABI boundary
            SetValue(bakerLibExports "${CMAKE_CURRENT_SOURCE_DIR}/${FO_ENGINE_ROOT}/BuildTools/cmake/exports/BakerLib.map")
            SetValue(verifyDynamicExports "${CMAKE_CURRENT_SOURCE_DIR}/${FO_ENGINE_ROOT}/BuildTools/cmake/helpers/VerifyDynamicExports.cmake")
            TargetLinkOptions(${FO_DEV_NAME}_BakerLib PRIVATE
                -Wl,--exclude-libs,ALL
                "-Wl,--version-script,${bakerLibExports}")
            AddCustomCommand(TARGET ${FO_DEV_NAME}_BakerLib POST_BUILD
                COMMAND ${CMAKE_COMMAND}
                    "-DNM_EXECUTABLE=${CMAKE_NM}"
                    "-DLIBRARY_PATH=$<TARGET_FILE:${FO_DEV_NAME}_BakerLib>"
                    "-DEXPECTED_EXPORTS=FO_BakeResources"
                    -P "${verifyDynamicExports}"
                COMMENT "Verify ${FO_DEV_NAME}_BakerLib public exports"
                VERBATIM)
        endif()
    endif()
endif()
