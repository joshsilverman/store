require 'net/http'
require 'uri'

class Questionbase  
  def self.get_studyeggs(eggs)
    egg_ids = eggs.join("+")
    url = URI.parse(STUDYEGG_QUESTIONS_PATH+"/api-V1/get_books/#{egg_ids}.json")
    req = Net::HTTP::Get.new(url.path)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    begin
      studyeggs = JSON.parse(res.body)
    rescue
      studyeggs=[]
    end
    
    return studyeggs
  end
  
  def self.get_studyegg_details(egg_id)
    url = URI.parse(STUDYEGG_QUESTIONS_PATH+'/api-V1/get_book_details/'+egg_id+'.json')
    req = Net::HTTP::Get.new(url.path)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    begin
      studyegg = JSON.parse(res.body)
    rescue
      studyegg=nil
    end
    
    return studyegg
  end
  
  def self.get_lessons(lessons)
    lesson_ids = lessons.join("+")
    url = URI.parse(STUDYEGG_QUESTIONS_PATH+"/api-V1/get_lessons/#{lesson_ids}.json")
    req = Net::HTTP::Get.new(url.path)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    begin
      studyeggs = JSON.parse(res.body)
    rescue
      studyeggs=[]
    end
    return studyeggs
  end
  
  def self.get_public
    url = URI.parse(STUDYEGG_QUESTIONS_PATH+"/api-V1/get_public.json")
    req = Net::HTTP::Get.new(url.path)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    begin
      studyeggs = JSON.parse(res.body)
    rescue
      studyeggs=[]
    end
    return studyeggs
  end
end