return {
  req = function(name, cb)
    local has_module, module = pcall(require, name)
    if not has_module then
      return
    end

    if type(cb) == 'function' then
      cb(module)
    else
      if cb ~= nil then
        require('plugins.' .. cb).init(module)
      else
        require('plugins.' .. name).init(module)
      end
    end
  end,
}
