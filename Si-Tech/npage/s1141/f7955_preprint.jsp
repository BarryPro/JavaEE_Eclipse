
<%
/********************
 version v2.0
������: si-tech
********************/
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<script language="JavaScript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>


<%	
	String[][] result = new String[][]{};
	ArrayList retArray = new ArrayList();
	String work_no = (String)session.getAttribute("workNo");
	String work_name = WtcUtil.repNull((String)session.getAttribute("workName"));
	String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String pass = (String)session.getAttribute("password");
	String ip_Addr =  (String)session.getAttribute("ipAddr"); 
	String prepayFeeStr=request.getParameter("prepayFeeStr");
	
%>  
<script language="JavaScript">
	rdShowMessageDialog("��ӡ�ڶ��ŷ�Ʊ��");
	location="/npage/public/hljBillPrint.jsp?retInfo=<%=prepayFeeStr%>&dirtPage=/npage/s1141/f7955_login.jsp";
</script>


