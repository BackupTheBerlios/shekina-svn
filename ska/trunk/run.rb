if ARGV.shift=='unit'

 Dir['test/unit/*.rb'].each do |f|
  require f
 end
else
 Dir['test/functional/*.rb'].each do |f|
  require f
 end
end
