<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>

<%
    String workno = (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");
    String orgcode = (String)session.getAttribute("orgCode");
    String regionCode = orgcode.substring(0,2);
    String busy_name="";

	String i_op_code = "2252";                                        //功能代码
    String i_login_no = workno;                                       //操作工号
    String i_login_passwd = (String)session.getAttribute("password"); //经过加密的工号密码
    String i_org_code = orgcode;	                                  //操作工号归属
    String i_op_note = request.getParameter("i_op_note");             //备注  
	String i_ip_addr = request.getRemoteAddr();		                  //IP地址
    String i_region_code = orgcode.substring(0, 2);	                  //地区代码
    String i_func_code = request.getParameter("i_func_code");
	String i_operate_type = request.getParameter("i_operate_type");
	String i_operate_code = request.getParameter("i_operate_code");
	String i_awake_fee = request.getParameter("i_awake_fee");
	String i_awake_times = request.getParameter("i_awake_times");
	String i_calling_fee = request.getParameter("i_calling_fee");
	String i_calling_times = request.getParameter("i_calling_times");
	String i_calling_cyc = request.getParameter("i_calling_cyc");
	String i_limit_flag = request.getParameter("i_limit_flag");
	String busy_type = request.getParameter("busy_type");
	
    if (busy_type.equals("I")){
      busy_name="增加";
    } else if (busy_type.equals("U")) {
      busy_name="修改";
    } else if (busy_type.equals("D")) {
      busy_name="删除";
    }
    

	String[] inParas = new String[17];
    inParas[0] = i_op_code;
	inParas[1] = i_login_no;
	inParas[2] = i_login_passwd;
	inParas[3] = i_org_code;
	inParas[4] = i_op_note;
	inParas[5] = i_ip_addr;
	inParas[6] = i_region_code;
	inParas[7] = i_func_code;
	inParas[8] = i_operate_type;
	inParas[9] = i_operate_code;
	inParas[10] = i_awake_fee;
	inParas[11] = i_awake_times;
	inParas[12] = i_calling_fee;
	inParas[13] = i_calling_times;
	inParas[14] = i_calling_cyc;
	inParas[15] = i_limit_flag;
	inParas[16] = busy_type;

%>                                                     
   <wtc:service name="s2252Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="iErrorNo" retmsg="sErrorMessage"  outnum="2" >
	       <wtc:param value="<%=inParas[0]%>"/>
	       <wtc:param value="<%=inParas[1]%>"/>
	       <wtc:param value="<%=inParas[2]%>"/>
	       <wtc:param value="<%=inParas[3]%>"/>
	       <wtc:param value="<%=inParas[4]%>"/>
	       <wtc:param value="<%=inParas[5]%>"/>
	       <wtc:param value="<%=inParas[6]%>"/>
	       <wtc:param value="<%=inParas[7]%>"/>
	       <wtc:param value="<%=inParas[8]%>"/>
	       <wtc:param value="<%=inParas[9]%>"/>
	       <wtc:param value="<%=inParas[10]%>"/>
	       <wtc:param value="<%=inParas[11]%>"/>
	       <wtc:param value="<%=inParas[12]%>"/>
	       <wtc:param value="<%=inParas[13]%>"/>
	       <wtc:param value="<%=inParas[14]%>"/>    
	       <wtc:param value="<%=inParas[15]%>"/>
	       <wtc:param value="<%=inParas[16]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end" />

<SCRIPT type=text/javascript>
function ifprint(){
     <% 
       if (iErrorNo.equals("000000")){%>
           rdShowMessageDialog("提醒、催缴阀值配置<%=busy_name%>成功！");
	       document.location.replace("s2252.jsp");
       <%} else {%>
         rdShowMessageDialog("提醒、催缴阀值配置<%=busy_name%>失败。<br>错误代码：'<%=iErrorNo%>'。<br>错误信息：'<%=sErrorMessage%>'。",0);
         history.go(-1);
       <%}
     %>
} 						
</SCRIPT>
<html>
<body onload="ifprint()">
</body>
</html>
