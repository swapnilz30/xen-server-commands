Name: xe-cmd
Version: 1.0
Release: %{build_num}
License: GPL
Source: ${pkg_name}-${version}.tar.gz
BuildArch: noarch
Summary: Xen Server Command

%description
Xen Server Command

%prep
%setup -q -n ${pkg_name}-%{verion}

%install
#install -d $RPM_BUILD_ROOT/xe-cmd
install xe-cmd.sh $RPM_BUILD_ROOT/xe-cmd.sh

%files
%attr(0755,root,root) /bin/xe-cmd.sh