s=ARGV[0]
filename=s.split('.')[0]
structure=filename.split('/')
changed=structure[-1]
require 'tilt'
print s
print changed
 
sites = {
    "Nettuts+" => "http://net.tutsplus.com", 
    "Psdtuts+" => "http://psd.tutsplus.com",
    "Mobiletuts+" => "http://mobile.tutplus.com",
    "Audiotuts+"  => "http://audio.tutsplus.com" }
 
template = Tilt::HamlTemplate.new("source/layout.html.haml")
context = Object.new
def context.title
    "Mark Scheid"
end
File.open( "compiled/pages/#{changed}.html", "w") do |file|
    file.write template.render(context) {
        Tilt::HamlTemplate.new("#{s}").render(Object.new, sites: sites)
    }
end
