require "grip"

class UsersController < Grip::Controllers::Http
  @users : Hash(String, JSON::Any) = {} of String => JSON::Any
  @messages : Array(Hash(String, String)) = [] of Hash(String, String)

  def one(context : Context)
    username = context.fetch_path_params.["username"].to_s

    if user = @users[username]?
      context.json({"success" => true, "message" => nil, "body" => user})
    else
      @users[username] = JSON::Any.new(
        {
          "chatId" => JSON::Any.new(UUID.random.to_s),
        }
      )

      context.json({"success" => true, "message" => nil, "body" => @users[username]})
    end
  end

  def messages(context : Context)
    context.json({"success" => true, "message" => nil, "body" => @messages})
  end

  def message(context : Context)
    username = context.fetch_json_params.["username"].to_s
    text = context.fetch_json_params.["text"].to_s

    if user = @users[username]?
      @messages.push({"username" => username, "text" => text})

      context
        .put_status(200)
        .json({"success" => true, "message" => nil, "body" => nil})
    else
      context
        .put_status(404)
        .json({"success" => false, "message" => "User is not registered", "body" => nil})
    end
  end
end

class Application < Grip::Application
  def initialize
    super()

    scope "/api" do
      get "/users/:username", UsersController, as: :one
      get "/users/messages", UsersController, as: :messages

      post "/users/message", UsersController, as: :message
    end

    router.insert(0, Grip::Handlers::Log.new)
  end

  def port : Int32
    8080
  end
end

app = Application.new
app.run
