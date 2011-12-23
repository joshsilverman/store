class StoreController < ApplicationController
  before_filter :login_required, :except => ["index"]
  def index
    eggs = Studyegg.select(:id).collect(&:id)
    @studyeggs = Questionbase.get_studyeggs(eggs)

    @studyeggs.each do |s|
      egg = Studyegg.find_by_qb_studyegg_id(s['id'])
      lesson_price = Lesson.find_by_id(s['chapters'][0]['id']).price
      s['rating'] = egg.total_score*1.0/egg.number_of_rates
      if egg.price == 0
        s['price'] = "Free"
      else
        s['price'] = "$"+sprintf("%.2f", egg.price*1.0/100).to_s
      end
      
      if lesson_price == 0
        s['lesson_price'] = "Free"
      else
        s['lesson_price'] = "$"+sprintf("%.2f", lesson_price*1.0/100).to_s
      end
    end
    puts "THIS IS WHAT WE GOT BACK: #{@studyeggs[0]}"
  end

  def egg_details
    @studyegg = Questionbase.get_studyegg_details(params[:id])
    egg = Studyegg.find_by_qb_studyegg_id(@studyegg['id'])
    
    if egg.price == 0
      @studyegg['price'] = "Free"
    else
      @studyegg['price'] = "$"+sprintf("%.2f", egg.price*1.0/100).to_s
    end
    @studyegg['rating'] = egg.total_score*1.0/egg.number_of_rates
    
    @studyegg['chapters'].each do |ch|
      lesson_price = Lesson.find_by_id(ch['id']).price
      if lesson_price == 0
        ch['lesson_price'] = "Free"
      else
        ch['lesson_price'] = "$"+sprintf("%.2f", lesson_price*1.0/100).to_s
      end
    end
  end
  
  def search
    q = params[:q]
    query = #search API call to qb
    render :text => query
  end
  
  def publish
    @studyegg = Questionbase.get_publishable()
    
  end
end
