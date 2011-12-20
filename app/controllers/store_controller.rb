require 'net/http'
require 'uri'

class StoreController < ApplicationController
  before_filter :login_required, :except => ["index"]
  def index
    eggs = Studyegg.select(:id).collect(&:id).join("+")
    begin
      url = URI.parse(STUDYEGG_QUESTIONS_PATH+"/api-V1/get_books/#{eggs}.json")
      req = Net::HTTP::Get.new(url.path)
      res = Net::HTTP.start(url.host, url.port) {|http|
        http.request(req)
      }
    rescue
      @studyeggs=nil
    end
    @studyeggs = JSON.parse(res.body)
    @studyeggs.each do |s|
      egg = Studyegg.find_by_qb_studyegg_id(s['book']['id'])
      lesson_price = Lesson.find_by_id(s['book']['chapters'][0]['chapter']['id']).price
      s['book']['rating'] = egg.total_score*1.0/egg.number_of_rates
      if egg.price == 0
        s['book']['price'] = "Free"
      else
        s['book']['price'] = "$"+sprintf("%.2f", egg.price*1.0/100).to_s
      end
      
      if lesson_price == 0
        s['book']['lesson_price'] = "Free"
      else
        s['book']['lesson_price'] = "$"+sprintf("%.2f", lesson_price*1.0/100).to_s
      end
    end
    puts "THIS IS WHAT WE GOT BACK: #{@studyeggs[0]}"
  end

  def egg_details
    url = URI.parse(STUDYEGG_QUESTIONS_PATH+'/api-V1/get_book_details/'+params[:id]+'.json')
    req = Net::HTTP::Get.new(url.path)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    puts res.body
    @studyegg = JSON.parse(res.body)
    egg = Studyegg.find_by_qb_studyegg_id(@studyegg['book']['id'])
    
    if egg.price == 0
      @studyegg['book']['price'] = "Free"
    else
      @studyegg['book']['price'] = "$"+sprintf("%.2f", egg.price*1.0/100).to_s
    end
    @studyegg['book']['rating'] = egg.total_score*1.0/egg.number_of_rates
    
    @studyegg['book']['chapters'].each do |ch|
      lesson_price = Lesson.find_by_id(ch['chapter']['id']).price
      if lesson_price == 0
        ch['chapter']['lesson_price'] = "Free"
      else
        ch['chapter']['lesson_price'] = "$"+sprintf("%.2f", lesson_price*1.0/100).to_s
      end
    end
  end
  
  def search
    q = params[:q]
    query = Tag.joins(:documents).select(['tags.*', 'MIN(documents.price) as doc_price']).where("(tags.name LIKE ? OR documents.name LIKE ?)", '%'+q+'%', '%'+q+'%').group('tags.id').limit(50)
    query = query.to_json()
    render :text => query
  end
end
