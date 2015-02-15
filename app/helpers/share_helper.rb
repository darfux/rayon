module ShareHelper

  def get_content(project, meta)
    params = meta[:params]
    callback = meta[:callback]
    content = ""
    if params
      content = project.send(meta[:attri], params)
    else
      content = project.send(meta[:attri])
    end

    return content unless callback

    params = callback[:params]
    handler = callback[:handler]
    if params
      self.send(handler, content, params)
    else
      self.send(handler, content)
    end

  end

end