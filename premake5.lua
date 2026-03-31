project "Assimp"
    kind "StaticLib"
    language "C++"
    cppdialect "C++17"
    staticruntime "off"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    files 
    {
        "include/**.h",
        "code/**.h",
        "code/**.cpp",

        -- zlib
        "contrib/zlib/**.c",
        "contrib/zlib/**.h",

        -- pugixml
        "contrib/pugixml/src/*.cpp",
        "contrib/pugixml/src/*.hpp",

        -- poly2tri (Required for Blender/IFC/etc)
        "contrib/poly2tri/poly2tri/common/*.cpp",
        "contrib/poly2tri/poly2tri/common/*.h",
        "contrib/poly2tri/poly2tri/sweep/*.cpp",
        "contrib/poly2tri/poly2tri/sweep/*.h",

        -- clipper (Required for several importers)
        "contrib/clipper/*.cpp",
        "contrib/clipper/*.hpp",

        -- unzip (Required for 3MF/FBX/etc)
        "contrib/unzip/*.c",
        "contrib/unzip/*.h"
    }

    includedirs 
    {
        ".",
        "include",
        "code",
        "code/PCH",
        "contrib",
        "contrib/zlib",
        "contrib/pugixml/src",
        "contrib/unzip",
        "contrib/rapidjson/include",
        "contrib/utf8cpp/source",   -- fixes utf8.h
    }

    removefiles {
        "code/AssetLib/IFC/**",
        "code/AssetLib/USD/**",
        "code/AssetLib/OpenGEX/**",
        "code/AssetLib/VRML/**",
        "code/AssetLib/MMD/**",
        "code/AssetLib/X3D/**",   -- depends on VRML
        "contrib/zlib/contrib/**",
    }

    defines {
        "ASSIMP_BUILD_NO_EXPORT",
        "_CRT_SECURE_NO_WARNINGS",
        "RAPIDJSON_HAS_STDSTRING=1",
        "ASSIMP_BUILD_NO_PCH",
        "ASSIMP_BUILD_NO_USD_IMPORTER",
        "ASSIMP_BUILD_NO_OPENGEX_IMPORTER",
        "ASSIMP_BUILD_NO_VRML_IMPORTER",
        "ASSIMP_BUILD_NO_MMD_IMPORTER",
        "ASSIMP_BUILD_NO_M3D_IMPORTER",
        "ASSIMP_BUILD_NO_M3D_EXPORTER",
        "ASSIMP_BUILD_NO_C4D_IMPORTER",
        "ASSIMP_BUILD_NO_IFC_IMPORTER",
        "ASSIMP_BUILD_NO_X3D_IMPORTER",
        "ASSIMP_BUILD_NO_VRML_IMPORTER",
    }

    filter "system:windows"
        systemversion "latest"
        defines { 
            "WIN32", 
            "_WINDOWS"
        }

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