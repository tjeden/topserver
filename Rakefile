require 'rspec/core/rake'

desc  "Run all specs with rcov"
RSpec::Core::RakeTask.new(:rcov => spec_prereq) do |t|
  t.rcov = true
  t.rcov_opts = %w{--rails --exclude osx\/objc,gems\/,spec\/,features\/}
end
