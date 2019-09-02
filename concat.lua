module('concat', package.seeall);

package.path = package.path .. ";./src/?.lua";

function parse_args(args)
  assert(type(args) == "table", "args must be a table")
  local options = { globals = {}, outfile = nil, entrypoint = nil, modules = {}};
  local i = 1;
  local n = table.getn(args);
  while i <= n do
    local a = args[i];
    if a == "-o" then
      i = i + 1;
      options["outfile"] = args[i];
    elseif a == "-e" then
      i = i + 1;
      options["entrypoint"] = args[i];
    elseif a == "-g" then
      i = i + 1;
      table.insert(options.globals, args[i]);
    elseif a == "-m" then
      i = i + 1;
      table.insert(options.modules, args[i]);
    end
    i = i + 1
  end
  return options;
end

function read_file(path)
  local file = io.open(path, "rb");
  if not file then return nil end
  -- *a or *all reads the whole file
  local content = file:read("*a");
  file:close();
  return content;
end


local delim = package.config:match( "^(.-)\n" ):gsub( "%%", "%%%%" );

function searchpath( name, path )
  local pname = name:gsub("%.", delim):gsub("%%", "%%%%");
  local msg = {};
  for subpath in path:gmatch("[^;]+") do
    local fpath = subpath:gsub("%?", pname);
    local f = io.open(fpath, "r");
    if f then
      f:close();
      return fpath;
    end
    msg[#msg+1] = "\n\tno file '"..fpath.."'";
  end
  return nil, table.concat(msg);
end

function main(cmdline_args)
  local options = parse_args(cmdline_args);
  assert(options.outfile);
  assert(options.entrypoint);

  local out = io.stdout
  out = assert( io.open( options.outfile, "w" ) )

  for _, g in ipairs(options.globals) do
    local path, msg  = searchpath(g, package.path);
    local contents = read_file(path)
    out:write("-- ", path, "\n\n", contents, "\n\n");
  end

  for _,m in ipairs(options.modules) do
    local path, msg  = searchpath(m, package.path);
    local contents = read_file(path)
    out:write("do","\n",
      "package.preload[\"", m, "\"] = function()", "\n",
        contents,
      "end", "\n",
    "end\n\n")
  end

  local path, msg  = searchpath(options.entrypoint, package.path);
  local entrypoint_content = read_file(path);
  out:write(entrypoint_content);
  out:close();
end

main(arg);
