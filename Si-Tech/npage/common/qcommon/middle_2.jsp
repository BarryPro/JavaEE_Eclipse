<%
  /*
   * 功能: 手输选号 固话 小灵通
　 * 版本: 2.0
　 * 日期: 2007-07-05 16:12
　 * 作者: wangxz
　 * 版权: sitech
　*/
%> 
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>


<%
    	int valid = 1;	//0:正确，1：系统错误，2：业务错误
		int recordNum=0;   //返回的行数
		String errCode_1="444444";//handNum 
   	 	String errMessage_1="系统错误，请与系统管理员联系，谢谢!!";
		String errCode_2="";
   	 	String errMessage_2=""; //080002
  	
  	String retType=request.getParameter("retType");
		String[][] result = null;
		String strArray="var arrMsg; ";  //must
  	
  	String NUM=request.getParameter("NUM");
		String IN_PHS_SWITCH=request.getParameter("IN_PHS_SWITCH");
		String BUSI_ID=request.getParameter("BUSI_ID");
		String STAFF_ID=request.getParameter("STAFF_ID");
		String BRANCH_NO=request.getParameter("BRANCH_NO");
		String PRODUCT_ID=request.getParameter("PRODUCT_ID");
		String SITE_ID=request.getParameter("SITE_ID");
		String vas_prod=request.getParameter("vas_prod");
		
		String WORK_F0RM_ID=request.getParameter("work_form_id");
		String CITY_ID=request.getParameter("city_id");
		String SVC_INST_ID=request.getParameter("svc_inst_id");
		String ORDER_ID=request.getParameter("order_id");
		String OBJECT_ID=request.getParameter("object_id");
		String RESO_NUMB=request.getParameter("reso_numb");
		String PRE_REASON=request.getParameter("pre_reason");
		String ADDR=request.getParameter("addr");
		String SVC_ID=request.getParameter("svc_id");
		String NUM_TYPE=request.getParameter("NUM_TYPE");
		String masterServId=request.getParameter("masterServId");
		String prod_str=PRODUCT_ID+"|"+masterServId;
		
		String ret_code = "";
		String ret_msg = "";
%>

<%if(PRODUCT_ID.trim().equals("1"))
{%>
  	<wtc:service name="MRM_handNum" outnum="3">
  		<wtc:param value="<%=NUM%>"/>
  		<wtc:param value="<%=BRANCH_NO%>"/>
  		<wtc:param value="<%=STAFF_ID%>"/>
  		<wtc:param value="<%=SITE_ID%>"/>
  		<wtc:param value="<%=IN_PHS_SWITCH%>"/>
		  <wtc:param value="<%=BUSI_ID%>"/>
  		<wtc:param value="<%=prod_str.trim()%>"/>
	</wtc:service>
	<wtc:array id="rows" scope="end"/>
<%
	errCode_1 = retCode;
	errMessage_1 = retMsg;
	System.out.println("MRM_handNum返回的错误信息是"+errMessage_1);
	result = rows;
}
else
{%>
	<wtc:service name="MRM_handPhs" outnum="3">
  		<wtc:param value="<%=NUM%>"/>
  		<wtc:param value="<%=BRANCH_NO%>"/>
  		<wtc:param value="<%=STAFF_ID%>"/>
  		<wtc:param value="<%=SITE_ID%>"/>
  		<wtc:param value="<%=IN_PHS_SWITCH%>"/>
			<wtc:param value="<%=BUSI_ID%>"/>
  		<wtc:param value="<%=prod_str.trim()%>"/>
	</wtc:service>
	<wtc:array id="rows" scope="end"/>
<%
	errCode_1 = retCode;
	errMessage_1 = retMsg;
	result = rows;
}
 	  	
 	  	%>
	

		
<%
    //错误代码和错误信息在此处统一处理.
    if( result == null )
    {
		valid = 1;
		errCode_1="444444";
		errMessage_1 = "发生系统错误";
    }
    else
    {
   		recordNum = result.length;      
     	if ( recordNum == 0 )
     	{
        	valid = 2;
      	}
      	else
      	{	
      		 valid = 0;
        	 strArray = CreatePlanerArray.createArray("arrMsg",result.length);
      	}
    }	
%>

<%=strArray%>

<% if( valid == 0 ){ %>
	<%
		for(int i = 0 ; i < recordNum; i ++){
      		for(int j = 0 ; j < result[i].length ; j ++){
				if(result[i][j].trim().equals("") || result[i][j] == null){
   				   result[i][j] = "";
				}
				%>
				arrMsg[<%=i%>][<%=j%>] = "<%=result[i][j].trim()%>";
				<%
			}
		}
	%>
<% } %>

<%
if(errCode_1.equals("000000"))
{	System.out.println("errCode_1 == "+errCode_1);
	NUM=NUM+"~";
%>
		<wtc:service name="MRM_YZ_0001" outnum="0">
			<wtc:param value="<%=NUM%>"/>
			<wtc:param value="<%=BRANCH_NO%>"/>
			<wtc:param value="0"/>
			<wtc:param value="<%=STAFF_ID%>"/>
			<wtc:param value="<%=SITE_ID%>"/>
			<wtc:param value="<%=NUM_TYPE%>"/>
			<wtc:param value="<%=WORK_F0RM_ID%>"/>
			<wtc:param value="<%=CITY_ID%>"/>
			<wtc:param value="<%=SVC_INST_ID%>"/>
			<wtc:param value="<%=ORDER_ID%>"/>
			<wtc:param value="<%=RESO_NUMB%>"/>
			<wtc:param value="<%=PRE_REASON%>"/>
			<wtc:param value="<%=ADDR%>"/>
			<wtc:param value="<%=PRODUCT_ID%>"/>
			<wtc:param value="<%=SVC_ID%>"/>
			<wtc:param value=""/>
		</wtc:service>
	<%
		if(retCode.equals("000000"))
		{	
			errCode_2="000000";
			System.out.println("errCode_2 == "+errCode_2);
			errMessage_2=retMsg;
		}
		else
		{	
			errCode_2=retCode;
			System.out.println("errCode_2 == "+errCode_2);
     		errMessage_2=retMsg;
		}
}
%>

var response = new AJAXPacket();

response.data.add("retType","<%=retType%>");
response.data.add("errCode_1","<%= errCode_1 %>");
response.data.add("retMessage_1","<%= errMessage_1 %>");
response.data.add("errCode_2","<%= errCode_2 %>");
response.data.add("retMessage_2","<%= errMessage_2 %>");
response.data.add("tri_list",arrMsg );

core.ajax.receivePacket(response);