<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

   String retType = WtcUtil.repNull(request.getParameter("retType"));
   String login_no = WtcUtil.repNull(request.getParameter("login_no"));
   String ipaddress = WtcUtil.repNull(request.getParameter("ipaddress"));
   String grade_code = WtcUtil.repNull(request.getParameter("grade_code"));
   String staffstatus = WtcUtil.repNull(request.getParameter("staffstatus"));
   String checkno = WtcUtil.repNull(request.getParameter("checkno"));
   String ccsworkno = WtcUtil.repNull(request.getParameter("ccsworkno"));
   String kf_no = WtcUtil.repNull(request.getParameter("kf_no"));
   String kf_name = WtcUtil.repNull((String)session.getAttribute("workName"));
   String class_id = WtcUtil.repNull(request.getParameter("class_id"));
   String org_id = WtcUtil.repNull(request.getParameter("org_id"));
   String duty = WtcUtil.repNull(request.getParameter("duty"));
   String op_code = WtcUtil.repNull(request.getParameter("op_code"));
   String succ_flag=WtcUtil.repNull(request.getParameter("succ_flag"));
   String vdnWork=WtcUtil.repNull(request.getParameter("vdnWork"));
   String mainCCS=WtcUtil.repNull(request.getParameter("mainCCS"));
   String BackCcsIP=WtcUtil.repNull(request.getParameter("BackCcsIP"));
   System.out.println("****************vdnWork"+vdnWork);
%>

<wtc:service name="sK005insert" outnum="2">
	<wtc:param value="<%=login_no%>"/>
	<wtc:param value="<%=ipaddress%>"/>
	<wtc:param value="<%=grade_code%>"/>
	<wtc:param value="<%=staffstatus%>"/>
	<wtc:param value="<%=checkno%>"/>
	<wtc:param value="<%=ccsworkno%>"/>
	<wtc:param value="<%=kf_no%>"/>
	<wtc:param value="<%=kf_name%>"/>
	<wtc:param value="<%=class_id%>"/>
	<wtc:param value="<%=org_id%>"/>
	<wtc:param value="<%=duty%>"/>
	<wtc:param value="<%=op_code%>"/>
	<wtc:param value="<%=succ_flag%>"/>
  <wtc:param value="<%=vdnWork%>"/>
  <wtc:param value="<%=mainCCS%>"/>
  <wtc:param value="<%=BackCcsIP%>"/>
</wtc:service>
	<wtc:array id="rows"  scope="end"/>
	<%
	  if(rows[0][0].equals("000001")){
	     retCode = "000001";
	     retMsg = "±£´æ¹ØÏµÊ§°Ü";
	  }
	  out.println("login_no|"+login_no+"|ipaddress|"+ipaddress+"|grade_code|"+grade_code+"|staffstatus|"+staffstatus+"|checkno|"+checkno+"|ccsworkno|"+ccsworkno+"|kf_no|"+kf_no+"|kf_name|"+kf_name+"|class_id|"+class_id+"|org_id|"+org_id+"|duty|"+duty+"|op_code|"+op_code+"|succ_flag|"+succ_flag+"|vdnWork|"+vdnWork);
	%>




