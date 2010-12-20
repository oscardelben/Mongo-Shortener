Mongoid.master.collections.select do |collection|
  collection.name !~ /system/
end.each(&:drop)