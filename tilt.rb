require 'tilt'
 
sites = {
    "Nettuts+" => "http://net.tutsplus.com", 
    "Psdtuts+" => "http://psd.tutsplus.com",
    "Mobiletuts+" => "http://mobile.tutplus.com",
    "Audiotuts+"  => "http://audio.tutsplus.com" }
 
context = Object.new
def context.title
    "Mark Scheid"
end
 
template = Tilt::HamlTemplate.new("source/layout.html.haml")
 
File.open( "compiled/output.html", "w") do |file|
    file.write template.render(context) {
        Tilt::HamlTemplate.new("source/example.html.haml").render(Object.new, sites: sites)
    }
end
