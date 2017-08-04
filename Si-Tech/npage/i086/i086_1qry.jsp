<%
  /*
   * 功能: 用户信誉度修改2308
   * 版本: 1.0
   * 日期: 2009/1/15
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>

<%
 		 
	String regionCode = (String)session.getAttribute("regCode");		//地市代码
 
	String workno = (String)session.getAttribute("workNo");
 
	String nopass = (String)session.getAttribute("password");
	String s_paytype = request.getParameter("s_paytype");

	String s_pay_name="";
	String s_trans_flag="";
	String s_refund_flag="";
	String s_show_flag="";
	String s_order_code="";
	String s_show_name1="";
	String s_show_name2="";
	String s_show_name3="";
 
	
	
%>
 
 	
 
	<wtc:service name="bi086Qry" routerKey="region" routerValue="<%=regionCode%>" outnum="14" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=s_paytype%>"/>
		<wtc:param value="<%=workno%>"/>
 
	</wtc:service>
	<wtc:array id="mainInfo1" start="2" length="5" scope="end"/>
	<wtc:array id="mainInfo2" start="7" length="3" scope="end"/>
	<wtc:array id="mainInfo3" start="10" length="4" scope="end"/> 
<%
	//<wtc:array id="sVerifyTypeArr1" start="0" length="20" scope="end"/>
	//<wtc:array id="sVerifyTypeArr2" start="20" length="8" scope="end"/>
	String errCode = retCode;
	String errMsg = retMsg;
 
	String[][] result1  = null ;
	String[][] result2  = null ;
	String[][] result3  = null ;
	result1 = mainInfo1;
	result2 = mainInfo2;
	result3 = mainInfo3;
	if(errMsg.equals("")){
		errMsg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(errCode));
		if( errMsg.equals("null")){
			errMsg ="未知错误信息";
		}
	} 
	
	//xl add for showname1为空的情况
	String s_name1_flag="";
	%>//alert("retCode is "+"<%=retCode%>");<%
	if(retCode.equals("0")||retCode.equals("000000"))
	{
		%>
		var response = new AJAXPacket();
		<%

		s_pay_name = result1[0][0];
		s_trans_flag = result1[0][1];
		s_refund_flag=result1[0][2];
		s_show_flag = result1[0][3];
		s_order_code = result1[0][4];

		s_show_name1 = result2[0][0];
		s_show_name2 = result2[0][1];
		s_show_name3 = result2[0][2];
		if(s_show_name1=="" ||s_show_name1.equals(""))
		{
			s_name1_flag="1";
		}
		else
		{
			s_name1_flag="0";
		}
		System.out.println("CCCCCCCCCCCCCCCCCCCCCCCCC result3[0][3] is "+result3[0][3]+" and result3[0] is "+result3[0]);
	%>
		response.data.add("s_pay_name","<%=s_pay_name%>");
		response.data.add("s_trans_flag","<%=s_trans_flag%>");
		response.data.add("s_refund_flag","<%=s_refund_flag%>");
		response.data.add("s_show_flag","<%=s_show_flag%>");
		response.data.add("s_order_code","<%=s_order_code%>");
		response.data.add("s_show_name1","<%=s_show_name1%>");
		response.data.add("s_show_name2","<%=s_show_name2%>");
		response.data.add("s_show_name3","<%=s_show_name3%>");
		response.data.add("flag1","0");
		response.data.add("s_name1_flag","<%=s_name1_flag%>");
		
		response.data.add("cx_result_length","<%=result3.length%>");
		<%
	 
			for(int i=0;i<result3.length;i++)
			{
				%>
				response.data.add("cx_result_fee_code"+"<%=i%>","<%=result3[i][0]%>");
				response.data.add("cx_result_fee_name"+"<%=i%>","<%=result3[i][1]%>");
				response.data.add("cx_result_detail_code"+"<%=i%>","<%=result3[i][2]%>");
				response.data.add("cx_result_detail_name"+"<%=i%>","<%=result3[i][3]%>");
				<%
			}
		%>
		
		core.ajax.receivePacket(response);
		<%
	}
	else
	{
		//System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA失败啦 errCode is "+errCode+" and errMsg is "+errMsg);
		%>
			var response = new AJAXPacket();
			
			response.data.add("flag1","1");
			
			response.data.add("s_name1_flag","<%=s_name1_flag%>");
			response.data.add("errCode","<%=errCode%>");
			response.data.add("errMsg","<%=errMsg%>");
			core.ajax.receivePacket(response);
		<%
	}
	

%>
	
 