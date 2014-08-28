Attribute VB_Name = "mdlXQBooth"
' XQBOOTH.BAS - Source Code for XiangQi Booth, Part I
'
' XiangQi Booth - a Chinese Chess Endgame Challenge Game
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

Private Declare Sub InitCipher Lib "XQBLCODE.DLL" Alias "_InitCipher@0" ()
Private Declare Function Encrypt Lib "XQBLCODE.DLL" Alias "_Encrypt@4" (ByVal nData As Long) As Long
Private Declare Function Decrypt Lib "XQBLCODE.DLL" Alias "_Decrypt@4" (ByVal nData As Long) As Long

' ȫ�ֳ�������������ʦ����
Public Const MAX_ENDGAMES       As Integer = 4096   ' �оֵ������Ŀ��
Public Const ENDGAME_FILE       As String = "ENDGAMES\BOOTH.EPD"    ' �о��ļ�
Public Const ENGINE_FILE        As String = "ELEEYE.EXE"            ' �����ļ�
Public Const XQAPP_URL          As String = "http://www.xqbase.com/xqbooth/"    ' ħ��ѧУ��ַ
' Public Const XQAPP_URL          As String = "http://localhost:8080/xqbooth/"    ' ħ��ѧУ��ַ
' ȫ�ֳ���������¼״̬
Public Const LOGIN_OK           As Integer = 0
Public Const LOGIN_FIRST        As Integer = 1
Public Const LOGIN_ERROR        As Integer = 2
Public Const LOGIN_CANCELED     As Integer = 3
' ȫ�ֳ���������ѡ����
Public Const DRAW_SELECTED      As Boolean = True
Public Const DRAW_MATE          As Boolean = True
Public Const DRAW_REFRESH       As Boolean = True
' ȫ�ֳ����������ؽ׶�
Public Const PHASE_READY        As Integer = 0
Public Const PHASE_WIN          As Integer = 1
Public Const PHASE_LOSS         As Integer = 2
' ȫ�ֳ���������ʾ״̬
Public Const HINT_NONE          As Integer = 0
Public Const HINT_RESTART       As Integer = 1
Public Const HINT_RETRY         As Integer = 2

' ȫ�ֱ�����������
Public App_frmMain              As Form     ' �����ڶ�������
Public App_szPath               As String   ' ���������ڵ��ļ��У���"\"��β
Public App_bRunning             As Boolean  ' �������б�־������ʱ���True�������False���������¼����ѭ��
Public App_nEndgames            As Integer  ' ����Ĳо�����
Public App_szEndgames(0 To MAX_ENDGAMES - 1) As String  ' ����Ĳо�
Public App_pos                  As PositionStruct   ' ���
Public App_mvLast               As Long     ' ���µ�һ���ŷ����������б��
Public App_sqSelected           As Integer  ' ���ѡ�е�����
Public App_nPhase               As Integer  ' ���ؽ׶�
Public App_nUsersEvent          As Integer  ' �û������¼�
Public App_nHint                As Integer  ' ��ʾ״̬
Public App_dfHintTime           As Double   ' ��ʾ����ʱ��
' ȫ�ֱ�����������
Public Gui_nCurr                As Integer  ' ��ǰ�оֵ���Ŀ���
Public Gui_nLast                As Integer  ' ���оֵ���Ŀ���
' ȫ�ֱ���������¼
Public Login_nStatus            As Integer  ' ��¼״̬
Public Login_szAct              As String   ' ��¼����
Public Login_szResult           As String   ' ��¼���
Public Login_szUserName         As String   ' ��¼�û���
Public Login_szPassword         As String   ' ��¼����
Public Login_bRemember          As Boolean  ' ��ס����
' ȫ�ֱ�����������
Public Engine_pipe              As PipeStruct ' ����ܵ�

' ��������
Public Sub PlayWavSound(ByVal szSoundFile As String)

If Options_bSounds Then
    PlaySoundA App_szPath & "SOUNDS\" & szSoundFile & ".WAV", 0, _
            SND_ASYNC + SND_NOWAIT + SND_FILENAME
End If

End Sub

' �����ʾ
Public Sub ClearHint()

App_nHint = HINT_NONE
App_dfHintTime = Timer

End Sub

' �������
Public Sub LoadGame()

Dim bNext As Boolean
App_frmMain.mnGameXQWizard.Enabled = False
bNext = Gui_nCurr < Gui_nLast And Gui_nCurr < App_nEndgames - 1
App_frmMain.mnGameNext.Enabled = bNext
App_frmMain.btnNext.Enabled = bNext
App_frmMain.mnGameHint.Enabled = True
App_frmMain.btnHint.Enabled = True
App_frmMain.mnGameRetract.Enabled = False
App_frmMain.btnRetract.Enabled = False
App_frmMain.Caption = L("�� ", "�� ") & (Gui_nCurr + 1) & L(" �� - ������ʦħ��ѧУ", " �P - �����׎�ħ���WУ")
CchessFen2Board App_pos, App_szEndgames(Gui_nCurr)
BoardFlush
App_sqSelected = 0
App_mvLast = 0
App_nPhase = PHASE_READY
If App_nHint = HINT_RETRY Then
    App_nHint = HINT_RESTART
End If

End Sub

' ����������ʾ���ӣ����ָ��"DRAW_SELECTED"������������ʾһ����ǿ�
Public Sub DrawSquare(ByVal sq As Integer, Optional ByVal bSelected As Boolean = False, _
        Optional ByVal bMate As Boolean = False, Optional ByVal bRefresh As Boolean = False)

Dim pc As Integer, nPicId As Integer, img As Image, i As Integer, x As Integer, y As Integer
pc = App_pos.ucpcSquares(sq)
If pc = 0 Then
    nPicId = 0
Else
    nPicId = PieceType(pc) + IIf(pc < 32, 1, 8)
End If
nPicId = nPicId + IIf(bSelected, 15, 0)
Set img = App_frmMain.imgSquares((sq \ 16 - 3) * 9 + sq Mod 16 - 3)
If bMate Then
    nPicId = IIf(pc = 16, 30, IIf(pc = 32, 31, nPicId))
    img.ZOrder
    x = img.Left
    y = img.Top
    For i = 5 To 1 Step -1
        img.Move x + i * 20, y
        img.Refresh
        Sleep 50
        img.Move x - i * 20, y
        img.Refresh
        Sleep 50
    Next
    img.Move x, y
End If
If Options_bLargeGui Then
    img.Picture = frmHide.imgPiecesLarge(nPicId).Picture
Else
    img.Picture = frmHide.imgPiecesSmall(nPicId).Picture
End If
If bRefresh Then
    img.Refresh
End If

End Sub

' ˢ������
Public Sub BoardFlush()

Dim i As Integer, j As Integer
For i = 3 To 12
    For j = 3 To 11
        DrawSquare i * 16 + j
    Next
Next

End Sub

' ����
Public Sub Animate(ByVal mv As Long, ByVal nSteps As Integer)

Dim sqSrc As Integer, sqDst As Integer
Dim i As Integer, xSrc As Long, ySrc As Long, xDst As Long, yDst As Long, img As Image

sqSrc = Src(mv)
sqDst = Dst(mv)
yDst = sqDst \ 16
xDst = sqDst Mod 16
Set img = App_frmMain.imgSquares((yDst - 3) * 9 + xDst - 3)
xDst = img.Left
yDst = img.Top
ySrc = sqSrc \ 16
xSrc = sqSrc Mod 16
Set img = App_frmMain.imgSquares((ySrc - 3) * 9 + xSrc - 3)
xSrc = img.Left
ySrc = img.Top
img.ZOrder
For i = 1 To nSteps
    img.Move (xSrc * (nSteps - i) + xDst * i) \ nSteps, (ySrc * (nSteps - i) + yDst * i) \ nSteps
    img.Refresh
    Sleep 25
Next
If Options_bLargeGui Then
    img.Picture = frmHide.imgPiecesLarge(0).Picture
Else
    img.Picture = frmHide.imgPiecesSmall(0).Picture
End If
img.Move xSrc, ySrc
img.Refresh

End Sub

' �������
Public Sub ClickSquare(ByVal sq As Integer)

Dim pc As Integer, mv As Long, nStatus As Long

pc = App_pos.ucpcSquares(sq)
If (pc And (16 + App_pos.sdPlayer * 16)) <> 0 Then
    If App_sqSelected > 0 Then
        DrawSquare App_sqSelected
    End If
    App_sqSelected = sq
    DrawSquare App_sqSelected, DRAW_SELECTED
    If App_mvLast > 0 Then
        DrawSquare Src(App_mvLast)
        DrawSquare Dst(App_mvLast)
    End If
    PlayWavSound "CLICK"
ElseIf App_sqSelected > 0 Then
    mv = Move(App_sqSelected, sq)
    If CchessTryMove(App_pos, nStatus, mv) Then
        If Options_nMoveDelay > 0 Then
            Animate mv, Options_nMoveDelay * 4
        End If
        ' ������˼�����ܻ�����������Ҫǿ��ˢ��
        DrawSquare Src(mv), DRAW_SELECTED, , DRAW_REFRESH
        DrawSquare Dst(mv), DRAW_SELECTED, , DRAW_REFRESH
        App_mvLast = mv
        App_sqSelected = 0
        App_nPhase = GetResult(nStatus)
        If App_nPhase = PHASE_READY Then
            mv = GetBestMove
            If App_mvLast > 0 Then
                DrawSquare Src(App_mvLast)
                DrawSquare Dst(App_mvLast)
            End If
            CchessTryMove App_pos, nStatus, mv
            If Options_nMoveDelay > 0 Then
                Sleep Options_nMoveDelay * 800
                Animate mv, Options_nMoveDelay * 4
            End If
            DrawSquare Src(mv), DRAW_SELECTED
            DrawSquare Dst(mv), DRAW_SELECTED
            App_mvLast = mv
            App_nPhase = GetResult(nStatus)
        End If
        If App_nPhase = PHASE_WIN And App_nHint = HINT_RETRY Then
            If MsgBox(L("����ʹ����ʾ����ͨ�����صģ��Ƿ�����ʾ����һ�Σ�", _
                    "����ʹ����ʾ����ͨ�^���P�ģ��Ƿ�����ʾ��ԇһ�Σ�"), vbQuestion + vbYesNo) = vbYes Then
                LoadGame
            End If
        End If
    ElseIf (nStatus And MOVE_INCHECK) <> 0 Then
        PlayWavSound "ILLEGAL"
    End If
End If

End Sub

' ��ô��ؽ��
Public Function GetResult(ByVal nStatus As Long) As Integer

Dim sqMate As Integer
App_frmMain.mnGameRetract.Enabled = True
App_frmMain.btnRetract.Enabled = True
If (nStatus And MOVE_MATE) <> 0 Then
    App_frmMain.mnGameHint.Enabled = False
    App_frmMain.btnHint.Enabled = False
    If App_pos.sdPlayer = 0 Then
        PlayWavSound "LOSS"
        If App_pos.ucsqPieces(16) > 0 Then
            DrawSquare App_pos.ucsqPieces(16), , DRAW_MATE
        End If
        MsgBoxIcon L("���ٽ�������", "Ո�ٽ��م���"), , , , ICON_LOSS
        GetResult = PHASE_LOSS
    Else
        App_frmMain.mnGameXQWizard.Enabled = True
        If Gui_nCurr < App_nEndgames - 1 Then
            App_frmMain.mnGameNext.Enabled = True
            App_frmMain.btnNext.Enabled = True
        End If
        PlayWavSound "WIN"
        If App_pos.ucsqPieces(32) > 0 Then
            DrawSquare App_pos.ucsqPieces(32), , DRAW_MATE
        End If
        If Gui_nCurr = App_nEndgames - 1 Then
            MsgBoxIcon L("��ϲ�㴳�����йؿ���", "��ϲ���J�^�����P����"), , , , ICON_WIN
        Else
            MsgBoxIcon L("��ϲ����أ�", "��ϲ���^�P��"), , , , ICON_WIN
        End If
        If Gui_nCurr = Gui_nLast Then
            Gui_nLast = Gui_nLast + 1
        End If
        GetResult = PHASE_WIN
    End If
    Exit Function
End If
If (nStatus And (MOVE_PERPETUAL Or MOVE_DRAW)) <> 0 Then
    App_frmMain.mnGameHint.Enabled = False
    App_frmMain.btnHint.Enabled = False
    PlayWavSound "LOSS"
    MsgBoxIcon L("�벻Ҫ���٣�", "Ո��Ҫ���H��"), , , , ICON_LOSS
    GetResult = PHASE_LOSS
    Exit Function
End If
' ����"position fen ..."ʹ��EPD�ļ��еĳ�ʼ���棬���Լ������Ҳ������posΪ������
If (nStatus And MOVE_CHECK) <> 0 Then
    PlayWavSound "CHECK" & IIf(App_pos.sdPlayer = 0, "2", "")
ElseIf (nStatus And MOVE_CAPTURE) <> 0 Then
    PlayWavSound "CAPTURE" & IIf(App_pos.sdPlayer = 0, "2", "")
Else
    PlayWavSound "MOVE" & IIf(App_pos.sdPlayer = 0, "2", "")
End If
GetResult = PHASE_READY

End Function

' �������߷�
Public Function GetBestMove() As Long

Dim lpStr As Long, mv As Long, nStatus As Long
Dim i As Integer, sz As String

App_frmMain.MousePointer = vbHourglass
sz = "position fen " & App_szEndgames(Gui_nCurr)
If App_pos.nMoveNum > 1 Then
    sz = sz & " moves"
    For i = 1 To App_pos.nMoveNum - 1
        sz = sz & " " & Move2Coord(App_pos.rbsList(i).mvs And &HFFFF&)
    Next
End If
PipeLineOutput Engine_pipe, sz
PipeLineOutput Engine_pipe, "go nodes 10077696"
mv = 0
Do While mv = 0
    lpStr = PipeLineInput(Engine_pipe)
    If lpStr = 0 Then
        ' DoEvents
        Sleep 1
    Else
        sz = AllocString(lpStr)
        If Left(sz, 9) = "bestmove " Then
            mv = Coord2Move(Mid(sz, 10, 4))
        End If
    End If
Loop
GetBestMove = mv
App_frmMain.MousePointer = vbDefault

End Function

' ��ȡ�浵
Public Sub DoLoad(ByVal nScore As Integer)

Dim bLoad As Boolean
bLoad = False
If nScore > Gui_nLast Then
    bLoad = True
ElseIf MsgBox(L("������ȡ�ĳɼ����統ǰ�ɼ����Ƿ񸲸ǵ�ǰ�ɼ���", _
        "�����@ȡ�ĳɿ����箔ǰ�ɿ����Ƿ��w��ǰ�ɿ���"), vbQuestion + vbYesNo) = vbYes Then
    bLoad = True
End If
If Not bLoad Then
    Exit Sub
End If
Gui_nLast = nScore
ClearHint
Gui_nCurr = IIf(Gui_nLast = App_nEndgames, Gui_nLast - 1, Gui_nLast)
LoadGame
MsgBox L("�浵��ȡ�ɹ���", "��n�@ȡ�ɹ���"), vbInformation

End Sub

' ��ȡ�浵
Public Sub OpenCode()

Dim szCode As String, nScore As Long
szCode = InputBox(L("�����԰Ѵ浵����µ��������Ի��ֻ��ϣ�Ҳ���Դ��������Ի��ֻ��ϸ��µ����", _
        "�����԰Ѵ�n�a���µ�������X���֙C�ϣ�Ҳ���ԏ�������X���֙C�ϸ��µ��@�e��"), _
        L("�浵��", "��n�a"), Mid(100000000 + Encrypt(Gui_nLast), 2))
If szCode = "" Then
    Exit Sub
End If
If Len(szCode) <> 8 Then
    MsgBox L("�浵�������8Ϊ���֡�", "�浵�������8Ϊ���֡�"), vbExclamation
    Exit Sub
End If
nScore = Decrypt(Str2Lng(szCode, 0, 99999999))
If nScore < 0 Or nScore > App_nEndgames Then
    MsgBox L("�浵���������ϸ�˶ԡ�", "�浵���������ϸ�˶ԡ�"), vbExclamation
    Exit Sub
End If
If nScore <> Gui_nLast Then
    DoLoad nScore
End If

End Sub

' ���Ӵ�����ʾ
Public Sub ConnError()

MsgBox L("�޷���¼��������ʦ�û����ģ����Ժ����ԡ�", _
        "�o����䛵������׎��Ñ����ģ�Ո������ԇ��"), vbExclamation

End Sub

' �Ƿ��¼�û�����
Public Sub NoRegError(ByVal szPrompt As String)

If MsgBox(szPrompt, vbQuestion + vbYesNo) = vbYes Then
    ShellExecuteA 0, vbNullString, "http://www.xqbase.com/users/?act=xqblight", _
            vbNullString, vbNullString, vbNormalFocus
End If

End Sub

' ������ʾ
Public Sub TryHint()

Dim dfThinkTime As Double, mv As Long, i As Integer

dfThinkTime = Timer
dfThinkTime = dfThinkTime + IIf(dfThinkTime < App_dfHintTime, 86400#, 0#) - App_dfHintTime
If dfThinkTime < 60 Then
    MsgBox L("��ֻ˼���˲���1���ӣ����ٶ�����ɡ�", "��ֻ˼���˲���1��犣�Ո�ٶ�����ɡ�"), vbExclamation
    Exit Sub
End If

#If Not RETAIL_VERSION Then
    If App_nHint = HINT_NONE And Gui_nCurr >= 500 Then
        Login_szAct = "hint"
        frmLogin.Show vbModal, App_frmMain
        If Login_nStatus <> LOGIN_OK Then
            Exit Sub
        End If
    End If
#End If

App_nHint = HINT_RETRY
mv = GetBestMove
If App_sqSelected > 0 Then
    DrawSquare App_sqSelected
ElseIf App_mvLast > 0 Then
    DrawSquare Src(App_mvLast)
    DrawSquare Dst(App_mvLast)
End If
For i = 1 To 5
    DrawSquare Src(mv), DRAW_SELECTED, , DRAW_REFRESH
    Sleep 250
    DrawSquare Dst(mv), DRAW_SELECTED, , DRAW_REFRESH
    DrawSquare Src(mv), , , DRAW_REFRESH
    Sleep 250
    DrawSquare Dst(mv), , , DRAW_REFRESH
Next
If App_sqSelected > 0 Then
    DrawSquare App_sqSelected, DRAW_SELECTED
ElseIf App_mvLast > 0 Then
    DrawSquare Src(App_mvLast), DRAW_SELECTED
    DrawSquare Dst(App_mvLast), DRAW_SELECTED
End If

End Sub

' ���Ի���
Public Sub TryRetract()

If App_pos.nDistance = 0 Then
    MsgBox L("����ʧ�ܡ�", "����ʧ����"), vbInformation
    Exit Sub
End If

#If Not RETAIL_VERSION Then
    If Gui_nCurr >= 500 Then
        Login_szAct = "retract"
        frmLogin.Show vbModal, App_frmMain
        If Login_nStatus <> LOGIN_OK Then
            Exit Sub
        End If
    End If
#End If

If App_pos.nDistance Mod 2 = 0 Then
    CchessUndoMove App_pos
End If
CchessUndoMove App_pos
BoardFlush
App_sqSelected = 0
App_mvLast = 0
App_nPhase = PHASE_READY
If App_pos.nDistance = 0 Then
    App_frmMain.mnGameRetract.Enabled = False
    App_frmMain.btnRetract.Enabled = False
End If
App_frmMain.mnGameHint.Enabled = True
App_frmMain.btnHint.Enabled = True

End Sub

' ��������ʦ��
Public Sub OpenWithXQWizard()

Dim nFileNo As Integer, i As Integer, szFile As String
Dim nStatus As Long, mv As Long, dwFileStr As Long
Dim posStart As PositionStruct

szFile = L("������ʦħ��ѧУ.PGN", "�����׎�ħ���WУ.PGN")
nFileNo = FreeFile
On Error GoTo lnErrorOpen
Open App_szPath & szFile For Output As #nFileNo
On Error GoTo 0
Print #nFileNo, "[Game ""Chinese Chess""]"
If Options_nLanguage = LANGUAGE_ZH_CN Then
    Print #nFileNo, "[Event ""�� " & (Gui_nCurr + 1) & " �� - ������ʦħ��ѧУ""]"
Else
    Print #nFileNo, "[Event ""�� " & (Gui_nCurr + 1) & " �P - �����׎�ħ���WУ""]"
End If
Print #nFileNo, "[Result ""1-0""]"
Print #nFileNo, "[FEN """ & App_szEndgames(Gui_nCurr) & """]"

CchessFen2Board posStart, App_szEndgames(Gui_nCurr)
For i = 0 To App_pos.nMoveNum - 2
    mv = App_pos.rbsList(i + 1).mvs And &HFFFF&
    dwFileStr = CchessMove2File(mv, posStart)
    If i Mod 2 = 0 Then ' ��
        Print #nFileNo, " " & (i \ 2 + 1) & ". " & MkC(CchessFile2Chin(dwFileStr, 0));
    Else ' ��
        Print #nFileNo, " " & MkC(CchessFile2Chin(dwFileStr, 1))
    End If
    CchessTryMove posStart, nStatus, mv
Next
Print #nFileNo, " 1-0"
Print #nFileNo, "======================"
Print #nFileNo, L("��ӭ��������ٿ�ȫ����", "�gӭ�L������ٿ�ȫ���W")
Print #nFileNo, L("�Ƽ���������ʦ��������", "�Ƽ��������׎��^�p���V")
Print #nFileNo, "http://www.xqbase.com/"
Close #nFileNo

On Error GoTo lnErrorOpen
Shell App_szPath & "XQWIZARD.EXE """ & App_szPath & szFile & """", vbNormalFocus
On Error GoTo 0

Exit Sub
lnErrorOpen:
On Error GoTo 0
ErrorOpen App_szPath & szFile

End Sub

' �����ύ
Public Sub TrySave()

Login_szAct = "save?score=" & Gui_nLast
frmLogin.Show vbModal, App_frmMain
If Login_nStatus = LOGIN_OK Then
    MsgBox L("�浵�ύ�ɹ���", "��n�ύ�ɹ���"), vbInformation
End If

End Sub

' ���Ի�ȡ
Public Sub TryLoad()

Login_szAct = "queryscore"
frmLogin.Show vbModal, App_frmMain
If Login_nStatus = LOGIN_OK Then
    DoLoad Str2Int(Login_szResult, 0, App_nEndgames)
End If

End Sub

' ���Ի�ȡ����
Public Sub TryPoints()

Dim szResults() As String
Login_szAct = "querypoints"
frmLogin.Show vbModal, App_frmMain
If Login_nStatus <> LOGIN_OK Then
    Exit Sub
End If

szResults = Split(Login_szResult, "|")
If UBound(szResults) = 1 Then
    If Options_nLanguage = LANGUAGE_ZH_CN Then
        MsgBox "������ " & szResults(0) & " ����á�" & IIf(Str2Int(szResults(1)) < 2800, "", _
                vbCrLf & vbCrLf & "���ǻƽ��Ա�û����������޴�ʹ����ʾ�ͻ��幦�ܡ�"), vbInformation
    Else
        MsgBox "��߀�� " & szResults(0) & " �c���á�" & IIf(Str2Int(szResults(1)) < 2800, "", _
                vbCrLf & vbCrLf & "���ǻƽ���T�Ñ������ԟo�޴�ʹ����ʾ�ͻ��幦�ܡ�"), vbInformation
    End If
Else
    ConnError
End If

End Sub

' ��������
Public Sub TryRank()
    
Login_szAct = "queryrank"
frmLogin.Show vbModal, App_frmMain
If Login_nStatus = LOGIN_OK Then
    If UBound(Split(Login_szResult, "|")) = 2 Then
        frmRank.Show vbModal, App_frmMain
    Else
        ConnError
    End If
End If

End Sub

' �����ύ�浵���ֻ�
Public Sub TryGetCode()

Login_szAct = "getcode?score=" & Gui_nLast
frmLogin.Show vbModal, App_frmMain
If Login_nStatus = LOGIN_OK Then
    MsgBox L("�浵����[", "��n�a��[") & Login_szResult & _
            L("]���뽫��8λ�������뵽�ֻ���", "]��Ո���@8λ����ݔ�뵽�֙C��"), vbInformation
End If

End Sub

' �����ύ�浵���ֻ�
Public Sub TryPutCode()

Dim szCode As String
szCode = ""
Do
    szCode = InputBox(L("�������ֻ�����ʾ��8λ�浵�룺", "Ոݔ���֙C���@ʾ��8λ��n�a��"), _
            L("���ֻ���ȡ�浵", "���֙C�@ȡ��n"), szCode)
    If szCode = "" Then
        Exit Sub
    End If
    If Len(szCode) = 8 Then
        Exit Do
    End If
    MsgBox L("�浵�������8λ����", "��n�a�����8λ����"), vbExclamation
Loop
Login_szAct = "putcode?code=" & szCode
frmLogin.Show vbModal, App_frmMain
If Login_nStatus = LOGIN_OK Then
    DoLoad Str2Int(Login_szResult, 0, App_nEndgames)
End If

End Sub

' �л�����
Public Sub SwapGui()

Dim bLargeGui As Boolean
bLargeGui = App_frmMain.mnOptionsGuiSmall.Checked
App_frmMain.mnOptionsGuiSmall.Checked = Not bLargeGui
App_frmMain.mnOptionsGuiLarge.Checked = bLargeGui
SaveSetting "XQWizard", "Options", "LargeGui", IIf(bLargeGui, "1", "0")
MsgBox L("��ʾģʽ�Ѿ����ģ�������������������Ч��", "�@ʾģʽ�ѽ����ģ������ӳ����������Ч��"), vbInformation

End Sub

' ��ע������ز���
Public Sub LoadRegs2()

Dim nLastOld As Integer, nLastNew As Integer
nLastOld = Str2Int(GetSetting("XQBooth", "Gui", "Last", "0"), 0, MAX_ENDGAMES - 1)
nLastNew = Str2Int(GetSetting("XQWizard", "Booth", "Last", "0"), 0, MAX_ENDGAMES - 1)
Gui_nLast = IIf(nLastOld > nLastNew, nLastOld, nLastNew)
Gui_nCurr = Str2Int(GetSetting("XQWizard", "Booth", "Curr", "0"), 0, MAX_ENDGAMES - 1)
Login_szUserName = GetSetting("XQWizard", "Booth", "UserName", "")
Login_szPassword = GetSetting("XQWizard", "Booth", "Password", "")
Login_bRemember = GetSetting("XQWizard", "Booth", "Remember", "1") <> "0"

End Sub

' ���������ע���
Public Sub SaveRegs2()

SaveSetting "XQWizard", "Booth", "Last", Gui_nLast
SaveSetting "XQWizard", "Booth", "Curr", Gui_nCurr
SaveSetting "XQWizard", "Booth", "UserName", Login_szUserName
' ֻ��32��λ�������Cookie���룬���Ա�����ע���
SaveSetting "XQWizard", "Booth", "Password", IIf(Login_bRemember And _
        Len(Login_szPassword) = 32, Login_szPassword, "")
SaveSetting "XQWizard", "Booth", "Remember", IIf(Login_bRemember, "1", "0")

End Sub

' ����������
Public Sub SetLang()

Dim i As Integer
If Options_nLanguage = LANGUAGE_ZH_CN Then
    Exit Sub
End If
App.Title = "�����׎�ħ���WУ"
App_frmMain.Font.Charset = 136
App_frmMain.Font.Name = "�����w"
On Error Resume Next
For i = 0 To App_frmMain.Controls.Count - 1
    App_frmMain.Controls(i).Font = App_frmMain.Font
Next
On Error GoTo 0
' �˵�
App_frmMain.mnGame.Caption = "�Α�(&G)"
App_frmMain.mnGameSelect.Caption = "�x�P(&O)..."
App_frmMain.mnGameNext.Caption = "��һ�P(&N)"
App_frmMain.mnGameRestart.Caption = "��ԇһ��(&R)"
App_frmMain.mnGameXQWizard.Caption = "�������׎����_(&X)"
App_frmMain.mnGameHint.Caption = "��ʾ(&H)"
App_frmMain.mnGameRetract.Caption = "����(&T)"
App_frmMain.mnGameCode.Caption = "��n�a(&C)"
App_frmMain.mnGameExit.Caption = "���_(&X)"

App_frmMain.mnUsers.Caption = "�Ñ�����(&U)"
App_frmMain.mnUsersSave.Caption = "�ύ��n(&S)"
App_frmMain.mnUsersLoad.Caption = "�@ȡ��n(&L)"
App_frmMain.mnUsersRank.Caption = "����(&R)..."
App_frmMain.mnUsersPoints.Caption = "��ԃ�c��(&P)..."
App_frmMain.mnUsersCenter.Caption = "�Ñ��������(&C)"
App_frmMain.mnUsersHelp.Caption = "����(&H)"
App_frmMain.mnUsersShare(0).Caption = "QQ���g(&Q)"
App_frmMain.mnUsersShare(1).Caption = "����΢��(&S)"
App_frmMain.mnUsersShare(2).Caption = "�_�ľW(&K)"
App_frmMain.mnUsersShare(3).Caption = "���˾W(&R)"
App_frmMain.mnUsersPublish(0).Caption = "�ٶ�֪��(&Z)"
App_frmMain.mnUsersPublish(1).Caption = "�ٶ��N�������(&T)"
App_frmMain.mnUsersPublish(2).Caption = "�����Wվ(&O)"

App_frmMain.mnMobile.Caption = "�֙C��(&M)"
App_frmMain.mnMobileSave.Caption = "�ύ��n���֙C(&S)..."
App_frmMain.mnMobileLoad.Caption = "���֙C�@ȡ��n(&L)..."
App_frmMain.mnMobileDownload.Caption = "���d�֙C��(&D)"
App_frmMain.mnMobileRegister.Caption = "�@���S���C(&R)"

' ��ť
App_frmMain.btnRetract.Caption = "����"
App_frmMain.btnHint.Caption = "��ʾ"
App_frmMain.btnRestart.Caption = "��ԇһ��"
App_frmMain.btnNext.Caption = "��һ�P"

End Sub

' ������
Public Sub Main()

Dim i As Integer, nFileNo As Integer, bPrevInstance As Boolean, bLoaded As Boolean
Dim sz As String, lpStr As Long, dwResult As Long
Dim dfThisTime As Double, dfLastTime As Double

' ��ʼ��
App_szPath = App.Path & IIf(Right(App.Path, 1) = "\", "", "\")
' ������ʾ��������
' frmStartup.Show
' frmStartup.Refresh
LoadRegs
CchessInit Options_nLanguage
LoadRegs2
LoadQuotes
#If RETAIL_VERSION Then
    InitCipher
#End If

' ���زо�
nFileNo = FreeFile
On Error GoTo lnErrorOpen
Open App_szPath & ENDGAME_FILE For Input As #nFileNo
On Error GoTo 0
App_nEndgames = 0
Do While App_nEndgames < MAX_ENDGAMES And Not EOF(nFileNo)
    Line Input #nFileNo, sz
    i = InStr(sz, ";")
    If i > 0 Then
        App_szEndgames(App_nEndgames) = RTrim(Left(sz, i - 1))
        App_nEndgames = App_nEndgames + 1
    Else
        sz = RTrim(sz)
        If sz <> "" Then
            App_szEndgames(App_nEndgames) = sz
            App_nEndgames = App_nEndgames + 1
        End If
    End If
Loop
Close #nFileNo
If App_nEndgames = 0 Then
    ' Unload frmStartup
    ErrorOpen App_szPath & ENDGAME_FILE
    Exit Sub
End If
' Last�ķ�Χ��[0, Endgames]
Gui_nLast = IIf(Gui_nLast > App_nEndgames, App_nEndgames, Gui_nLast)
' Curr�ķ�Χ��[0, Min(Last, Endgames - 1)]
Gui_nCurr = IIf(Gui_nCurr > Gui_nLast, Gui_nLast, Gui_nCurr)
Gui_nCurr = IIf(Gui_nCurr > App_nEndgames - 1, App_nEndgames - 1, Gui_nCurr)

' ��������
If GetAppType(App_szPath & "ELEEYE.EXE") <> IMAGE_SUBSYSTEM_WINDOWS_CUI Then
    ' Unload frmStartup
    MsgBox L("�޷��������棺", "�o�����d���棺") & App_szPath & "ELEEYE.EXE", vbExclamation
    Exit Sub
End If
PipeOpen Engine_pipe, App_szPath & ENGINE_FILE
PipeLineOutput Engine_pipe, "ucci"
dfLastTime = Timer
bLoaded = False
Do While Not bLoaded
    lpStr = PipeLineInput(Engine_pipe)
    If lpStr = 0 Then
        Sleep 1
        dfThisTime = Timer
        dfThisTime = dfThisTime + IIf(dfThisTime < dfLastTime, 86400#, 0#)
        If dfThisTime > dfLastTime + 60# Then
            Exit Do
        End If
    Else
        sz = AllocString(lpStr)
        If sz = "ucciok" Then
            bLoaded = True
        End If
    End If
Loop
If Not bLoaded Then
    PipeLineOutput Engine_pipe, "quit"
    PipeClose Engine_pipe
    ' Unload frmStartup
    MsgBox L("�޷��������棺", "�o�����d���棺") & App_szPath & "ELEEYE.EXE" & vbCrLf & vbCrLf & _
            L("��������������ĵ��Ը��ɹ��ض�����ģ����˳�������ʦħ��ѧУ�������������Կ���", _
            "�@���������������Xؓ���^�ض�����ģ�Ո�˳������׎�ħ���WУ��K�����\��ԇԇ����"), vbExclamation
    Exit Sub
End If
' ����ִ�ڣ�����ֻ���ǽ����߷�
' PipeLineOutput Engine_pipe, "setoption alwayscheck true"

' ���ع�棬�������ʧ�ܣ������ع���б����ٴμ���ʧ�������
Gui_dfLastTime = 0#
Gui_nAdvertIndex = 0
Gui_nAdvertTimes(0) = 10 ' 10���Ӻ�ʼ���Ź��
LoadAdvertList
If Gui_nAdvertNum = 0 Then
    #If RETAIL_VERSION Then
        DownloadAdvertList "advert_retail.txt"
    #Else
        DownloadAdvertList "advert_0450.txt"
    #End If
    LoadAdvertList
    If Gui_nAdvertNum = 0 Then
        Gui_nAdvertNum = 1
        Gui_szAdvertFiles(1) = "xqbase"
        Gui_nAdvertTimes(1) = 32767
    Else
        Gui_szAdvertDate = Date
    End If
End If
' �����£�����û��������£��ᵯ������ҳ�棬������������ʦҳ��֮ǰ
#If Not RETAIL_VERSION Then
    If Gui_szUpgradeDate <> Date Then
        CheckUpdate "xqwizard"
    End If
#End If
If Options_bLargeGui Then
    Set App_frmMain = frmMainLarge
Else
    Set App_frmMain = frmMainSmall
End If
ClearHint
LoadGame
' ����ʾ������ǰ���Ȱ��������ú�
SetLang
SetLangOptions App_frmMain
' ��������۰棬�����ء��Ƽ������ѡ��͡������¡�
#If RETAIL_VERSION Then
    App_frmMain.mnHelpShare_.Visible = False
    App_frmMain.mnHelpSep2.Visible = False
    App_frmMain.mnHelpUpdate.Visible = False
    App_frmMain.mnUsers.Visible = False
    App_frmMain.mnMobile.Visible = False
#Else
    App_frmMain.mnGameCode.Visible = False
    App_frmMain.mnGameSep4.Visible = False
#End If
App_frmMain.Show
App_frmMain.web.Navigate2 App_szPath & "ADVERT\xqbase.htm"
App_frmMain.mnOptionsGuiSmall.Checked = Not Options_bLargeGui
App_frmMain.mnOptionsGuiLarge.Checked = Options_bLargeGui
App_frmMain.mnOptionsSounds.Checked = Options_bSounds
App_frmMain.mnOptionsLanguage(Options_nLanguage).Checked = True
' Unload frmStartup

Login_nStatus = LOGIN_FIRST
' ��ѭ��
App_bRunning = True
bPrevInstance = App.PrevInstance
Do While App_bRunning
    ' ����
    If Options_nMusic > MUSIC_NONE And Not bPrevInstance Then
        If frmHide.mci.Length = frmHide.mci.Position Then
            frmHide.mci.To = 0
            frmHide.mci.Command = "Seek"
            frmHide.mci.Command = "Play"
        End If
    End If
    ' ���
    dfThisTime = Timer
    dfThisTime = dfThisTime + IIf(dfThisTime < Gui_dfLastTime, 86400#, 0#)
    If dfThisTime > Gui_dfLastTime + Gui_nAdvertTimes(Gui_nAdvertIndex) Then
        Gui_dfLastTime = Timer
        Gui_nAdvertIndex = Gui_nAdvertIndex + 1
        If Gui_nAdvertIndex > Gui_nAdvertNum Then
            Gui_nAdvertIndex = 1
        End If
        App_frmMain.web.Navigate2 App_szPath & "ADVERT\" & Gui_szAdvertFiles(Gui_nAdvertIndex) & ".htm"
    End If
    DoEvents
    Sleep 1
Loop
' �˳�ǰ���ع���б�
If Gui_szAdvertDate <> Date Then
    #If RETAIL_VERSION Then
        DownloadAdvertList "advert_retail.txt"
    #Else
        DownloadAdvertList "advert_0450.txt"
    #End If
    LoadAdvertList
    If Gui_nAdvertNum > 0 Then
        Gui_szAdvertDate = Date
    End If
End If
' �ر�����
PipeLineOutput Engine_pipe, "quit"
PipeClose Engine_pipe
' �˳�
SaveRegs
SaveRegs2
PlaySoundA vbNullString, 0, 0
frmHide.mci.Command = "Close"
' ���۰治�˵�
#If Not RETAIL_VERSION Then
    ExitPopup
#End If
Unload frmHide
Unload frmHide2

Exit Sub
lnErrorOpen:
On Error GoTo 0
' Unload frmStartup
ErrorOpen App_szPath & ENDGAME_FILE

End Sub