#!/bin/bash
version=1.0
spec_file=xe-cmd.spec
pkg_name=xe-cmd


RPM_SOURCE_DIR="/home/jenkins/rpmbuild/SOURCES"
RPM_BUILD_DIR="/home/jenkins/rpmbuild/BUILD"
RPM_BUILD_ROOT="/home/jenkins/rpmbuild/BUILDROOT/${pkg_name}.x86_64"

export RPM_SOURCE_DIR RPM_BUILD_DIR RPM_BUILD_ROOT

cd $WORKSPACE/xen-server-commands
tar -czvf ${pkg_name}.tar.gz ${pkg_name}
echo "RPM_SOURCE_DIR: $RPM_SOURCE_DIR"
cp ${pkg_name}.tar.gz $RPM_SOURCE_DIR


while getopts b: name
do
	case $name in
		b)
			build_num="$OPTARG"
		;;
   		?)
			echo "Specify the parameter.Check the following example."
            echo "Example: sh build.sh -b <build_num>"
			exit 1
          	;;
    esac
done;



rpmbuild -ba --define "build_num $build_num" --define "version $version" --define "pkg_name $pkg_name" $spec_file

if [ $? == 0  ]; then
   echo "success"
else
   echo "fail"
fi
