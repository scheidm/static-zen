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

def split(filearg)
  filename=filearg.split('.')[0]
  return filename.split('/')
end

def update(s)
  structure=split(s)
  changed=structure[3..-1].join('/')
  template = Tilt::HamlTemplate.new("source/haml/layouts/default.html.haml")
  #template = Tilt::HamlTemplate.new("source/layout.html.haml")
  site = YAML::load_file('site.yaml')
  context = to_ostruct(site)
  File.open( "compiled/#{changed}.html", "w") do |file|
      file.write template.render(context) {
          Tilt::HamlTemplate.new("#{s}").render(context)
      }
  end
end
s=ARGV[0]
structure=split(s)
if structure[2]=='layouts' then
  print 'layout updated'
  updates=Dir.glob('source/haml/pages/**/*').select{ |e| File.file? e }
  updates.each{ |page|
    print "update #{page}\n"
    update(page)
  }
else 
  update(changed)
end
