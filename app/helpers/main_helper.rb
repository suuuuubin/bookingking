module MainHelper
    
    def stringcontroller(s)
        if s[20].nil?
            s[0..20]
        else
            s[0..20]+'...'
        end
    end
    
end
