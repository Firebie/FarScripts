local function SelectBlock(info, sel, pos, blockType)
   
  if not sel then
    if pos > info.CurPos then
      editor.Select(info.EditorId, blockType, info.CurLine, info.CurPos, pos - info.CurPos, 1)
    else
      editor.Select(info.EditorId, blockType, info.CurLine, pos, info.CurPos - pos, 1)  
    end
  else
    if info.CurLine < sel.EndLine or (info.CurLine == sel.EndLine and info.CurPos < sel.EndPos) then
      if info.CurLine == sel.EndLine and (pos - 1) == sel.EndPos then
        editor.Select(info.EditorId, 0)
      else
        editor.Select(info.EditorId, blockType, info.CurLine, pos, sel.EndPos - pos + 1, sel.EndLine - info.CurLine + 1)
      end
    else
      editor.Select(info.EditorId, blockType, sel.StartLine, sel.StartPos, pos - sel.StartPos, info.CurLine - sel.StartLine + 1)
    end
  end
end

local function SmartHome(select, blockType)
  
  blockType = blockType or far.Flags.BTYPE_STREAM 
  
  local info = editor.GetInfo()
  local sel  = editor.GetSelection()
    
  if info then
    local str = editor.GetString(-1, info.CurLine)
    local s = str.StringText
    local len = s:len()
    local set = false 
      
    for i = 1, len do
      local c = s:sub(i, i)
      if c ~= " " and c ~= "\t" then
        
        local pos = i
        if pos == info.CurPos then
          pos = 1
        end
          
        editor.SetPosition(info.EditorId, info.CurLine, pos)
        if (select) then
          SelectBlock(info, sel, pos, blockType)
        elseif band(info.Options, far.Flags.EOPT_PERSISTENTBLOCKS) == 0 then
          editor.Select(info.EditorId, 0)
        end  

        set = true
        break
      end
    end
 
    if not set then
      editor.SetPosition(info.EditorId, info.CurLine, 1)
    end
    
  end
end

local function SmartEnd(select, blockType)
  
  blockType = blockType or far.Flags.BTYPE_STREAM

  local info = editor.GetInfo()
  local sel  = editor.GetSelection()

  if info then
    local str = editor.GetString(-1, info.CurLine)
    local s = str.StringText
    local len = s:len()
    local set = false
      
    for i = len, 1, -1 do
      local c = s:sub(i, i)
      if c ~= " " and c ~= "\t" then
        local pos = i + 1
        if pos == info.CurPos then
          pos = string.len(s) + 1
        end
          
        editor.SetPosition(info.EditorId, info.CurLine, pos)

        if (select) then
          SelectBlock(info, sel, pos, blockType)
        elseif band(info.Options, far.Flags.EOPT_PERSISTENTBLOCKS) == 0 then
          editor.Select(info.EditorId, 0)
        end

        set = true
        break
      end
    end

    if not set then
      editor.SetPosition(info.EditorId, info.CurLine, len + 1)
    end
 end
end


Macro {
  area="Editor"; key="Home"; flags=""; action = function()
    SmartHome(false)
  end;
}


Macro {
  area="Editor"; key="ShiftHome"; flags=""; action = function()
    SmartHome(true)
  end;
}

Macro {
  area="Editor"; key="AltShiftHome"; flags=""; action = function()
    SmartHome(true, far.Flags.BTYPE_COLUMN)
  end;
}

Macro {
  area="Editor"; key="End"; flags=""; action = function()
    SmartEnd(false)
  end;
}

Macro {
  area="Editor"; key="ShiftEnd"; flags=""; action = function()
    SmartEnd(true)
  end;
}

Macro {
  area="Editor"; key="AltShiftEnd"; flags=""; action = function()
    SmartEnd(true, far.Flags.BTYPE_COLUMN)
  end;
}
