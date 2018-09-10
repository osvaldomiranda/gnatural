class RutFormatValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)

    if value.present?

      value = value.gsub('.','')
      dv=value[value.length-1]

      t=value.to_i
      v=1
      s=0
      for i in (2..9)
        if i == 8
          v=2
        else 
          v+=1
        end
        s+=v*(t%10)
        t/=10
      end

      s = 11 - s%11
      if s == 11
        dvc= '0'
      elsif s == 10
        dvc= 'K'
      else
        dvc=s.to_s
      end

      unless dvc == dv.upcase 
        object.errors[attribute] << (options[:message] || "Incorrecto")
      end  
    end    
  end
end