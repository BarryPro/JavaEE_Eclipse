<%
/*****************************
 * ģ�����ƣ��������պ�Ⱥ��Ա����
 * ����汾��version 1.0
 * �� �� ��: SI-TECH
 * ��    ��: shengzd
 * ����ʱ��: 2010-05-19
 *****************************/
%>

<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="java.util.*"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
	String regionCode = (String) session.getAttribute("regCode");

	String[][] callData = null;

	String errorCode = "7777777";
	String errorMsg = "ϵͳ��������ϵͳ����Ա��ϵ��лл!!";
	
	String strArray = "var arrMsg; ";
	String vOutNum = "";
	String insql = "";

	String verifyType = request.getParameter("verifyType"); 
  System.out.println("\n## ++++++++++++++++++++ verifyType = "+verifyType+"\n");
  String vNewClose  = request.getParameter("vNewClose");
  String vOldClose  = request.getParameter("vOldCloseNo");
  String vUnitId    = request.getParameter("vOldUnitId");
  System.out.println("## ++++++++++++++++++++ vNewClose  = "+vNewClose+"\n");
  System.out.println("## ++++++++++++++++++++ vOldClose  = "+vNewClose+"\n");
  System.out.println("## ++++++++++++++++++++ vUnitId    = "+vUnitId+"\n");
	if(verifyType.equals("getNewClose")){ /*getNewClose ��ȡ�պ�Ⱥ�б� */
	  vOutNum = "2";
	  insql = "SELECT Close_NO,Close_NO||'-->'||Close_name from dCloseGrpMsg where Unit_id="+vUnitId+" AND CLOSE_NO !="+vOldClose+" ORDER BY CLOSE_NO";
	}
	if(verifyType.equals("NewClose")){ /* NewClose �����±պ�Ⱥ��Ϣ */
	  vOutNum = "3";
	  insql = "SELECT CLOSE_NAME,FEE_INDEX,MAX_USER_NUM FROM dCloseGrpMsg WHERE CLOSE_NO="+vNewClose;
	}
	System.out.println("## ++++++++++++++++++++ insql = "+ insql +"\n\n");
	
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="<%=vOutNum%>">
	<wtc:sql><%=insql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end" />
<%
callData = result;
strArray = WtcUtil.createArray("arrMsg",callData.length);
%>
<%=strArray%>
<%
	for (int i = 0; i < callData.length; i++) {
		for (int j = 0; j < callData[i].length; j++) {

			if (callData[i][j].trim().equals("") || callData[i][j] == null) {
				callData[i][j] = "";
			}
%>
arrMsg[<%=i%>][<%=j%>] = "<%=callData[i][j].trim()%>";
<%
		}
	}
%>

var response = new AJAXPacket(); 
response.data.add("verifyType","<%=verifyType%>");
response.data.add("errorCode","<%=errorCode%>");
response.data.add("errorMsg","<%=errorMsg%>");
response.data.add("backArrMsg",arrMsg);
core.ajax.receivePacket(response);

