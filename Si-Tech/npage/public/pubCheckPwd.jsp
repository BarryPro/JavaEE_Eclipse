<%
/********************
 version v2.0
������: si-tech
*
*create:wanghfa@2010-8-16 У�������Ƿ���ȷ
*
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	String accountType = (String)session.getAttribute("accountType"); 		//yanpx ��� Ϊ�ж��Ƿ�Ϊ�ͷ�����
	String custType = WtcUtil.repStr(request.getParameter("custType"),"");	//01:�ֻ����� 02 �ͻ�����У�� 03�ʻ�����У��
	String phoneNo = WtcUtil.repStr(request.getParameter("phoneNo"),"");	//�ƶ�����,�ͻ�id,�ʻ�id
	String custPaswd = WtcUtil.repStr(request.getParameter("custPaswd"),"");//�û�/�ͻ�/�ʻ�����
	String idType = WtcUtil.repStr(request.getParameter("idType"),"");		//en ����Ϊ���ģ�������� ����Ϊ����
	String idNum = WtcUtil.repStr(request.getParameter("idNum"),"");		//����
	String loginNo = WtcUtil.repStr(request.getParameter("loginNo"),"");	//����
	String retCode1 = new String();
	String retMsg1 = new String();
	System.out.println("====pubCheckPwd.jsp====wanghfa=��������Ƿ���ȷ===========");
	System.out.println("===========wanghfa============ custType = " + custType);
	System.out.println("===========wanghfa============ phoneNo = " + phoneNo);
	System.out.println("===========wanghfa============ custPaswd = " + custPaswd);
	System.out.println("===========wanghfa============ idType = " + idType);
	System.out.println("===========wanghfa============ idNum = " + idNum);
	System.out.println("===========wanghfa============ loginNo = " + loginNo);

/*yanpx ��� �ͷ����Ų�����������֤ ֱ��ͨ��20100907 ��ʼ */
if( accountType.equals("2") ){
	retCode1 = "000000";
	retMsg1  = "������֤ͨ��";
} else {
%>
<wtc:service name="sPubCustCheck" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode" retmsg="retMsg" outnum="5">
	<wtc:param value="<%=custType%>"/>
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value="<%=custPaswd%>"/>
	<wtc:param value="<%=idType%>"/>
	<wtc:param value="<%=idNum%>"/>
	<wtc:param value="<%=loginNo%>"/>
</wtc:service>
<wtc:array id="result" scope="end"/>
<%
	System.out.println("===========wanghfa============retCode=" + retCode);
	System.out.println("===========wanghfa============retMsg=" + retMsg);
	retCode1 = retCode;
	retMsg1  = retMsg;

	if ("000000".equals(retCode)) {
		for (int i = 0; i < result.length; i ++ ) {
			for (int j = 0; j < result[i].length; j ++) {
				System.out.println("=========wanghfa==========result[" + i + "][" + j + "]" + result[i][j]);
			}
		}
	}

}
/*yanpx ��� ����*/
%>
var response = new AJAXPacket();
var retResult = "<%=retCode1%>";
var msg = "<%=retMsg1%>";

response.data.add("retResult",retResult);
response.data.add("msg",msg);

core.ajax.receivePacket(response);
