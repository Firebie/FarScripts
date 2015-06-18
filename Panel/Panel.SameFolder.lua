Macro {
  area="Shell"; key="Ctrl="; action = function()
    if (panel.SetPanelDirectory(nil, 0, panel.GetPanelDirectory(nil, 1))) 
    then
      
      local fileName = panel.GetPanelItem (nil, 1, panel.GetPanelInfo (nil, 1).CurrentItem).FileName

      local pPanelInfo = panel.GetPanelInfo (nil, 0)
      for i = 1, pPanelInfo.ItemsNumber do
        if far.LStricmp(panel.GetPanelItem (nil, 0, i).FileName, fileName) == 0 
        then
          --msgbox("2", item.FileName, "")
          local redraw = {}
          redraw["CurrentItem"] = i
          panel.RedrawPanel(nil, 0, redraw)
          break
        end  
      end

      --msgbox("1", APanel.Current, "")
      --msgbox("2", item.FileName, "")
      
      --Panel.SetPos(1, APanel.Current)
      --panel.RedrawPanel(nil, 0, APanel.Current)
    end
  end;
}

