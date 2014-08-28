' STARTUP.VB - Source Code for XiangQi Wizard Light, Part III
'
' XiangQi Wizard Light - a Chinese Chess Program for Windows CE
' Designed by Morning Yellow, Version: 1.21, Last Modified: Jan. 2008
' Copyright (C) 2004-2008 www.elephantbase.net
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

Public Class StartUp
    Inherits System.Windows.Forms.Form
    Friend WithEvents btnStart As System.Windows.Forms.Button
    Friend WithEvents btnExit As System.Windows.Forms.Button

#Region " Windows ������������ɵĴ��� "

    Public Sub New()

        MyBase.New()

        '�õ����� Windows ���������������ġ�
        InitializeComponent()

        '�� InitializeComponent() ����֮�������κγ�ʼ��
        optRed.Checked = True
        optHandicap.SelectedIndex = 0
        optLevel.SelectedIndex = 0

    End Sub

    '������д dispose ����������б���
    Protected Overloads Overrides Sub Dispose(ByVal disposing As Boolean)
        MyBase.Dispose(disposing)
    End Sub

    'ע��: ���¹����� Windows ����������������
    '����ʹ�� Windows ����������޸Ĵ˹��̡�
    '��Ҫʹ�ô���༭���޸�����
    Friend WithEvents optHandicap As System.Windows.Forms.ComboBox
    Friend WithEvents lblHandicap As System.Windows.Forms.Label
    Friend WithEvents optRed As System.Windows.Forms.RadioButton
    Friend WithEvents optBlack As System.Windows.Forms.RadioButton
    Friend WithEvents lblPlayer As System.Windows.Forms.Label
    Friend WithEvents optLevel As System.Windows.Forms.ComboBox
    Friend WithEvents lblLevel As System.Windows.Forms.Label
    Friend WithEvents btnAbout As System.Windows.Forms.Button
    Friend WithEvents chkSound As System.Windows.Forms.CheckBox
    Private Sub InitializeComponent()
        Me.btnStart = New System.Windows.Forms.Button
        Me.btnExit = New System.Windows.Forms.Button
        Me.optHandicap = New System.Windows.Forms.ComboBox
        Me.lblHandicap = New System.Windows.Forms.Label
        Me.lblLevel = New System.Windows.Forms.Label
        Me.optRed = New System.Windows.Forms.RadioButton
        Me.optBlack = New System.Windows.Forms.RadioButton
        Me.lblPlayer = New System.Windows.Forms.Label
        Me.optLevel = New System.Windows.Forms.ComboBox
        Me.btnAbout = New System.Windows.Forms.Button
        Me.chkSound = New System.Windows.Forms.CheckBox
        '
        'btnAbout
        '
        Me.btnAbout.Location = New System.Drawing.Point(16, 0)
        Me.btnAbout.Size = New System.Drawing.Size(120, 24)
        Me.btnAbout.Text = "����""����С��ʦ"""
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog
        '
        'lblPlayer
        '
        Me.lblPlayer.Location = New System.Drawing.Point(16, 32)
        Me.lblPlayer.Size = New System.Drawing.Size(48, 16)
        Me.lblPlayer.Text = "˭����"
        '
        'optRed
        '
        Me.optRed.Location = New System.Drawing.Point(64, 24)
        Me.optRed.Size = New System.Drawing.Size(64, 24)
        Me.optRed.Text = "������"
        '
        'optBlack
        '
        Me.optBlack.Location = New System.Drawing.Point(64, 48)
        Me.optBlack.Size = New System.Drawing.Size(72, 24)
        Me.optBlack.Text = "��������"
        '
        'lblHandicap
        '
        Me.lblHandicap.Location = New System.Drawing.Point(16, 72)
        Me.lblHandicap.Size = New System.Drawing.Size(56, 16)
        Me.lblHandicap.Text = "��������"
        '
        'optHandicap
        '
        Me.optHandicap.Items.Add("������")
        Me.optHandicap.Items.Add("������")
        Me.optHandicap.Items.Add("��˫��")
        Me.optHandicap.Items.Add("�þ���")
        Me.optHandicap.Location = New System.Drawing.Point(72, 72)
        Me.optHandicap.Size = New System.Drawing.Size(64, 20)
        '
        'lblLevel
        '
        Me.lblLevel.Location = New System.Drawing.Point(16, 96)
        Me.lblLevel.Size = New System.Drawing.Size(56, 16)
        Me.lblLevel.Text = "����ˮƽ"
        '
        'optLevel
        '
        Me.optLevel.Items.Add("����")
        Me.optLevel.Items.Add("ҵ��")
        Me.optLevel.Items.Add("רҵ")
        Me.optLevel.Location = New System.Drawing.Point(72, 96)
        Me.optLevel.Size = New System.Drawing.Size(64, 20)
        '
        'chkSound
        '
        Me.chkSound.Checked = True
        Me.chkSound.CheckState = System.Windows.Forms.CheckState.Checked
        Me.chkSound.Location = New System.Drawing.Point(16, 120)
        Me.chkSound.Size = New System.Drawing.Size(56, 16)
        Me.chkSound.Text = "��Ч"
        '
        'btnStart
        '
        Me.btnStart.Location = New System.Drawing.Point(16, 144)
        Me.btnStart.Size = New System.Drawing.Size(56, 24)
        Me.btnStart.Text = "��ʼ"
        '
        'btnExit
        '
        Me.btnExit.Location = New System.Drawing.Point(80, 144)
        Me.btnExit.Size = New System.Drawing.Size(56, 24)
        Me.btnExit.Text = "�˳�"
        '
        'StartUp
        '
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.ClientSize = New System.Drawing.Size(154, 175)
        Me.Controls.Add(Me.btnAbout)
        Me.Controls.Add(Me.lblPlayer)
        Me.Controls.Add(Me.optRed)
        Me.Controls.Add(Me.optBlack)
        Me.Controls.Add(Me.lblHandicap)
        Me.Controls.Add(Me.optHandicap)
        Me.Controls.Add(Me.lblLevel)
        Me.Controls.Add(Me.optLevel)
        Me.Controls.Add(Me.chkSound)
        Me.Controls.Add(Me.btnStart)
        Me.Controls.Add(Me.btnExit)
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Text = "��ʼ - ����С��ʦ"

    End Sub
#End Region
    Private Sub btnStart_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnStart.Click
        App_bExit = False
        Close()
    End Sub

    Private Sub btnExit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnExit.Click
        App_bExit = True
        Close()
    End Sub

    Private Sub frmStartUp_Closed(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Closed
        App_bFlipped = optBlack.Checked
        App_nHandicap = optHandicap.SelectedIndex
        If App_nHandicap < 0 OrElse App_nHandicap > 3 Then
            App_nHandicap = 0
        End If
        App_nLevel = optLevel.SelectedIndex
        If App_nLevel < 0 OrElse App_nLevel > 2 Then
            App_nLevel = 0
        End If
        App_bSound = chkSound.Checked
    End Sub

    Private Sub btnAbout_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnAbout.Click
        MsgBox("����С��ʦ 1.21" + vbCrLf + "����ٿ�ȫ�� ������Ʒ" + vbCrLf + vbCrLf + _
                "(C) 2004-2008 www.elephantbase.net" + vbCrLf + "����Ʒ����GNUͨ�ù�������Э��" + vbCrLf + vbCrLf + _
                "��ӭ��¼ www.elephantbase.net" + vbCrLf + "�������PC�� ������ʦ", MsgBoxStyle.Information, "��������С��ʦ")
    End Sub
End Class