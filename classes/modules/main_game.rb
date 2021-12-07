module Main_game
  def self.included(base)
    base.extend(ClassMethods)
    base.send :include, InstanceMethods
  end
  module ClassMethods
  end

  module InstanceMethods
    def sayhello
      #Вначале, запрашиваем у пользователя имя после чего, начинается игра.
    end
    def createClient
      #создание клиента
    end
  end
end
