 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-12 页面改造,修改样式
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.lang.*"%>

<script language="JavaScript">
<%
	String regionCode=(String)session.getAttribute("regCode");  	
	String card_no = request.getParameter("card_no");
	String cardflag = request.getParameter("cardflag");
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
	int inputNumber = 2;
	String  outputNumber = "4";
	String  inputParsm [] = new String[inputNumber];
	inputParsm[0] = card_no;
	inputParsm[1] = cardflag;
	System.out.println("gaopeng---------------->"+card_no);
	System.out.println("gaopeng---------------->"+cardflag);
  	//String [] initBack = impl.callService("s3075Init",inputParsm,outputNumber);
  %>
	<wtc:service name="s3075Init" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="4">			
		<wtc:param value="<%=inputParsm[0]%>"/>
		<wtc:param value="<%=inputParsm[1]%>"/>
	</wtc:service>	
	<wtc:array id="result"  scope="end"/>  

  <%
	//ArrayList list  = initBack.getList();
	String[][] initBack = result;
   
	//int return_code=impl.getErrCode();
	//String error_msg =impl.getErrMsg();
	String return_code=retCode2;
	String error_msg =retMsg2;
	
	if (return_code.equals("000000"))
	{
%>
		window.returnValue="0<%=initBack[0][2]%>"+"||"+"<%=initBack[0][3]%>";
		window.close();
<%
	}
	else{		
%>
		window.returnValue="1<%=error_msg%>";
		window.close(); 
<%
	}
%>
 
</script>
