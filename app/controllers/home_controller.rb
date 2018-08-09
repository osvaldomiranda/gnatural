class HomeController < ApplicationController
  before_filter :authenticate_user! 

  respond_to :html

  def index  
    @id_centro = params[:center] 

    if @id_centro.present?
      center = OwnerCenter.where(id_centro: @id_centro).first
      @nombre_centro = center.name_center
      @rut_centro = center.rut_centro 
    else 
      owner_center = current_user.owner_centers.order(:name_center).first
      @id_centro = owner_center.id_centro 
      @rut_centro = owner_center.rut_centro 
      @nombre_centro = owner_center.name_center 
    end  

    @comment = Comment.where(center_id: @id_centro).last

    sql = "SELECT * FROM hora_act"
    array =  ActiveRecord::Base.connection.execute(sql).to_a
    @hora_act = DateTime.parse(array.last["hora"])


    vta_total_mes = "SELECT id_centro, sum(price_subtotal_incl) FROM tablon_mes WHERE id_centro=#{@id_centro} GROUP BY id_centro"
    array = ActiveRecord::Base.connection.execute(vta_total_mes).to_a
    if array.count > 0
      @vta_total_mes = array.first["sum"].to_i
    else
      @vta_total_mes = 0
    end  

    #***************************

    vta_producto_mes = "SELECT  name_template, sum(price_subtotal_incl) FROM tablon_mes WHERE id_centro=#{@id_centro} GROUP BY name_template "
    array = ActiveRecord::Base.connection.execute(vta_producto_mes).to_a
    @vta_producto_mes = array.map{|a| {a["name_template"]=>a["sum"]}}
    @vta_producto_mes = @vta_producto_mes.reduce({}, :merge)

    #***************************
  
    vta_diaria_total = "SELECT to_char(date_trunc('day', CAST(create_date_order AS DATE)), 'YYYY-MM-DD') AS date , sum(price_subtotal_incl) FROM tablon_mes WHERE id_centro=#{@id_centro} GROUP BY date ORDER BY date "
    @array_vta_diaria_total = ActiveRecord::Base.connection.execute(vta_diaria_total).to_a 
    @vta_diaria_total = @array_vta_diaria_total.map{|a| {a["date"]=>a["sum"]}}
    @vta_diaria_total = @vta_diaria_total.reduce({}, :merge)

    #***************************

    vta_diaria_item = "SELECT name_template, to_char(date_trunc('day', CAST(create_date_order AS DATE)), 'YYYY-MM-DD') AS date , sum(price_subtotal_incl) FROM tablon_mes WHERE id_centro=#{@id_centro} GROUP BY name_template,date ORDER BY name_template "
    @array_vta_diaria_item = ActiveRecord::Base.connection.execute(vta_diaria_item).to_a 
    @vta_diaria_item = @array_vta_diaria_item.map{|a| {[a["name_template"],a["date"]]=>a["sum"]}}
    @vta_diaria_item = @vta_diaria_item.reduce({}, :merge)

    #***************************

    vta_anual_item = "SELECT name_template, to_char(date_trunc('month', CAST(create_date_order AS DATE)), 'YYYY-MM-DD') AS date , sum(price_subtotal_incl) FROM tablon2_anual WHERE id_centro=#{@id_centro} AND CAST(create_date_order AS DATE) > date_trunc('month', CURRENT_DATE) - INTERVAL '13 months'  GROUP BY name_template,date ORDER BY name_template "
    @vta_anual_item = ActiveRecord::Base.connection.execute(vta_anual_item).to_a 
    @vta_anual_item = @vta_anual_item.map{|a| {[a["name_template"],a["date"]]=>a["sum"]}}
    @vta_anual_item = @vta_anual_item.reduce({}, :merge)

    #***************************

    vta_mes_anual = "SELECT to_char(date_trunc('day', CAST(create_date_order AS DATE)), 'DD') AS date, SUM(SUM(price_subtotal_incl)) OVER (ORDER BY to_char(date_trunc('day', CAST(create_date_order AS DATE)), 'DD') ASC) AS sum_of_no FROM tablon_mes WHERE  id_centro = #{@id_centro}  GROUP BY date ORDER BY date "   
    vta_mes_curso = ActiveRecord::Base.connection.execute(vta_mes_anual).to_a 
    vta_mes_curso = vta_mes_curso.map{|a| {["#{(Date.today).strftime("%Y-%m")}",a["date"]]=>a["sum_of_no"]}}
    vta_mes_curso = vta_mes_curso.reduce({}, :merge)
    if vta_mes_curso.count > 0
      last_value = vta_mes_curso.first[1]
      (1..Date.today.day).each do |dia|
        if vta_mes_curso.find.select{|key, hash| key == ["#{(Date.today).strftime("%Y-%m")}",format('%02d', dia)] }.present?
          last_value = vta_mes_curso.find.select{|key, hash| key == ["#{(Date.today).strftime("%Y-%m")}",format('%02d', dia)] }[0][1]
        else  
          vta_mes_curso[["#{(Date.today).strftime("%Y-%m")}",format('%02d', dia)]]=last_value
        end
      end
      vta_mes_curso=vta_mes_curso.sort.to_h
    end
    
    vta_mes_anual = "SELECT to_char(date_trunc('day', CAST(create_date_order AS DATE)), 'DD') AS date, SUM(SUM(price_subtotal_incl)) OVER (ORDER BY to_char(date_trunc('day', CAST(create_date_order AS DATE)), 'DD') ASC) AS sum_of_no FROM tablon2_anual WHERE to_char(CAST(create_date_order AS DATE), 'YYYY-MM') = '#{(Date.today-1.month).strftime("%Y-%m")}' AND id_centro = #{@id_centro}  GROUP BY date ORDER BY date "   
    vta_mes_enero = ActiveRecord::Base.connection.execute(vta_mes_anual).to_a 
    vta_mes_enero = vta_mes_enero.map{|a| {["#{(Date.today-1.month).strftime("%Y-%m")}",a["date"]]=>a["sum_of_no"]}}
    vta_mes_enero = vta_mes_enero.reduce({}, :merge)
    if vta_mes_enero.count > 0
      last_value = vta_mes_enero.first[1]
      (1..31).each do |dia|
        if vta_mes_enero.find.select{|key, hash| key == ["#{(Date.today-1.month).strftime("%Y-%m")}",format('%02d', dia)] }.present?
          last_value = vta_mes_enero.find.select{|key, hash| key == ["#{(Date.today-1.month).strftime("%Y-%m")}",format('%02d', dia)] }[0][1]
        else  
          vta_mes_enero[["#{(Date.today-1.month).strftime("%Y-%m")}",format('%02d', dia)]]=last_value
        end
      end
      vta_mes_enero=vta_mes_enero.sort.to_h
    end

    vta_mes_anual = "SELECT to_char(date_trunc('day', CAST(create_date_order AS DATE)), 'DD') AS date, SUM(SUM(price_subtotal_incl)) OVER (ORDER BY to_char(date_trunc('day', CAST(create_date_order AS DATE)), 'DD') ASC) AS sum_of_no FROM tablon2_anual WHERE to_char(CAST(create_date_order AS DATE), 'YYYY-MM') = '#{(Date.today-2.month).strftime("%Y-%m")}' AND id_centro = #{@id_centro}  GROUP BY date ORDER BY date "   
    vta_mes_febrero = ActiveRecord::Base.connection.execute(vta_mes_anual).to_a 
    vta_mes_febrero = vta_mes_febrero.map{|a| {["#{(Date.today-2.month).strftime("%Y-%m")}",a["date"]]=>a["sum_of_no"]}}
    vta_mes_febrero = vta_mes_febrero.reduce({}, :merge)
    if vta_mes_febrero.count > 0
      last_value = vta_mes_febrero.first[1]
      (1..31).each do |dia|
        if vta_mes_febrero.find.select{|key, hash| key == ["#{(Date.today-2.month).strftime("%Y-%m")}",format('%02d', dia)] }.present?
          last_value = vta_mes_febrero.find.select{|key, hash| key == ["#{(Date.today-2.month).strftime("%Y-%m")}",format('%02d', dia)] }[0][1]
        else  
          vta_mes_febrero[["#{(Date.today-2.month).strftime("%Y-%m")}",format('%02d', dia)]]=last_value
        end
      end
      vta_mes_febrero=vta_mes_febrero.sort.to_h
    end

    vta_mes_anual = "SELECT to_char(date_trunc('day', CAST(create_date_order AS DATE)), 'DD') AS date, SUM(SUM(price_subtotal_incl)) OVER (ORDER BY to_char(date_trunc('day', CAST(create_date_order AS DATE)), 'DD') ASC) AS sum_of_no FROM tablon2_anual WHERE to_char(CAST(create_date_order AS DATE), 'YYYY-MM') = '#{(Date.today-3.month).strftime("%Y-%m")}' AND id_centro = #{@id_centro}  GROUP BY date ORDER BY date "   
    vta_mes_marzo = ActiveRecord::Base.connection.execute(vta_mes_anual).to_a 
    vta_mes_marzo = vta_mes_marzo.map{|a| {["#{(Date.today-3.month).strftime("%Y-%m")}",a["date"]]=>a["sum_of_no"]}}
    vta_mes_marzo = vta_mes_marzo.reduce({}, :merge)
    if vta_mes_marzo.count > 0
      last_value = vta_mes_marzo.first[1]
      (1..31).each do |dia|
        if vta_mes_marzo.find.select{|key, hash| key == ["#{(Date.today-3.month).strftime("%Y-%m")}",format('%02d', dia)] }.present?
          last_value = vta_mes_marzo.find.select{|key, hash| key == ["#{(Date.today-3.month).strftime("%Y-%m")}",format('%02d', dia)] }[0][1]
        else  
          vta_mes_marzo[["#{(Date.today-3.month).strftime("%Y-%m")}",format('%02d', dia)]]=last_value
        end
      end
      
      vta_mes_marzo=vta_mes_marzo.sort.to_h
    end

    vta_mes_anual = "SELECT to_char(date_trunc('day', CAST(create_date_order AS DATE)), 'DD') AS date, SUM(SUM(price_subtotal_incl)) OVER (ORDER BY to_char(date_trunc('day', CAST(create_date_order AS DATE)), 'DD') ASC) AS sum_of_no FROM tablon2_anual WHERE to_char(CAST(create_date_order AS DATE), 'YYYY-MM') = '#{(Date.today-4.month).strftime("%Y-%m")}' AND id_centro = #{@id_centro}  GROUP BY date ORDER BY date "   
    vta_mes_abril = ActiveRecord::Base.connection.execute(vta_mes_anual).to_a 
    vta_mes_abril = vta_mes_abril.map{|a| {["#{(Date.today-4.month).strftime("%Y-%m")}",a["date"]]=>a["sum_of_no"]}}
    vta_mes_abril = vta_mes_abril.reduce({}, :merge)

    if vta_mes_abril.count > 0
      last_value = vta_mes_abril.first[1]
      (1..31).each do |dia|
        if vta_mes_abril.find.select{|key, hash| key == ["#{(Date.today-4.month).strftime("%Y-%m")}",format('%02d', dia)] }.present?
          last_value = vta_mes_abril.find.select{|key, hash| key == ["#{(Date.today-4.month).strftime("%Y-%m")}",format('%02d', dia)] }[0][1]
        else  
          vta_mes_abril[["#{(Date.today-4.month).strftime("%Y-%m")}",format('%02d', dia)]]=last_value
        end
      end
      vta_mes_abril=vta_mes_abril.sort.to_h
    end  

    vta_mes_anual = "SELECT to_char(date_trunc('day', CAST(create_date_order AS DATE)), 'DD') AS date, SUM(SUM(price_subtotal_incl)) OVER (ORDER BY to_char(date_trunc('day', CAST(create_date_order AS DATE)), 'DD') ASC) AS sum_of_no FROM tablon2_anual WHERE to_char(CAST(create_date_order AS DATE), 'YYYY-MM') = '#{(Date.today-5.month).strftime("%Y-%m")}' AND id_centro = #{@id_centro}  GROUP BY date ORDER BY date "   
    vta_mes_mayo = ActiveRecord::Base.connection.execute(vta_mes_anual).to_a 
    vta_mes_mayo = vta_mes_mayo.map{|a| {["#{(Date.today-5.month).strftime("%Y-%m")}",a["date"]]=>a["sum_of_no"]}}
    vta_mes_mayo = vta_mes_mayo.reduce({}, :merge)
    if vta_mes_mayo.count > 0
      last_value = vta_mes_mayo.first[1]
      (1..31).each do |dia|
        if vta_mes_mayo.find.select{|key, hash| key == ["#{(Date.today-5.month).strftime("%Y-%m")}",format('%02d', dia)] }.present?
          last_value = vta_mes_mayo.find.select{|key, hash| key == ["#{(Date.today-5.month).strftime("%Y-%m")}",format('%02d', dia)] }[0][1]
        else  
          vta_mes_mayo[["#{(Date.today-5.month).strftime("%Y-%m")}",format('%02d', dia)]]=last_value
        end
      end
      vta_mes_mayo=vta_mes_mayo.sort.to_h
    end  

    vta_mes_anual = "SELECT to_char(date_trunc('day', CAST(create_date_order AS DATE)), 'DD') AS date, SUM(SUM(price_subtotal_incl)) OVER (ORDER BY to_char(date_trunc('day', CAST(create_date_order AS DATE)), 'DD') ASC) AS sum_of_no FROM tablon2_anual WHERE to_char(CAST(create_date_order AS DATE), 'YYYY-MM') = '#{(Date.today-6.month).strftime("%Y-%m")}' AND id_centro = #{@id_centro} GROUP BY date ORDER BY date "   
    vta_mes_junio = ActiveRecord::Base.connection.execute(vta_mes_anual).to_a 
    vta_mes_junio = vta_mes_junio.map{|a| {["#{(Date.today-6.month).strftime("%Y-%m")}",a["date"]]=>a["sum_of_no"]}}
    vta_mes_junio = vta_mes_junio.reduce({}, :merge)
    if vta_mes_junio.count > 0
      last_value = vta_mes_junio.first[1]
      (1..31).each do |dia|
        if vta_mes_junio.find.select{|key, hash| key == ["#{(Date.today-6.month).strftime("%Y-%m")}",format('%02d', dia)] }.present?
          last_value = vta_mes_junio.find.select{|key, hash| key == ["#{(Date.today-6.month).strftime("%Y-%m")}",format('%02d', dia)] }[0][1]
        else  
          vta_mes_junio[["#{(Date.today-6.month).strftime("%Y-%m")}",format('%02d', dia)]]=last_value
        end
      end
      vta_mes_junio=vta_mes_junio.sort.to_h
    end  

    vta_mes_anual = "SELECT to_char(date_trunc('day', CAST(create_date_order AS DATE)), 'DD') AS date, SUM(SUM(price_subtotal_incl)) OVER (ORDER BY to_char(date_trunc('day', CAST(create_date_order AS DATE)), 'DD') ASC) AS sum_of_no FROM tablon2_anual WHERE to_char(CAST(create_date_order AS DATE), 'YYYY-MM') = '#{(Date.today-7.month).strftime("%Y-%m")}' AND id_centro = #{@id_centro}  GROUP BY date ORDER BY date "   
    vta_mes_julio = ActiveRecord::Base.connection.execute(vta_mes_anual).to_a 
    vta_mes_julio = vta_mes_julio.map{|a| {["#{(Date.today-7.month).strftime("%Y-%m")}",a["date"]]=>a["sum_of_no"]}}
    vta_mes_julio = vta_mes_julio.reduce({}, :merge)
    if vta_mes_julio.count > 0
    last_value = vta_mes_julio.first[1]
      (1..31).each do |dia|
        if vta_mes_julio.find.select{|key, hash| key == ["#{(Date.today-7.month).strftime("%Y-%m")}",format('%02d', dia)] }.present?
          last_value = vta_mes_julio.find.select{|key, hash| key == ["#{(Date.today-7.month).strftime("%Y-%m")}",format('%02d', dia)] }[0][1]
        else  
          vta_mes_julio[["#{(Date.today-7.month).strftime("%Y-%m")}",format('%02d', dia)]]=last_value
        end
      end
      vta_mes_julio=vta_mes_julio.sort.to_h
    end

    vta_mes_anual = "SELECT to_char(date_trunc('day', CAST(create_date_order AS DATE)), 'DD') AS date, SUM(SUM(price_subtotal_incl)) OVER (ORDER BY to_char(date_trunc('day', CAST(create_date_order AS DATE)), 'DD') ASC) AS sum_of_no FROM tablon2_anual WHERE to_char(CAST(create_date_order AS DATE), 'YYYY-MM') = '#{(Date.today-8.month).strftime("%Y-%m")}' AND id_centro = #{@id_centro}  GROUP BY date ORDER BY date "   
    vta_mes_agosto = ActiveRecord::Base.connection.execute(vta_mes_anual).to_a 
    vta_mes_agosto = vta_mes_agosto.map{|a| {["#{(Date.today-8.month).strftime("%Y-%m")}",a["date"]]=>a["sum_of_no"]}}
    vta_mes_agosto = vta_mes_agosto.reduce({}, :merge)
    if vta_mes_agosto.count > 0
    last_value = vta_mes_agosto.first[1]
      (1..31).each do |dia|
        if vta_mes_agosto.find.select{|key, hash| key == ["#{(Date.today-8.month).strftime("%Y-%m")}",format('%02d', dia)] }.present?
          last_value = vta_mes_agosto.find.select{|key, hash| key == ["#{(Date.today-8.month).strftime("%Y-%m")}",format('%02d', dia)] }[0][1]
        else  
          vta_mes_agosto[["#{(Date.today-8.month).strftime("%Y-%m")}",format('%02d', dia)]]=last_value
        end
      end
      vta_mes_agosto=vta_mes_agosto.sort.to_h
    end  

    vta_mes_anual = "SELECT to_char(date_trunc('day', CAST(create_date_order AS DATE)), 'DD') AS date, SUM(SUM(price_subtotal_incl)) OVER (ORDER BY to_char(date_trunc('day', CAST(create_date_order AS DATE)), 'DD') ASC) AS sum_of_no FROM tablon2_anual WHERE to_char(CAST(create_date_order AS DATE), 'YYYY-MM') = '#{(Date.today-9.month).strftime("%Y-%m")}' AND id_centro = #{@id_centro}  GROUP BY date ORDER BY date "   
    vta_mes_sept = ActiveRecord::Base.connection.execute(vta_mes_anual).to_a 
    vta_mes_sept = vta_mes_sept.map{|a| {["#{(Date.today-9.month).strftime("%Y-%m")}",a["date"]]=>a["sum_of_no"]}}
    vta_mes_sept = vta_mes_sept.reduce({}, :merge)
    if vta_mes_sept.count > 0
      last_value = vta_mes_sept.first[1]
      (1..31).each do |dia|
        if vta_mes_sept.find.select{|key, hash| key == ["#{(Date.today-9.month).strftime("%Y-%m")}",format('%02d', dia)] }.present?
          last_value = vta_mes_sept.find.select{|key, hash| key == ["#{(Date.today-9.month).strftime("%Y-%m")}",format('%02d', dia)] }[0][1]
        else  
          vta_mes_sept[["#{(Date.today-9.month).strftime("%Y-%m")}",format('%02d', dia)]]=last_value
        end
      end
      vta_mes_sept=vta_mes_sept.sort.to_h
    end
      
    vta_mes_anual = "SELECT to_char(date_trunc('day', CAST(create_date_order AS DATE)), 'DD') AS date, SUM(SUM(price_subtotal_incl)) OVER (ORDER BY to_char(date_trunc('day', CAST(create_date_order AS DATE)), 'DD') ASC) AS sum_of_no FROM tablon2_anual WHERE to_char(CAST(create_date_order AS DATE), 'YYYY-MM') = '#{(Date.today-10.month).strftime("%Y-%m")}' AND id_centro = #{@id_centro}  GROUP BY date ORDER BY date "   
    vta_mes_oct = ActiveRecord::Base.connection.execute(vta_mes_anual).to_a 
    vta_mes_oct = vta_mes_oct.map{|a| {["#{(Date.today-10.month).strftime("%Y-%m")}",a["date"]]=>a["sum_of_no"]}}
    vta_mes_oct = vta_mes_oct.reduce({}, :merge)
    if vta_mes_oct.count > 0
      last_value = vta_mes_oct.first[1]
      (1..31).each do |dia|
        if vta_mes_oct.find.select{|key, hash| key == ["#{(Date.today-10.month).strftime("%Y-%m")}",format('%02d', dia)] }.present?
          last_value = vta_mes_oct.find.select{|key, hash| key == ["#{(Date.today-10.month).strftime("%Y-%m")}",format('%02d', dia)] }[0][1]
        else  
          vta_mes_oct[["#{(Date.today-10.month).strftime("%Y-%m")}",format('%02d', dia)]]=last_value
        end
      end
      vta_mes_oct=vta_mes_oct.sort.to_h
    end  

    vta_mes_anual = "SELECT to_char(date_trunc('day', CAST(create_date_order AS DATE)), 'DD') AS date, SUM(SUM(price_subtotal_incl)) OVER (ORDER BY to_char(date_trunc('day', CAST(create_date_order AS DATE)), 'DD') ASC) AS sum_of_no FROM tablon2_anual WHERE to_char(CAST(create_date_order AS DATE), 'YYYY-MM') = '#{(Date.today-11.month).strftime("%Y-%m")}' AND id_centro = #{@id_centro}  GROUP BY date ORDER BY date "   
    vta_mes_nov = ActiveRecord::Base.connection.execute(vta_mes_anual).to_a 
    vta_mes_nov = vta_mes_nov.map{|a| {["#{(Date.today-11.month).strftime("%Y-%m")}",a["date"]]=>a["sum_of_no"]}}
    vta_mes_nov = vta_mes_nov.reduce({}, :merge)
    if vta_mes_nov.count > 0
      last_value = vta_mes_nov.first[1]
      (1..31).each do |dia|
        if vta_mes_nov.find.select{|key, hash| key == ["#{(Date.today-11.month).strftime("%Y-%m")}",format('%02d', dia)] }.present?
          last_value = vta_mes_nov.find.select{|key, hash| key == ["#{(Date.today-11.month).strftime("%Y-%m")}",format('%02d', dia)] }[0][1]
        else  
          vta_mes_nov[["#{(Date.today-11.month).strftime("%Y-%m")}",format('%02d', dia)]]=last_value
        end
      end
      vta_mes_nov=vta_mes_nov.sort.to_h
    end

    vta_mes_anual = "SELECT to_char(date_trunc('day', CAST(create_date_order AS DATE)), 'DD') AS date, SUM(SUM(price_subtotal_incl)) OVER (ORDER BY to_char(date_trunc('day', CAST(create_date_order AS DATE)), 'DD') ASC) AS sum_of_no FROM tablon2_anual WHERE to_char(CAST(create_date_order AS DATE), 'YYYY-MM') = '#{(Date.today-12.month).strftime("%Y-%m")}' AND id_centro = #{@id_centro}  GROUP BY date ORDER BY date "   
    vta_mes_dic = ActiveRecord::Base.connection.execute(vta_mes_anual).to_a 
    vta_mes_dic = vta_mes_dic.map{|a| {["#{(Date.today-12.month).strftime("%Y-%m")}",a["date"]]=>a["sum_of_no"]}}
    vta_mes_dic = vta_mes_dic.reduce({}, :merge)
    if vta_mes_dic.count > 0
      last_value = vta_mes_dic.first[1]
      (1..31).each do |dia|
        if vta_mes_dic.find.select{|key, hash| key == ["#{(Date.today-12.month).strftime("%Y-%m")}",format('%02d', dia)] }.present?
          last_value = vta_mes_dic.find.select{|key, hash| key == ["#{(Date.today-12.month).strftime("%Y-%m")}",format('%02d', dia)] }[0][1]
        else  
          vta_mes_dic[["#{(Date.today-12.month).strftime("%Y-%m")}",format('%02d', dia)]]=last_value
        end
      end
      vta_mes_dic=vta_mes_dic.sort.to_h
    end  

    vta_mes_anual = "SELECT to_char(date_trunc('day', CAST(create_date_order AS DATE)), 'DD') AS date, SUM(SUM(price_subtotal_incl)) OVER (ORDER BY to_char(date_trunc('day', CAST(create_date_order AS DATE)), 'DD') ASC) AS sum_of_no FROM tablon2_anual WHERE to_char(CAST(create_date_order AS DATE), 'YYYY-MM') = '#{(Date.today-13.month).strftime("%Y-%m")}' AND id_centro = #{@id_centro}  GROUP BY date ORDER BY date "   
    vta_mes_dic2 = ActiveRecord::Base.connection.execute(vta_mes_anual).to_a 
    vta_mes_dic2 = vta_mes_dic2.map{|a| {["#{(Date.today-13.month).strftime("%Y-%m")}",a["date"]]=>a["sum_of_no"]}}
    vta_mes_dic2 = vta_mes_dic2.reduce({}, :merge)
    if vta_mes_dic2.count > 0
      last_value = vta_mes_dic2.first[1]
      (1..31).each do |dia|
        if vta_mes_dic2.find.select{|key, hash| key == ["#{(Date.today-12.month).strftime("%Y-%m")}",format('%02d', dia)] }.present?
          last_value = vta_mes_dic2.find.select{|key, hash| key == ["#{(Date.today-13.month).strftime("%Y-%m")}",format('%02d', dia)] }[0][1]
        else  
          vta_mes_dic2[["#{(Date.today-13.month).strftime("%Y-%m")}",format('%02d', dia)]]=last_value
        end
      end
      vta_mes_dic2=vta_mes_dic2.sort.to_h
    end  

    @vta_mes_anual = vta_mes_curso.merge(vta_mes_enero).merge(vta_mes_febrero).merge(vta_mes_marzo).merge(vta_mes_abril).merge(vta_mes_mayo).merge(vta_mes_junio).merge(vta_mes_julio).merge(vta_mes_agosto).merge(vta_mes_sept).merge(vta_mes_oct).merge(vta_mes_nov).merge(vta_mes_dic).merge(vta_mes_dic2)
    @vta_mes_comp = vta_mes_curso.merge(vta_mes_dic)




    #***************************


    boletas_anual = "SELECT  to_char(date_trunc('month', CAST(create_date_order AS DATE)), 'YYYY-MM-DD') AS date , count(*) AS sum FROM tablon2_anual WHERE id_centro=#{@id_centro} AND CAST(create_date_order AS DATE) > date_trunc('month', CURRENT_DATE) - INTERVAL '13 months' GROUP BY date ORDER BY date"
    @array_boletas_anual = ActiveRecord::Base.connection.execute(boletas_anual).to_a 
    @boletas_anual = @array_boletas_anual.map{|a| {a["date"]=>a["sum"]}}
    @boletas_anual = @boletas_anual.reduce({}, :merge)

    #***************************


    vta_anual = "SELECT  to_char(date_trunc('month', CAST(create_date_order AS DATE)), 'YYYY-MM-DD') AS date , sum(price_subtotal_incl) FROM tablon2_anual WHERE id_centro=#{@id_centro} AND CAST(create_date_order AS DATE) > date_trunc('month', CURRENT_DATE) - INTERVAL '13 months' GROUP BY date ORDER BY date"
    @array_vta_anual = ActiveRecord::Base.connection.execute(vta_anual).to_a 
    @vta_anual = @array_vta_anual.map{|a| {a["date"]=>a["sum"]}}
    @vta_anual = @vta_anual.reduce({}, :merge)

    #**************************

    vta_origen_anual = " SELECT   CASE WHEN login='Cupones' THEN 'Cupones' WHEN login='cupon' THEN 'Cupones' WHEN login='cupones'  THEN 'Cupones' ELSE 'Kines' END AS vta_origen, to_char(date_trunc('month', CAST(create_date_order AS DATE)), 'YYYY-MM-DD') AS date , sum(price_subtotal_incl) FROM tablon2_anual WHERE id_centro=#{@id_centro} AND CAST(create_date_order AS DATE) > date_trunc('month', CURRENT_DATE) - INTERVAL '13 months'  GROUP BY vta_origen, date"
    @array_vta_origen_anual = ActiveRecord::Base.connection.execute(vta_origen_anual).to_a 
    @vta_origen_anual = @array_vta_origen_anual.map{|a| {[a["vta_origen"],a["date"]]=>a["sum"]}}
    @vta_origen_anual = @vta_origen_anual.reduce({}, :merge)


    #*********** ticket promedio ***************

    ticket_prom_anual = " SELECT   to_char(date_trunc('month', CAST(create_date_order AS DATE)), 'YYYY-MM-DD') AS date , sum(price_subtotal_incl), count(*) FROM tablon2_anual WHERE id_centro=#{@id_centro} AND CAST(create_date_order AS DATE) > date_trunc('month', CURRENT_DATE) - INTERVAL '13 months'  GROUP BY date"
    @array_ticket_prom_anual = ActiveRecord::Base.connection.execute(ticket_prom_anual).to_a 
    @ticket_prom_anual = @array_ticket_prom_anual.map{|a| {["Todos",a["date"]]=>(a["sum"].to_f/a["count"].to_f)}}
    @ticket_prom_anual = @ticket_prom_anual.reduce({}, :merge)

    #**************************

    vta_origen_anual2 = " SELECT upper(login) AS vta_origen, to_char(date_trunc('month', CAST(create_date_order AS DATE)), 'YYYY-MM') AS date , sum(price_subtotal_incl) FROM tablon2_anual WHERE login<>'cupones' AND login<>'cupon' AND id_centro=#{@id_centro} AND CAST(create_date_order AS DATE) > date_trunc('month', CURRENT_DATE) - INTERVAL '1 months' GROUP BY vta_origen, date ORDER BY date, vta_origen"
    @array_vta_origen_anual2 = ActiveRecord::Base.connection.execute(vta_origen_anual2).to_a   
    @vta_origen_anual2 = @array_vta_origen_anual2.map{|a| {[a["vta_origen"],a["date"]]=>a["sum"]}}

    if (@rut_centro != '76779547-5') && (@rut_centro!= '76.779.397-9') && (@rut_centro != '76.827.773-7') && (@rut_centro != '76.790.505-k')
      f = @vta_origen_anual2.first
      @vta_origen_anual2.delete(f)
    end

    @vta_origen_anual2 = @vta_origen_anual2.reduce({}, :merge)
    

  end
end

