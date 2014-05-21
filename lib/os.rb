module OS

  def self.platform_name
    os = ""

    case RUBY_PLATFORM
      when '/cygwin|mswin|mingw|bccwin|wince|emx/'
        os = "Windows"
      when '/darwin/'
        os = "Mac OS"
      else
        os = "Linux"
    end

    os
  end

  def self.interpret(command)
    responses = []

    if command.match(/^(?:dime|muestrame\s)+|cual\+es\s+mi\s*SO*$/i)
      os = platform_name

      responses << {
        :command => "echo '#{os}'",
        :explanation => "Muestra el Sistema Operativo que uso"
      }
    end

    responses
  end

  def self.help
    commands = []
    commands << {
      :category => "SO",
      :description => 'Show \033[34mOS\033[0m name',
      :usage => ["- betty dime cual es mi SO."]
    }
    commands
  end
end

$executors << OS
