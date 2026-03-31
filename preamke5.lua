project "Assimp"
    kind "StaticLib"
    language "C++"
    cppdialect "C++17"

    staticruntime "off"

    targetdir ("bin/%{cfg.buildcfg}/%{prj.name}")
    objdir ("bin-int/%{cfg.buildcfg}/%{prj.name}")

    includedirs {
        "include",
        "code",
        "contrib",
        "contrib/zlib"
    }

    files {
        "include/**.h",
        "code/**.h",
        "code/**.cpp",

        -- zlib (required)
        "contrib/zlib/**.c",
        "contrib/zlib/**.h"
    }

    defines {
        "ASSIMP_BUILD_NO_EXPORT",
        "ASSIMP_BUILD_NO_IMPORTER_X", -- optional: disable stuff if needed
        "_CRT_SECURE_NO_WARNINGS"
    }

    filter "system:windows"
        systemversion "latest"
        defines { "WIN32", "_WINDOWS" }

    filter "configurations:Debug"
        runtime "Debug"
        symbols "on"

    filter "configurations:Release"
        runtime "Release"
        optimize "on"
    
    filter "configurations:Dist"
		runtime "Release"
		optimize "on"
        symbols "off"