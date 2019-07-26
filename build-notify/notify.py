#!/usr/bin/env python3
# -*- coding: utf-8 -*-
 
# simple.py

import wx
import time
import threading
import urllib.request
import re
def status_thread():
    index = 0
    while True:
        summary = urllib.request.urlopen("http://staging.evolus.vn/build-notify.jsp").read().decode("utf-8")
        
        wx.CallAfter(update_message, summary)
        index = index + 1
        time.sleep(1)

def update_message(message):
    pattern = re.compile("^[ \t\r\n]*$")
    if pattern.match(message):
        s = label.GetSize()
        w = s.Width
        x = int(width / 2 - w / 2)
        frame.SetSize(x, 2000, w, 1)
    else:
        label.SetLabel(" BUILD: " + message + " ")
        s = label.GetSize()
        w = s.Width
        h = s.Height + 10
        x = int(width / 2 - w / 2)
        frame.SetSize(x, 1, w, 20)
        


app = wx.App()
width, height = wx.GetDisplaySize()
frame = wx.Frame(None, style=(wx.FRAME_NO_TASKBAR | wx.NO_BORDER | wx.FRAME_TOOL_WINDOW | wx.STAY_ON_TOP | wx.FRAME_FLOAT_ON_PARENT))

label = wx.StaticText(frame, label="", style=wx.ALIGN_CENTER)
label.SetForegroundColour((255, 0, 0))
vbox = wx.BoxSizer(wx.VERTICAL)
vbox.Add(label, wx.ID_ANY, wx.EXPAND | wx.ALL, 0)
frame.SetSizer(vbox)
frame.Show()

thread = threading.Thread(target=status_thread)
thread.start()

app.MainLoop()

