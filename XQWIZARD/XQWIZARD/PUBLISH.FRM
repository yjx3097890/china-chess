VERSION 5.00
Begin VB.Form frmPublish 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "��������"
   ClientHeight    =   3120
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4680
   BeginProperty Font 
      Name            =   "����"
      Size            =   9
      Charset         =   134
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "PUBLISH.frx":0000
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3120
   ScaleWidth      =   4680
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.CommandButton btnHelp 
      Caption         =   "����"
      Height          =   375
      Left            =   360
      TabIndex        =   21
      Top             =   2640
      Width           =   1095
   End
   Begin VB.CommandButton btnPublish 
      Caption         =   "����"
      Default         =   -1  'True
      Height          =   375
      Left            =   1800
      TabIndex        =   22
      Top             =   2640
      Width           =   1095
   End
   Begin VB.Frame frmBoard 
      Caption         =   "����"
      Height          =   1335
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   4455
      Begin VB.ComboBox cmbPieces 
         Height          =   300
         Left            =   3120
         Style           =   2  'Dropdown List
         TabIndex        =   9
         Top             =   600
         Width           =   1215
      End
      Begin VB.ComboBox cmbBoard 
         Height          =   300
         Left            =   960
         Style           =   2  'Dropdown List
         TabIndex        =   7
         Top             =   600
         Width           =   1215
      End
      Begin VB.OptionButton optSize 
         Caption         =   "��"
         Height          =   255
         Index           =   0
         Left            =   960
         TabIndex        =   2
         Top             =   240
         Width           =   855
      End
      Begin VB.TextBox txtBoardUrl 
         BackColor       =   &H8000000F&
         Height          =   270
         Left            =   960
         Locked          =   -1  'True
         TabIndex        =   11
         ToolTipText     =   "��Ctrl-C���Ƶ�������"
         Top             =   960
         Width           =   2895
      End
      Begin VB.OptionButton optSize 
         Caption         =   "���"
         Height          =   255
         Index           =   3
         Left            =   3480
         TabIndex        =   5
         Top             =   240
         Width           =   855
      End
      Begin VB.OptionButton optSize 
         Caption         =   "����"
         Height          =   255
         Index           =   2
         Left            =   2640
         TabIndex        =   4
         Top             =   240
         Width           =   855
      End
      Begin VB.OptionButton optSize 
         Caption         =   "ӡˢ"
         Height          =   255
         Index           =   1
         Left            =   1800
         TabIndex        =   3
         Top             =   240
         Width           =   855
      End
      Begin VB.Label lblBoardUrl 
         Caption         =   "ͼƬ��ַ"
         Height          =   255
         Left            =   120
         TabIndex        =   10
         Top             =   960
         Width           =   735
      End
      Begin VB.Label lblViewBoard 
         Caption         =   "Ԥ��"
         BeginProperty Font 
            Name            =   "����"
            Size            =   9
            Charset         =   134
            Weight          =   400
            Underline       =   -1  'True
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF0000&
         Height          =   255
         Left            =   3960
         MouseIcon       =   "PUBLISH.frx":000C
         MousePointer    =   99  'Custom
         TabIndex        =   12
         Top             =   960
         Width           =   375
      End
      Begin VB.Label lblPieces 
         Caption         =   "������ʽ"
         Height          =   255
         Left            =   2280
         TabIndex        =   8
         Top             =   600
         Width           =   735
      End
      Begin VB.Label lblBoard 
         Caption         =   "������ʽ"
         Height          =   255
         Left            =   120
         TabIndex        =   6
         Top             =   600
         Width           =   735
      End
      Begin VB.Label lblSize 
         Caption         =   "ͼƬ����"
         Height          =   255
         Left            =   120
         TabIndex        =   1
         Top             =   240
         Width           =   735
      End
   End
   Begin VB.CommandButton btnCancel 
      Cancel          =   -1  'True
      Caption         =   "�ر�"
      Height          =   375
      Left            =   3240
      TabIndex        =   23
      Top             =   2640
      Width           =   1095
   End
   Begin VB.Frame frmFormat 
      Caption         =   "����"
      Height          =   975
      Left            =   120
      TabIndex        =   13
      Top             =   1560
      Width           =   4455
      Begin VB.OptionButton optContent 
         Caption         =   "��ǰ����"
         Height          =   255
         Index           =   1
         Left            =   2040
         TabIndex        =   16
         Top             =   240
         Width           =   1095
      End
      Begin VB.OptionButton optContent 
         Caption         =   "�������"
         Height          =   255
         Index           =   0
         Left            =   960
         TabIndex        =   15
         Top             =   240
         Width           =   1095
      End
      Begin VB.ComboBox cmbLocation 
         Height          =   300
         Left            =   960
         Style           =   2  'Dropdown List
         TabIndex        =   18
         Top             =   600
         Width           =   1215
      End
      Begin VB.ComboBox cmbFormat 
         Height          =   300
         Left            =   3120
         Style           =   2  'Dropdown List
         TabIndex        =   20
         Top             =   600
         Width           =   1215
      End
      Begin VB.Label lblFormat 
         Caption         =   "������ʽ"
         BeginProperty Font 
            Name            =   "����"
            Size            =   9
            Charset         =   134
            Weight          =   400
            Underline       =   -1  'True
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF0000&
         Height          =   255
         Left            =   2280
         MouseIcon       =   "PUBLISH.frx":015E
         MousePointer    =   99  'Custom
         TabIndex        =   19
         Top             =   600
         Width           =   735
      End
      Begin VB.Label lblLocation 
         Caption         =   "����վ��"
         BeginProperty Font 
            Name            =   "����"
            Size            =   9
            Charset         =   134
            Weight          =   400
            Underline       =   -1  'True
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF0000&
         Height          =   255
         Left            =   120
         MouseIcon       =   "PUBLISH.frx":02B0
         MousePointer    =   99  'Custom
         TabIndex        =   17
         Top             =   600
         Width           =   735
      End
      Begin VB.Label lblContent 
         Caption         =   "��������"
         Height          =   255
         Left            =   120
         TabIndex        =   14
         Top             =   240
         Width           =   735
      End
   End
End
Attribute VB_Name = "frmPublish"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
' PUBLISH.FRM - Source Code for XiangQi Wizard, Part XI
'
' XiangQi Wizard - a Chinese Chess Program (GUI for UCCI Engines)
' Designed by Morning Yellow, Version: 4.73, Last Modified: Aug. 2010
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
' ͼƬ����
optSize(Publish_nSize).Value = True

' ��������
optContent(IIf(Publish_bContent, 1, 0)).Value = True

' ������ʽ
cmbFormat.Clear
cmbFormat.AddItem L("���ı�", "���ı�"), 0
cmbFormat.AddItem L("ANSI�ı�", "ANSI�ı�"), 1
cmbFormat.AddItem L("UBB�ı�", "UBB�ı�"), 2
cmbFormat.AddItem L("HTML�ı�", "HTML�ı�"), 3
cmbFormat.AddItem L("HTML����", "HTML����"), 4
cmbFormat.ListIndex = Publish_nFormat

' ע�⣺���з�����ʽ�����з���վ�㣡
' ����վ��
cmbLocation.Clear
cmbLocation.AddItem L("�ٶ�֪��", "�ٶ�֪��"), 0
cmbLocation.AddItem L("�ٶ����������", "�ٶ��N�������"), 1
cmbLocation.AddItem L("���˲���", "���˲���"), 2
cmbLocation.AddItem L("QQ�ռ�", "QQ���g"), 3
cmbLocation.AddItem L("(����)", "(����)"), 4
cmbLocation.ListIndex = Publish_nLocation

SetTopMost hWnd

If Options_nLanguage = LANGUAGE_ZH_CN Then
    Exit Sub
End If
Font.Charset = 136
Font.Name = "�����w"
On Error Resume Next
For i = 0 To Controls.Count - 1
    Controls(i).Font = Font
Next
On Error GoTo 0
lblViewBoard.Font.Underline = True
lblLocation.Font.Underline = True
lblFormat.Font.Underline = True
Caption = "�l�����V"
frmBoard.Caption = "��P"
lblSize.Caption = "�DƬ���"
optSize(0).Caption = "����"
optSize(1).Caption = "ӡˢ"
optSize(2).Caption = "�m��"
optSize(3).Caption = "���"
lblBoard.Caption = "��P��ʽ"
lblPieces.Caption = "���Ә�ʽ"
lblBoardUrl.Caption = "�DƬ��ַ"
txtBoardUrl.ToolTipText = "��Ctrl-C�}�u�����N��"
lblViewBoard.Caption = "�A�["
frmFormat.Caption = "�l��"
lblContent.Caption = "�l������"
optContent(0).Caption = "�������"
optContent(1).Caption = "��ǰ����"
lblLocation.Caption = "�l��վ�c"
lblFormat.Caption = "�l����ʽ"
btnHelp.Caption = "����"
btnPublish.Caption = "�l��"
btnCancel.Caption = "�P�]"

End Sub

Private Sub Form_Unload(Cancel As Integer)

' ����
Select Case Publish_nSize
Case PUB_SIZE_MINI, PUB_SIZE_PRINT
    Publish_bTrad = (cmbPieces.ListIndex = 1)
Case PUB_SIZE_SMALL
    Publish_nBoardS = cmbBoard.ListIndex
    Publish_nPiecesS = cmbPieces.ListIndex
Case PUB_SIZE_LARGE
    Publish_nBoardL = cmbBoard.ListIndex
    Publish_nPiecesL = cmbPieces.ListIndex
End Select
' ����
Publish_bContent = optContent(1).Value
Publish_nLocation = cmbLocation.ListIndex
Publish_nFormat = cmbFormat.ListIndex

End Sub

Private Sub optSize_Click(nIndex As Integer)

Publish_nSize = nIndex
cmbBoard.Clear
cmbPieces.Clear
Select Case nIndex
Case PUB_SIZE_MINI, PUB_SIZE_PRINT
    cmbBoard.AddItem L("Ĭ��", "Ĭ�J"), 0
    cmbBoard.ListIndex = 0
    cmbPieces.AddItem L("����", "���w"), 0
    cmbPieces.AddItem L("����", "���w"), 1
    cmbPieces.ListIndex = IIf(Publish_bTrad, 1, 0)
Case PUB_SIZE_SMALL
    cmbBoard.AddItem L("��ľ", "��ľ"), 0
    cmbBoard.AddItem L("��ɫ����ʯ", "�Gɫ����ʯ"), 1
    cmbBoard.AddItem L("��ɫ����ʯ", "��ɫ����ʯ"), 2
    cmbBoard.AddItem L("����ֽ", "������"), 3
    cmbBoard.AddItem L("����", "����"), 4
    cmbBoard.AddItem L("ˮ��", "ˮ��"), 5
    cmbBoard.AddItem L("�������ʯ", "�{����"), 6
    cmbBoard.AddItem L("�����ݲ���", "�����ݲ���"), 7
    cmbBoard.AddItem L("������Ե", "�����徉"), 8
    cmbBoard.AddItem L("�������", "������C"), 9
    cmbBoard.AddItem L("��������", "�v�R����"), 10
    cmbBoard.AddItem L("ǳ������", "�\�t����"), 11
    cmbBoard.ListIndex = Publish_nBoardS
    cmbPieces.AddItem L("ľ��", "ľ��"), 0
    cmbPieces.AddItem L("����", "���@"), 1
    cmbPieces.AddItem L("����", "���"), 2
    cmbPieces.AddItem L("�����ݲ���", "�����ݲ���"), 3
    cmbPieces.AddItem L("������Ե", "�����徉"), 4
    cmbPieces.AddItem L("�������", "������C"), 5
    cmbPieces.AddItem L("��������", "�v�R����"), 6
    cmbPieces.ListIndex = Publish_nPiecesS
Case PUB_SIZE_LARGE
    cmbBoard.AddItem L("��ľ", "��ľ"), 0
    cmbBoard.AddItem L("��ɫ����ʯ", "�Gɫ����ʯ"), 1
    cmbBoard.AddItem L("��ɫ����ʯ", "��ɫ����ʯ"), 2
    cmbBoard.AddItem L("����ֽ", "������"), 3
    cmbBoard.AddItem L("����", "����"), 4
    cmbBoard.AddItem L("ˮ��", "ˮ��"), 5
    cmbBoard.AddItem L("ǳ������", "�\�t����"), 6
    cmbBoard.ListIndex = Publish_nBoardL
    cmbPieces.AddItem L("ľ��", "ľ��"), 0
    cmbPieces.AddItem L("����", "���@"), 1
    cmbPieces.AddItem L("����", "���"), 2
    cmbPieces.ListIndex = Publish_nPiecesL
End Select

End Sub

Private Sub cmbBoard_Click()

Select Case Publish_nSize
Case PUB_SIZE_SMALL
    Publish_nBoardS = cmbBoard.ListIndex
Case PUB_SIZE_LARGE
    Publish_nBoardL = cmbBoard.ListIndex
End Select
txtBoardUrl.Text = GetBoardUrl(AllocString(CchessBoard2Fen(Game_pos)))

End Sub

Private Sub cmbPieces_Click()

Select Case Publish_nSize
Case PUB_SIZE_MINI, PUB_SIZE_PRINT
    Publish_bTrad = (cmbPieces.ListIndex = 1)
Case PUB_SIZE_SMALL
    Publish_nPiecesS = cmbPieces.ListIndex
Case PUB_SIZE_LARGE
    Publish_nPiecesL = cmbPieces.ListIndex
End Select
txtBoardUrl.Text = GetBoardUrl(AllocString(CchessBoard2Fen(Game_pos)))

End Sub

Private Sub optContent_Click(Index As Integer)

Publish_bContent = optContent(1).Value

End Sub

Private Sub btnHelp_Click()

ShellExecuteA 0, vbNullString, "http://www.xqbase.com/xqwizard/help_publish.htm", _
        vbNullString, vbNullString, vbNormalFocus

End Sub

Private Sub btnPublish_Click()

Dim szCopy As String, szFen As String, szBr As String, szAd As String, szFlashVars As String
Dim bReturned As Boolean, cnt As Integer, sd As Integer, i As Integer
Dim pos As PositionStruct

' �������(���¡����������ص㡢����)
szCopy = ""
szBr = IIf(Publish_nFormat >= PUB_FORMAT_HTML, "<br>" & vbCrLf, vbCrLf)
If EventString <> "" Then
    szCopy = szCopy & EventString & szBr
End If
If ResultString <> "" Then
    szCopy = szCopy & ResultString & szBr
End If
If DateSiteString <> "" Then
    szCopy = szCopy & DateSiteString & szBr
End If
If OpenString <> "" Then
    szCopy = szCopy & OpenString & szBr
End If
szAd = L("# ��������������ʦ���ɣ���ӭ���� ", "# �����V�������׎����ɣ��gӭ�L�� ")
If Publish_bContent Then
    ' ������ǰ���棬������ʾ�ı�����/ͼƬ���̣����FEN����
    szFen = AllocString(CchessBoard2Fen(Game_pos))
    Select Case Publish_nFormat
    Case PUB_FORMAT_TEXT, PUB_FORMAT_ANSI
        szCopy = szCopy & GetBoardText(Game_pos)
        szCopy = szCopy & "# " & szFen & szBr
    Case PUB_FORMAT_UBB
        szCopy = szCopy & "[img]" & GetBoardUrl(szFen) & "[/img]" & szBr
        szCopy = szCopy & "# [url=http://www.xqbase.com/pub/fen.php?fen=" & _
                UrlEncode(szFen) & "]" & szFen & "[/url]" & szBr
    Case PUB_FORMAT_HTML, PUB_FORMAT_WEB
        szCopy = szCopy & "<img src=""" & GetBoardUrl(szFen) & """>" & szBr
        szCopy = szCopy & "# <a href=""http://www.xqbase.com/pub/fen.php?fen=" & _
                UrlEncode(szFen) & """>" & szFen & "</a>" & szBr
    End Select
Else
    ' �����Ƿ����ʼ���濪ʼ��HTML��ʽ����ʾFlash����
    If Publish_nFormat >= PUB_FORMAT_HTML Then
        szFlashVars = IIf(Game_bStartPos, "", "Position=" & UrlEncode(Game_szFen) & "&") & "MoveList="
        For i = 1 To Game_nMaxMove
            szFlashVars = szFlashVars & UrlEncode(Move2Iccs(Game_mvMove(i)) & " ")
        Next
        szCopy = szCopy & "<embed src=""http://www.xqbase.com/pub/flashxq.swf"" " & _
                "width=""324"" height=""396"" type=""application/x-shockwave-flash"" " & _
                "pluginspage=""http://www.macromedia.com/go/getflashplayer"" allowScriptAccess=""always"" " & _
                "quality=""high"" wmode=""transparent"" flashvars=""" & szFlashVars & """>" & szBr
    End If
    ' ����������֣�������Ǵ���ʼ���濪ʼ�ģ���ô������ʾ�ı�����/ͼƬ���̣����FEN����
    If Not Game_bStartPos Then
        Select Case Publish_nFormat
        Case PUB_FORMAT_TEXT, PUB_FORMAT_ANSI
            CchessFen2Board pos, Game_szFen
            szCopy = szCopy & GetBoardText(pos)
            szCopy = szCopy & "# " & Game_szFen & szBr
        Case PUB_FORMAT_UBB
            szCopy = szCopy & "[img]" & GetBoardUrl(Game_szFen) & "[/img]" & szBr
            szCopy = szCopy & "# [url=http://www.xqbase.com/pub/fen.php?fen=" & _
                    UrlEncode(Game_szFen) & "]" & Game_szFen & "[/url]" & szBr
        Case PUB_FORMAT_HTML, PUB_FORMAT_WEB
            szCopy = szCopy & "# <a href=""http://www.xqbase.com/pub/fen.php?fen=" & _
                    UrlEncode(Game_szFen) & """>" & Game_szFen & "</a>" & szBr
        End Select
    End If
    ' ��ʾ�ı����ף���ɫ����
    Select Case Publish_nFormat
    Case PUB_FORMAT_ANSI
        szCopy = szCopy & Chr(27) & "[1;33m"
    Case PUB_FORMAT_UBB
        szCopy = szCopy & "[color=#003333]"
    Case PUB_FORMAT_HTML, PUB_FORMAT_WEB
        szCopy = szCopy & "<font color=""#003333"">"
    End Select
    ' �������
    If Game_szComment(0) <> "" Then
        szCopy = szCopy & "{" & Replace(Game_szComment(0), vbCrLf, szBr) & "}" & szBr
    End If
    bReturned = True
    cnt = Game_cntStart
    sd = Game_sdStart
    For i = 1 To Game_nMaxMove
        If bReturned Then
            szCopy = szCopy & Space(3 - Len("" & cnt)) & cnt & ". "
            If sd = 1 Then
                szCopy = szCopy & Space(Choose(Game_nFormat + 1, 8, 4, 5))
            End If
        End If
        If sd = 0 Then
            szCopy = szCopy & Game_szMoveText(Game_nFormat, i)
            bReturned = False
        Else
            szCopy = szCopy & " " & Game_szMoveText(Game_nFormat, i) & szBr
            bReturned = True
        End If
        If Game_szComment(i) <> "" Then
            If Not bReturned Then
                szCopy = szCopy & szBr
            End If
            szCopy = szCopy & "{" & Replace(Game_szComment(i), vbCrLf, szBr) & "}" & szBr
            bReturned = True
        End If
        sd = 1 - sd
        cnt = cnt + 1 - sd
    Next
    szCopy = szCopy & Choose(Game_nResult + 1, " *", " 1-0", " 1/2-1/2", " 0-1") & szBr
    ' ȡ����ɫ
    Select Case Publish_nFormat
    Case PUB_FORMAT_ANSI
        szCopy = szCopy & Chr(27) & "[1;0m"
    Case PUB_FORMAT_UBB
        szCopy = szCopy & "[/color]"
    Case PUB_FORMAT_HTML, PUB_FORMAT_WEB
        szCopy = szCopy & "</font>"
    End Select
    ' �����ǹ�����ճ�����ı�����
End If
' ��������ʦ�������
If Not Publish_bContent Then
    szCopy = szCopy & "===============================================" & szBr
End If
Select Case Publish_nFormat
Case PUB_FORMAT_TEXT, PUB_FORMAT_ANSI
    szCopy = szCopy & szAd & "www.xqbase.com"
Case PUB_FORMAT_UBB
    szCopy = szCopy & szAd & "[url=http://www.xqbase.com/]www.xqbase.com[/url]"
Case PUB_FORMAT_HTML, PUB_FORMAT_WEB
    szCopy = szCopy & szAd & "<a href=""http://www.xqbase.com/"">www.xqbase.com</a>"
End Select
' ��szCopy�����ݸ��Ƶ�������
If Publish_nFormat = PUB_FORMAT_WEB Then
    With frmHide2.web.Document
        .body.innerHtml = szCopy
        .execCommand "SelectAll"
        .execCommand "Copy"
        .body.innerHtml = ""
    End With
Else
    Clipboard.Clear
    Clipboard.SetText szCopy
End If
' ��Ҫ��������ҳ
Select Case Publish_nLocation
Case PUB_LOCATION_ZHIDAO
    ShellExecuteA 0, vbNullString, "http://zhidao.baidu.com/", _
            vbNullString, vbNullString, vbNormalFocus
Case PUB_LOCATION_TIEBA
    ShellExecuteA 0, vbNullString, "http://tieba.baidu.com/f?kw=%CF%F3%C6%E5#sub", _
            vbNullString, vbNullString, vbNormalFocus
Case PUB_LOCATION_SINA
    ShellExecuteA 0, vbNullString, "http://control.blog.sina.com.cn/admin/article/article_add.php?index", _
            vbNullString, vbNullString, vbNormalFocus
Case PUB_LOCATION_QZONE
    ShellExecuteA 0, vbNullString, "http://user.qzone.qq.com/", _
            vbNullString, vbNullString, vbNormalFocus
End Select
MsgBox L("�����Ѹ��Ƶ������壬���ҵ��������ӵ����ݿ򣬰�Ctrl-V��ճ����", _
        "���V���}�u�����N�壬Ո�ҵ��l�����ӵă��ݿ򣬰�Ctrl-V�Iճ�N��"), vbInformation

End Sub

Private Sub btnCancel_Click()

Unload Me

End Sub

Private Sub txtBoardUrl_Click()

txtBoardUrl.SelStart = 0
txtBoardUrl.SelLength = Len(txtBoardUrl)

End Sub

Private Sub cmbFormat_Click()

Publish_nFormat = cmbFormat.ListIndex

End Sub

Private Sub cmbLocation_Click()

Publish_nLocation = cmbLocation.ListIndex
Select Case Publish_nLocation
Case PUB_LOCATION_ZHIDAO
    Publish_nFormat = PUB_FORMAT_TEXT
Case PUB_LOCATION_TIEBA
    Publish_nFormat = PUB_FORMAT_TEXT
Case PUB_LOCATION_SINA
    Publish_nFormat = PUB_FORMAT_WEB
Case PUB_LOCATION_QZONE
    Publish_nFormat = PUB_FORMAT_WEB
End Select
cmbFormat.ListIndex = Publish_nFormat

End Sub

Private Sub lblViewBoard_Click()

ShellExecuteA 0, vbNullString, txtBoardUrl.Text, vbNullString, vbNullString, vbNormalFocus

End Sub

Private Sub lblLocation_Click()

ShellExecuteA 0, vbNullString, "http://www.xqbase.com/xqwizard/help_publish.htm#location", _
        vbNullString, vbNullString, vbNormalFocus

End Sub

Private Sub lblFormat_Click()

ShellExecuteA 0, vbNullString, "http://www.xqbase.com/xqwizard/help_publish.htm#format", _
        vbNullString, vbNullString, vbNormalFocus

End Sub

Private Function GetBoardUrl(ByVal szFen As String) As String

GetBoardUrl = "http://www.xqbase.com/pub/board.php?fen=" & UrlEncode(szFen) & _
        "&size=" & Publish_nSize & "&board=" & cmbBoard.ListIndex & "&pieces=" & cmbPieces.ListIndex

End Function

Private Function GetBoardText(ByRef pos As PositionStruct) As String

Dim sz As String
sz = AllocString(CchessBoardText(pos, IIf(Publish_nFormat = PUB_FORMAT_ANSI, CCHESS_ANSI_TEXT, 0)))
' �ڰٶ������Ҫ������˫�ո�ȫ���滻"�\"(������"��")��������ʾ�������ܻ�����Щ
' If Publish_nLocation = PUB_LOCATION_TIEBA Or Publish_nLocation = PUB_LOCATION_ZHIDAO Then
If Publish_nFormat = PUB_FORMAT_ANSI Then
    sz = AllocString(CchessBoardText(pos, CCHESS_ANSI_TEXT))
Else
    sz = AllocString(CchessBoardText(pos))
    sz = Replace(sz, "  ", L("�\", "��"))
    sz = Replace(sz, "--", "��")
End If
GetBoardText = sz

End Function