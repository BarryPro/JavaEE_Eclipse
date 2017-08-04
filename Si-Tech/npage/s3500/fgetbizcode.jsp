 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-01-16 页面改造,修改样式
	********************/
%> 

<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	//SPubCallSvrImpl callView = new SPubCallSvrImpl();
	
	String id_no = request.getParameter("id_no");
	String retType = request.getParameter("retType");
	String regionCode = request.getParameter("region_code");
	String ret_message = "";
	String ret_code = "";
	//ArrayList retArray = new ArrayList();
	String flag_1001 = "0";
	String flag_1002 = "0";
	String biz_code = "";
	int i=0;

	System.out.println("luxc fgetbizcode.jsp id_no="+id_no);


	try
	{
	    	//String[][] result3  = null;
		String sqlStr3 = "";
		
		sqlStr3="select nvl(field_value,'') from dGrpUserMsgAdd "
			+"where field_code='YWDM0' and id_no="+id_no;
			
		//result3 = (String[][])callView.sPubSelect("1",sqlStr3).get(0);
		%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
				<wtc:sql><%=sqlStr3%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result3" scope="end" />	
		<%
		if (result3 != null && result3.length != 0) 
		{
			biz_code = result3[0][0];
		}
		else
		{
			ret_code = "000003";
			ret_message = "查询业务代码失败,请检查产品配置dGrpUserMsgAdd!";
		}
		
		//String[][] result1  = null;
		//String[][] result2  = null;
		//String[][] result4  = null;
		//String[][] result5  = null;
		String sqlStr1 = "";
		String sqlStr2 = "";	
		String sqlStr4 = "";	
		String sqlStr5 = "";	
		
		
		sqlStr1="select count(*) from dGrpUserMsgAdd a, dbvipadm.sCommonCode b where  a.field_value = '"+biz_code+"'"+
	            " and b.common_code = '1001'   and a.field_value = b.field_code1 and a.id_no = "+id_no+" and field_code='YWDM0' and field_code2='"+regionCode+"'";
			
		
		sqlStr2="select count(*) from dGrpUserMsgAdd a, dbvipadm.sCommonCode b where  a.field_value = '"+biz_code+"'"+
	            " and b.common_code = '1002'   and a.field_value = b.field_code1 and a.id_no = "+id_no+" and a.field_code='YWDM0'  and b.field_code2='"+regionCode+"'";
		
		//result1 = (String[][])callView.sPubSelect("1",sqlStr1).get(0);
		%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
				<wtc:sql><%=sqlStr1%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result1" scope="end" />	
		<%
		if (result1 != null && result1.length != 0) 
		{
	        
	        if(Integer.parseInt(result1[0][0])>0)
			flag_1001 = "1";
			
			if(Integer.parseInt(result1[0][0])==0){		
			
		    sqlStr4="select count(*) from dGrpUserMsg a, dbvipadm.sCommonCode b where a.run_code='A' and"+
	            " b.common_code = '1001'   and a.product_code = b.field_code1 and a.id_no = "+id_no+ "and field_code2='"+regionCode+"'";
			//result4 = (String[][])callView.sPubSelect("1",sqlStr4).get(0);
			%>
			<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
				<wtc:sql><%=sqlStr4%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="result4" scope="end" />	
			<%
				if (result4 != null && result4.length != 0) {
				 if(Integer.parseInt(result4[0][0])>0)
			   flag_1001 = "1";			
				}        
	        }
		}
		else
		{
			ret_code = "000001";
			ret_message = "查询业务代码失败,请检查产品配置dGrpUserMsgAdd!";
		}
		
		
		//result2 = (String[][])callView.sPubSelect("1",sqlStr2).get(0);
		%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
				<wtc:sql><%=sqlStr2%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result2" scope="end" />	
		<%
		if (result2 != null && result2.length != 0) 
		{
		    if(Integer.parseInt(result2[0][0])>0)
			flag_1002 ="1";
			
		    if(Integer.parseInt(result2[0][0])==0){		
			
		    sqlStr5="select count(*) from dGrpUserMsg a, dbvipadm.sCommonCode b where a.run_code='A' "+
	            " and b.common_code = '1002'   and a.product_code = b.field_code1 and a.id_no = "+id_no+" and field_code2='"+regionCode+"'";
			//result5 = (String[][])callView.sPubSelect("1",sqlStr5).get(0);
			%>
			<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
				<wtc:sql><%=sqlStr5%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="result5" scope="end" />	
			<%
				if (result5 != null && result5.length != 0) {
				 if(Integer.parseInt(result5[0][0])>0)
			   flag_1002 = "1";			
				}        
	        }	    	
		    	}
		
		else
		{
			ret_code = "000002";
			ret_message = "查询业务代码失败,请检查产品配置dGrpUserMsgAdd!";
		}	
		
		
		ret_code = "000000";
		System.out.println("luxc fgetbizcode.jsp biz_code="+biz_code);
		
		ret_code = "000000";
		System.out.println("luxc fgetbizcode.jsp flag_1001="+flag_1001);
		System.out.println("luxc fgetbizcode.jsp flag_1002="+flag_1002);
	}
	
	catch(Exception e)
	{
		ret_code = "000001";
		ret_message = "查询产品业务代码失败2dGrpUserMsgAdd biz_code,请检查产品配置!";
	}
	%>


	var response = new AJAXPacket();
	
	var retType = "";
	var retCode = "";
	var retMessage = "";
	var flag_1001 = "";
	var flag_1002 = "";
	var biz_code = "";
	
	retType = "<%=retType%>";
	retCode = "<%=ret_code%>";
	retMessage = "<%=ret_message%>";
	flag_1001 = "<%=flag_1001%>";
	flag_1002 = "<%=flag_1002%>";
	biz_code = "<%=biz_code%>";
	response.data.add("retType",retType);
	response.data.add("retCode",retCode);
	response.data.add("retMessage",retMessage);
	response.data.add("flag_1001",flag_1001);
	response.data.add("flag_1002",flag_1002);
	response.data.add("biz_code",biz_code);
	core.ajax.receivePacket(response);

