get '/' do
  haml :index
end

get '/new_task' do
  @task = Task.new
  haml :new_task
end

post '/create_task' do
  @task = Task.new(params[:task])
  if @task.save
    redirect '/' 
  else
    haml :new_task
  end
end

get '/edit_task/:id' do |id|
  @task = Task.find(id)
  haml :edit_task
end

post '/update_task/:id' do |id|
  @task = Task.find(id)
  if @task.update_attributes(params[:task])
    redirect '/' 
  else
    haml :edit_task
  end
end

post '/delete_task/:id' do |id|
  Task.find(id).delete
  redirect '/'
end

get '/clients/:id' do |id|
  @task = Task.find(id)
  haml :clients
end
