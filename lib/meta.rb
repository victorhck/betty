module Meta  
  def self.interpret(command)
    responses = []
    
    if command.match(/^(que\s+)?version(\s+eres)?$/) || command.match(/^(qué\s+)?versión(\s+eres)?$/) || command.match(/^(que\s+)?versión(\s+eres)?$/)
      responses << {
        :say => $VERSION,
        :explanation => "Muestra la versión de Betty."
      }
    end
    
    if command.match(/^cual\s+es\s+la\s+direccion\s+de\s+tu\s+(repositorio|url|github|repo)$/) ||
       command.match(/^(website|url|dirección|direccion)$/) ||
       command.match(/^cual\s+es\s+la\s+dirección\s+de\s+tu\s+(repositorio|url|github|repo)$/)
      responses << {
        :say => $URL,
        :explanation => "Muestra la dirección web de Betty."
      }
    end
    
    responses
  end

  def self.help
    commands = []
    commands << {
      :category => "Meta",
      :usage => ["- betty que versión eres",
      "- betty cual es la dirección de tu repositorio"]
    }
    commands
  end
end

$executors << Meta
