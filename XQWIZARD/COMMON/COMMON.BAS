Attribute VB_Name = "mdlCommon"
' COMMON.BAS - Source Code for XiangQi Wizard & XiangQi Witchcraft School
'
' XiangQi Wizard - a Chinese Chess Program (GUI for UCCI Engines)
' XiangQi Witchcraft School - a Chinese Chess Endgame Challenge Game
' Designed by Morning Yellow, Version: 4.82, Last Modified: Oct. 2010
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

Private Const TH32CS_SNAPPROCESS As Long = 2

Private Type PROCESSENTRY32
    dwSize As Long
    cntUsage As Long
    th32ProcessID As Long
    th32DefaultHeapID As Long
    th32ModuleID As Long
    cntThreads As Long
    th32ParentProcessID As Long
    pcPriClassBase As Long
    dwFlags As Long
    szExeFile As String * 1024
End Type

Private Declare Function GetACP Lib "KERNEL32.DLL" () As Long
Private Declare Function CreateToolhelp32Snapshot Lib "KERNEL32.DLL" (ByVal dwFlags As Long, ByVal th32ProcessID As Long) As Long
Private Declare Function Process32First Lib "KERNEL32.DLL" (ByVal hSnapshot As Long, ByRef lppe As PROCESSENTRY32) As Long
Private Declare Function Process32Next Lib "KERNEL32.DLL" (ByVal hSnapshot As Long, ByRef lppe As PROCESSENTRY32) As Long
Private Declare Sub CloseHandle Lib "KERNEL32.DLL" (ByVal hObject As Long)

' 全局常量——象棋巫师信息
Public Const STRING_VERSION     As String = "4.84"
Public Const QUOTE_NUM          As Integer = 12     ' 名言条目数
Public Const ICON_QUOTE         As Integer = 8      ' 名言图标
Public Const ICON_WIN           As Integer = 15     ' 胜的图标
Public Const ICON_DRAW          As Integer = 16     ' 和的图标
Public Const ICON_LOSS          As Integer = 17     ' 负的图标
Public Const MAX_MOVE_DELAY     As Integer = 5      ' 最长延时
Public Const HELP_SCHOOL        As Boolean = True   ' HelpPublish
Public Const MANUAL_UPDATE      As Boolean = True   ' CheckUpdate
' 全局常量——棋盘(小)设置选项
Public Const BOARD_S_WOOD       As Integer = 0
Public Const BOARD_S_GREEN      As Integer = 1
Public Const BOARD_S_WHITE      As Integer = 2
Public Const BOARD_S_SHEET      As Integer = 3
Public Const BOARD_S_CANVAS     As Integer = 4
Public Const BOARD_S_DROPS      As Integer = 5
Public Const BOARD_S_CLOUDS     As Integer = 6
Public Const BOARD_S_XQSTUDIO   As Integer = 7
Public Const BOARD_S_MOVESKY    As Integer = 8
Public Const BOARD_S_MRSJ       As Integer = 9
Public Const BOARD_S_ZMBL       As Integer = 10
Public Const BOARD_S_QIANHONG   As Integer = 11
Public Const BOARD_S_MAX        As Integer = 12
' 全局常量——棋子(小)设置选项
Public Const PIECES_S_WOOD      As Integer = 0
Public Const PIECES_S_DELICATE  As Integer = 1
Public Const PIECES_S_POLISH    As Integer = 2
Public Const PIECES_S_XQSTUDIO  As Integer = 3
Public Const PIECES_S_MOVESKY   As Integer = 4
Public Const PIECES_S_MRSJ      As Integer = 5
Public Const PIECES_S_ZMBL      As Integer = 6
Public Const PIECES_S_MAX       As Integer = 7
' 全局常量——棋盘(大)设置选项
Public Const BOARD_L_WOOD       As Integer = 0
Public Const BOARD_L_GREEN      As Integer = 1
Public Const BOARD_L_WHITE      As Integer = 2
Public Const BOARD_L_SHEET      As Integer = 3
Public Const BOARD_L_CANVAS     As Integer = 4
Public Const BOARD_L_DROPS      As Integer = 5
Public Const BOARD_L_QIANHONG   As Integer = 6
Public Const BOARD_L_MAX        As Integer = 7
' 全局常量——棋子(大)设置选项
Public Const PIECES_L_WOOD      As Integer = 0
Public Const PIECES_L_DELICATE  As Integer = 1
Public Const PIECES_L_POLISH    As Integer = 2
Public Const PIECES_L_MAX       As Integer = 3
' 全局常量——音乐设置选项
Public Const MUSIC_NONE         As Integer = 0
Public Const MUSIC_EXPRESS      As Integer = 1
Public Const MUSIC_FUNNY        As Integer = 2
Public Const MUSIC_CLASSIC      As Integer = 3
Public Const MUSIC_MOZART1      As Integer = 4
Public Const MUSIC_MOZART4      As Integer = 5
Public Const MUSIC_FULELISE     As Integer = 6
Public Const MUSIC_LOVDREAM     As Integer = 7
Public Const MUSIC_WALTZ        As Integer = 8
Public Const MUSIC_HUMOUR       As Integer = 9
Public Const MUSIC_MARIO1       As Integer = 10
Public Const MUSIC_MARIO2       As Integer = 11
Public Const MUSIC_PAL          As Integer = 12
Public Const MUSIC_CMUSIC       As Integer = 13
Public Const MUSIC_MAX          As Integer = 14
' 全局变量——网站求助
Public Const HELP_PUB_ZHIDAO    As Integer = 0
Public Const HELP_PUB_TIEBA     As Integer = 1
Public Const HELP_PUB_OTHER     As Integer = 2
' 全局变量——网站求助
Public Const HELP_SHARE_QQ      As Integer = 0
Public Const HELP_SHARE_SINA     As Integer = 1
Public Const HELP_SHARE_KAIXIN001 As Integer = 2
Public Const HELP_SHARE_RENREN    As Integer = 3
Public Const HELP_SHARE_RESERVED As Integer = 4
Public Const HELP_SHARE_OTHER   As Integer = 5
' 全局常量——语言
Public Const LANGUAGE_ZH_CN     As Integer = 0
Public Const LANGUAGE_ZH_TW     As Integer = 1
Public Const LANGUAGE_MAX       As Integer = 2
' 全局变量——选项
Public Options_nMoveDelay       As Integer  ' 走子延时
Public Options_nLanguage        As Integer  ' 语言
Public Options_bLargeGui        As Boolean  ' 大界面
Public Options_nBoardS          As Integer  ' 小界面的棋盘
Public Options_nPiecesS         As Integer  ' 小界面的棋子
Public Options_nBoardL          As Integer  ' 大界面的棋盘
Public Options_nPiecesL         As Integer  ' 大界面的棋子
Public Options_bSounds          As Boolean  ' 声音
Public Options_nMusic           As Integer  ' 音乐
' 全局变量——界面(杂项)
Public Gui_szQuotes(1 To QUOTE_NUM) As String ' “名言”的条目
Public Gui_szUpgradeVer         As String   ' 检查升级的版本
Public Gui_szUpgradeDate        As String   ' 检查升级的日期
Public Gui_szAdvertDate         As String   ' 检查广告的日期
Public Gui_nAdvertIndex         As Integer  ' 当前广告序号
Public Gui_dfLastTime           As Double   ' 当前时间(每天00:00过去的秒数)

' 简繁选择，0选简体，1选繁体
Public Function L(ParamArray sz() As Variant) As String

L = sz(Options_nLanguage)

End Function

' 打开文件对话框
Public Function FileDialog(ByVal szTitle As String, ByVal szFileType As String, _
        ByVal szExt As String, Optional ByVal szSave As String = "") As String

Dim szFileName As String, szFilter As String
szFilter = szFileType & " (*." & szExt & ")|*." & szExt & "|" & L("所有文件", "所有文件") & " (*.*)|*.*"
If szSave = "" Then
    szFileName = OpenFileDialog(szTitle, szFilter)
Else
    szFileName = szSave
    szFileName = Replace(szFileName, "\", "＼")
    szFileName = Replace(szFileName, "/", "／")
    szFileName = Replace(szFileName, ":", "：")
    szFileName = Replace(szFileName, "*", "＊")
    szFileName = Replace(szFileName, "?", "？")
    ' 全角双引号用在某些操作系统上不正常，所以用半角单引号代替
    szFileName = Replace(szFileName, """", "'")
    szFileName = Replace(szFileName, "<", "＜")
    szFileName = Replace(szFileName, ">", "＞")
    szFileName = Replace(szFileName, "|", "｜")
    szFileName = SaveFileDialog(szTitle, szFilter, szFileName & "." & szExt, szExt)
End If
FileDialog = szFileName

End Function

' 设置音乐
Public Sub MusicSetting(ByVal szPath As String, ByVal nMusicIndex As Integer)

Dim i As Integer
frmHide.mci.Command = "Close"
If nMusicIndex > MUSIC_NONE Then
    frmHide.mci.FileName = szPath & "MUSICS\" & _
            Choose(nMusicIndex, "EXPRESS", "FUNNY", "CLASSIC", "MOZART1", "MOZART4", _
            "FURELISE", "LOVDREAM", "WALTZ", "HUMOUR", "MARIO1", "MARIO2", "PAL", "CMUSIC") & ".MID"
    If Not App.PrevInstance Then
        frmHide.mci.Command = "Open"
        frmHide.mci.Command = "Play"
    End If
End If
Options_nMusic = nMusicIndex

End Sub

' 无法打开文件提示
Public Sub ErrorOpen(ByVal szFileName As String)

MsgBox L("无法打开文件 ", "無法打開文件 ") & szFileName, vbExclamation

End Sub

' 获得棋子图片的文件名
Public Function PieceFileName(ByVal nIndex As Integer) As String

If nIndex = 30 Then
    PieceFileName = "RKM"
ElseIf nIndex = 31 Then
    PieceFileName = "BKM"
ElseIf nIndex >= 15 Then
    PieceFileName = PieceFileName(nIndex - 15) & "S"
Else
    If nIndex = 0 Then
        PieceFileName = "OO"
    Else
        If nIndex > 7 Then
            PieceFileName = "B" & PieceByte(nIndex - 8)
        Else
            PieceFileName = "R" & PieceByte(nIndex - 1)
        End If
    End If
End If

End Function

' 推荐给好友
Public Sub HelpPublish(ByVal nIndex As Integer, ByVal szTitle As String, ByVal szFen As String, _
        Optional ByVal bSchool As Boolean = False)

Dim pos As PositionStruct
CchessFen2Board pos, szFen
Clipboard.Clear
Clipboard.SetText szTitle & vbCrLf & _
        Replace(Replace(AllocString(CchessBoardText(pos)), "  ", L("‐", "．")), "--", "—") & _
        L("=== 本棋谱由象棋巫师生成，欢迎访问 www.xqbase.com ===", "=== 本棋譜由象棋巫師生成，歡迎訪問 www.xqbase.com ===")
Select Case nIndex
Case HELP_PUB_ZHIDAO
    ShellExecuteA 0, vbNullString, "http://zhidao.baidu.com/", _
            vbNullString, vbNullString, vbNormalFocus
Case HELP_PUB_TIEBA
    ShellExecuteA 0, vbNullString, "http://tieba.baidu.com/f?kw=%CF%F3%C6%E5#sub", _
            vbNullString, vbNullString, vbNormalFocus
End Select
MsgBox L("棋谱已复制到剪贴板，请找到发表帖子的内容框，按Ctrl-V键粘贴。", _
        "棋譜已複製到剪貼板，請找到發表帖子的內容框，按Ctrl-V鍵粘貼。") & _
        IIf(bSchool, vbCrLf & vbCrLf & L("每位学员的题目是不一样的，所以请务必把题目粘贴完整。", _
        "每位學員的題目是不一樣的，所以請務必把題目粘貼完整。"), ""), vbInformation

End Sub

' “推荐给好友”的广告词
Public Function ShareWords() As String

ShareWords = L("象棋巫师 - 功能超强的中国象棋教学、电脑对弈和棋谱编辑软件", _
        "象棋巫師 - 功能超強的中國象棋教學、電腦對弈和棋譜編輯軟件")

End Function

' 推荐给好友
Public Sub HelpShare(ByVal nIndex As Integer, ByVal szTitle As String, ByVal szUrl As String)

Select Case nIndex
Case HELP_SHARE_QQ
    ShellExecuteA 0, vbNullString, "http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?" & _
            "url=" & UrlEncode(szUrl), vbNullString, vbNullString, vbNormalFocus
Case HELP_SHARE_SINA
    ShellExecuteA 0, vbNullString, "http://v.t.sina.com.cn/share/share.php?title=" & _
            szTitle & "&url=" & UrlEncode(szUrl), vbNullString, vbNullString, vbNormalFocus
Case HELP_SHARE_KAIXIN001
    ShellExecuteA 0, vbNullString, "http://www.kaixin001.com/~repaste/repaste.php?rtitle=" & _
            szTitle & "%20%20%20%20&rcontent=" & szTitle & _
            "%20%20%20%20&rurl=" & UrlEncode(szUrl), vbNullString, vbNullString, vbNormalFocus
Case HELP_SHARE_RENREN
    ShellExecuteA 0, vbNullString, "http://share.renren.com/share/buttonshare.do?" & _
            "link=" & UrlEncode(szUrl), vbNullString, vbNullString, vbNormalFocus
Case HELP_SHARE_OTHER
    Clipboard.Clear
    Clipboard.SetText szTitle & " " & vbCrLf & szUrl
    MsgBox L("推荐链接已复制到剪贴板，您可以将推荐链接粘贴到任何网站、论坛、社区上(按Ctrl-V键粘贴)。", _
            "推薦鏈接已複製到剪貼板，您可以將推薦鏈接粘貼到任何網站、論壇、社區上(按Ctrl-V鍵粘貼)。") & vbCrLf & vbCrLf & _
            L("感谢您对象棋巫师的支持。", "感謝您對象棋巫師的支持。"), vbInformation
End Select

End Sub

' 关于象棋巫师
Public Sub AboutXQWizard()

MessageBeep vbInformation
If Options_nLanguage = LANGUAGE_ZH_CN Then
    MsgBoxIcon "象棋巫师 " & STRING_VERSION & vbCrLf & vbCrLf & "版权所有 (C) 2010 上海贤趣信息技术有限公司", , "关于象棋巫师"
Else
    MsgBoxIcon "象棋巫師 " & STRING_VERSION & vbCrLf & vbCrLf & "版權所有 (C) 2010 上海賢趣信息技術有限公司", , "關於象棋巫師"
End If

End Sub

' 检查更新
Public Sub CheckUpdate(ByVal szReferer As String, Optional ByVal bManual As Boolean = False)

Dim sz As String, szUserID As String, szWhatsNew As String
Dim dwCounter(0 To 1) As Long

sz = ""
QueryPerformanceCounter VarPtr(dwCounter(0))
szUserID = GetSetting("XQWizard", "Gui", "UserID", Hex(dwCounter(0)) & Hex(dwCounter(1)))
On Error Resume Next
sz = frmHide.Inet.OpenURL("http://www.xqbase.com/xqwizard/version.php?referer=" & szReferer & "&version=" & _
        STRING_VERSION & "&userid=" & szUserID)
On Error GoTo 0
If sz = "" Then
    If bManual Then
        MsgBox L("无法访问 www.xqbase.com，请稍后再试。", "無法訪問 www.xqbase.com，請稍後再試。"), vbExclamation
    End If
Else
    Gui_szUpgradeDate = Date ' 如果访问升级信息成功，那么当天就不再访问升级信息
    SaveSetting "XQWizard", "Gui", "UpgradeDate", Gui_szUpgradeDate ' 立即写注册表，避免重开窗口导致的重复访问
    SaveSetting "XQWizard", "Gui", "UserID", szUserID               ' 同上
    If Val(sz) > Val(STRING_VERSION) + 0.005 And (bManual Or Val(sz) > Val(Gui_szUpgradeVer) + 0.005) Then
        szWhatsNew = ""
        On Error Resume Next
        szWhatsNew = frmHide.Inet.OpenURL("http://www.xqbase.com/xqwizard/whatsnew_" & L("simp.txt", "trad.txt"))
        On Error GoTo 0
        If szWhatsNew = "" Then
            szWhatsNew = L("象棋巫师 ", "象棋巫師") & sz & _
                    L(" 已经发布，需要下载最新版本吗？", " 已經發布，需要下載最新版本嗎？")
        End If
        If MsgBox(szWhatsNew, vbQuestion + vbYesNo) = vbYes Then
            ShellExecuteA 0, vbNullString, "http://www.xqbase.com/xqwizard/download.php", _
                    vbNullString, vbNullString, vbNormalFocus
        Else
            Gui_szUpgradeVer = sz
        End If
    Else
        If bManual Then
            MsgBox L("您的象棋巫师已经是最新版本了。", "您的象棋巫師已經是最新版本了。"), vbInformation
        End If
    End If
End If

End Sub

' 退弹
Public Sub ExitPopup()

Dim szUrl As String
' 用到时才读注册表，避免重开窗口导致的重复访问。这里的做法与Gui_szAdvertDate相反，但达到的目的是一样的。
If GetSetting("XQWizard", "Gui", "PopupDate", "") = Date Then
    Exit Sub
End If
' 如果退弹成功，那么当天就不再退弹了
SaveSetting "XQWizard", "Gui", "PopupDate", Date
szUrl = ""
On Error Resume Next
szUrl = frmHide.Inet.OpenURL("http://www.xqbase.com/advert/popup.txt")
On Error GoTo 0
If Left(szUrl, 7) = "http://" Then
    ShellExecuteA 0, vbNullString, szUrl, vbNullString, vbNullString, vbNormalFocus
End If

End Sub

' 加载“名言”
Public Sub LoadQuotes()

If Options_nLanguage = LANGUAGE_ZH_CN Then

Gui_szQuotes(1) = "子曰：“学而时习之，不亦说乎？有朋自远方来，不亦乐乎？人不知而不愠，不亦君子乎？”" & vbCrLf & vbCrLf & _
        "　　　　　　　　　　　　　　　　　　　　——《论语·学而》"
Gui_szQuotes(2) = "子贡问曰：“有一言而可以终身行之者乎？”子曰：“其恕乎！己所不欲，勿施于人。”" & vbCrLf & vbCrLf & _
        "　　　　　　　　　　　　　　　　　　　　——《论语·卫灵公》"
Gui_szQuotes(3) = "或曰：“以德报怨，何如？”子曰：“何以报德？以直报怨，以德报德。”" & vbCrLf & vbCrLf & _
        "　　　　　　　　　　　　　　　　　　　　——《论语·宪问》"
Gui_szQuotes(4) = "子夏曰：“博学而笃志，切问而近思；仁在其中矣。”" & vbCrLf & vbCrLf & _
        "　　　　　　　　　　　　　　　　　　　　——《论语·子张》"
Gui_szQuotes(5) = "子曰：“不患人之不己知，患不知人也。”" & vbCrLf & vbCrLf & _
        "　　　　　　　　　　　　　　　　　　　　——《论语·学而》"
Gui_szQuotes(6) = "子曰：“三人行，必有我师焉：择其善者而从之，其不善者而改之。”" & vbCrLf & vbCrLf & _
        "　　　　　　　　　　　　　　　　　　　　——《论语·述而》"
Gui_szQuotes(7) = "将欲歙之，必固张之；将欲弱之，必固强之；将欲废之，必固兴之；将欲取之，必固与之。是谓微明。" & vbCrLf & vbCrLf & _
        "　　　　　　　　　　　　　　　　　　　　——《老子·第三十六章》"
Gui_szQuotes(8) = "柔弱胜刚强。鱼不可脱于渊，国之利器不可以示人。" & vbCrLf & vbCrLf & _
        "　　　　　　　　　　　　　　　　　　　　——《老子·第三十六章》"
Gui_szQuotes(9) = "图难于其易；为大于其细。天下难事，必作于易；天下大事，必作于细。" & vbCrLf & vbCrLf & _
        "　　　　　　　　　　　　　　　　　　　　——《老子·第六十三章》"
Gui_szQuotes(10) = "合抱之木，生于毫末；九层之台，起于累土；千里之行，始于足下。" & vbCrLf & vbCrLf & _
        "　　　　　　　　　　　　　　　　　　　　——《老子·第六十四章》"
Gui_szQuotes(11) = "知彼知己，胜乃不殆；知天知地，胜乃可全。" & vbCrLf & vbCrLf & _
        "　　　　　　　　　　　　　　　　　　　　——《孙子兵法·地形》"
Gui_szQuotes(12) = "怒可以复喜，愠可以复说，亡国不可以复存，死者不可以复生。" & vbCrLf & vbCrLf & _
        "　　　　　　　　　　　　　　　　　　　　——《孙子兵法·火攻》"

Else

Gui_szQuotes(1) = "子曰：“學而時習之，不亦說乎？有朋自遠方來，不亦樂乎？人不知而不慍，不亦君子乎？”" & vbCrLf & vbCrLf & _
        "　　　　　　　　　　　　　　　　　　　　——《論語．學而》"
Gui_szQuotes(2) = "子貢問曰：“有一言而可以終身行之者乎？”子曰：“其恕乎！己所不欲，勿施於人。”" & vbCrLf & vbCrLf & _
        "　　　　　　　　　　　　　　　　　　　　——《論語．衛靈公》"
Gui_szQuotes(3) = "或曰：“以德報怨，何如？”子曰：“何以報德？以直報怨，以德報德。”" & vbCrLf & vbCrLf & _
        "　　　　　　　　　　　　　　　　　　　　——《論語．憲問》"
Gui_szQuotes(4) = "子夏曰：“博學而篤志，切問而近思；仁在其中矣。”" & vbCrLf & vbCrLf & _
        "　　　　　　　　　　　　　　　　　　　　——《論語．子張》"
Gui_szQuotes(5) = "子曰：“不患人之不己知，患不知人也。”" & vbCrLf & vbCrLf & _
        "　　　　　　　　　　　　　　　　　　　　——《論語．學而》"
Gui_szQuotes(6) = "子曰：“三人行，必有我師焉：擇其善者而從之，其不善者而改之。”" & vbCrLf & vbCrLf & _
        "　　　　　　　　　　　　　　　　　　　　——《論語．述而》"
Gui_szQuotes(7) = "將欲歙之，必固張之；將欲弱之，必固強之；將欲廢之，必固興之；將欲取之，必固与之。是謂微明。" & vbCrLf & vbCrLf & _
        "　　　　　　　　　　　　　　　　　　　　——《老子．第三十六章》"
Gui_szQuotes(8) = "柔弱胜剛強。魚不可脫於淵，國之利器不可以示人。" & vbCrLf & vbCrLf & _
        "　　　　　　　　　　　　　　　　　　　　——《老子．第三十六章》"
Gui_szQuotes(9) = "圖難於其易；為大於其細。天下難事，必作於易；天下大事，必作於細。" & vbCrLf & vbCrLf & _
        "　　　　　　　　　　　　　　　　　　　　——《老子．第六十三章》"
Gui_szQuotes(10) = "合抱之木，生於毫末；九層之台，起於累土；千里之行，始於足下。" & vbCrLf & vbCrLf & _
        "　　　　　　　　　　　　　　　　　　　　——《老子．第六十四章》"
Gui_szQuotes(11) = "知彼知己，胜乃不殆；知天知地，胜乃可全。" & vbCrLf & vbCrLf & _
        "　　　　　　　　　　　　　　　　　　　　——《孫子兵法．地形》"
Gui_szQuotes(12) = "怒可以複喜，慍可以複說，亡國不可以複存，死者不可以複生。" & vbCrLf & vbCrLf & _
        "　　　　　　　　　　　　　　　　　　　　——《孫子兵法．火攻》"

End If

End Sub

' 设置语言(选项)
Public Sub SetLangOptions(ByVal frm As Form)

If Options_nLanguage = LANGUAGE_ZH_CN Then
    Exit Sub
End If
frm.mnOptions.Caption = "選項(&O)"
frm.mnOptionsGui.Caption = "窗口(&W)"
frm.mnOptionsGuiSmall.Caption = "小(&S)"
frm.mnOptionsGuiLarge.Caption = "大(&L)"
frm.mnOptionsBoard_.Caption = "棋盤(&B)"
frm.mnOptionsPieces_.Caption = "棋子(&P)"
frm.mnOptionsAnimation_.Caption = "走棋動畫(&A)"
frm.mnOptionsAnimation(0).Caption = "無(&A)"
frm.mnOptionsAnimation(1).Caption = "快(&B)"
frm.mnOptionsAnimation(2).Caption = "稍快(&C)"
frm.mnOptionsAnimation(3).Caption = "中速(&D)"
frm.mnOptionsAnimation(4).Caption = "稍慢(&E)"
frm.mnOptionsAnimation(5).Caption = "慢(&F)"
frm.mnOptionsSounds.Caption = "音效(&S)"
frm.mnOptionsMusic_.Caption = "音樂(&M)"
frm.mnOptionsMusic(0).Caption = "無聲(&A)"
frm.mnOptionsMusic(1).Caption = "緊張(&B)"
frm.mnOptionsMusic(2).Caption = "風趣(&C)"
frm.mnOptionsMusic(3).Caption = "巴赫(&D)"
frm.mnOptionsMusic(4).Caption = "莫扎特一(&E)"
frm.mnOptionsMusic(5).Caption = "莫扎特四(&F)"
frm.mnOptionsMusic(6).Caption = "貝多芬(&G)"
frm.mnOptionsMusic(7).Caption = "李斯特(&H)"
frm.mnOptionsMusic(8).Caption = "柴可夫斯基(&I)"
frm.mnOptionsMusic(9).Caption = "德沃夏克(&J)"
frm.mnOptionsMusic(10).Caption = "馬里奧一(&K)"
frm.mnOptionsMusic(11).Caption = "馬里奧二(&L)"
frm.mnOptionsMusic(12).Caption = "仙劍奇俠傳(&M)"
frm.mnOptionsMusic(13).Caption = "望江南(&N)"
frm.mnOptionsLanguage_.Caption = "語言/&Language"
frm.mnOptionsLanguage(0).Caption = "簡體中文/&Simplified Chinese"
frm.mnOptionsLanguage(1).Caption = "繁體中文/&Traditional Chinese"

frm.mnHelp.Caption = "幫助(&H)"
frm.mnHelpQuote.Caption = "名言(&Q)"
frm.mnHelpShare_.Caption = "推薦給好友(&F)"
frm.mnHelpShare(0).Caption = "QQ空間(&Q)"
frm.mnHelpShare(1).Caption = "新浪微博(&S)"
frm.mnHelpShare(2).Caption = "開心網(&K)"
frm.mnHelpShare(3).Caption = "人人網(&R)"
frm.mnHelpShare(5).Caption = "其他網站(&O)"
frm.mnHelpUpdate.Caption = "檢查最新版本(&P)"
frm.mnHelpHome.Caption = "象棋百科全書(&H)"
frm.mnHelpSuggest.Caption = "意見反饋(&S)"
frm.mnHelpAbout.Caption = "關于象棋巫師(&A)"

End Sub

' 设置语言(小棋盘)
Public Sub SetLangSmall(ByVal frm As Form)

If Options_nLanguage = LANGUAGE_ZH_CN Then
    Exit Sub
End If
frm.mnOptionsBoard(0).Caption = "櫟木(&A)"
frm.mnOptionsBoard(1).Caption = "綠色大理石(&B)"
frm.mnOptionsBoard(2).Caption = "白色大理石(&C)"
frm.mnOptionsBoard(3).Caption = "再生紙(&D)"
frm.mnOptionsBoard(4).Caption = "畫布(&E)"
frm.mnOptionsBoard(5).Caption = "水滴(&F)"
frm.mnOptionsBoard(6).Caption = "藍天白雲(&G)"
frm.mnOptionsBoard(7).Caption = "象棋演播室(&H)"
frm.mnOptionsBoard(8).Caption = "弈天棋緣(&I)"
frm.mnOptionsBoard(9).Caption = "夢入神機(&J)"
frm.mnOptionsBoard(10).Caption = "縱馬奔流(&K)"
frm.mnOptionsBoard(11).Caption = "淺紅象棋(&L)"
frm.mnOptionsPieces(0).Caption = "木刻(&A)"
frm.mnOptionsPieces(1).Caption = "精緻(&B)"
frm.mnOptionsPieces(2).Caption = "光澤(&C)"
frm.mnOptionsPieces(3).Caption = "象棋演播室(&D)"
frm.mnOptionsPieces(4).Caption = "弈天棋緣(&E)"
frm.mnOptionsPieces(5).Caption = "夢入神機(&F)"
frm.mnOptionsPieces(6).Caption = "縱馬奔流(&G)"

End Sub

' 设置语言(大棋盘)
Public Sub SetLangLarge(ByVal frm As Form)

If Options_nLanguage = LANGUAGE_ZH_CN Then
    Exit Sub
End If
frm.mnOptionsBoard(0).Caption = "櫟木(&A)"
frm.mnOptionsBoard(1).Caption = "綠色大理石(&B)"
frm.mnOptionsBoard(2).Caption = "白色大理石(&C)"
frm.mnOptionsBoard(3).Caption = "再生紙(&D)"
frm.mnOptionsBoard(4).Caption = "畫布(&E)"
frm.mnOptionsBoard(5).Caption = "水滴(&F)"
frm.mnOptionsBoard(6).Caption = "淺紅象棋(&G)"
frm.mnOptionsPieces(0).Caption = "木刻(&A)"
frm.mnOptionsPieces(1).Caption = "精緻(&B)"
frm.mnOptionsPieces(2).Caption = "光澤(&C)"

End Sub

' 从注册表加载参数
Public Sub LoadRegs()

Options_nMoveDelay = Str2Int(GetSetting("XQWizard", "Options", "MoveDelay", "1"), 0, MAX_MOVE_DELAY)
Options_nLanguage = Str2Int(GetSetting("XQWizard", "Options", "Language", IIf(GetACP = 950, "1", "0")), 0, LANGUAGE_MAX - 1)
Options_bLargeGui = (Str2Int(GetSetting("XQWizard", "Options", "LargeGui", IIf(Screen.Height > 10000, "1", "0"))) <> 0)
Options_nBoardS = Str2Int(GetSetting("XQWizard", "Options", "BoardSmall", "0"), 0, BOARD_S_MAX - 1)
Options_nPiecesS = Str2Int(GetSetting("XQWizard", "Options", "PiecesSmall", "0"), 0, PIECES_S_MAX - 1)
Options_nBoardL = Str2Int(GetSetting("XQWizard", "Options", "BoardLarge", "0"), 0, BOARD_L_MAX - 1)
Options_nPiecesL = Str2Int(GetSetting("XQWizard", "Options", "PiecesLarge", "0"), 0, PIECES_L_MAX - 1)
Options_bSounds = (Str2Int(GetSetting("XQWizard", "Options", "Sounds", "1")) <> 0)
Options_nMusic = Str2Int(GetSetting("XQWizard", "Options", "Music", "0"), 0, MUSIC_MAX - 1)
Gui_szUpgradeVer = GetSetting("XQWizard", "Gui", "UpgradeVer", STRING_VERSION)
Gui_szUpgradeDate = GetSetting("XQWizard", "Gui", "UpgradeDate", "")
Gui_szAdvertDate = GetSetting("XQWizard", "Gui", "AdvertDate", "")

End Sub

' 保存参数到注册表
Public Sub SaveRegs()

SaveSetting "XQWizard", "Options", "MoveDelay", Options_nMoveDelay
SaveSetting "XQWizard", "Options", "BoardSmall", Options_nBoardS
SaveSetting "XQWizard", "Options", "PiecesSmall", Options_nPiecesS
SaveSetting "XQWizard", "Options", "BoardLarge", Options_nBoardL
SaveSetting "XQWizard", "Options", "PiecesLarge", Options_nPiecesL
SaveSetting "XQWizard", "Options", "Sounds", IIf(Options_bSounds, "1", "0")
SaveSetting "XQWizard", "Options", "Music", Options_nMusic
SaveSetting "XQWizard", "Gui", "UpgradeVer", Gui_szUpgradeVer
SaveSetting "XQWizard", "Gui", "AdvertDate", Gui_szAdvertDate

End Sub

Public Function FindProcess(ByVal szName As String) As Boolean

Dim hSnapshot As Long, pe As PROCESSENTRY32
Dim i As Integer

FindProcess = False
hSnapshot = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0)
If hSnapshot = 0 Then
    Exit Function
End If

szName = UCase(szName)
pe.dwSize = Len(pe)
If Process32First(hSnapshot, pe) <> 0 Then
    Do
        If InStr(UCase(pe.szExeFile), szName) > 0 Then
            FindProcess = True
            Exit Do
        End If
    Loop Until Process32Next(hSnapshot, pe) = 0
End If
CloseHandle hSnapshot

End Function
