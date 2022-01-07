module Response
    def json_response(object, status = :ok)
      render json: object, status: status #200 for getting a todo or all todos, 201 for creating a todo successfully, 204 for updating/deleting successfully
    end
  end