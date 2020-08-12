module Ffmprb

  VERSION = '0.11.4'

  GEM_GITHUB_URL = 'https://github.com/costa/ffmprb'

  FIREBASE_AVAILABLE =
    begin
      require 'firebase'
      true
    rescue Exception
    end

end
