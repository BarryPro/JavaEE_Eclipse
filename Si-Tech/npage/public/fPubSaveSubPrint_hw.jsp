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
 			String work_no = (String)session.getAttribute("workNo");

			String retType=request.getParameter("retType");
	    String billType=request.getParameter("billType");
	    String phoneNo=request.getParameter("phoneNo");
	    String login_accept=request.getParameter("login_accept");
	    String errCode="";
	    String errMsg="";

	    String iccidcardno="";
	    String everyInfoCounts="";
	    
	    System.out.println("hejwa     retType="+retType);
	    System.out.println("hejwa     billType="+billType);
%>
	<wtc:service name="sPrt_JprintNew" routerKey="phone" routerValue="<%=phoneNo%>" outnum="14" >
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value="<%=work_no%>"/>
		<wtc:param value="<%=billType%>"/>
		<wtc:param value="<%=login_accept%>"/>
	</wtc:service>
	
	<wtc:array id="result2222" scope="end"  start="0"  length="2"/>
	<wtc:array id="result" scope="end"  start="2"  length="6"/>
		
  var impResultArr = new Array();	

	<%
	
	
	System.out.println("hejwa      result2222.length=="+result.length);
	  if(result2222.length>0){
	  		iccidcardno=result2222[0][0];
	  		everyInfoCounts=result2222[0][1];
	  		everyInfoCounts=everyInfoCounts.substring(0,everyInfoCounts.length()-1);
	  }
	
	  System.out.println("hejwa      iccidcardno=="+iccidcardno);
	  System.out.println("hejwa      everyInfoCounts=="+everyInfoCounts);
		String tempStr="";
			if(result.length>0){
				for(int i=0;i<result.length;i++){
	%>
					var temResultArr = new Array();
	<%
					for(int j=0;j<result[i].length;j++){
						tempStr = result[i][j].replaceAll("\r\n","");
						tempStr = tempStr.replaceAll("\"","\\\\\"");
						System.out.println("hejwa      result["+i+"]["+j+"]=="+result[i][j]);
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
response.data.add("everyInfoCounts","<%=everyInfoCounts%>");
response.data.add("iccidcard","<%=iccidcardno%>");
core.ajax.receivePacket(response);