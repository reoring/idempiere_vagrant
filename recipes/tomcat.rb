cookbook_file "/etc/tomcat6/tomcat-users.xml" do
    source "tomcat-users.xml"
    owner "root"
    mode 00664
end
