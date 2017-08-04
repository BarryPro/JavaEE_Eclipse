<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *update:zhanghonga@2008-09-03 页面改造,修改样式
     *
     ********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
System.out.println("--------------------ajaxRetMsg.jsp-------------------");
		String return_code = "000000";
		String org_code = (String) session.getAttribute("orgCode");
		String errMsg="";
		String strPhoneNo =request.getParameter("phone_no");
		String loginNo = (String)session.getAttribute("workNo");
		String loginPwd = (String)session.getAttribute("password");
		String opCode =request.getParameter("opCode");
		String servId =request.getParameter("servId");
		String iChnSource = "01";
		
		
		String regionCode = (String)session.getAttribute("regCode");
		 

		System.out.println("--------------------strPhoneNo-------------------"+strPhoneNo);
		System.out.println("strPhoneNo="+strPhoneNo);
%>
<%
	/*****刘春梅20080715增加，查询用户的黑白名单信息********/
 		String sqlB=" select to_char(count(*))	from dBlakWhiteList a,dcustmsg b where a.id_no=b.id_no and b.phone_no=:phone and a.list_type='B'";
 		
 		System.out.println("sqlB|"+sqlB);
 		
 		String [] paraIn1 = new String[4];
 		String liststr="";
  	paraIn1[0] = "region";
  	paraIn1[1] = org_code.substring(0,2);
  	paraIn1[2] = sqlB;
  	paraIn1[3] = "phone="+strPhoneNo;
%>
		 	<wtc:service name="sPubSelectNew" routerKey="phone" routerValue="<%=strPhoneNo%>" outnum="1" >
			<wtc:param value="<%=paraIn1[0]%>"/>
			<wtc:param value="<%=paraIn1[1]%>"/>
			<wtc:param value="<%=paraIn1[2]%>"/>
			<wtc:param value="<%=paraIn1[3]%>"/>
			</wtc:service>
			<wtc:array id="offnodataArray" scope="end"/>
<%
			System.out.println("----------------retCode-----------------"+retCode);
    	if(!retCode.equals("000000")){
    		return_code="999999";
    		errMsg="查询黑白名单信息错误!";
    	}
    	System.out.println("----------------offnodataArray.length-----------------"+offnodataArray.length);
    	if(offnodataArray!=null&&offnodataArray.length>0){
    	System.out.println("----------------offnodataArray[0][0]-----------------"+offnodataArray[0][0]);
	    	if(!offnodataArray[0][0].equals("0")){
	    		liststr="此客户在黑名单库中!";
	    		return_code="000000";
	    	}else{
	 			String sqloffon="select to_char(count(*)) from dBlakWhiteList a,dcustmsg b where a.id_no=b.id_no and b.phone_no=:phone "
	 				+" and op_Type='0' and op_code='0' and list_type='W' ";
	  			System.out.println("sqloffon====="+sqloffon);
	  			//组织输入参数
	    		String [] paraIn2 = new String[4];
	    		paraIn2[0] = "region";
	    		paraIn2[1] = org_code.substring(0,2);
	    		paraIn2[2] = sqloffon;
	    		paraIn2[3] = "phone="+strPhoneNo;
	  			//调用服务
%>
				 	<wtc:service name="sPubSelectNew" routerKey="phone" routerValue="<%=strPhoneNo%>" outnum="1" >
					<wtc:param value="<%=paraIn2[0]%>"/>
					<wtc:param value="<%=paraIn2[1]%>"/>
					<wtc:param value="<%=paraIn2[2]%>"/>
					<wtc:param value="<%=paraIn2[3]%>"/>
					</wtc:service>
					<wtc:array id="offnodataArray" scope="end"/>					
<%
System.out.println("----------------retCode-----------------"+retCode);
	    		if(!retCode.equals("000000")){
	    			return_code="999999";
	    			errMsg="查询黑白名单信息错误!";
	    		}
	    		if(offnodataArray!=null&&offnodataArray.length>0){
	    		System.out.println("----------------offnodataArray[0][0]-----------------"+offnodataArray[0][0]);
		    		if(offnodataArray[0][0].equals("0")){
		    			liststr="此客户不在白名单库中!";
		    			return_code="000000";
		    		}
	    		}
	    	}
    	}
 	
 	System.out.println("-----------------liststr--------------"+liststr);
 /**************liucm end **************/
 
 
 
 
 
 
 						String vOfferAttrType	 = "" ;  //资费类型
            String vTwoPhoneFlag	="";  //	双号标识
            String vHighFlag	="";		//高端客户标识

%>


/**************wangzc 增加 提示用户是否是智能网VPMN用户******************/
 <%
 String sqlB1=" select to_char(count(*)) from dcustmsgadd a where  a.id_no=:vidNo and  a.field_code='1004' and a.user_TYpe='vp'";
 		
 		System.out.println("sqlB1|"+sqlB1);
 		
 		String [] paraIn2 = new String[4];
 		String vpmnstr="";
  	paraIn2[0] = "region";
  	paraIn2[1] = org_code.substring(0,2);
  	paraIn2[2] = sqlB1;
  	paraIn2[3] = "vIdNo="+servId;
%>
		 	<wtc:service name="sPubSelectNew" routerKey="vIdNo" routerValue="<%=servId%>" outnum="1" >
			<wtc:param value="<%=paraIn2[0]%>"/>
			<wtc:param value="<%=paraIn2[1]%>"/>
			<wtc:param value="<%=paraIn2[2]%>"/>
			<wtc:param value="<%=paraIn2[3]%>"/>
			</wtc:service>
			<wtc:array id="offnodataArray" scope="end"/>
<%				
	
 System.out.println("----------------retCode-----------------"+retCode);
       if(!retCode.equals("000000")){
    		return_code="999999";
    		errMsg="查询智能网VPMN错误!";
    	}
    	System.out.println("----------------offnodataArray.length-----------------"+offnodataArray.length);
    	if(offnodataArray!=null&&offnodataArray.length>0){
    	    System.out.println("----------------offnodataArray[0][0]-----------------"+offnodataArray[0][0]);
	    	if(!offnodataArray[0][0].equals("0")){
	    		vpmnstr="该客户是智能网VPMN用户";
	    		return_code="000000";
	    	}else{
	    		vpmnstr="";
	    		return_code="000000";
	    	}
	  }
	  System.out.println("-----------------vpmnstr--------------"+vpmnstr);
%>
 
 /**************wangzc 增加 提示用户是否是智能网VPMN用户 end******************/
 
 
 /**************wangzc 增加 提示用户是否是智能网VPMN用户且是否需要在免填单上有体现******************/

		 	<wtc:service name="sVpmnQry" routerKey="phone" routerValue="<%=strPhoneNo%>" outnum="1" >
			<wtc:param value="" />
			<wtc:param value="<%=iChnSource%>" />	
			<wtc:param value="<%=opCode%>" />		
			<wtc:param value="<%=loginNo%>" />			
			<wtc:param value="<%=loginPwd%>" />				
			<wtc:param value="<%=strPhoneNo%>" />					
			<wtc:param value="" />
			
			</wtc:service>
			<wtc:array id="offnodataArray1" scope="end"/>
<%				
	String vpmnstr1="";
 System.out.println("----------------retCode-----------------"+retCode);
       if(!retCode.equals("000000")){
    	
    		vpmnstr1="NO";
    	}
    	else
    	{
		    if(offnodataArray1[0][0].equals("000000")){
		    	vpmnstr1="YES";
		    }    	
    		
    	}
    	
    	
	  System.out.println("-----------------vpmnstr1--------------"+vpmnstr1);
%>
 
 /**************wangzc 增加 提示用户是否是智能网VPMN用户且是否需要在免填单上有体现 end******************/


    <wtc:service name="sGetAlertMsg" outnum="5" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=servId%>" />
			<wtc:param value="<%=loginNo%>" />
			<wtc:param value="<%=opCode%>" />		
		</wtc:service>
		<wtc:array id="result_t" scope="end"/>

<%
		if(result_t.length>0&&result_t[0][2]!=null) vOfferAttrType = result_t[0][2];
		if(result_t.length>0&&result_t[0][3]!=null) vTwoPhoneFlag = result_t[0][3];
		if(result_t.length>0&&result_t[0][4]!=null) vHighFlag = result_t[0][4];
		
		System.out.println("---------------------vOfferAttrType-----------------"+vOfferAttrType);
		System.out.println("---------------------vTwoPhoneFlag------------------"+vTwoPhoneFlag);
		System.out.println("---------------------vHighFlag----------------------"+vHighFlag);
		
%>
			var response = new AJAXPacket();
			var liststr = "<%=liststr%>";
			var vpmnstr="<%=vpmnstr%>";
			var vpmnstr1="<%=vpmnstr1%>";
			
			var return_code = "<%=return_code%>";
			var return_msg = "<%=errMsg%>";
			
			response.data.add("liststr",liststr);
			response.data.add("vpmnstr",vpmnstr);
			response.data.add("vpmnstr1",vpmnstr1);
			
			response.data.add("vOfferAttrType","<%=vOfferAttrType%>");
			response.data.add("vTwoPhoneFlag","<%=vTwoPhoneFlag%>");
			response.data.add("vHighFlag","<%=vHighFlag%>");
			
			
			response.data.add("return_code",return_code);
			response.data.add("return_msg",return_msg);
			core.ajax.receivePacket(response);


 
