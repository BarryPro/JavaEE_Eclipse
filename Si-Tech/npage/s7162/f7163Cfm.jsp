<%
/********************
version v2.0
������: si-tech
ģ�飺��ֵ�������
���ڣ�2008.12.1
���ߣ�leimd
********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.*" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%	

//	String[][] result = new String[][]{};
//	SPubCallSvrImpl impl = new SPubCallSvrImpl();
	
//	ArrayList retArray = new ArrayList();
	String opCode = "7163";
	String opName = "��ֵ�������";
//	ArrayList arr = (ArrayList)session.getAttribute("allArr");
//	String[][] baseInfo = (String[][])arr.get(0);
//	String work_no = baseInfo[0][2];
//	String work_name = baseInfo[0][3];
//	String org_code = baseInfo[0][16];
		String work_no = (String)session.getAttribute("workNo");
  	String work_name = (String)session.getAttribute("workName");
  	String org_code = (String)session.getAttribute("orgCode");
	  String phoneNo = (String)request.getParameter("phoneNo");
//	ArrayList paraAray = new ArrayList();
	String[] paraIN = new String [7];
	paraIN[0]=(request.getParameter("sysAccept"));//������ˮ(�ɿ�)
	paraIN[1]=("7163");//��������
	paraIN[2]=(work_no);//����
	paraIN[3]=(request.getParameter("opNote"));//��ע
	paraIN[4]=(request.getRemoteHost());//ip
	paraIN[5]=(request.getParameter("phoneNo"));//�ֻ�����
	paraIN[6]=(request.getParameter("loginaccept"));//����������ˮ
	
//	String[] ret = impl.callService("s7163Cfm",paraIN,"2");
%>
    <wtc:service name="s7163Cfm"  routerKey="phone" routerValue="<%=phoneNo%>" retcode="error_code1" retmsg="error_msg1" outnum="2" >
		<wtc:param value="<%=paraIN[0]%>"/>
		<wtc:param value="<%=paraIN[1]%>"/>
		<wtc:param value="<%=paraIN[2]%>"/> 
		<wtc:param value="<%=paraIN[3]%>"/>
		<wtc:param value="<%=paraIN[4]%>"/>
		<wtc:param value="<%=paraIN[5]%>"/>
		<wtc:param value="<%=paraIN[6]%>"/> 
	  </wtc:service>
	  <wtc:array id="result" scope="end"/>
	  
<%
String error_code = result[0][0];
String error_msg = result[0][1];
System.out.println("error_codeerror_codeerror_codeerror_codeerror_codeerror_code"+error_code);
String errorcode="";
if(error_code.equals("0")){
	errorcode="000000";
}else{
	errorcode=error_code;	
}
String url = "/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+error_code+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+paraIN[6]+"&pageActivePhone="+paraIN[5]+"&retMsgForCntt="+error_msg+"&opBeginTime="+opBeginTime+"&contactId="+paraIN[5]+"&contactType=user"; 
	String errCode = error_code;
	String errMsg = error_msg;
	System.out.println("error_codeerror_codeerror_codeerror_codeerror_codeerror_code"+error_code);
	if (errCode.equals("0")||errCode.equals("000000"))
	{
%>
<script language="JavaScript">
   rdShowMessageDialog("�����ɹ���",2);
   location="f7162_1.jsp?activePhone=<%=request.getParameter("phoneNo")%>&opCode=7163&opName=��ֵ�������";
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("errCode:"+"<%=errCode%>"+"<br>errMsg:"+"<%=errMsg%>",0);
	history.go(-1);
</script>
<%}%>
<jsp:include page="<%=url%>" flush="true" />
