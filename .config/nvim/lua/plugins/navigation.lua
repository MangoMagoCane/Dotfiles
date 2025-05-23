local function fileExtension(path)
  local rev_path = path:reverse()
  local slash_i = rev_path:find("/")
  local dot_i = rev_path:find("%.")

  if slash_i == nil then
    slash_i = 1
  else
    slash_i = #rev_path - slash_i + 2
  end

  if dot_i == nil then
    dot_i = -1
  else
    dot_i = #rev_path - dot_i + 2
  end

  if dot_i <= slash_i + 1 or (path:sub(slash_i, slash_i) == "." and dot_i < 1) then
    return path:sub(slash_i), ""
  else
    return path:sub(slash_i, dot_i - 2), path:sub(dot_i)
  end
end

local function order_numer(str_a, str_b)
  for i = 1, math.min(#str_a, #str_b) do
    local a_sub = str_a:sub(i)
    local b_sub = str_b:sub(i)
    local a_c = a_sub:sub(1, 1)
    local b_c = b_sub:sub(1, 1)

    if type(tonumber(a_c)) == "number" and type(tonumber(b_c)) == "number" then
      local a_num = tonumber(a_sub:match("^[0-9]+"))
      local b_num = tonumber(b_sub:match("^[0-9]+"))

      if a_num ~= b_num then
        return a_num < b_num
      end
    elseif a_c ~= b_c then
      return a_sub < b_sub
    end
  end
  return str_a < str_b
end

local function natural_cmp(a, b)
  if a.type == nil or a.path == nil then
    return false
  end
  if b.type == nil or b.path == nil then
    return true
  end
  local a_name, a_ext = fileExtension(a.path:lower())
  local b_name, b_ext = fileExtension(b.path:lower())

  if a.type == "directory" and b.type ~= "directory" then
    return true
  end
  if b.type == "directory" and a.type ~= "directory" then
    return false
  end

  if a.filtered_by ~= nil and b.filtered_by == nil then
    return a.type == "directory" and b.type == "directory"
  end
  if b.filtered_by ~= nil and a.filtered_by == nil then
    return not (a.type == "directory" and b.type == "directory")
  end

  local a_c = a_name:sub(1, 1)
  local b_c = b_name:sub(1, 1)
  if a_c == "." and b_c ~= "." then
    return false
  end
  if b_c == "." and a_c ~= "." then
    return true
  end

  a_name = a_ext .. " " .. a_name
  b_name = b_ext .. " " .. b_name

  return order_numer(a_name, b_name)
end

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      sort_function = natural_cmp,
      -- = function(a, b)
      -- keys of a and b
      -- not documented anywhere
      --   parent_path:           full, absolute path of parent directory
      --   type:                  "directory" (even for links), or "file"
      --   path:                  full, absolute path, no trailing slash
      --   name:                  file name
      --   is_link                bool is a symlink
      --   is_reveal_target       bool ??
      --   link_to                full, absolute path to link target
      --   loaded                 bool if file is loaded in editor
      --   id                     seems to be same as path
      --   children               type of a/b table, directories only
      --   exts                   file extension  ??, files only
      --   ext                    file extension  ??, files only
      --   name_lcase             name, but lowercase, files only?
      --   filtered_by            table if hidden file, nil otherwise ??

      -- if a.type == b.type then
      --   return a.path < b.path
      -- else
      --   return a.type < b.type
      -- end

      -- workaround till https://github.com/nvim-neo-tree/neo-tree.nvim/issues/1226 is solved
      --   if a.name == nil then
      --     return false
      --   end
      --
      --   if b.name == nil then
      --     return true
      --   end
      --
      --   if a.type == "directory" and b.type ~= "directory" then
      --     -- directories first
      --     return true
      --   end
      --   if b.type == "directory" and a.type ~= "directory" then
      --     -- directories first
      --     return false
      --   end
      --
      --   if a.name:sub(1, 1) == "." and b.name:sub(1, 1) ~= "." then
      --     -- dotfiles last
      --     return false
      --   end
      --   if b.name:sub(1, 1) == "." and a.name:sub(1, 1) ~= "." then
      --     -- dotfiles last
      --     return true
      --   end
      --   -- otherwise just sort by name, case insensitive
      --   -- return a.name:upper() < b.name:upper()
      --   local max_len = #a
      --   if #b > #a then
      --     max_len = #b
      --   end
      --
      --   for i = 1, max_len do
      --     local c_a = a.type:sub(i, i)
      --     local b_a = b.type:sub(i, i)
      --   end
      --   -- if a.type == b.type then
      --   --   return a.path < b.path
      --   -- else
      --   --   return a.type < b.type
      --   -- end
      -- end,
    },
  },
}
