<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>

<%	
	String opr_source = "01";
	String workno = request.getParameter("work_no").trim();  
	String id_type = "01";
	String id_value = request.getParameter("phone_no").trim();
	String opr_numb = "";
	String opr_code = request.getParameter("opr_code").trim();      
	String biz_type = "32";
	//String effeti_time = request.getParameter("effeti_time").trim().replaceAll("-", "");
	//String sp_id = request.getParameter("sp_id").trim();
	//String pack_numb = request.getParameter("pack_numb").trim();
	//String biz_code = request.getParameter("biz_code").trim();
	String start_type = "02";
	String conf_type = request.getParameter("conf_type").trim();
	String max_num = request.getParameter("max_num").trim();
	String max_speaker_num = request.getParameter("max_speaker_num").trim();
	String start_time = request.getParameter("start_time").trim().replaceAll(" ", "").replaceAll(":", "");
	String end_time = request.getParameter("end_time").trim().replaceAll(" ", "").replaceAll(":", "");     
	String conf_pwd = ""; 
	String compere_pwd = ""; 
	String conf_cont = request.getParameter("conf_cont").trim(); 
	String conf_id = request.getParameter("conf_id").trim(); 
	String login_accept=request.getParameter("login_accept").trim();
%>

<wtc:service name="s1848Cfm" outnum="2" routerKey="phone" routerValue="<%=id_value%>">
	<wtc:param value="<%=opr_source%>"/>
	<wtc:param value="<%=workno%>"/>
	<wtc:param value="<%=id_type%>"/>
	<wtc:param value="<%=id_value%>"/>
	<wtc:param value="<%=opr_numb%>"/>
	<wtc:param value="<%=opr_code%>"/>
	<wtc:param value="<%=biz_type%>"/>
	<wtc:param value="<%=start_type%>"/>
	<wtc:param value="<%=conf_type%>"/>
	<wtc:param value="<%=max_num%>"/>
	<wtc:param value="<%=max_speaker_num%>"/>
	<wtc:param value="<%=start_time%>"/>
	<wtc:param value="<%=end_time%>"/>
	<wtc:param value="<%=conf_cont%>"/>
	<wtc:param value="<%=conf_id%>"/>
	<wtc:param value="<%=login_accept%>"/>
	<wtc:param value="<%=conf_pwd%>"/>
	<wtc:param value="<%=compere_pwd%>"/>
			
</wtc:service>
<wtc:array id="result" start="0" length="2" scope="end" />

<%
	String code1 = result[0][0];
	String msg1 = result[0][1];		
	if(code1.equals("000000") && opr_code.equals("02"))
	{
		code1="000009";
	}
%>
<%
    System.out.println("%%%%%%%调用统一接触开始%%%%%%%%");
		String retCodeForCntt = code1 ;
		String loginAccept = login_accept; 
		String url = "/npage/contact/upCnttInfo.jsp?opCode=1848&retCodeForCntt="+code1+"&opName=多媒体彩铃&workNo="+workno+"&loginAccept="+login_accept+"&pageActivePhone="+id_value+"&retMsgForCntt="+msg1+"&opBeginTime="+opBeginTime;
		System.out.println("url="+url);
		
		
%>
<jsp:include page="<%=url%>" flush="true" />

<script language="javascript" type="text/javascript">
	if("<%=code1%>"!="000009")
	{
		rdShowMessageDialog("'<%=code1%>','<%=msg1%>'");
		window.location.reload("f1848.jsp?phone_no=<%=id_value%>&op_code=1848");
	}
	else 
	{
		rdShowMessageDialog("000000,"+'<%=msg1%>');
		parent.removeTab('1848');
	}
	
</script>
