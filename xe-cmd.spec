Name: xe-cmd
Version: 1.0
Release: %{build_num}
License: GPL
Source: xe-cmd.tar.gz
BuildArch: noarch
Summary: Xen Server Command

%description
Xen Server Command

%setup -q

%install
install xe-cmd/xe-cmd.sh $RPM_BUILD_ROOT/bin/xe-cmd.sh

%files
%attr(0755,root,root) /bin/xe-cmd.sh