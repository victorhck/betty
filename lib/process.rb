module Process
  
  def self.examples
    [ "listado de todos los procesos",
      "procesos del usuario root",
      "muestrame mis procesos" ]
  end
  
  def self.test
    for phrase in examples
      puts "FAILED "+phrase if interpret(phrase).empty?
    end
  end
  
  def self.my_user_id
    my_name=`echo $USER`
    find_user_id my_name
  end

  def self.find_user_id(name)
    id=`id -u #{name}`
    id.strip
  end
  
  def self.interpret(command)
    responses = []
    
    process_pattern=%r{
      (muestra|muestrame|encuentra|dame|da|una|lista|de|esos|\s)*
      (?<all>todos\s)?
      (?<my>mis\s)?
      PROCESS(es)?
      (con|cuales|que|\s)*
      (para|procesos|\s)* (id\s(?<process_id>[0-9]+))?
      (para|pertenezcan|sean|de|a|\s)* (usuario\s(?<user_id>\w+))?
      ((como|matching|con|que|pattern|contengan|that|which|contain|\s)+ (?<pattern>\w+))?
    }imx
    
    # (?# todo <kill>kill\s)
    # (?# regex comments need newer versions of ruby)
    
    match=process_pattern.match command 
    
    if match  
      command="ps"
      args =  ""
      args += " -afx"               if match[:all]
      args += " -U#{ my_user_id }"  if match[:my]
      args += " -U#{ find_user_id(match[:user_id]) }" if match[:user_id]
      args += " | grep #{ match[:pattern] }"          if match[:pattern]
      # args+=" | kill" if match[:kill] #todo
      
        responses << {
          :command => "#{command} #{args}",
          :explanation => "List all processes"
        }
    end

    return responses
  end

  def self.help
    commands = []
    commands << {
      :category => "Procs",
      :description => 'Manipulate a running \033[34mProcs\033[0m (processes)',
      :usage => ["- betty show me all processes by root containing grep",
      "- betty show me all my processes containing netbio"]
    }
    commands
  end
end

$executors << Process
