alias dns.flushcache="sudo dscacheutil -flushcache"
alias dns.reset="dns.flushcache && sudo killall -HUP mDNSResponder"
