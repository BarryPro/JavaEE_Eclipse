<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-15 ҳ�����,�޸���ʽ
*
********************/
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%
   String phone_no = WtcUtil.repStr(request.getParameter("phone_no")," ");
   String busy_type = WtcUtil.repStr(request.getParameter("busy_type")," ");
   String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);      
	 String retResult = "";
	 String returnCode="";
	 String sqlStr = "";
	 String strIdNo = "";
	 String strSzxFlag = "";
	 String strIsMarketingFlag ="";
	System.out.println("phone_no----------------------------------------------------------------:"+phone_no);
	/*���� 2006��8��29�� ���ӱ�׼�������ж�*/	
	String strSqlText = "";
	
  //����У��
	System.out.println("=zhangyan==14=pubCheckPwd.jsp====wanghfa=��������Ƿ���ȷ===========");

	String accountType = (String)session.getAttribute("accountType"); 		//yanpx ��� Ϊ�ж��Ƿ�Ϊ�ͷ�����
	String custType = WtcUtil.repStr(request.getParameter("custType"),"");	//01:�û�����У�� 02 �ͻ�����У�� 03�ʻ�����У��
		System.out.println("=zhangyan==18=pubCheckPwd.jsp====wanghfa=��������Ƿ���ȷ===========");

	String phoneNo = WtcUtil.repStr(request.getParameter("phoneNo"),"");	//�ƶ�����,�ͻ�id,�ʻ�id
		System.out.println("=zhangyan==21=pubCheckPwd.jsp====wanghfa=��������Ƿ���ȷ===========");

	String custPaswd = WtcUtil.repStr(request.getParameter("custPaswd"),"");//�û�/�ͻ�/�ʻ�����
	custPaswd = Encrypt.encrypt(custPaswd);
	String idType = WtcUtil.repStr(request.getParameter("idType"),"");		//en ����Ϊ���ģ�������� ����Ϊ����
	String idNum = WtcUtil.repStr(request.getParameter("idNum"),"");		//����
	String loginNo = (String)session.getAttribute("workNo");//WtcUtil.repStr(request.getParameter("loginNo"),"");	//����
	
	//loginNo="aa0101";
	String retCode1 = new String();
	String retMsg1 = new String();
	System.out.println("=zhangyan===pubCheckPwd.jsp====wanghfa=��������Ƿ���ȷ===========");
	System.out.println("=zhangyan==========wanghfa============ custType = " + custType);
	System.out.println("=zhangyan==========wanghfa============ phoneNo = " + phoneNo);
	System.out.println("=zhangyan==========wanghfa============ custPaswd = " + custPaswd);
	System.out.println("=zhangyan==========wanghfa============ idType = " + idType);
	System.out.println("=zhangyan==========wanghfa============ idNum = " + idNum);
	System.out.println("=zhangyan==========wanghfa============ loginNo = " + loginNo);

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
	System.out.println("=zhangyan==========wanghfa============retCode=" + retCode);
	System.out.println("=zhangyan==========wanghfa============retMsg=" + retMsg);
	retCode1 = retCode;
	retMsg1  = retMsg;

	if ("000000".equals(retCode)) {
		for (int i = 0; i < result.length; i ++ ) {
			for (int j = 0; j < result[i].length; j ++) {
				System.out.println("==zhangyan=======wanghfa==========result[" + i + "][" + j + "]" + result[i][j]);
			}
		}
	}

}
%>
 


var response = new AJAXPacket();
var retResult = "<%=retResult%>";
var SzxFlag = "<%=strSzxFlag%>";
var returnCode="<%=returnCode%>";
var IsMarketing="<%=strIsMarketingFlag%>";
var retResult_mm = "<%=retCode1%>";
var msg = "<%=retMsg1%>";
 



response.data.add("retResult",retResult);
response.data.add("SzxFlag",SzxFlag);
response.data.add("returnCode",returnCode);
response.data.add("IsMarketing",IsMarketing);
response.data.add("retResult_mm",retResult_mm);
response.data.add("msg",msg);
 


core.ajax.receivePacket(response);



 
