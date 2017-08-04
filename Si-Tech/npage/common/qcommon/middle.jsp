<%
  /*
   author:zhouyg
   date:2009-2-11
　*/
%> 
<%@ page contentType="text/html;charset=GB2312"%>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

   
<%
 		int valid = 1;	//0:正确，1：系统错误，2：业务错误
		int recordNum=0;   //返回的行数
  	String errCode_1="444444";
 	 	String errMessage_1="系统错误，请与系统管理员联系，谢谢!!"; //selNum
		String errCode_2="444444";
 	 	String errMessage_2="系统错误，请与系统管理员联系，谢谢!!"; //080002  	
		String retType=request.getParameter("retType");
		String[][] result = null;
		String strArray="var arrMsg; ";  //must  
  	
		String TEL_HEAD=request.getParameter("TEL_HEAD");
		String TEL_LEVEL=request.getParameter("TEL_LEVEL");
		String TEL_TAIL=request.getParameter("TEL_TAIL");
		String OBJECT_TYPE=request.getParameter("OBJECT_TYPE"); 
		String IN_PHS_SWITCH=request.getParameter("IN_PHS_SWITCH");
		String BUSI_ID=request.getParameter("BUSI_ID");
		String FEE_LEVEL=request.getParameter("FEE_LEVEL");
		
		String STAFF_ID=request.getParameter("STAFF_ID");//	同时做pre_occupy_staff
		String BRANCH_NO=request.getParameter("BRANCH_NO");
		String masterServType = request.getParameter("PRODUCT_ID");//主体服务类型
		String masterServId = request.getParameter("masterServId");//主体服务ID
		//String vas_prod=request.getParameter("vas_prod");  // chendm说不要这个了,换成主体服务Id
		String WORK_F0RM_ID=request.getParameter("work_form_id");
		String CITY_ID=request.getParameter("city_id");
		String SVC_INST_ID=request.getParameter("svc_inst_id");
		String ORDER_ID=request.getParameter("order_id");
		String OBJECT_ID=request.getParameter("object_id");
		String RESO_NUMB=request.getParameter("reso_numb");
		String PRE_REASON=request.getParameter("pre_reason");
		String ADDR=request.getParameter("addr");
		String SVC_ID=request.getParameter("svc_id");
		
		String SITE_ID=request.getParameter("SITE_ID");
		String SWITCH=request.getParameter("switch");
		String TYPE=request.getParameter("NUM_TYPE");
		
		String NUMSTR= request.getParameter("NUM");
		String prod_str=masterServType+"|"+masterServId;
		System.out.println("-----------------prod_str == " + prod_str);
		System.out.println("-----------------kaishi----------------------");
		
%>
<%
	if("getNum".equals(retType)){
	if(masterServType.trim().equals("1"))
	{
	System.out.println("-----------------"+masterServType+"----------------------");
	%>
	<wtc:service name="MRM_selNum" outnum="4">
	  <wtc:param  value="<%=BRANCH_NO%>"/>
	  <wtc:param  value="<%=TEL_HEAD%>"/>
	  <wtc:param  value="<%=TEL_LEVEL%>"/>
	  <wtc:param 	value="<%=TEL_TAIL%>"/>
	  <wtc:param  value="<%=prod_str.trim()%>"/>
	  <wtc:param  value=""/>
	  <wtc:param  value="<%=OBJECT_TYPE%>"/>
	  <wtc:param 	value="<%=IN_PHS_SWITCH%>"/>
	  <wtc:param  value="<%=BUSI_ID%>"/>
	  <wtc:param  value="<%=FEE_LEVEL%>"/>
	  <wtc:param  value="<%=STAFF_ID%>"/>
	</wtc:service>
	<%
	}
	else
	{
	%>
	<wtc:service name="MRM_selPhs" outnum="4">
	  <wtc:param  value="<%=BRANCH_NO%>"/>
	  <wtc:param  value="<%=TEL_HEAD%>"/>
	  <wtc:param  value="<%=TEL_LEVEL%>"/>
	  <wtc:param  value="<%=TEL_TAIL%>"/>
	  <wtc:param  value="<%=prod_str.trim()%>"/>
	  <wtc:param  value=""/>
	  <wtc:param  value="<%=OBJECT_TYPE%>"/>
	  <wtc:param  value="<%=IN_PHS_SWITCH%>"/>
	  <wtc:param  value="<%=BUSI_ID%>"/>
	  <wtc:param  value="<%=FEE_LEVEL%>"/>
	  <wtc:param  value="<%=STAFF_ID%>"/>
	</wtc:service>
	<%
	}
	%>
	 	  <wtc:array id="rows">
	 	  		<%	
	 	  			System.out.println("rows == "+rows.length);
						result = rows;
	 	  		%>	
	 	  </wtc:array>
	
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
	        	errCode_1 = "  222222";
	        	errMessage_1 = "查询无结果";
	      }
	      else
	      {
	      		valid = 0;
	        	errCode_1 ="000000";
				errMessage_1 = "有查询到相关信息";
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
	 }
	}else if("num_yz".equals(retType)){
		out.println("var arrMsg;");
	%>
	<wtc:service name="MRM_YZ_0001" outnum="0">
		<wtc:param 	value="<%=NUMSTR%>"/><%System.out.println("NUMSTR == "+NUMSTR);%>
		<wtc:param 	value="<%=BRANCH_NO%>"/><%System.out.println("BRANCH_NO == "+BRANCH_NO);%>
		<wtc:param  value="0"/><%System.out.println("0 == "+0);%>
		<wtc:param  value="<%=STAFF_ID%>"/><%System.out.println("STAFF_ID == "+STAFF_ID);%>
		<wtc:param  value="<%=SITE_ID%>"/><%System.out.println("SITE_ID == "+SITE_ID);%>
		<wtc:param  value="<%=TYPE%>"/><%System.out.println("TYPE == "+TYPE);%>
		<wtc:param  value="<%=WORK_F0RM_ID%>"/><%System.out.println("WORK_F0RM_ID == "+WORK_F0RM_ID);%>
		<wtc:param  value="<%=CITY_ID%>"/><%System.out.println("CITY_ID == "+CITY_ID);%>
		<wtc:param  value="<%=SVC_INST_ID%>"/><%System.out.println("SVC_INST_ID == "+SVC_INST_ID);%>
		<wtc:param  value="<%=ORDER_ID%>"/><%System.out.println("ORDER_ID == "+ORDER_ID);%>
		<wtc:param  value="<%=RESO_NUMB%>"/><%System.out.println("RESO_NUMB == "+RESO_NUMB);%>
		<wtc:param  value="<%=PRE_REASON%>"/><%System.out.println("PRE_REASON == "+PRE_REASON);%>
		<wtc:param  value="<%=ADDR%>"/><%System.out.println("ADDR == "+ADDR);%>
		<wtc:param  value="<%=masterServType%>"/><%System.out.println("masterServType == "+masterServType);%>
		<wtc:param  value="<%=SVC_ID%>"/><%System.out.println("SVC_ID == "+SVC_ID);%>
		<wtc:param	value=""/><%System.out.println("null == ");%>
	</wtc:service>
	<%
	if(retCode.equals("000000"))
	{	
		errCode_2="000000";
		errMessage_2=retMsg;
	}
	else
	{	
		errCode_2=retCode;
		errMessage_2=retMsg;
	}
}
%>

var response = new AJAXPacket;

response.data.add("retType","<%=retType%>");
response.data.add("errCode_1","<%= errCode_1 %>");
response.data.add("errMessage_1","<%= errMessage_1 %>");
response.data.add("errCode_2","<%= errCode_2 %>");
response.data.add("errMessage_2","<%= errMessage_2 %>");
response.data.add("tri_list",arrMsg );
core.ajax.receivePacket(response);
