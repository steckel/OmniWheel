local global_table = _G;
local package = {
  loaded = {},
  loaders = {},
  path = {},
  preload = {},
  seeall = function(module)
    setmetatable(module, {__index = _G });
    -- local new_env = {};
    -- setfenv(3, setmetatable(new_env, {
    --   __index = _G,
    --   __newindex = function(_,k,v) rawset(new_env,k,v); module[k]=v end
    -- }));
  end
};

function module(modname, ...)
  local t = {};
  t["_NAME"] = modname;
  t["_M"] = t;
  t["_PACKAGE"] = ''; -- if modname is 'package.foo.bar' then package should be 'package.foo';
  for _, decorator in ipairs({...}) do
    decorator(t);
  end
  package.loaded[modname] = t;
  setfenv(2, t);
end

function require(modname)
  -- FIXME(steckel): Handle error.
  local loaded = loader(modname);
  if not loaded ~= nil then
    package.loaded[modname] = loaded;
  else
    package.loaded[modname] = true;
  end
  return package.loaded[modname];
end

function loader(modname)
  local preload = package.preload[modname];

  if not type(preload) == "func" then
    error();
  end

  local status, export_or_error = pcall(preload);
  if not status then
    error(export_or_error);
  end

  if export_or_error ~= nil then
    package.loaded[modname] = export_or_error;
  elseif package.loaded[modname] == nil then
    package.loaded[modname] = true;
  end

  return package.loaded[modname];
end
