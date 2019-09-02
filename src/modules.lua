local package_table = {};

function require(name)
  local package = assert(
    package_table[name],
    'Module with name '..name..' does not exist in package table.');
  if not package.loaded then
    local status, export_or_error = pcall(package.closure);
    if not status then
      error(export_or_error);
    end
    package.loaded = true;
    package.export = export_or_error;
  end
  return package.export;
end

function export(name, closure)
  local M = {};
  do
    local globaltbl = _G;
    local newenv = setmetatable({require = require}, {
      __index = function (t, k)
        local v = M[k];
        if v == nil then return globaltbl[k] end;
        return v;
      end,
      __newindex = M,
    });
    setfenv(closure, newenv);
    package_table[name] = {closure = closure, loaded = false, export = nil};
  end
end
