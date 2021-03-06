VERSION 5.00
Begin VB.Form frmEditTags 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "编辑标签"
   ClientHeight    =   4200
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4440
   BeginProperty Font 
      Name            =   "宋体"
      Size            =   9
      Charset         =   134
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "EDITTAGS.frx":0000
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4200
   ScaleWidth      =   4440
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.CommandButton btnCancel 
      Cancel          =   -1  'True
      Caption         =   "取消"
      Height          =   375
      Left            =   2400
      TabIndex        =   30
      Top             =   3720
      Width           =   855
   End
   Begin VB.CommandButton btnConfirm 
      Caption         =   "确定"
      Default         =   -1  'True
      Height          =   375
      Left            =   1200
      TabIndex        =   29
      Top             =   3720
      Width           =   855
   End
   Begin VB.Frame frmOpen 
      Caption         =   "开局"
      Height          =   1335
      Left            =   120
      TabIndex        =   21
      Top             =   2280
      Width           =   4215
      Begin VB.CheckBox chkAutoEcco 
         Caption         =   "自动解析开局"
         Height          =   255
         Left            =   2640
         TabIndex        =   24
         Top             =   240
         Width           =   1455
      End
      Begin VB.TextBox txtOpen 
         Height          =   285
         Left            =   600
         TabIndex        =   26
         Top             =   600
         Width           =   3495
      End
      Begin VB.TextBox txtVar 
         Height          =   285
         Left            =   600
         TabIndex        =   28
         Top             =   960
         Width           =   3495
      End
      Begin VB.TextBox txtEcco 
         Height          =   285
         Left            =   600
         TabIndex        =   23
         Top             =   240
         Width           =   375
      End
      Begin VB.Label lblVar 
         Caption         =   "变例"
         Height          =   255
         Left            =   120
         TabIndex        =   27
         Top             =   960
         Width           =   375
      End
      Begin VB.Label lblEcco 
         Caption         =   "ECCO"
         Height          =   255
         Left            =   120
         TabIndex        =   22
         Top             =   240
         Width           =   615
      End
      Begin VB.Label lblOpen 
         Caption         =   "开局"
         Height          =   255
         Left            =   120
         TabIndex        =   25
         Top             =   600
         Width           =   375
      End
   End
   Begin VB.Frame frmBlack 
      Caption         =   "黑方"
      Height          =   975
      Left            =   2040
      TabIndex        =   16
      Top             =   1200
      Width           =   2295
      Begin VB.TextBox txtBlackTeam 
         Height          =   285
         Left            =   600
         TabIndex        =   18
         Top             =   240
         Width           =   1575
      End
      Begin VB.TextBox txtBlackPlayer 
         Height          =   285
         Left            =   600
         TabIndex        =   20
         Top             =   600
         Width           =   1575
      End
      Begin VB.Label lblBlackPlayer 
         Caption         =   "选手"
         Height          =   255
         Left            =   120
         TabIndex        =   19
         Top             =   600
         Width           =   375
      End
      Begin VB.Label lblBlackTeam 
         Caption         =   "单位"
         Height          =   255
         Left            =   120
         TabIndex        =   17
         Top             =   240
         Width           =   375
      End
   End
   Begin VB.Frame frmMatch 
      Caption         =   "比赛"
      Height          =   2055
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   1815
      Begin VB.TextBox txtEvent 
         Height          =   285
         Left            =   600
         TabIndex        =   2
         Top             =   240
         Width           =   1095
      End
      Begin VB.TextBox txtRound 
         Height          =   285
         Left            =   600
         TabIndex        =   4
         Top             =   600
         Width           =   1095
      End
      Begin VB.TextBox txtDate 
         Height          =   285
         Left            =   600
         TabIndex        =   6
         Top             =   960
         Width           =   1095
      End
      Begin VB.TextBox txtSite 
         Height          =   285
         Left            =   600
         TabIndex        =   8
         Top             =   1320
         Width           =   1095
      End
      Begin VB.ComboBox cmbResult 
         Height          =   300
         ItemData        =   "EDITTAGS.frx":000C
         Left            =   600
         List            =   "EDITTAGS.frx":000E
         Style           =   2  'Dropdown List
         TabIndex        =   10
         Top             =   1680
         Width           =   1095
      End
      Begin VB.Label lblRound 
         Caption         =   "轮次"
         Height          =   255
         Left            =   120
         TabIndex        =   3
         Top             =   600
         Width           =   375
      End
      Begin VB.Label lblEvent 
         Caption         =   "赛事"
         Height          =   255
         Left            =   120
         TabIndex        =   1
         Top             =   240
         Width           =   375
      End
      Begin VB.Label lblResult 
         Caption         =   "结果"
         Height          =   255
         Left            =   120
         TabIndex        =   9
         Top             =   1680
         Width           =   375
      End
      Begin VB.Label lblDate 
         Caption         =   "日期"
         Height          =   255
         Left            =   120
         TabIndex        =   5
         Top             =   960
         Width           =   375
      End
      Begin VB.Label lblSite 
         Caption         =   "地点"
         Height          =   255
         Left            =   120
         TabIndex        =   7
         Top             =   1320
         Width           =   375
      End
   End
   Begin VB.Frame frmRed 
      Caption         =   "红方"
      Height          =   975
      Left            =   2040
      TabIndex        =   11
      Top             =   120
      Width           =   2295
      Begin VB.TextBox txtRedTeam 
         Height          =   285
         Left            =   600
         TabIndex        =   13
         Top             =   240
         Width           =   1575
      End
      Begin VB.TextBox txtRedPlayer 
         Height          =   285
         Left            =   600
         TabIndex        =   15
         Top             =   600
         Width           =   1575
      End
      Begin VB.Label lblRedPlayer 
         Caption         =   "选手"
         Height          =   255
         Left            =   120
         TabIndex        =   14
         Top             =   600
         Width           =   375
      End
      Begin VB.Label lblRedTeam 
         Caption         =   "单位"
         Height          =   255
         Left            =   120
         TabIndex        =   12
         Top             =   240
         Width           =   375
      End
   End
End
Attribute VB_Name = "frmEditTags"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
' EDITTAGS.BAS - Source Code for XiangQi Wizard, Part VI
'
' XiangQi Wizard - a Chinese Chess Program (GUI for UCCI Engines)
' Designed by Morning Yellow, Version: 4.78, Last Modified: Sep. 2010
' Copyright (C) 2004-2010 www.xqbase.com
'
' This program is free software; you can redistribute it and/or modify
' it under the terms of the GNU General Public License as published by
' the Free Software Foundation; either version 2 of the License, or
' (at your option) any later version.

' This program is distributed in the hope that it will be useful,
' but WITHOUT ANY WARRANTY; without even the implied warranty of
' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
' GNU General Public License for more details.

' You should have received a copy of the GNU General Public License along
' with this program; if not, write to the Free Software Foundation, Inc.,
' 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

Option Explicit

Private Sub Form_Load()

Dim i As Integer
txtEvent = Game_szEvent
txtRound = Game_szRound
txtDate = Game_szDate
txtSite = Game_szSite
cmbResult.Clear
cmbResult.AddItem L("未知", "未知"), 0
cmbResult.AddItem L("红胜", "紅勝"), 1
cmbResult.AddItem L("和棋", "和棋"), 2
cmbResult.AddItem L("黑胜", "黑勝"), 3
cmbResult.ListIndex = Game_nResult
txtRedTeam = Game_szRedTeam
txtRedPlayer = Game_szRedPlayer
txtBlackTeam = Game_szBlackTeam
txtBlackPlayer = Game_szBlackPlayer
txtEcco = Game_szEcco
txtOpen = Game_szOpen
txtVar = Game_szVar
chkAutoEcco.Value = IIf(App_bAutoEcco, 1, 0)
chkAutoEcco.Enabled = Game_bStartPos
SetTopMost hWnd

If Options_nLanguage = LANGUAGE_ZH_CN Then
    Exit Sub
End If
Font.Charset = 136
Font.Name = "細明體"
On Error Resume Next
For i = 0 To Controls.Count - 1
    Controls(i).Font = Font
Next
On Error GoTo 0
Caption = "編輯標簽"
frmMatch.Caption = "比賽"
lblEvent.Caption = "賽事"
lblRound.Caption = "輪次"
lblDate.Caption = "日期"
lblSite.Caption = "地點"
lblResult.Caption = "結果"
frmRed.Caption = "紅方"
lblRedTeam.Caption = "單位"
lblRedPlayer.Caption = "選手"
frmBlack.Caption = "黑方"
lblBlackTeam.Caption = "單位"
lblBlackPlayer.Caption = "選手"
frmOpen.Caption = "開局"
chkAutoEcco.Caption = "自動解析開局"
lblOpen.Caption = "開局"
lblVar.Caption = "變例"
btnConfirm.Caption = "確定"
btnCancel.Caption = "取消"

End Sub

Private Sub btnConfirm_Click()

App_bAutoEcco = (chkAutoEcco.Value = 1)
Game_szEvent = txtEvent
Game_szRound = txtRound
Game_szDate = txtDate
Game_szSite = txtSite
Game_nResult = cmbResult.ListIndex
Game_szRedTeam = txtRedTeam
Game_szRedPlayer = txtRedPlayer
Game_szBlackTeam = txtBlackTeam
Game_szBlackPlayer = txtBlackPlayer
Game_szEcco = txtEcco
Game_szOpen = txtOpen
Game_szVar = txtVar
LabelFlush
Unload Me

End Sub

Private Sub btnCancel_Click()

Unload Me

End Sub
