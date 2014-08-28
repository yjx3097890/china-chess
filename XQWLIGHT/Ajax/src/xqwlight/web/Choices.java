package xqwlight.web;

import java.util.Arrays;
import java.util.List;

public class Choices {
	public static final String FLIPPED_FALSE = "������";
	public static final String FLIPPED_TRUE = "��������";

	private static List<String> lstFlipped = Arrays.asList(new String[] {
		FLIPPED_FALSE, FLIPPED_TRUE
	});

	public static List<String> getFlippedTypes() {
		return lstFlipped;
	}

	private static List<String> lstHandicap = Arrays.asList(new String[] {
		"������", "������", "��˫��", "�þ���"
	});

	public static List<String> getHandicapTypes() {
		return lstHandicap;
	}

	private static List<String> lstBoard = Arrays.asList(new String[] {
		"��ľ", "��ɫ����ʯ", "��ɫ����ʯ", "����ֽ", "����", "ˮ��", "ǳ������"
	});

	public static List<String> getBoardTypes() {
		return lstBoard;
	}

	private static List<String> lstPieces = Arrays.asList(new String[] {
		"ľ��", "����", "����"
	});

	public static List<String> getPiecesTypes() {
		return lstPieces;
	}

	private static List<String> lstMusic = Arrays.asList(new String[] {
		"����", "��Ȥ", "�ͺ�", "Ī����һ", "Ī������", "�����",
		"��˹��", "��ɷ�˹��", "�����Ŀ�", "�ɽ�������", "������",
	});

	public static List<String> getMusicTypes() {
		return lstMusic;
	}
}