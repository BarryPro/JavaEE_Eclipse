<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%
    //得到输入参数
    String agt_phone = WtcUtil.repStr(request.getParameter("agt_phone")," ");
    String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
       
    String sqlStr = "";
	
	String s_sum="0";
	String ret_code="";
	String ret_msg="";
 
%>

<wtc:service name="sQuery" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="3">
			<wtc:param value="<%=agt_phone%>"/>
 
</wtc:service>
<wtc:array id="result1" scope="end"/>

<%
	     if(result1!=null&&result1.length>0)
	     {
		      if(result1[0][0]=="000000" ||result1[0][0].equals("000000"))
			  {
				  ret_code="0"; 
				  ret_msg=result1[0][1];
				  s_sum=result1[0][2];
				  System.out.println("CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC");
			  }	
			  else
			  {
				  ret_code="1";
				  ret_msg="查询报错";
				  s_sum="0";
				  System.out.println("ddddddddddddddddddd");
			  }		 
			  System.out.println("AAAAAAAAAAAAAAAAA s_sum is "+s_sum+" result1[0][0] is "+result1[0][0]+" and result1[0][1] is "+result1[0][1]+" and result1[0][2] is "+result1[0][2]); 				   	  
	     }
		 else
		 {
		     ret_code="2";
			 ret_msg="服务调用报错";
			 s_sum="0";
			 System.out.println("BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB");
		   
	     }
	      
	      
 
 

%>
var response = new AJAXPacket  ();
var retResult = "<%=ret_code%>";
var s_sum = "<%=s_sum%>";
var ret_msg = "<%=ret_msg%>";
 
response.data.add("retResult",retResult);
response.data.add("s_sum",s_sum);
response.data.add("ret_msg",ret_msg);
core.ajax .receivePacket(response);
<%System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");%>


 
