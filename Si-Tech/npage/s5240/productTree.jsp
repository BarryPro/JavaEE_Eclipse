   
<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-17
********************/
%>
              
<%
  String opCode = "5240";
  String opName = "��Ʒ����";
%>              

	
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="java.util.*"%>
<%
	    
%>

<%
String productType = request.getParameter("productType");	//����־ 1Ϊ���� 2Ϊ����
String productCode = request.getParameter("productCode");
if(request.getParameter("productCode")==null){
	productCode = productType;
}


String productForm = request.getParameter("productForm")==null?"form1":request.getParameter("productForm");

String dataJsp = "productXml.jsp?productCode="+productCode
					+"&productType="+productType
					+"&isRoot=true";
					
System.out.println("datajsp="+dataJsp);
ArrayList arr = new ArrayList();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title><%=productType.equals("1")?"����":"����"%>��ƷĿ¼��</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="../../css/jl.css" type="text/css">
<script type="text/javascript" src="../../js/xtree.js"></script>
<script language="JavaScript" src="xtree/script/loader.js"></script>
<link rel="stylesheet" type="text/css" href="xtree/css/xtree.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<style type="text/css">
a:link,a:visited { text-decoration: none; color: #111111 }
font { font-family: ����; font-size: 13px; }
</style>
<script language="JavaScript"> 
	
function returnCode(directCode,directName){
	window.opener.<%=productForm%>.direct_id.value=directCode;
	window.opener.<%=productForm%>.direct_name.value=directName;
	window.close();
}

</SCRIPT>
</head>
<body >
<form name="frm" method="post" action="">
<div id="Main">

   <DIV id="Operation_Table"> 

			<table   cellspacing="0">
				<tr > 
					<td height="300" valign="top" nowrap>
						
						<script>loader();</script>
						<div id="xtree"  XmlSrc="<%=dataJsp%>">
						</div>
						
						<script language="JavaScript">
						<!--
						document.all.xtree.className="xtree";
						
						//-->
						</script>
					
			    </td>
			  </tr>
			</table>
<%@ include file="/npage/include/footer_simple.jsp" %>
</body>
</html>


