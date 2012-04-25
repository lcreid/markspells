module DemoHelper
  USERS = %W( Adriana Joe Sherry Thomas )
  WORDS = %W( even in the quietest moments )
  WORD_LIST_TITLE = "April Demo"
  
  def create_practice_sessions(user, word_list, n, start_time_string, duration = 20, time_increment = 24)
    start_time = Time.new(start_time_string)
    1.upto(n) do |i|
      user.practice_sessions.create(:start_time => start_time, :end_time => start_time + duration.seconds, 
        :word_list_id => word_list.id, :user_id => user.id)
      start_time += time_increment.hours
      user
    end
  end 
  
  def create_student_response(word, response, ps, duration = 20)
    if ps.student_responses.empty? then
      start_time = ps.start_time
    else
      sr = ps.student_responses.max_by { |sr| sr.end_time }
      start_time = sr.end_time
    end
#    puts word.word, response, start_time.to_s, (start_time + duration.seconds).to_s
    ps.student_responses.create(:word => word.word, :word_id => word.id, :student_response => response,
      :start_time => start_time, :end_time => start_time + duration.seconds,
      :user_id => ps.user_id)
  end
  
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
    
    words = wl.list_items
    
    create_practice_sessions(users['Joe'], wl, 3, '2012-04-22 10:44.23', 15)
    ps = users['Joe'].practice_sessions[0]
    create_student_response(words[0], 'eve', ps, 20)
    create_student_response(words[0], 'evan', ps, 20)
    create_student_response(words[0], 'even', ps, 20)
    create_student_response(words[1], 'in', ps, 20)
    create_student_response(words[2], 'the', ps, 20)
    create_student_response(words[3], 'quitest', ps, 20)
    create_student_response(words[3], 'quaytest', ps, 20)
    create_student_response(words[3], 'quite', ps, 20)
    create_student_response(words[3], 'quietest', ps, 20)
    create_student_response(words[4], 'moments', ps, 20)

    ps = users['Joe'].practice_sessions[1]
    create_student_response(words[0], 'eve', ps, 20)
    create_student_response(words[0], 'evan', ps, 20)
    create_student_response(words[0], 'even', ps, 20)
    create_student_response(words[1], 'in', ps, 20)
    create_student_response(words[2], 'the', ps, 20)
    create_student_response(words[3], 'quitest', ps, 20)
    create_student_response(words[3], 'quaytest', ps, 20)
    create_student_response(words[3], 'quite', ps, 20)
    create_student_response(words[3], 'quietest', ps, 20)
    create_student_response(words[4], 'moments', ps, 20)

    ps = users['Joe'].practice_sessions[2]
    create_student_response(words[0], 'even', ps, 20)
    create_student_response(words[1], 'in', ps, 20)
    create_student_response(words[2], 'the', ps, 20)
    create_student_response(words[3], 'quitest', ps, 20)
    create_student_response(words[3], 'quietest', ps, 20)
    create_student_response(words[4], 'moments', ps, 20)


    create_practice_sessions(users['Adriana'], wl, 2, '2012-04-22 10:44.23', 25)

    ps = users['Adriana'].practice_sessions[0]
    create_student_response(words[0], 'eve', ps, 15)
    create_student_response(words[0], 'even', ps, 15)
    create_student_response(words[1], 'in', ps, 15)
    create_student_response(words[2], 'the', ps, 15)
    create_student_response(words[3], 'quite', ps, 15)
    create_student_response(words[3], 'quietest', ps, 15)
    create_student_response(words[4], 'moments', ps, 15)


    ps = users['Adriana'].practice_sessions[1]
    create_student_response(words[0], 'even', ps, 15)
    create_student_response(words[1], 'in', ps, 15)
    create_student_response(words[2], 'the', ps, 15)
    create_student_response(words[3], 'quietest', ps, 15)
    create_student_response(words[4], 'moments', ps, 15)


    create_practice_sessions(users['Thomas'], wl, 4, '2012-04-22 10:44.23')
    ps = users['Thomas'].practice_sessions[0]
    create_student_response(words[0], 'eve', ps, 20)
    create_student_response(words[0], 'evan', ps, 20)
    create_student_response(words[0], 'even', ps, 20)
    create_student_response(words[1], 'en', ps, 20)
    create_student_response(words[1], 'in', ps, 20)
    create_student_response(words[2], 'the', ps, 20)
    create_student_response(words[3], 'quitest', ps, 20)
    create_student_response(words[3], 'quaytest', ps, 20)
    create_student_response(words[3], 'quite', ps, 20)
    create_student_response(words[3], 'quietest', ps, 20)
    create_student_response(words[4], 'moments', ps, 20)
    
    ps = users['Thomas'].practice_sessions[1]
    create_student_response(words[0], 'eve', ps, 20)
    create_student_response(words[0], 'evan', ps, 20)
    create_student_response(words[0], 'even', ps, 20)
    create_student_response(words[1], 'en', ps, 20)
    create_student_response(words[1], 'in', ps, 20)
    create_student_response(words[2], 'the', ps, 20)
    create_student_response(words[3], 'quitest', ps, 20)
    create_student_response(words[3], 'quaytest', ps, 20)
    create_student_response(words[3], 'quite', ps, 20)
    create_student_response(words[3], 'quietest', ps, 20)
    create_student_response(words[4], 'moments', ps, 20)

    ps = users['Thomas'].practice_sessions[2]
    create_student_response(words[0], 'even', ps, 20)
    create_student_response(words[1], 'in', ps, 20)
    create_student_response(words[2], 'the', ps, 20)
    create_student_response(words[3], 'quitest', ps, 20)
    create_student_response(words[3], 'quaytest', ps, 20)
    create_student_response(words[3], 'quite', ps, 20)
    create_student_response(words[3], 'quietest', ps, 20)
    create_student_response(words[4], 'moments', ps, 20)

    ps = users['Thomas'].practice_sessions[3]
    create_student_response(words[0], 'eve', ps, 20)
    create_student_response(words[0], 'evan', ps, 20)
    create_student_response(words[0], 'even', ps, 20)
    create_student_response(words[1], 'en', ps, 20)
    create_student_response(words[1], 'in', ps, 20)
    create_student_response(words[2], 'the', ps, 20)
    create_student_response(words[3], 'quitest', ps, 20)
    create_student_response(words[3], 'quaytest', ps, 20)
    create_student_response(words[3], 'quite', ps, 20)
    create_student_response(words[4], 'moments', ps, 20)
    
    
    create_practice_sessions(users['Sherry'], wl, 1, '2012-04-22 10:44.23', 5, 6)
    ps = users['Sherry'].practice_sessions[0]
    create_student_response(words[0], 'eve', ps, 30)
    create_student_response(words[0], 'even', ps, 30)
    create_student_response(words[1], 'en', ps, 30)
    create_student_response(words[1], 'in', ps, 30)
    create_student_response(words[2], 'the', ps, 30)
    create_student_response(words[3], 'quitest', ps, 30)
    create_student_response(words[3], 'quaytest', ps, 30)
    create_student_response(words[3], 'quite', ps, 30)
    create_student_response(words[3], 'quietest', ps, 30)
    create_student_response(words[4], 'moments', ps, 30)
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
        u.practice_sessions.destroy
        u.destroy 
      end
    end
  end
end 

