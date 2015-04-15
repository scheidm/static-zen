require 'yaml'
require 'tilt'

s=ARGV[0]
filename=s.split('.')[0]
structure=filename.split('/')
changed=structure[-1]
print s
 
template = Tilt::HamlTemplate.new("source/layouts/default.html.haml")
#template = Tilt::HamlTemplate.new("source/layout.html.haml")
site = YAML::load_file('site.yaml')
context = Object.new
def context.title
    "Mark Scheid"
end
File.open( "compiled/#{changed}.html", "w") do |file|
    file.write template.render(context, data: site) {
        Tilt::HamlTemplate.new("#{s}").render(context, data: site)
    }
end
