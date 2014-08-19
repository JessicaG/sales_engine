guard :minitest do
  watch(%r{^test/(.*)\/?(.*)_test\.rb$})
  watch(%r{^(.*)\.rb$}) do |fragments|
    puts "Got #{fragment}\n"
    "test/#{fragment[1]}_test.rb"
  end
  watch(%r{^test/test_helper\.rb$})
end
