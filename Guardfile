guard :rspec do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$}) { |m| "spec/unit/#{m[1]}_spec.rb" }
  watch('spec/unit/spec_helper.rb')  { "spec/unit" }
end

