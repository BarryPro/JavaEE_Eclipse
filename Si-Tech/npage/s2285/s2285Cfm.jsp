<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2009.02.05
 ģ��: ���еش����̻�������
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>

 <%
    response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
	
	String loginAccept = request.getParameter("loginAccept");
 	String opCode  = request.getParameter("opCode");
 	String opName="";
 	if(opCode.equals("2285")){
		opName="���еش����̻�������";
	}else{
		opName="���еش����̻��ճ���";
		
	}
 	
	String phoneNo = request.getParameter("phoneNo");
	String cardNo = request.getParameter("cardNo");
	String newcardNo = request.getParameter("oldcardNo");
	String opNote = request.getParameter("opNote");
	String oldloginAccept = request.getParameter("oldloginAccept");
		
	/* ningtn �������г���ͨ����  */
	String dnCityCardNo = request.getParameter("dnCityCardNo")==null?"0":request.getParameter("dnCityCardNo");
	if(dnCityCardNo.length() == 0){
		dnCityCardNo = "0";
	}
	System.out.println(" $$$$$$ ningtn  $$$$$$ " + dnCityCardNo);

    //==============================��ȡӪҵԱ��Ϣ
    String workno = (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");
	//=======================��ò�����ˮ
	
    String [] inParas = new String[9];
	
	inParas[0] = loginAccept;
	inParas[1] = opCode;
	inParas[2] = workno;
	inParas[3] = phoneNo;
	inParas[4] = cardNo;
	inParas[5] = newcardNo;
	inParas[6] = opNote;
	inParas[7] = oldloginAccept;
	/* ningtn �������г���ͨ����  */
	inParas[8] = dnCityCardNo;
	
	
	//String[] ret = impl.callService("s2285Cfm",inParas,"2");
%>
	<wtc:service name="s2285Cfm" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="2">			
	<wtc:param value="<%=inParas[0]%>"/>	
	<wtc:param value="<%=inParas[1]%>"/>	
	<wtc:param value="<%=inParas[2]%>"/>	
	<wtc:param value="<%=inParas[3]%>"/>	
	<wtc:param value="<%=inParas[4]%>"/>	
	<wtc:param value="<%=inParas[5]%>"/>	
	<wtc:param value="<%=inParas[6]%>"/>	
	<wtc:param value="<%=inParas[7]%>"/>	
	<wtc:param value="<%=inParas[8]%>"/>	
	</wtc:service>	
	<wtc:array id="ret"  scope="end"/>
<%
	String retCode= retCode1;
	String retMsg = retMsg1;
	System.out.println("retCode===="+retCode);
	System.out.println("retMsg1===="+retMsg1);
	String url = "/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode1+"&opName="+opName+"&workNo="+workno+"&loginAccept="+loginAccept+"&pageActivePhone="+phoneNo+"&retMsgForCntt="+retMsg1+"&opBeginTime="+opBeginTime;
%>
	<jsp:include page="<%=url%>" flush="true" />
<%	
	if (ret != null && retCode.equals("000000"))
{%>
	 <script language="JavaScript">
		rdShowMessageDialog("�����ɹ�",2);
		removeCurrentTab();
	 </script>
<%}else{%>
	 <script language="JavaScript">
		rdShowMessageDialog("��ѯ����!<br>������룺'<%=retCode%>'��������Ϣ��'<%=retMsg%>'��",0);
		history.go(-2);
	 </script>
<%} %>
