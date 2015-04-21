require 'yaml'
require 'tilt'
require 'ostruct'

def to_ostruct(object)
  case object
  when Hash
    OpenStruct.new(Hash[object.map {|k, v| [k, to_ostruct(v)] }])
  when Array
    object.map {|x| to_ostruct(x) }
  else
    object
  end
end

s=ARGV[0]
filename=s.split('.')[0]
structure=filename.split('/')
if structure[2]=='layouts' then
  print 'layout updated'
  return;
end
changed=structure[3..-1].join('/')
print changed
 
template = Tilt::HamlTemplate.new("source/haml/layouts/default.html.haml")
#template = Tilt::HamlTemplate.new("source/layout.html.haml")
site = YAML::load_file('site.yaml')
context = to_ostruct(site)
File.open( "compiled/#{changed}.html", "w") do |file|
    file.write template.render(context) {
        Tilt::HamlTemplate.new("#{s}").render(context)
    }
end

