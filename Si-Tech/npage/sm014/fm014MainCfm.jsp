<%
  /*
   *	IMS固话过户（Centrex）
   *	ningtn
   *	日期: 2013-12-16 13:29:14
   */
%>

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

	<%
		String opCode = (String)request.getParameter("opCode");
  	String opName = (String)request.getParameter("opName");
  	String checkIdNo = (String)request.getParameter("checkIdNo");
  	String checkIdNoIn = (String)request.getParameter("checkIdNo");
  	String phoneNoList = (String)request.getParameter("phoneNoList");
  	String new_cus_id=WtcUtil.repNull(request.getParameter("new_cus_id"));
  	
  	
		String workNo = (String)session.getAttribute("workNo");
		String password = (String)session.getAttribute("password");
		String regionCode= (String)session.getAttribute("regCode");
		String org_code = (String)session.getAttribute("orgCode");
		System.out.println("=========== ningtn m014 checkIdNo " + checkIdNo);
		/*ID拆分数组*/
		if(checkIdNo.length() > 0){
			checkIdNo = checkIdNo.substring(0,checkIdNo.length() - 1);
		}
		System.out.println("=========== ningtn m014 checkIdNo " + checkIdNo);
		String ids[] = checkIdNo.split(",");
		System.out.println("=========== ningtn m014 ids " + ids);
		if(ids == null){
		System.out.println("=========== ningtn m014 ids is null ");
			ids = new String[1];
			ids[0] = checkIdNo;
		}
		System.out.println("=========== ningtn m014 ids length " + ids.length);
	%>
	<%
		String paraStr[]=new String[53];
		paraStr[0]=WtcUtil.repNull(request.getParameter("loginAccept"));
		paraStr[1]=opCode;
		paraStr[2]=workNo;
		paraStr[3]=password;
		paraStr[4]=org_code;
		paraStr[5]=checkIdNoIn;
		paraStr[6]=new_cus_id; 
		paraStr[8]= WtcUtil.repNull(request.getParameter("cust_name"));
		paraStr[14]= WtcUtil.repNull(request.getParameter("iccid"));
		paraStr[32]= phoneNoList + "过户到" + new_cus_id +"下。";
		paraStr[33] = "操作员" + workNo;
		paraStr[43] = "N";
		paraStr[44] = "0~~";
		paraStr[45] = "0";
		paraStr[48] = "0";
		paraStr[49] = "" + ids.length;
		
	%>
<wtc:service name="sM014Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="3" >
		<wtc:param value="<%=paraStr[0]%>"/>
		<wtc:param value="<%=paraStr[1]%>"/> 
		<wtc:param value="<%=paraStr[2]%>"/>
		<wtc:param value="<%=paraStr[3]%>"/>
		<wtc:param value="<%=paraStr[4]%>"/>
		<wtc:param value="<%=paraStr[5]%>"/>
		<wtc:param value="<%=paraStr[6]%>"/>
		<wtc:param value=""/>	
		<wtc:param value="<%=paraStr[8]%>"/>
		<wtc:param value=""/> 
		<wtc:param value=""/>
		<wtc:param value=""/> 
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=paraStr[14]%>"/>
		<wtc:param value=""/> 
		<wtc:param value=""/>
		<wtc:param value=""/>	
		<wtc:param value=""/>
		<wtc:param value=""/> 
		<wtc:param value=""/>
		<wtc:param value=""/> 
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value=""/> 
		<wtc:param value=""/>
		<wtc:param value=""/>	
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value=""/> 
		<wtc:param value="<%=paraStr[32]%>"/>
		<wtc:param value="<%=paraStr[33]%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/> 
		<wtc:param value=""/>
		<wtc:param value=""/>	
		<wtc:param value=""/>
		<wtc:param value=""/> 
		<wtc:param value=""/>
		<wtc:param value=""/> 
		<wtc:param value=""/>
		<wtc:param value="<%=paraStr[43]%>"/>
		<wtc:param value="<%=paraStr[44]%>"/>
		<wtc:param value="<%=paraStr[45]%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=paraStr[48]%>"/>
    <wtc:param value="<%=paraStr[49]%>"/>						 	
		</wtc:service>
		<wtc:array id="sm014CfmArr" scope="end"/>

<%
	if(retCode1.equals("000000")
		&& sm014CfmArr!= null 
		&& (sm014CfmArr.length == 0 || sm014CfmArr[0][0].length() == 0)){
%>
	<script>
		rdShowMessageDialog('过户成功');
		location="fm014Main.jsp?opCode=m014&opName=IMS固话过户（Centrex）&crmActiveOpCode=m014";
	</script>
<%
	}else if(retCode1.equals("000000")){
		String errPhone = "";
		String errCode = "";
		String errMsg = "";
		if(sm014CfmArr!= null && sm014CfmArr.length > 0){
			errPhone = sm014CfmArr[0][0];
			errCode = sm014CfmArr[0][1];
			errMsg = sm014CfmArr[0][2];
		}
%>
		<script>
			var obj = new Object();
			obj.errPhone="<%=errPhone%>";
			obj.errCode="<%=errCode%>";
			obj.errMsg="<%=errMsg%>";
			window.showModalDialog("fm014Result.jsp",obj,"dialogWidth=650px;dialogHeight=500px");
			location="fm014Main.jsp?opCode=m014&opName=IMS固话过户（Centrex）&crmActiveOpCode=m014";
		</script>
<%
	}else{
%>
	<script>
		rdShowMessageDialog('过户失败' + "<%=retCode1%>" + "："+"<%=retMsg1%>");
		location="fm014Main.jsp?opCode=m014&opName=IMS固话过户（Centrex）&crmActiveOpCode=m014";
	</script>
<%
	}
%>
