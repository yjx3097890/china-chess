#if !defined(AFX_XQWLIGHTCTL_H__FFD433A1_BFCF_4BA6_947F_67756786860C__INCLUDED_)
#define AFX_XQWLIGHTCTL_H__FFD433A1_BFCF_4BA6_947F_67756786860C__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

// XQWLightCtl.h : Declaration of the CXQWLightCtrl ActiveX Control class.

#include <objsafe.h>

/* === ����������С��ʦ��������� === */

// ��������
const int MAX_GEN_MOVES = 128; // ���������߷���
const int MAX_MOVES = 256;     // ������ʷ�߷���
const int LIMIT_DEPTH = 64;    // �����������
const int MATE_VALUE = 10000;  // ��߷�ֵ���������ķ�ֵ
const int BAN_VALUE = MATE_VALUE - 100; // �����и��ķ�ֵ�����ڸ�ֵ����д���û���
const int WIN_VALUE = MATE_VALUE - 200; // ������ʤ���ķ�ֵ���ޣ�������ֵ��˵���Ѿ�������ɱ����
const int DRAW_VALUE = 20;     // ����ʱ���صķ���(ȡ��ֵ)
const int ADVANCED_VALUE = 3;  // ����Ȩ��ֵ
const int RANDOM_MASK = 7;     // ����Է�ֵ
const int NULL_MARGIN = 400;   // �ղ��ü��������߽�
const int NULL_DEPTH = 2;      // �ղ��ü��Ĳü����
const int HASH_SIZE = 1 << 20; // �û����С
const int HASH_ALPHA = 1;      // ALPHA�ڵ���û�����
const int HASH_BETA = 2;       // BETA�ڵ���û�����
const int HASH_PV = 3;         // PV�ڵ���û�����
const int BOOK_SIZE = 16384;   // ���ֿ��С

// RC4������������
struct RC4Struct {
  BYTE s[256];
  int x, y;

  void InitZero(void);   // �ÿ���Կ��ʼ��������������
  BYTE NextByte(void) {  // ��������������һ���ֽ�
    BYTE uc;
    x = (x + 1) & 255;
    y = (y + s[x]) & 255;
    uc = s[x];
    s[x] = s[y];
    s[y] = uc;
    return s[(s[x] + s[y]) & 255];
  }
  DWORD NextLong(void) { // ���������������ĸ��ֽ�
    BYTE uc0, uc1, uc2, uc3;
    uc0 = NextByte();
    uc1 = NextByte();
    uc2 = NextByte();
    uc3 = NextByte();
    return uc0 + (uc1 << 8) + (uc2 << 16) + (uc3 << 24);
  }
};

// Zobrist�ṹ
struct ZobristStruct {
  DWORD dwKey, dwLock0, dwLock1;

  void InitZero(void) {                 // �������Zobrist
    dwKey = dwLock0 = dwLock1 = 0;
  }
  void InitRC4(RC4Struct &rc4) {        // �����������Zobrist
    dwKey = rc4.NextLong();
    dwLock0 = rc4.NextLong();
    dwLock1 = rc4.NextLong();
  }
  void Xor(const ZobristStruct &zobr) { // ִ��XOR����
    dwKey ^= zobr.dwKey;
    dwLock0 ^= zobr.dwLock0;
    dwLock1 ^= zobr.dwLock1;
  }
  void Xor(const ZobristStruct &zobr1, const ZobristStruct &zobr2) {
    dwKey ^= zobr1.dwKey ^ zobr2.dwKey;
    dwLock0 ^= zobr1.dwLock0 ^ zobr2.dwLock0;
    dwLock1 ^= zobr1.dwLock1 ^ zobr2.dwLock1;
  }
};

// ��ʷ�߷���Ϣ(ռ4�ֽ�)
struct MoveStruct {
  WORD wmv;
  BYTE ucpcCaptured, ucbCheck;
  DWORD dwKey;

  void Set(int mv, int pcCaptured, BOOL bCheck, DWORD dwKey_) {
    wmv = mv;
    ucpcCaptured = pcCaptured;
    ucbCheck = bCheck;
    dwKey = dwKey_;
  }
}; // mvs

// ����ṹ
struct PositionStruct {
  int sdPlayer;                   // �ֵ�˭�ߣ�0=�췽��1=�ڷ�
  BYTE ucpcSquares[256];          // �����ϵ�����
  int vlWhite, vlBlack;           // �졢��˫����������ֵ
  int nDistance, nMoveNum;        // ������ڵ�Ĳ�������ʷ�߷���
  MoveStruct mvsList[MAX_MOVES];  // ��ʷ�߷���Ϣ�б�
  ZobristStruct zobr;             // Zobrist

  void ClearBoard(void) {         // �������
    sdPlayer = vlWhite = vlBlack = nDistance = 0;
    memset(ucpcSquares, 0, 256);
    zobr.InitZero();
  }
  void SetIrrev(void) {           // ���(��ʼ��)��ʷ�߷���Ϣ
    mvsList[0].Set(0, 0, Checked(), zobr.dwKey);
    nMoveNum = 1;
  }
  void Startup(void);             // ��ʼ������
  // ���·����Ѷ�����".cpp"�ļ���
  void ChangeSide(void);
  void AddPiece(int sq, int pc);
  void DelPiece(int sq, int pc);
  // ���Ϸ����Ѷ�����".cpp"�ļ���
  int Evaluate(void) const {      // �������ۺ���
    return (sdPlayer == 0 ? vlWhite - vlBlack : vlBlack - vlWhite) + ADVANCED_VALUE;
  }
  BOOL InCheck(void) const {      // �Ƿ񱻽���
    return mvsList[nMoveNum - 1].ucbCheck;
  }
  BOOL Captured(void) const {     // ��һ���Ƿ����
    return mvsList[nMoveNum - 1].ucpcCaptured != 0;
  }
  int MovePiece(int mv);                      // ��һ���������
  void UndoMovePiece(int mv, int pcCaptured); // ������һ���������
  BOOL MakeMove(int mv);                      // ��һ����
  void UndoMakeMove(void) {                   // ������һ����
    nDistance --;
    nMoveNum --;
    ChangeSide();
    UndoMovePiece(mvsList[nMoveNum].wmv, mvsList[nMoveNum].ucpcCaptured);
  }
  void NullMove(void) {                       // ��һ���ղ�
    DWORD dwKey;
    dwKey = zobr.dwKey;
    ChangeSide();
    mvsList[nMoveNum].Set(0, 0, FALSE, dwKey);
    nMoveNum ++;
    nDistance ++;
  }
  void UndoNullMove(void) {                   // ������һ���ղ�
    nDistance --;
    nMoveNum --;
    ChangeSide();
  }
  // ���������߷������"bCapture"Ϊ"TRUE"��ֻ���ɳ����߷�
  int GenerateMoves(int *mvs, BOOL bCapture = FALSE) const;
  BOOL LegalMove(int mv) const;               // �ж��߷��Ƿ����
  BOOL Checked(void) const;                   // �ж��Ƿ񱻽���
  BOOL IsMate(void);                          // �ж��Ƿ�ɱ
  int DrawValue(void) const {                 // �����ֵ
    return (nDistance & 1) == 0 ? -DRAW_VALUE : DRAW_VALUE;
  }
  int RepStatus(int nRecur = 1) const;        // ����ظ�����
  int RepValue(int nRepStatus) const {        // �ظ������ֵ
    int vlReturn;
    vlReturn = ((nRepStatus & 2) == 0 ? 0 : nDistance - BAN_VALUE) +
        ((nRepStatus & 4) == 0 ? 0 : BAN_VALUE - nDistance);
    return vlReturn == 0 ? DrawValue() : vlReturn;
  }
  BOOL NullOkay(void) const {                 // �ж��Ƿ�����ղ��ü�
    return (sdPlayer == 0 ? vlWhite : vlBlack) > NULL_MARGIN;
  }
  void Mirror(PositionStruct &posMirror) const; // �Ծ��澵��
};

// �û�����ṹ
struct HashItem {
  BYTE ucDepth, ucFlag;
  short svl;
  WORD wmv, wReserved;
  DWORD dwLock0, dwLock1;
};

// ���ֿ���ṹ
struct BookItem {
  DWORD dwLock;
  WORD wmv, wvl;
};

/* === ����������С��ʦ��������� === */

/////////////////////////////////////////////////////////////////////////////
// CXQWLightCtrl : See XQWLightCtl.cpp for implementation.

class CXQWLightCtrl : public COleControl
{
	DECLARE_DYNCREATE(CXQWLightCtrl)

// Constructor
public:
	BEGIN_INTERFACE_PART(ObjectSafety, IObjectSafety) 
		STDMETHOD(GetInterfaceSafetyOptions)(REFIID riid, DWORD __RPC_FAR *pdwSupportedOptions, DWORD __RPC_FAR *pdwEnabledOptions); 
		STDMETHOD(SetInterfaceSafetyOptions)(REFIID riid, DWORD dwOptionSetMask, DWORD dwEnabledOptions); 
	END_INTERFACE_PART(ObjectSafety) 

	DECLARE_INTERFACE_MAP(); 

	CXQWLightCtrl();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CXQWLightCtrl)
	public:
	virtual void OnDraw(CDC* pdc, const CRect& rcBounds, const CRect& rcInvalid);
	virtual void DoPropExchange(CPropExchange* pPX);
	virtual void OnResetState();
	virtual BOOL OnSetExtent(LPSIZEL lpSizeL);
	//}}AFX_VIRTUAL

// Implementation
protected:
	~CXQWLightCtrl();

	DECLARE_OLECREATE_EX(CXQWLightCtrl)    // Class factory and guid
	DECLARE_OLETYPELIB(CXQWLightCtrl)      // GetTypeInfo
	DECLARE_PROPPAGEIDS(CXQWLightCtrl)     // Property page IDs
	DECLARE_OLECTLTYPE(CXQWLightCtrl)		// Type name and misc status

// Message maps
	//{{AFX_MSG(CXQWLightCtrl)
	afx_msg void OnLButtonDown(UINT nFlags, CPoint point);
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()

// Dispatch maps
	//{{AFX_DISPATCH(CXQWLightCtrl)
	afx_msg BOOL GetFlip();
	afx_msg void SetFlip(BOOL bNewValue);
	afx_msg void Restart();
	//}}AFX_DISPATCH
	DECLARE_DISPATCH_MAP()

// Event maps
	//{{AFX_EVENT(CXQWLightCtrl)
	//}}AFX_EVENT
	DECLARE_EVENT_MAP()

// Dispatch and event IDs
public:
	enum {
	//{{AFX_DISP_ID(CXQWLightCtrl)
	dispidFlip = 1L,
	dispidRestart = 2L,
	//}}AFX_DISP_ID
	};

/* === ����������С��ʦ��������� === */

  PositionStruct pos; // ����ʵ��

  struct {
    int mvResult;                  // �����ߵ���
    int nHistoryTable[65536];      // ��ʷ��
    int mvKillers[LIMIT_DEPTH][2]; // ɱ���߷���
    HashItem HashTable[HASH_SIZE]; // �û���
  } Search;
  struct {
    HDC hdc, hdcTmp;                              // �豸�����ֻ��"ClickSquare"��������Ч
    int sqSelected, mvLast;                       // ѡ�еĸ��ӣ���һ����
    BOOL bFlipped, bGameOver;                     // �Ƿ�ת���̣��Ƿ���Ϸ����(���ü�������ȥ)
  } Xqwl;

  int SearchBook(void);
  int ProbeHash(int vlAlpha, int vlBeta, int nDepth, int &mv);
  void RecordHash(int nFlag, int vl, int nDepth, int mv);
  void SetBestMove(int mv, int nDepth);
  int SearchQuiesc(int vlAlpha, int vlBeta);
  int SearchFull(int vlAlpha, int vlBeta, int nDepth, BOOL bNoNull = FALSE);
  int SearchRoot(int nDepth);
  void SearchMain(void);
  void DrawBoard(HDC hdc);
  void MessageBoxMute(LPCSTR lpszText);
  void DrawSquare(int sq, BOOL bSelected = FALSE);
  void ResponseMove(void);
  void ClickSquare(int sq);
  void Startup(void);
/* === ����������С��ʦ��������� === */

};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_XQWLIGHTCTL_H__FFD433A1_BFCF_4BA6_947F_67756786860C__INCLUDED)
