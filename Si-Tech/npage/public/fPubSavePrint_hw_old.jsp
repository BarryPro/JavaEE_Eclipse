<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-19 ҳ�����,�޸���ʽ
*1270,1219,2266��ģ����ʹ�õ�ҳ��.
********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="java.util.*"%>

<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %> 

<%	
		/***�û��ֻ���	phone_no**��������	login_no**Ʊ������	bill_type*/
 
		String opCode=request.getParameter("opCode");
		String login_accept=request.getParameter("login_accept");
		String retType=request.getParameter("retType");
	    String billType=request.getParameter("billType");
	    String phoneNo=request.getParameter("phoneNo");
	    String errCode="";
	    String errMsg="";
	    
	    
	    System.out.println("opCode="+opCode);
	    System.out.println("login_accept="+login_accept);
	    System.out.println("retType="+retType);
	    System.out.println("billType="+billType);
%>
	<wtc:service name="sPrt_Print" routerKey="phone" routerValue="<%=phoneNo%>" outnum="13" >
		<wtc:param value="<%=login_accept%>"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=billType%>"/>
		<wtc:param value="<%=phoneNo%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>

  var impResultArr = new Array();	
	<%
			if(result.length>0){
				for(int i=0;i<result.length;i++){
	%>
					var temResultArr = new Array();
	<%
					for(int j=0;j<result[i].length;j++){
					String tempStr = result[i][j].replaceAll("\r\n","");
					tempStr = tempStr.replaceAll("\"","\\\\\"");
					System.out.println("result["+i+"]["+j+"]=="+tempStr);
	%>
						
						temResultArr[<%=j%>] = "<%=tempStr%>";
	<%				
					}
	%>
					impResultArr[<%=i%>]=temResultArr;
	<%
				}	
			}
	%>
<%
if(retCode.equals("000000")){   
	if(result.length>0)
	{
		 errCode="000000";
     errMsg="������ӡ�ɹ���";
     session.removeAttribute("loginacceptJT");
	}
	else{
		 errCode="000001";
     errMsg="��ӡ����Ϊ�գ�";
	}
}else{ 
   errCode=retCode;
   errMsg=retMsg;
	}
%>
var response = new AJAXPacket();
var retType = "";
var errCode = ""
var errMsg = "";
retType = "<%=retType%>";
errCode = "<%=errCode%>";
errMsg = "<%=errMsg%>";
response.data.add("retType",retType);
response.data.add("errCode",errCode);
response.data.add("errMsg",errMsg);
response.data.add("impResultArr",impResultArr);
core.ajax.receivePacket(response);

