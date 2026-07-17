# --------------------------------------------------------------------
# GEN_Main_WaylandProtocols.cmake
# Main: Linux Wayland protocol code generation
# --------------------------------------------------------------------

# Unlike X11 (a stable protocol with fixed system headers), Wayland only defines a small
# "core" protocol in libwayland-client (wl_compositor, wl_surface, wl_seat, wl_output...).
# Everything needed to open an actual top-level window (xdg-shell) lives in separate XML
# protocol descriptions shipped by the wayland-protocols package, and has to be turned into
# C bindings at configure/build time with wayland-scanner. This file does exactly that, and
# only runs its logic when GEN_LINUX_WAYLAND_ACTIVE was set to TRUE by
# GEN_Main_Compiler_Linux.cmake (i.e. LINUX_WAYLAND_FEATURE is ON AND every Wayland
# dependency was actually found) -- on any other build (X11, FrameBuffer, Windows, Android,
# STM32, ESP32, or a Linux Wayland build simply missing the dev packages) this whole file is
# a silent no-op.


if(GEN_LINUX_WAYLAND_ACTIVE)

  set(GEN_WAYLAND_GENERATED_DIR "${CMAKE_BINARY_DIR}/GEN_Wayland_Generated")

  file(MAKE_DIRECTORY "${GEN_WAYLAND_GENERATED_DIR}")

  pkg_get_variable(GEN_WAYLAND_PROTOCOLS_DATADIR wayland-protocols pkgdatadir)

  set(GEN_XDG_SHELL_XML "${GEN_WAYLAND_PROTOCOLS_DATADIR}/stable/xdg-shell/xdg-shell.xml")

  if(NOT EXISTS "${GEN_XDG_SHELL_XML}")

    message(STATUS "[ GEN Linux Wayland: xdg-shell.xml not found at '${GEN_XDG_SHELL_XML}' -- disabling LINUX_WAYLAND_ACTIVE for this build ]")

    remove_definitions(-DLINUX_WAYLAND_ACTIVE)
    set(GEN_LINUX_WAYLAND_ACTIVE FALSE)

  else()

    set(GEN_XDG_SHELL_HEADER "${GEN_WAYLAND_GENERATED_DIR}/xdg-shell-client-protocol.h")
    set(GEN_XDG_SHELL_SOURCE "${GEN_WAYLAND_GENERATED_DIR}/xdg-shell-protocol.c")

    add_custom_command(
      OUTPUT  "${GEN_XDG_SHELL_HEADER}"
      COMMAND "${GEN_WAYLAND_SCANNER}" client-header "${GEN_XDG_SHELL_XML}" "${GEN_XDG_SHELL_HEADER}"
      DEPENDS "${GEN_XDG_SHELL_XML}"
      COMMENT "[ GEN Wayland ] wayland-scanner client-header xdg-shell")

    add_custom_command(
      OUTPUT  "${GEN_XDG_SHELL_SOURCE}"
      COMMAND "${GEN_WAYLAND_SCANNER}" private-code "${GEN_XDG_SHELL_XML}" "${GEN_XDG_SHELL_SOURCE}"
      DEPENDS "${GEN_XDG_SHELL_XML}"
      COMMENT "[ GEN Wayland ] wayland-scanner private-code xdg-shell")

    set_source_files_properties("${GEN_XDG_SHELL_SOURCE}" PROPERTIES GENERATED TRUE)
    set_source_files_properties("${GEN_XDG_SHELL_HEADER}" PROPERTIES GENERATED TRUE HEADER_FILE_ONLY TRUE)

    # Both the generated .c AND .h are listed here (not just the .c): each add_custom_command()
    # above only wires a ninja build edge for callers that depend on ITS OWN OUTPUT. The header is
    # never compiled on its own (nothing #include-only ever appears as a compiler input), so unless
    # it is also added as a source of the final target, ninja has no reason to run its custom command
    # before the first .cpp that #includes it -- causing a "file not found" on a clean build even
    # though the .c generation (chained off being an actual compiled source) works fine. Marking it
    # HEADER_FILE_ONLY keeps CMake from trying to compile it while still creating that build edge.
    #
    # Consumed by GEN_Main_Sources_Linux.cmake (appended to GEN_SOURCES_MODULES_LIST) and by
    # GEN_Main_SetDirectories.cmake / the include dirs list, so GRPLINUXScreenWayland.cpp can
    # simply #include "xdg-shell-client-protocol.h" like any other GEN header.
    set(GEN_WAYLAND_PROTOCOL_SOURCES "${GEN_XDG_SHELL_SOURCE}" "${GEN_XDG_SHELL_HEADER}")

    list(APPEND GEN_INCLUDES_DIR_LIST "${GEN_WAYLAND_GENERATED_DIR}")

    message(STATUS "[ GEN Linux Wayland: xdg-shell protocol generated in ${GEN_WAYLAND_GENERATED_DIR} ]")

    # ----------------------------------------------------------------------------------------
    # xdg-decoration (unstable-v1): OPTIONAL, unlike xdg-shell above -- lets GEN ASK the
    # compositor for server-side (native) window decorations on GRPSCREENCFGCHROMES native-caption
    # requests (GRPLINUXSCREENX11's _MOTIF_WM_HINTS equivalent). Never mandatory: core xdg-shell
    # has no decoration concept at all, some compositors (notably GNOME/Mutter) never implement
    # this extension by design and expect every client to draw its own chrome instead, and even
    # where it IS implemented the compositor can still grant a different mode than requested (see
    # Decoration_Configure() in GRPLINUXScreenWayland.cpp). So unlike xdg-shell.xml missing (which
    # disables Wayland outright), this XML missing just silently skips native-decoration support --
    # LINUX_WAYLAND_ACTIVE and everything else about this build stays completely unaffected.
    set(GEN_XDG_DECORATION_XML "${GEN_WAYLAND_PROTOCOLS_DATADIR}/unstable/xdg-decoration/xdg-decoration-unstable-v1.xml")

    if(EXISTS "${GEN_XDG_DECORATION_XML}")

      set(GEN_XDG_DECORATION_HEADER "${GEN_WAYLAND_GENERATED_DIR}/xdg-decoration-unstable-v1-client-protocol.h")
      set(GEN_XDG_DECORATION_SOURCE "${GEN_WAYLAND_GENERATED_DIR}/xdg-decoration-unstable-v1-protocol.c")

      add_custom_command(
        OUTPUT  "${GEN_XDG_DECORATION_HEADER}"
        COMMAND "${GEN_WAYLAND_SCANNER}" client-header "${GEN_XDG_DECORATION_XML}" "${GEN_XDG_DECORATION_HEADER}"
        DEPENDS "${GEN_XDG_DECORATION_XML}"
        COMMENT "[ GEN Wayland ] wayland-scanner client-header xdg-decoration")

      add_custom_command(
        OUTPUT  "${GEN_XDG_DECORATION_SOURCE}"
        COMMAND "${GEN_WAYLAND_SCANNER}" private-code "${GEN_XDG_DECORATION_XML}" "${GEN_XDG_DECORATION_SOURCE}"
        DEPENDS "${GEN_XDG_DECORATION_XML}"
        COMMENT "[ GEN Wayland ] wayland-scanner private-code xdg-decoration")

      set_source_files_properties("${GEN_XDG_DECORATION_SOURCE}" PROPERTIES GENERATED TRUE)
      set_source_files_properties("${GEN_XDG_DECORATION_HEADER}" PROPERTIES GENERATED TRUE HEADER_FILE_ONLY TRUE)

      # Same "list both .c and .h" reasoning as GEN_XDG_SHELL_SOURCES above -- appended onto the
      # SAME variable GEN_Main_Sources_Linux.cmake already consumes, so no change needed there.
      list(APPEND GEN_WAYLAND_PROTOCOL_SOURCES "${GEN_XDG_DECORATION_SOURCE}" "${GEN_XDG_DECORATION_HEADER}")

      add_definitions(-DLINUX_WAYLAND_XDGDECORATION_ACTIVE)

      message(STATUS "[ GEN Linux Wayland: xdg-decoration protocol generated -- native chromes available when the compositor supports it ]")

    else()

      message(STATUS "[ GEN Linux Wayland: xdg-decoration-unstable-v1.xml not found -- native chromes unavailable on Wayland for this build, custom chromes / no decoration unaffected ]")

    endif()

  endif()

endif()
