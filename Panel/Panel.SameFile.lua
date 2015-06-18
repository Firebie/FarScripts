Macro {
  area="Shell"; key="CtrlShift="; action = function()
    local info = panel.GetPanelInfo (nil, 1)
    local item = panel.GetPanelItem (nil, 1, info.CurrentItem)

     --CurrentItem:         1-based integer
     --msgbox("", info.ItemsNumber, "")

    local pPanelInfo = panel.GetPanelInfo (nil, 0)
    for i = 1, pPanelInfo.ItemsNumber do
      if far.LStricmp(panel.GetPanelItem (nil, 0, i).FileName, item.FileName) == 0 then
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
  end;
}

