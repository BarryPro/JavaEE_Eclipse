package org.crazyit.cal;

/**
 * ����ҵ����
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @author Kelvin Mak kelvin.mak125@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class CalService {
	// �洢��,Ĭ��Ϊ0�����ڱ�����Ҫ��ʱ����ļ�����
	private double store = 0;
	// ��һ��������
	private String firstNum = null;
	// �ϴβ���
	private String lastOp = null;
	// �ڶ���������
	private String secondNum = null;
	// �Ƿ�ڶ���������������ǣ�������ּ�ʱ�������ı�������������
	private boolean isSecondNum = false;

	// ����
	private String numString = "0123456789.";
	// ��������
	private String opString = "+-*/";

	/**
	 * Ĭ�Ϲ�����
	 */
	public CalService() {
		super();
	}

	/**
	 * ���÷��������ؼ�����
	 * 
	 * @return String
	 */
	public String callMethod(String cmd, String text) throws Exception {
		if (cmd.equals("C")) {
			return clearAll();
		} else if (cmd.equals("CE")) {
			return clear(text);
		} else if (cmd.equals("Back")) {
			return backSpace(text);
		} else if (numString.indexOf(cmd) != -1) {
			return catNum(cmd, text);
		} else if (opString.indexOf(cmd) != -1) {
			return setOp(cmd, text);
		} else if (cmd.equals("=")) {
			return cal(text, false);
		} else if (cmd.equals("+/-")) {
			return setNegative(text);
		} else if (cmd.equals("1/x")) {
			return setReciprocal(text);
		} else if (cmd.equals("sqrt")) {
			return sqrt(text);
		} else if (cmd.equals("%")) {
			return cal(text, true);
		} else {
			return mCmd(cmd, text);
		}
	}

	/**
	 * ��������������
	 * 
	 * @param text
	 *            String ������е�ֵ
	 * @param isPercent
	 *            boolean �Ƿ���"%"����
	 * @return String ��ճ��ַ����ļ�����
	 */
	public String cal(String text, boolean isPercent) throws Exception {
		// ��ʼ���ڶ���������
		double secondResult = secondNum == null ? Double.valueOf(text)
				.doubleValue() : Double.valueOf(secondNum).doubleValue();
		// �������Ϊ0��������
		if (secondResult == 0 && this.lastOp.equals("/")) {
			return "0";
		}
		// �����"%"��������ڶ���������������������ٳ���100
		if (isPercent) {
			secondResult = MyMath.multiply(Double.valueOf(firstNum), MyMath
					.divide(secondResult, 100));
		}
		// �������㣬���ؽ��������һ��������
		if (this.lastOp.equals("+")) {
			firstNum = String.valueOf(MyMath.add(Double.valueOf(firstNum),
					secondResult));
		} else if (this.lastOp.equals("-")) {
			firstNum = String.valueOf(MyMath.subtract(Double.valueOf(firstNum),
					secondResult));
		} else if (this.lastOp.equals("*")) {
			firstNum = String.valueOf(MyMath.multiply(Double.valueOf(firstNum),
					secondResult));
		} else if (this.lastOp.equals("/")) {
			firstNum = String.valueOf(MyMath.divide(Double.valueOf(firstNum),
					secondResult));
		}
		// ���ڶ������������¸�ֵ
		secondNum = secondNum == null ? text : secondNum;
		// ��isSecondNum��־Ϊtrue
		this.isSecondNum = true;
		return firstNum;
	}

	/**
	 * ���㵹��
	 * 
	 * @param text
	 *            String ������е�ֵ
	 * @return String ��ճ��ַ����Ľ��
	 */
	public String setReciprocal(String text) {
		// ���textΪ0��������
		if (text.equals("0")) {
			return text;
		} else {
			// ��isSecondNum��־Ϊtrue
			this.isSecondNum = true;
			// ������������
			return String.valueOf(MyMath.divide(1, Double.valueOf(text)));
		}
	}

	/**
	 * ���㿪��
	 * 
	 * @param text
	 *            String ������е�ֵ
	 * @return String ��ճ��ַ����Ľ��
	 */
	public String sqrt(String text) {
		// ��isSecondNum��־Ϊtrue
		this.isSecondNum = true;
		// ������������
		return String.valueOf(Math.sqrt(Double.valueOf(text)));
	}

	/**
	 * ���ò�������
	 * 
	 * @param cmd
	 *            String ��������
	 * @param text
	 *            String ������е�ֵ
	 * @return String ��ճ��ַ����Ľ��
	 */
	public String setOp(String cmd, String text) {
		// ���˲�����������Ϊ�ϴεĲ���
		this.lastOp = cmd;
		// ���õ�һ����������ֵ
		this.firstNum = text;
		// ���ڶ�����������ֵΪ��
		this.secondNum = null;
		// ��isSecondNum��־Ϊtrue
		this.isSecondNum = true;
		// ���ؿ�ֵ
		return null;
	}

	/**
	 * ����������
	 * 
	 * @param text
	 *            String ������е�ֵ
	 * @return String ��ճ��ַ����Ľ��
	 */
	public String setNegative(String text) {
		// ���text�Ǹ������ͽ�����Ϊ����
		if (text.indexOf("-") == 0) {
			return text.substring(1, text.length());
		}
		// ���򣬽�������ɸ���
		return text.equals("0") ? text : "-" + text;
	}

	/**
	 * ������������֣�ÿ�ε������ ���¼ӵ�����׷�ӵ�����
	 * 
	 * @param cmd
	 *            String ��������
	 * @param text
	 *            String ������е�ֵ
	 * @return String ��ճ��ַ����Ľ��
	 */
	public String catNum(String cmd, String text) {
		String result = cmd;
		// ���Ŀǰ��text������0
		if (!text.equals("0")) {
			if (isSecondNum) {
				// ��isSecondNum��־Ϊfalse
				isSecondNum = false;
			} else {
				// �շ��ؽ��ΪĿǰ��text�����µ��������
				result = text + cmd;
			}
		}
		// �����.��ͷ������ǰ�油0
		if (result.indexOf(".") == 0) {
			result = "0" + result;
		}
		return result;
	}

	/**
	 * ʵ��backspace����
	 * 
	 * @param text
	 *            String ���������Ľ��
	 * @return String
	 */
	public String backSpace(String text) {
		return text.equals("0") || text.equals("") ? "0" : text.substring(0,
				text.length() - 1);
	}

	/**
	 * ʵ�ִ洢��������
	 * 
	 * @param cmd
	 *            String ��������
	 * @param text
	 *            String ���������Ľ��
	 * @return String
	 */
	public String mCmd(String cmd, String text) {
		if (cmd.equals("M+")) {
			// �����"M+"����,�հѼ������ۻ���store��
			store = MyMath.add(store, Double.valueOf(text));
		} else if (cmd.equals("MC")) {
			// �����"MC"�����������store
			store = 0;
		} else if (cmd.equals("MR")) {
			// �����"MR"���������store��ֵ������
			isSecondNum = true;
			return String.valueOf(store);
		} else if (cmd.equals("MS")) {
			// �����"MS"��������Ѽ��������浽store
			store = Double.valueOf(text).doubleValue();
		}
		return null;
	}

	/**
	 * ������м�����
	 * 
	 * @return String
	 */
	public String clearAll() {
		// ����һ�ڶ��������ָ�ΪĬ��ֵ
		this.firstNum = "0";
		this.secondNum = null;
		return this.firstNum;
	}

	/**
	 * ����ϴμ�����
	 * 
	 * @param text
	 *            String ���������Ľ��
	 * @return String
	 */
	public String clear(String text) {
		return "0";
	}

	/**
	 * ���ش洢���еĽ��
	 * 
	 * @return double
	 */
	public double getStore() {
		return this.store;
	}

}