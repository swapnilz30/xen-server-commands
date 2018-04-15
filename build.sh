#!/bin/bash

spec_file=xe-cmd.spec
pkg_name=xe-cmd

RPM_BUILD_ROOT="/home/jenkins/rpmbuild/BUILDROOT/${pkg_name}-${release}.x86_64"

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



rpmbuild -ba --define "build_num $build_num" $spec_file

if [ $? == 0  ]; then
   echo "success"
else
   echo "fail"
fi
