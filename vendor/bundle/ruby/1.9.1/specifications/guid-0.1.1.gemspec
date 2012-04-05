# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "guid"
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Brian Takita, Ross Hale, & David Garamond"]
  s.date = "2008-04-24"
  s.description = "Guid is a Ruby library for portable GUID/UUID generation. At the moment it can be used on Windows (except first release of Win95 and older) and on Unix. This is a fork of David Garamond's ruby-uuid library."
  s.email = "opensource@pivotallabs.com"
  s.extra_rdoc_files = ["README", "CHANGES"]
  s.files = ["README", "CHANGES"]
  s.homepage = "http://pivotallabs.com"
  s.rdoc_options = ["--main", "README", "--inline-source", "--line-numbers"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "pivotalrb"
  s.rubygems_version = "1.8.15"
  s.summary = "Guid is a Ruby library for portable GUID/UUID generation. At the moment it can be used on Windows (except first release of Win95 and older) and on Unix. This is a fork of David Garamond's ruby-uuid library."

  if s.respond_to? :specification_version then
    s.specification_version = 2

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
