local package_table = {};

function require(name)
  return assert(
    package_table[name],
    'Module with name '..name..' does not exist in package table.');
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
    -- TODO(steckel): Don't pcall until require.
    local status, export_or_error = pcall(closure);
    if status == false then
      print(status, export_or_error);
    end
    package_table[name] = export_or_error;
  end
end
