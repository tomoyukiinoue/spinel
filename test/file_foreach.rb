# Test File.foreach(path) { |line| ... }.
# Streams a file line-by-line without loading the whole file into
# memory. Lowered to fopen + fgets loop + fclose; the 4 KB line
# buffer matches the existing f.each_line lowering.
# Uses a cwd-relative path for the same reason as test/fileio.rb.

# Set up
File.open("spinel_foreach_test.txt", "w") do |f|
  f.puts "line 1"
  f.puts "line 2"
  f.puts "line 3"
end

# Iterate and print each line (lines retain their trailing newline,
# so puts won't double up).
File.foreach("spinel_foreach_test.txt") do |line|
  puts line
end

# Count lines via foreach
count = 0
File.foreach("spinel_foreach_test.txt") do |line|
  count = count + 1
end
puts count   # 3

# Empty file: block body must not execute
File.open("spinel_foreach_empty.txt", "w") do |f|
end
ec = 0
File.foreach("spinel_foreach_empty.txt") do |line|
  ec = ec + 1
end
puts ec      # 0

# Cleanup
File.delete("spinel_foreach_test.txt")
File.delete("spinel_foreach_empty.txt")
puts "done"
