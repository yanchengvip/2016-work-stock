json.status 'ok'
@hot_keyword_names = []
@keyword_search_histories = current_user.keyword_search_histories.where(IsDeleted: false).map{|keyword| keyword.KeyWordName}.uniq
@keywords.KeyWordName.to_s.split(/[,，]/).each do |text|
  @hot_keyword_names << text
end
json.hot_keyword_names @hot_keyword_names
json.keyword_search_histories @keyword_search_histories


