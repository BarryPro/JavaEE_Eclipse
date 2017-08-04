   
<%
/********************
 version v2.0
 开发商 si-tech
 update anln@2009-2-19
********************/
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	
	String loginNo = (String)session.getAttribute("workNo");
		
	String grouptype = request.getParameter("grouptype")==null?"form1":request.getParameter("grouptype");	
	String roleCode = request.getParameter("roleCode");	//角色代码
	String roleName = request.getParameter("roleName");	//角色名称
	String loginNo1 = request.getParameter("loginNo1");	//新建或修改的工号代码	
	String dataJsp = "funcTreeXml.jsp?loginNo1="+loginNo1+"&isRoot=true&roleCode="+roleCode;
%>


<html>
<head>
<title>[<%=loginNo%>]权限树</title>
<script language="JavaScript" src="xtreeFunc/script/loader.js"></script>
<link rel="stylesheet" type="text/css" href="xtreeFunc/css/xtree.css">
<style type="text/css">
	a:link,a:visited { text-decoration: none; color: #111111 }
	font { font-family: 宋体; font-size: 13px; }
	.divTitle
	 {
		background-color:#EEEEEE;
		border: 1px  solid #82A2B9;
		width: 98%;
		margin-top: 10px;
		margin-bottom: 10px;
	 }
</style>
<script language="JavaScript"> 
var treenode1;
//-----返回组织节点-------	
function saveTo(retPopeDomCode,retPopeDomName)
{
	parent.rightFrame.location="funclist.jsp?loginNo1=<%=loginNo1%>&popeDomCode="+retPopeDomCode+"&popeDomName="+retPopeDomName+"&roleCode="+"<%=roleCode%>"+"&roleName="+"<%=roleName%>";
}

</SCRIPT>
</head>
<body>
<form name="frm" method="post" action="">

    
      	<div class="divTitle">
		      <table  cellspacing="0">
			<tr>
		          <td width="40%"  style="font-size: 12px"><span id="titlename">
		          	<script language="javascript">document.write(document.title);</script></span></td>
		          <td width="60%" style="font-size: 12px">&nbsp;</td>
		        </tr>
		      </table>
    </div> 
	    
			<table cellspacing="0">
    		  	<tr> 
    		  		<TD width="20" >
    		  		</TD>
				<td  nowrap>
					<script>loader();</script>
					<div id="xtree"  XmlSrc="<%=dataJsp%>"></div>
					<script language="JavaScript">
					<!--
					document.all.xtree.className="xtree";
					//-->
					</script>
				</td>
  				</tr>
			</table>
</body>
</html>