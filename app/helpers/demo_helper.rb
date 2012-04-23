module DemoHelper
  USERS = %W( Adriana Joe Sherry Thomas )
  WORDS = %W( even in the quietest moments )
  WORD_LIST_TITLE = "April Demo"
  
  def load_demo_apr_2012
    wl = WordList.new do |wl|
      wl.title = WORD_LIST_TITLE
      wl.due_date = "2012-04-30"
    end
    WORDS.inject(0) do |i, w|
      wl.list_items.build do |li| 
        li.word = w
        li.word_order = i
      end
      i + 1
    end 
    wl.save!
    
    users = {}
    USERS.each do |name|
      users[name] = User.create do |u|
        u.name = name
      end
      
      users[name].assignments.create do |a|
        a.word_list_id = wl.id
      end
    end
  end 
  
  def unload_demo_apr_2012 
    wl = WordList.find_by_title(WORD_LIST_TITLE)
    wl.list_items.destroy if wl && wl.list_items
    wl.destroy if wl
    
    USERS.each do |name|
      u = User.find_by_name(name)
      if u
        u.assignments.each do |a|
          a.destroy
        end
        u.destroy 
      end
    end
  end
end 

