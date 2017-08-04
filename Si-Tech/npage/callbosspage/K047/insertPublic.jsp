<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	  /*midify by guozw 20091114 公共查询服务替换*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

    String retType = WtcUtil.repNull(request.getParameter("retType"));
    String SKILL_QUENCE = WtcUtil.repNull(request.getParameter("SKILL_QUENCE"));
    String contactId = WtcUtil.repNull(request.getParameter("contactId"));
    String called = WtcUtil.repNull(request.getParameter("called"));
    String caller = WtcUtil.repNull(request.getParameter("caller"));
    String transagent = WtcUtil.repNull(request.getParameter("transagent"));
		String loginNo = (String)session.getAttribute("workNo");  //取login_no
	  String loginName = (String)session.getAttribute("workName"); //取login_name
		String transType = WtcUtil.repNull(request.getParameter("transType")); //transType
		String op_code = WtcUtil.repNull(request.getParameter("op_code")); //op_code
		String is_success = WtcUtil.repNull(request.getParameter("is_success")); //is_success
		String oper_type = WtcUtil.repNull(request.getParameter("oper_type")); //is_success  
		
    String transfer_kf_login_no = (String)session.getAttribute("kfWorkNo");  //取客服login_no	    
    String accept_kf_login_no="";
    System.out.println("wenchtransagent:"+transagent+"********************");
		String temp = "select kf_login_no from dloginmsgrelation where boss_login_no= :transagent";
    myParams = "transagent="+transagent ;
   %>
	 <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="1">
	 		<wtc:param value="<%=temp%>"/>
	 		<wtc:param value="<%=myParams%>"/>
	 </wtc:service>
	 <wtc:array id="tempList"  scope="end"/>
	 <%		
    if(tempList.length>0){
     accept_kf_login_no=tempList[0][0];
    } 
		
		java.util.Date current=new java.util.Date();
    java.text.SimpleDateFormat sdf=new java.text.SimpleDateFormat("yyyyMM"); 
    String table_name="dcallcall"+sdf.format(current);
		
		String sql= "insert into DCALLTRANSFER (SERIAL_NO,CONTACT_ID,CONTACT_ACCEPT,CALLER_PHONE,ACCEPT_DATE,TRANSFER_LOGIN_NO,ACCEPT_LOGIN_NO,OPER_TYPE,TRANSFER_TYPE,SKILL_QUENCE,SUCCESS_FLAG,OP_CODE,ransfer_kf_login_no,accept_kf_login_no)"+
		"select lpad(SEQ_TRANS.nextval,14,'0'),contact_id, contact_accept, caller_phone,sysdate,"+
		":v1,:v2,:v3,:v4,:v5,'',:v6,:v7,:v8 from "
    +table_name+" where contact_id in (select max(contact_id) from "+table_name+" where ACCEPT_LOGIN_NO=:v9)";  

%>
	<wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=sql%>"/>
			<wtc:param value="dbchange"/>
			<wtc:param value="<%=loginNo%>"/>
			<wtc:param value="<%=transagent%>"/>
			<wtc:param value="<%=oper_type%>"/>
			<wtc:param value="<%=transType%>"/>
			<wtc:param value="<%=SKILL_QUENCE%>"/>
			<wtc:param value="<%=op_code%>"/>
			<wtc:param value="<%=transfer_kf_login_no%>"/>
			<wtc:param value="<%=accept_kf_login_no%>"/>
			<wtc:param value="<%=transagent%>"/>
	</wtc:service>
	<wtc:array id="rows"  scope="end"/>
	<%
	  if(rows[0][0].equals("000001")){
	     retCode = "000001";
	     retMsg = "保存关系失败1";
	  }
	%>
	
	var response = new AJAXPacket();
	response.data.add("retType","<%=retType%>");
	response.data.add("retCode","<%=retCode%>");
	response.data.add("retMsg","<%=retMsg%>");
	core.ajax.receivePacket(response);



