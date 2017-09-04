local DIST_DIR = "./dist"
local PROJECTS_DIR = ".build"
local TARGET_DIR = path.join(DIST_DIR, "lib", _TARGET_OS.."_x64")

os.copyfile("config_".._TARGET_OS..".h", "curl/lib/curl_config.h")

workspace "libcurl"
	configurations { "Debug", "Release" }
	architecture "x86_64"

	location(path.join(PROJECTS_DIR, _TARGET_OS))

project "curl"
	language "C"
	kind "StaticLib"
	warnings "off"

	targetdir(TARGET_DIR)
	targetsuffix "%{cfg.longname}"

	defines {
		-- libcurl
		"HAVE_CONFIG_H", "BUILDING_LIBCURL", "CURL_STATICLIB", "HTTP_ONLY", "USE_ZLIB",
		-- zlib
		"N_FSEEKO",
		-- mbedtls
		"MBEDTLS_ZLIB_SUPPORT"
	}

	includedirs {
		"curl/include", "curl/lib",
		"zlib",
		"mbedtls/include"
	}

	files {
		"curl/include/curl/**.h",
		"curl/lib/**.h",
		"curl/lib/**.c",

		"zlib/*.h",
		"zlib/*.c",

		"mbedtls/include/**.h",
		"mbedtls/library/*.c"
	}

	filter "configurations:Debug"
		defines { "DEBUG" }
		symbols "On"

	filter "configurations:Release"
		defines { "NDEBUG" }
		optimize "On"

	filter "system:windows"
		defines { "_WINDOWS" }

	filter "system:linux"
		defines { "CURL_HIDDEN_SYMBOLS", "HAVE_UNISTD_H" }

		-- find the location of the ca bundle
		local ca = nil
		for _, f in ipairs {
			"/etc/ssl/certs/ca-certificates.crt",
			"/etc/pki/tls/certs/ca-bundle.crt",
			"/usr/share/ssl/certs/ca-bundle.crt",
			"/usr/local/share/certs/ca-root.crt",
			"/usr/local/share/certs/ca-root-nss.crt",
			"/etc/ssl/cert.pem" } do
			if os.isfile(f) then
				ca = f
				break
			end
		end
		if ca then
			defines { 'CURL_CA_BUNDLE="' .. ca .. '"' }
		end
