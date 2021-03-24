#!/usr/bin/awk -f
# ---
# Copyright (c) 2020 Alex Blewitt
#
# Released under the MIT License SPDX:MIT
# See LICENSE.txt for more information
# ---
# Displays a list of installed JVMs in mvn toolchain format
#
# This uses the /usr/libexec/java_home utilty, which displays the contents of
# the installed JVMs in the platform, via its Plist format.
#
# The output of this srciprt can then be reviewed or installed into the standard
# Maven toolchains location ~/.m2/toolchains.xml
#
# Usage:
#
#   /usr/libexec/java_home -x | macOS-mvn-toolchains.awk > ~/.m2/toolchains.xml

BEGIN {
	print("<?xml version=\"1.0\" encoding=\"UTF8\"?>")
	print("<toolchains>")
	jvm["home"]="kansas"
	jvm["version"]="1.8"
	jvm["vendor"]="Oracle"
}

/<dict>/ {
	jvm["home"]=""
	jvm["version"]=""
	jvm["version_short"]=""
	jvm["vendor"]=""
}

next_home {
	match($0, />.*</)
	jvm["home"]=substr($0,RSTART+1,RLENGTH-2)
	next_home=0
}

next_vendor {
	match($0, />.*</)
	jvm["vendor"]=substr($0,RSTART+1,RLENGTH-2)
	next_vendor=0
}

next_version {
	match($0, />.*</)
	jvm["version"]=substr($0,RSTART+1,RLENGTH-2)

	if (match(jvm["version"],/^[0-9]+/))    jvm["version_short"]=substr(jvm["version"],RSTART,RLENGTH)
	if (match(jvm["version"],/^1\.[0-9]+/)) jvm["version_short"]=substr(jvm["version"],RSTART,RLENGTH)
	next_version=0
}

/JVMHomePath/ {
	next_home=1
	next
}

/JVMVendor/ {
	next_vendor=1
	next
}

/JVMVersion/ {
	next_version=1
	next
}

jvm["home"] && /<\/dict>/ {
	print("  <toolchain>")
	if (jvm["version_short"]) print("    <id>JavaSE-" jvm["version_short"] "</id>")
	print("    <type>jdk</type>")
	print("    <provides>")
	print("      <version>" jvm["version"] "</version>")
	print("      <vendor>" jvm["vendor"] "</vendor>")
	print("    </provides>")
	print("    <configuration>")
	print("      <jdkHome>" jvm["home"] "</jdkHome>")
	print("    </configuration>")
	print("  </toolchain>")
}

END {
	print("</toolchains>")
}
