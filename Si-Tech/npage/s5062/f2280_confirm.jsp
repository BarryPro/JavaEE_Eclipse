<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 短信催缴定制2280
   * 版本: 1.0
   * 日期: 2008/01/13
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<% request.setCharacterEncoding("GBK");%>
<%@ page import="com.sitech.boss.pub.*"%>
<%@ page import="com.sitech.boss.util.*"%>

<jsp:useBean id="s5010" class="com.sitech.boss.s5010.viewBean.S5010Impl" />
<%
	String opCode="2280";
	String opName="短信催缴定制";
	String regionCode=(String)session.getAttribute("regCode");						//地市
	String ithe_ip = (String)session.getAttribute("ipAddr");                       	//登陆IP
	String workNo = (String)session.getAttribute("workNo");                    		//工号
	String nopass = (String)session.getAttribute("password");						//工号密码 
	String orgCode = (String)session.getAttribute("orgCode");                  		//工号归属
	String region_code=(String)session.getAttribute("regCode");						//地域代码
	String temp_type=request.getParameter("do_type");
	if (temp_type.trim().equals("0")) temp_type="I";
	else temp_type="D";
	
	String temp_phoneno=request.getParameter("phone_no");
	String temp_calling_times=request.getParameter("calling_times");
	String temp_awake_times=request.getParameter("awake_times");
	String temp_awake_fee=request.getParameter("awake_fee");
	String temp_begin_hm=request.getParameter("begin_hm");
	String temp_end_hm=request.getParameter("end_hm");
	String temp_time_flag=request.getParameter("time_flag");
	String temp_forbid_flag=request.getParameter("forbid_flag");	
	String temp_opnote=WtcUtil.repNull(request.getParameter("note"));
	String loginAccept=request.getParameter("loginAccept");

	if(temp_opnote.equals("")){
		temp_opnote = "用户"+temp_phoneno+"进行短信催缴定制服务";
	}

	if (temp_type.equals("D")){
		temp_calling_times="0";
		temp_awake_times="0";
		temp_awake_fee="0";
		temp_begin_hm="0000";
		temp_end_hm="0000";
		temp_time_flag="0";
		temp_forbid_flag="0";
	}
	else if (temp_forbid_flag.equals("1")){
		temp_calling_times="0";
		temp_awake_times="0";
		temp_awake_fee="0";
		temp_begin_hm="0000";
		temp_end_hm="0000";
		temp_time_flag="0";		
	}
		else if (temp_forbid_flag.equals("2")){
		temp_calling_times="0";
		temp_awake_times="0";
		temp_awake_fee="0";
		temp_begin_hm="0000";
		temp_end_hm="0000";
		temp_time_flag="0";		
		System.out.println("ludl:temp_forbid_flag====2");
	}
	else if (temp_time_flag.equals("0")){
		temp_begin_hm="0000";
		temp_end_hm="0000";		
	}	
	
	String opcode="2280";
//	ArrayList ret =new ArrayList();
//	boolean showFlag=false;	//showFlag表示是否有数据可供显示
//  int valid = 1;	//0:正确，1：系统错误，2：业务错误
  	System.out.println("!!!!!!!!!!!!!!");
//	SPubCallSvrImpl impl = new SPubCallSvrImpl();
	//服务的输入参数
	String[] paraStrIn = new String[]{"2280",workNo,nopass,orgCode,temp_opnote,ithe_ip,temp_phoneno,temp_type,temp_awake_fee,temp_awake_times,temp_calling_times,temp_begin_hm,temp_end_hm,temp_time_flag,temp_forbid_flag};
//	ret = impl.callFXService("s2280Cfm",paraStrIn,"2");
System.out.println("loginAccept = " +loginAccept);
System.out.println("opcode = "+opcode);
System.out.println("workNo = "+workNo);
System.out.println("nopass =" +nopass);
System.out.println("temp_phoneno =" +temp_phoneno);
%>
	<wtc:service name="s2280Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=loginAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opcode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=nopass%>"/>
		<wtc:param value="<%=temp_phoneno%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=orgCode%>"/>
		<wtc:param value="<%=temp_opnote%>"/>
		<wtc:param value="<%=ithe_ip%>"/>
		<wtc:param value="<%=temp_type%>"/>
		<wtc:param value="<%=temp_awake_fee%>"/>
		<wtc:param value="<%=temp_awake_times%>"/>
		<wtc:param value="<%=temp_calling_times%>"/>
		<wtc:param value="<%=temp_begin_hm%>"/>
		<wtc:param value="<%=temp_end_hm%>"/>
		<wtc:param value="<%=temp_time_flag%>"/>
		<wtc:param value="<%=temp_forbid_flag%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
	String error_code=retCode;
	String error_msg=retMsg;
	String printAccept = "";
	System.out.println("--------------"+error_code);
	System.out.println("++++++++++++++"+error_msg);
	if (error_code.equals("000000")||error_code.equals("0")&&result.length>0){
		 printAccept = result[0][0];
		
%>

<script language="JavaScript">
	rdShowMessageDialog("<%=temp_phoneno%>"+"操作成功!!",2);
	window.location="f2280_1.jsp?activePhone=<%=temp_phoneno%>";
</script>

<%}else{%>
<script language="JavaScript">
	rdShowMessageDialog("<%=error_msg%>",0);
	window.location="f2280_1.jsp?activePhone=<%=temp_phoneno%>";
</script>
<%}
	String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode
			+"&opName="+opName+"&workNo="+workNo+"&loginAccept="+loginAccept+"&pageActivePhone="
			+temp_phoneno+"&retMsgForCntt="+retMsg+"&opBeginTime="+opBeginTime;
%>
<jsp:include page="<%=url%>" flush="true" />
