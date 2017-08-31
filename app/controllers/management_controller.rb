class ManagementController < ApplicationController
    # 로그인 되었을때만 booklist 접근 가능
    before_action :authenticate_user!, only: [:booklist, :buylist]
    
    def booklist
        # @customer = Shop.where(shop_name: params[:shop_name])
        if Shop.where(shop_name: params[:shop_name]).take.user_id == current_user.id
            @ex = Booking.where(shop_id: current_user.id)
        else
            flash[:notice]="접근 권한이 없습니다."
            redirect_to '/'
        end
        
        @ex.each do |b|
            if b.book_end < Time.zone.now
                b.destroy
            end
        end
        
        # authorize! :manage, @ex
    end
    
    def buylist
        if User.where(name: params[:user_name]).take.name == current_user.name
            @list=Booking.where(user_id: current_user.id)
        else
            flash[:notice]="접근 권한이 없습니다."
            redirect_to '/'
        end
    end
    
    def nonmember
        @name = params[:name]
        
        @userinfo = User.where(email: @name).take.name
    end

    def check
        checkBook = Booking.find(params[:shop_id])
        temp = Shop.find(checkBook.shop_id).shop_name

        checkBook.checked =true
        checkBook.save
        
        bookedtable = Table.find(checkBook.table_id)
        
        if bookedtable.book_at.nil?
            bookedtable.book_at = checkBook.book_at
            bookedtable.book_end = checkBook.book_end
        else
            if bookedtable.book_at > checkBook.book_at
                bookedtable.book_at = checkBook.book_at
                bookedtable.book_end = checkBook.book_end  
            end
        end
        bookedtable.save
        
        Post.create(sender_shop: temp,
                    receiver_id: checkBook.user_id,
                    title: "#{temp.to_s}님이 보낸 메세지 입니다.",
                    content: "#{temp.to_s} 가게에서 #{checkBook.book_at.to_time.strftime("%m월 %d일 %H시 %M분")}에서 #{checkBook.book_end.to_time.strftime("%m월 %d일 %H시 %M분")}시간 까지 예약이 완료되었습니다. 제 시간에 맞게 도착해 주시기 바랍니다.",
                    checked: false
                    )
        
        redirect_to "/booklist/#{URI::encode(temp.to_s)}"
    end
    
    def delete
        deleteBook = Booking.find(params[:shop_id])
        temp = Shop.find(deleteBook.shop_id).shop_name
        deleteBook.destroy
               
        Post.create(sender_shop: Shop.find(params[:shop_id]).shop_name,
                    receiver_id: deleteBook.user_id,
                    title: "#{Shop.find(params[:shop_id]).shop_name}님이 보낸 메세지 입니다.",
                    content: "예약취소", checked: false
                    )
        redirect_to "/booklist/#{URI::encode(temp.to_s)}"
    end
end
