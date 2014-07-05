pid = ARGV[0]

raw_result = %x(ps -eo rss,pid | grep #{pid} | grep -v grep | awk '{ print $1; }')

puts '%.2f MB' % (raw_result.chomp.to_f / 1024)
