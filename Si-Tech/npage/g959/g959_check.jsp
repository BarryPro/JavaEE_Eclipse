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
	
	String[] inParas2 = new String[2];
	inParas2[0]="select to_char(count(contract_no)) ,to_char(contract_no) from dagtbasemsg where agt_phone=:agt_no  group by contract_no ";
	inParas2[1]="agt_no="+agt_phone;
				
	String i_count="0";   
	String retResult = "";
	String ret_code="";
	String s_contract_no="";
	String s_id="";
 
%>

<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2">
			<wtc:param value="<%=inParas2[0]%>"/>
			<wtc:param value="<%=inParas2[1]%>"/>
</wtc:service>
<wtc:array id="result1" scope="end"/>

<%
	     String cust_passwd="";
	     String iccid="";
	      
	     if(result1!=null&&result1.length>0)
	     {
		      ret_code="1"; 
			  i_count=result1[0][0];	
			  s_contract_no = result1[0][1];	
			  if(Integer.parseInt(i_count)>0)
			  {
				   String[] inParas3 = new String[2];
				   inParas3[0]="select to_char(id_no) from dconusermsg where contract_no=:s_con ";
				   inParas3[1]="s_con="+s_contract_no;
				   %>
							<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="1">
										<wtc:param value="<%=inParas3[0]%>"/>
										<wtc:param value="<%=inParas3[1]%>"/>
							</wtc:service>
							<wtc:array id="result2" scope="end"/>
				   <%
				   if(result2!=null&&result2.length>0)
				   {
						s_id=result2[0][0];
						String[] inParas4 = new String[2];
						inParas4[0]="select to_char(phone_no)  from dcustmsg where id_no=:s_id ";
						inParas4[1]="s_id="+s_id;
						%>
							<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode3" retmsg="retMsg3" outnum="1">
										<wtc:param value="<%=inParas4[0]%>"/>
										<wtc:param value="<%=inParas4[1]%>"/>
							</wtc:service>
							<wtc:array id="result3" scope="end"/>
						<%
						if(result3!=null&&result3.length>0)
					    {
							 ret_code="0"; 
						}
						else
					     {
							   ret_code="4";
							   retResult="没有此用户的dcustmsg相关资料!";
						   }
				   }	
				   else
				   {
					   ret_code="3";
					   retResult="没有此用户的dconusermsg相关资料!";
				   }


				  
			  } 	  
	     }
		 else
		 {
		     ret_code="2";
		     retResult="没有此用户的相关资料!";
	     }
	      
	      
 
 

%>
var response = new AJAXPacket  ();
var retResult = "<%=ret_code%>";
var retResult1 =  "<%=retResult%>";
response.guid = '<%= request.getParameter("guid") %>';
response.data.add("retResult",retResult);
response.data.add("retResult1",retResult1);
core.ajax .receivePacket(response);
<%System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");%>


 
