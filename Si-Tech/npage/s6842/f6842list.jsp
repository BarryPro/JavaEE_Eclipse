<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String return_code = "000000";
		String org_code = (String) session.getAttribute("orgCode");
		String errMsg="";
		String strPhoneNo =request.getParameter("phone_no");
		System.out.println("strPhoneNo="+strPhoneNo);
%>
<%
	/*****刘春梅20080715增加，查询用户的黑白名单信息********/
 		String sqlB=" select to_char(count(*))	from dBlakWhiteList a,dcustmsg b where a.id_no=b.id_no and b.phone_no=:phone and a.list_type='B'";
 		String [] paraIn1 = new String[4];
 		String liststr="a";
  	paraIn1[0] = "region";
  	paraIn1[1] = org_code.substring(0,2);
  	paraIn1[2] = sqlB;
  	paraIn1[3] = "phone="+strPhoneNo;
  	//ArrayList offonArr = callViewn.callFXService("sPubSelectNew",paraIn1,"1");
%>
		 	<wtc:service name="sPubSelectNew" routerKey="phone" routerValue="<%=strPhoneNo%>" outnum="1" >
			<wtc:param value="<%=paraIn1[0]%>"/>
			<wtc:param value="<%=paraIn1[1]%>"/>
			<wtc:param value="<%=paraIn1[2]%>"/>
			<wtc:param value="<%=paraIn1[3]%>"/>
			</wtc:service>
			<wtc:array id="offnodataArray" scope="end"/>
<%
			
    	if(!retCode.equals("000000")){
    		return_code="999999";
    		errMsg="查询黑白名单信息错误!";
    	}
    	if(offnodataArray!=null&&offnodataArray.length>0){
	    	if(!offnodataArray[0][0].equals("0")){
	    		liststr="此客户在黑名单库中!";
	    		return_code="000000";
	    	}else{
	 			String sqloffon="select to_char(count(*)) from dBlakWhiteList a,dcustmsg b where a.id_no=b.id_no and b.phone_no=:phone "
	 				+" and op_Type='0' and op_code='0' and list_type='W' ";
	    		String [] paraIn2 = new String[4];
	    		paraIn2[0] = "region";
	    		paraIn2[1] = org_code.substring(0,2);
	    		paraIn2[2] = sqloffon;
	    		paraIn2[3] = "phone="+strPhoneNo;
%>
				 	<wtc:service name="sPubSelectNew" routerKey="phone" routerValue="<%=strPhoneNo%>" outnum="1" >
					<wtc:param value="<%=paraIn2[0]%>"/>
					<wtc:param value="<%=paraIn2[1]%>"/>
					<wtc:param value="<%=paraIn2[2]%>"/>
					<wtc:param value="<%=paraIn2[3]%>"/>
					</wtc:service>
					<wtc:array id="offnodataArray" scope="end"/>					
<%
	    		if(!retCode.equals("000000")){
	    			return_code="999999";
	    			errMsg="查询黑白名单信息错误!";
	    		}
	    		if(offnodataArray!=null&&offnodataArray.length>0){
		    		if(offnodataArray[0][0].equals("0")){
		    			liststr="此客户不在白名单库中!";
		    			return_code="000000";
		    		}
	    		}
	    	}
    	}
 	
 	System.out.println("liststrliststrliststr="+liststr);
 /**************liucm end **************/	
%>
			var response = new AJAXPacket();
			var liststr = "<%=liststr%>";
			
			var return_code = "<%=return_code%>";
			var return_msg = "<%=errMsg%>";
			
			response.data.add("rpc_page","listqry");
			response.data.add("liststr",liststr);
			response.data.add("return_code",return_code);
			response.data.add("return_msg",return_msg);
			core.ajax.receivePacket(response);


 
