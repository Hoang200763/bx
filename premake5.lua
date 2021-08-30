local BX_DIR = "%{wks.location}/bx"

project "bx"
	kind "StaticLib"
	language "C++"
	cppdialect "C++14"
	exceptionhandling "Off"
	rtti "Off"
	defines "__STDC_FORMAT_MACROS"
	files
	{
        BX_DIR .. "/include/bx/*.h",
        BX_DIR .. "/include/bx/inline/*.inl",
        BX_DIR .. "/src/*.cpp",
	}
	excludes
	{
		BX_DIR .. "/src/amalgamated.cpp",
		BX_DIR .. "/src/crtnone.cpp",
	}
	includedirs
	{
		BX_DIR .. "/3rdparty",
		BX_DIR .. "/include",
	}
	filter "action:vs*"
		defines "_CRT_SECURE_NO_WARNINGS"
		includedirs { BX_DIR .. "/include/compat/msvc" }

	filter { "system:windows", "action:gmake" }
		includedirs { BX_DIR .. "/include/compat/mingw" }
        
	filter { "system:macosx" }
		includedirs { BX_DIR .. "/include/compat/osx" }
		buildoptions { "-x objective-c++" }