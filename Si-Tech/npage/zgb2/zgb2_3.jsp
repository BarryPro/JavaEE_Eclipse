<%
/********************
 * version v2.0
 * ������: si-tech
 * update by zhangshuaia @ 2009-08-05
 ********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%	
    String workno = (String)session.getAttribute("workNo");
	String loginAccept = request.getParameter("login_accept");     //������ˮ 
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode = org_code.substring(0,2);
	String begin_ym = request.getParameter("begin_ym");  
	String end_ym = request.getParameter("end_ym");
	 
%>
<wtc:service name="szg23Del" routerKey="region" routerValue="<%=regionCode%>" retcode="s4141CfmCode" retmsg="s4141CfmMsg" outnum="2" >
	<wtc:param value="<%=loginAccept%>"/>
	<wtc:param value="<%=workno%>"/>
	<wtc:param value="<%=begin_ym%>"/>
	<wtc:param value="<%=end_ym%>"/>
</wtc:service>
<wtc:array id="s4141CfmArr" scope="end"/>
<%
	String retCode= s4141CfmCode;
	String retMsg = s4141CfmMsg;

	System.out.println("retCode === "+ retCode);
	System.out.println("retMsg === "+ retMsg);
%>
 
<%
   

	String errMsg = s4141CfmMsg;
	if ( s4141CfmCode.equals("000000"))
	{
 
%>
<script language="JavaScript">
	rdShowMessageDialog("��ֵ˰רƱ��������ɾ���ɹ���");
	window.location="zgb2_1.jsp?opCode=asdf&opName=���ſͻ��ɷ�֪ͨ";
	</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("��ֵ˰רƱ��������ɾ��ʧ��: <%=retMsg%>,<%=s4141CfmCode%>",0);
	window.location="zgb2_1.jsp?opCode=asdf&opName=���ſͻ��ɷ�֪ͨ";
	</script>
<%}
%>

