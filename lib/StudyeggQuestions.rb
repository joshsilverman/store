include 'rubygems'
include 'httparty'

class StudyeggQuestions
  include HTTParty

  base_uri STUDYEGG_QUESTION_PATH

  def self.getPublished
    #return get('/apiV1/getPublished')
    return get('/books.json')
  end
end