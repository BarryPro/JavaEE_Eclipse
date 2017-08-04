<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *update:zhanghonga@2008-09-03 页面改造,修改样式
     *
     ********************/
%>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	String id_iccid = "";
	String id_address = "";
	String cust_name = "";
	String return_code = "";

	String work_no = (String) session.getAttribute("workNo");
	String work_name = (String) session.getAttribute("workName");
	String org_code = (String) session.getAttribute("orgCode");
	String pass = (String) session.getAttribute("password");	
	String smName="";
	
	String strPhoneNo =request.getParameter("phone_no");
	String strAwardCode =request.getParameter("award_code");
	String strDetailCode =request.getParameter("detail_code");
	String strLoginAccept =request.getParameter("check_login_accept");
	String strGradeCode = request.getParameter("grade_code");
	//String strUserPasswd = request.getParameter("user_password");
	String strUserPasswd = "";//因为废弃了此处密码验证,所以置空
	System.out.println("strPhoneNo="+strPhoneNo);
	System.out.println("strAwardCode="+strAwardCode);
	System.out.println("strDetailCode="+strDetailCode);
	System.out.println("strLoginAccept="+strLoginAccept);
	System.out.println("strGradeCode="+strGradeCode);
	System.out.println("strUserPasswd="+strUserPasswd);
  
  String paraAray[] = new String[9];
 	paraAray[0] = work_no;//工号
	paraAray[1] = pass;//工号密码
	paraAray[2] = "2266";//操作代码 
	paraAray[3] = strPhoneNo;//手机号码
	paraAray[4] = strAwardCode;//大类代码
	paraAray[5] = strDetailCode;//小类代码
	paraAray[6] = strLoginAccept;//验证的操作流水
	paraAray[7] = strGradeCode;//选择的等级代码
	paraAray[8] = strUserPasswd;//用户密码
	//retList = callView1.callFXService(strServName,paraAray,"6","phone",strPhoneNo);
%>
 	<wtc:service name="s2266Check" routerKey="phone" routerValue="<%=strPhoneNo%>" outnum="6" >
	<wtc:param value="<%=paraAray[0]%>"/>
	<wtc:param value="<%=paraAray[1]%>"/>
	<wtc:param value="<%=paraAray[2]%>"/>
	<wtc:param value="<%=paraAray[3]%>"/>
	<wtc:param value="<%=paraAray[4]%>"/>
	<wtc:param value="<%=paraAray[5]%>"/>
	<wtc:param value="<%=paraAray[6]%>"/>
	<wtc:param value="<%=paraAray[7]%>"/>
	<wtc:param value="<%=paraAray[8]%>"/>
	</wtc:service>
	<wtc:array id="s2266CheckArr" scope="end"/>
<%
 	int errCode = retCode==""?999999:Integer.parseInt(retCode);
  String errMsg = retMsg;

	if(s2266CheckArr!=null&&s2266CheckArr.length>0){
	  	return_code=s2266CheckArr[0][0];//返回代码 
	  	cust_name=s2266CheckArr[0][1];//用户名称 
	  	System.out.println("################################f2266phoneqry.jsp->cust_name"+cust_name);
	  	id_iccid=s2266CheckArr[0][2];	//用户id
	  	id_address=s2266CheckArr[0][3];//用户地址
	  	smName=s2266CheckArr[0][5];//用户品牌
  }else{
	  	return_code = "999999";
	  	errMsg = "系统未定义错误";
  }	
	
%>

		var response = new AJAXPacket();
		var id_iccid = "<%=id_iccid%>";
		var id_address = "<%=id_address%>";
		var cust_name = "<%=cust_name%>";
		var sm_name="<%=smName%>";
		
		var return_code = "<%=return_code%>";
		var return_msg = "<%=errMsg%>";
		
		response.data.add("rpc_page","phoneqry");
		response.data.add("id_iccid",id_iccid);
		response.data.add("id_address",id_address);
		response.data.add("cust_name",cust_name);
		response.data.add("smName",sm_name);
		
		response.data.add("return_code",return_code);
		response.data.add("return_msg",return_msg);
		core.ajax.receivePacket(response);


 