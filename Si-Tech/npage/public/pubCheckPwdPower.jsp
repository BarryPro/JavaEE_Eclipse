<%@ page import="java.util.Map"%>
<%
	System.out.println("====wanghfa==== accountType = " + (String)session.getAttribute("accountType"));
	if ("2".equals((String)session.getAttribute("accountType"))) {	//�ͷ�����
		pwrf = true;
	} else {
		Map tmap = (Map)(session.getAttribute("contactTimeMap") == null ? new HashMap() : session.getAttribute("contactTimeMap"));
		System.out.println("====wanghfa==== pubOpCode = " + pubOpCode);
		String pubPwdValidate = "";
		for (int pubI = 0; pubI < pubOpCode.split(",").length; pubI ++) {
			pubPwdValidate += (String)tmap.get("x|" + pubOpCode.split(",")[pubI]) + ",";
		}
		System.out.println("====wanghfa==== pubPwdValidate = " + pubPwdValidate);
		if (pubPwdValidate.indexOf("pwdValidate") != -1) {	/*������Ȩ��*/
			pwrf = true;
		} else {	/*������Ȩ��*/
			pwrf = false;
		}
	}
%>
