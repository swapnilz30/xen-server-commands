#!/bin/bash

xen_cmd=xe
vm_list_file=/tmp/vm_list.txt
while getopts u:i: name
do
	case $name in
		u)
			user_name="$OPTARG"
		;;
		i)
		    host_ip="$OPTARG"
		;;
   		?)
			echo "Specify the parameter.Check the following example."
            echo "Example: sh build.sh -u <user_name> -i <host_ip>"
			exit 1
          	;;
    esac
done;


if [ ! -z $user_name ] && [ ! -z $host_ip ]; then
echo "Enter the following option from the list."
echo "1. vms list"
echo "2. exit"
read opt

    case $opt in
        1)
         # ssh $user_name@$host_ip "$xen_cmd vm-list"
              ssh $user_name@$host_ip "$xen_cmd vm-list | grep name-label | cut -d':' -f2" > $vm_list_file
              sed 's/^ *//'  $vm_list_file
              echo "Enter the vm name from the list."
              read vm_name
              if [ -f $vm_list_file ]; then
                grep -w "$vm_name" $vm_list_file
                if [ $? !=0 ]; then
                    exit 1
                fi
              fi
              echo "Select the operation for vm."
              echo "1. start"
              echo "2. shutdown"
              echo "3. reboot"
              echo "4. state"
              read vm_state
              case $vm_state in
                1)
                    ssh $user_name@$host_ip "$xen_cmd vm-start vm='$vm_name' && $xen_cmd vm-list name-label='$vm_name'"
                    ;;
                2)
                    ssh $user_name@$host_ip "$xen_cmd vm-shutdown vm='$vm_name' && $xen_cmd vm-list name-label='$vm_name'"
                    ;;
                3)  ssh $user_name@$host_ip "$xen_cmd vm-reboot vm='$vm_name' && $xen_cmd vm-list name-label='$vm_name'"
                    ;;
                4)
                    ssh $user_name@$host_ip "$xen_cmd vm-list name-label='$vm_name'"
                    ;;
                *)
                    echo "Enter option from the list."
                    exit 1
              esac

            ;;
        2)
             exit 1
             break
            ;;
        *)
            echo "Enter valid option from the list."
            ;;
    esac
else
    echo "user name and host ip should not be empty."
fi

rm -rf $vm_list_file