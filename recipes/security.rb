include_recipe "simple_iptables"

# Tomcat redirects
simple_iptables_rule "tomcat" do
  table "nat"
  direction "PREROUTING"
  rule [ "--protocol tcp --dport 80 --jump REDIRECT --to-port 8080",
         "--protocol tcp --dport 443 --jump REDIRECT --to-port 8443" ]
  jump false
end
