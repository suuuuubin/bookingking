class MainController < ApplicationController
  def index
    @num = Shop.last
    
    @recommend = Shop.where(id: (1+Random.rand(@num.id)))
    @today= Shop.where(id: Date.today.mday%(@num.id))
  end

  def shop
    @name = params[:s_name]

    @shop_info = Shop.where(shop_name: @name).take

    if @shop_info.category ==1
      @category ="한식"
    elsif @shop_info.category ==2
      @category ="중식"
    elsif @shop_info.category ==3
      @category ="양식"
    elsif @shop_info.category ==4
      @category ="일식"
    elsif @shop_info.category ==5
      @category ="술집"
    end
    
    @shop_info.tables.each do |t|
      
      if t.book_at.nil? or (t.book_end.to_time < (Time.zone.now).to_time) or t.bookings.count==0
        t.table_state=0
      elsif (  t.book_at.to_time) and ((Time.zone.now).to_time < t.book_end.to_time)
        t.table_state=2
      else
        t.table_state=1
      end
      
      t.save  
    end
  
  end
  
  def list
    if params[:category] == nil
      @select=params[:select_type]
    else
      @select=params[:category]
    end
    
    if @select=='0' or @select == nil
      @choice = Shop.all.order('seat_number DESC')
    else
      @choice = Shop.where(category: @select).order('seat_number DESC')
    end

    @choice.each do |c|
      c.seat_number=0;
      
      c.tables.each do |t|
          if t.table_state == 0 or t.table_state == 1
            c.seat_number= c.seat_number + t.table_size
          end
      end
      c.save
    end
    
  end
  
  
  def book
    @name = params[:s_name]
    @shop_info = Shop.where(shop_name: @name).take
    
    @booking_list = Booking.where(user_id: current_user.id, shop_id: @shop_info.id)
  end
  
  def book_save
    totalprice=0
    current_shop = Shop.where(shop_name: params[:s_name]).take
    
    if user_signed_in?
      @new_book = Booking.new
      @new_book.user_id = current_user.id
      @new_book.shop_id = current_shop.id
      @new_book.table_id = current_shop.tables[params[:select_seat].to_i-1].id
      @new_book.table_num=params[:select_seat]
      
      current_shop.menus.each do |m|
        id="menu"
        id << m.id.to_s
        prices=params[id].to_i * m.price
        totalprice+=prices
        
        if params[id].to_i > 0
          @new_book.dish.push("메뉴명 : #{m.menu_name} 수량 : #{params[id]} 가격 : #{prices}")
        end
     end
     
      @new_book.price=totalprice
      @new_book.book_at=params[:book_at].to_time
      @new_book.book_end=params[:book_end].to_time
  
      @new_book.save
      
      redirect_to "/book/#{URI::encode(params[:s_name].to_s)}"
    else
      redirect_to '/users/sign_in'
    end

  end
  
  def test
    # authorize! :test, @num

    @shop = Shop.find(6)
    
  end


  def search
    @search = Shop.where("#{params[:search_type]} LIKE ?", "%#{params[:feature]}%").order('seat_number DESC')
    
     @search.each do |c|
      c.seat_number=0;
      
      c.tables.each do |t|
          if t.table_state == 0 or t.table_state == 1
            c.seat_number= c.seat_number + t.table_size
          end
      end
      c.save
    end
  end

end