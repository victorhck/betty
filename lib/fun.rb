module Fun
  def self.interpret(command)
    responses = []
    
    if command.match(/^cual\s?(\s+es)?\s+el\s+significado\s+de\s+la\s+vida\??$/i) || command.match(/^cual\s?(\s+es)?\s+el\s+sentido\s+de\s+la\s+vida\??$/i)
      responses << {
        :say => "42."
      }
    end
    
    if command.match(/^hazme\s+un\s+(.+)$/i) || command.match(/^hazme\s+una\s+(.+)$/i)
      thing = "#{ $1 }"
      responses << {
        :call => lambda { self.make_me_a(thing) }
      }
    end
    
    if command.match(/^sudo\s+hazme\s+un\s+(.+)$/i) || command.match(/^sudo\s+hazme\s+una\s+(.+)$/i)
      responses << {
        :say => "Creo que sería mejor si pones el sudo al inicio del comando."
      }
    end
    
    if command.match(/^cual\s?(\s+es)?\s+mi\s+nombre\??$/i)
      responses << {
        :say => "Snoop Doggy Dogg."
      }
    end
    
    if command.match(/^eres\s+?(genial|asombrosa|fascinante|divertida|la\s+mejor|rule)$/i)
      responses << {
        :say => "Puedes apostar a que sí!!"
      }
    end
    
    if command.match(/^vuelvete\s+loca$/i) || command.match(/^trip\s+(out|acid)$/i)
      responses << {
        :call => lambda { self.go_crazy },
        :say => "Woah."
      }
    end
    
    responses
  end
  
  def self.make_me_a(thing)
    if Process.uid != 0
      puts "Haztelo tu mismo el maldito  #{thing}."
    else
      puts "Ja, sudo no tiene ningún efecto sobre mi!"
    end
  end
  
  def self.go_crazy
    (0...63).step(3) do |i|
      system "osascript -e \"tell application \\\"Terminal\\\" to set background color of window 1 to {64000,#{ 64 - i }000,63000,0}\""
    end

    (0...63).step(3) do |i|
      system "osascript -e \"tell application \\\"Terminal\\\" to set background color of window 1 to {#{ 64 - i }000,#{ i }000,63000,0}\""
    end

    (0...63).step(3) do |i|
      system "osascript -e \"tell application \\\"Terminal\\\" to set background color of window 1 to {#{ i }000,63000,#{ 63 - i }000,0}\""
    end
    
    system 'osascript -e "tell application \"Terminal\" to set background color of window 1 to {64000,64000,64000,0}"'
  end

  def self.help
    commands = []
    commands << {
      :category => "Diversión",
      :usage => ["- betty cual es el significado de la vida",
      "...and more that are left for you to discover!"]
    }
    commands
  end
end

$executors << Fun
