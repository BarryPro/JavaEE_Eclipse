<%
   /*
   * ����: ��ʾ��֯������������ѡ�еĽ�ɫ�ڵ㷵�ص����õ�ҳ�档
   *       ���ص�ҳ������Ҫ��roleCode,roleName�����ֶ�
�� * �汾: v1.0
�� * ����: 2007/03/26
�� * ����: 
�� * ��Ȩ: sitech
   * �޸���ʷ
 ��*/
%>
<%@ page contentType="text/html;charset=gbk"%>
<%@ page errorPage="/page/common/errorpage.jsp" %>
<%@ page import="java.util.*"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>

<%
	System.out.println("<-----------------grouptree.jsp start------------------>");
	String grouptype = request.getParameter("groupType")==null?"form1":request.getParameter("groupType");
	
	String groupName = "groupName";
	String groupId = "groupId";
	
	String dataJsp = "groupTreeXml.jsp?isRoot=true";
	

	
	System.out.println("grouptree.jsp");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>��֯������</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link rel="stylesheet" href="../../css/style.css" type="text/css">
<script type="text/javascript" src="../../js/xtree.js"></script>
<script language="JavaScript" src="../../js/global.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<script language="JavaScript" src="xtree/script/loader.js"></script>

<link rel="stylesheet" type="text/css" href="xtree/css/xtree.css">
<style type="text/css">
a:link,a:visited { text-decoration: none; color: #111111 }
font { font-family: ����; font-size: 13px; }
</style>
<script language="JavaScript">
var treenode1;
function saveTo(retGroupId,retGroupName)
{
	var retGroupId=retGroupId;
	var retGroupName=retGroupName;
	window.opener.<%=grouptype%>.<%=groupId%>.value=retGroupId;     //����Ϣ���ص����õ�ҳ��ȥ
	window.returnValue = retGroupId + "|" + retGroupName;
	//window.opener.getWorkNo();
	window.close();
}
//-----������֯�ڵ�-------	

//��ѡ��nodeֵ����,��
var checkedNodes="";
var checkedNames="";
//��ѡ��Ľڵ���Ŀ
var selectedCount=0;
//������ѡ��ڵ�
function addCheckedNode(nodeId,nodeName)
{	
	if(checkedNames=="")
	{
		checkedNames=nodeName;
	}
	else
	{
		checkedNames=checkedNames+","+nodeName;
	}
	if(checkedNodes=="")
	{
		checkedNodes=nodeId;
	}
	else
	{
		checkedNodes=checkedNodes+","+nodeId;
	}
	selectedCount++;
}

//ȡ��ĳ�ڵ�����ѡ��Ľڵ�
function getSelectNode(node)
{
	if(selectedCount > 0){
		return false;
	}
	var Children=node.children;
	for(var i=0; i < Children.length; i++)
	{
		if(Children[i].tagName.toUpperCase()=="DIV")
		{
			getSelectNode(Children[i]);
		}
		
		if(Children[i].tagName.toUpperCase()=="INPUT")
		{
			if(Children[i].checked)
			{
				addCheckedNode(Children[i].name,Children[i+1].title);
			}
		}
	}
}

function closeLogicDialog()
{
	var tree = document.all.xtree;

	getSelectNode(tree);

	if(selectedCount==0)
	{
		alert('����Ҫѡ��һ�����ϵĲ���');
		return;
	}

	window.opener.<%=grouptype%>.<%=groupId%>.value=checkedNodes;     //����Ϣ���ص����õ�ҳ��ȥ
	window.opener.<%=grouptype%>.<%=groupName%>.value=checkedNames;
	window.returnValue = checkedNodes + "|" + checkedNames;
	window.opener.getWorkNo();
	window.close();
	//Add by Mumu Lee ���������ַ�ʽ������ֵ������ģʽ�Ի��򼰷�ģʽ�Ի���
}

</SCRIPT>
</head>
<body topmargin="0">
	<form name="frm">
		<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
			<tr>
				<td width="31" height="23">
					<img src="../../../images/bar_left(1).gif" width="6" height="25">
				</td>
				<td width="100%" background="../../../images/bar_bg(1).gif" class="show-title">
					��֯��
				</td>
				<td>
					<img src="../../../images/bar_right(1).gif" width="6" height="25">
				</td>
			</tr>
		</table>
		<script>loader();</script>
		<div id="xtree" XmlSrc="<%=dataJsp%>">
		</div>
		<br>
		<table width="100%"  border="0" align="center" cellpadding="0" cellspacing="0">
			<tr>
				<td width="35%"></td>
				<td width="120">
				<table width="100" border="0" cellspacing="0" cellpadding="0">
					<tr>
		  				<td></td>
						<td width="100%">
							<INPUT TYPE="button" value="ȷ  ��" onClick="closeLogicDialog();">
						</td>
						<td></td>
					</tr>
				</table>
				</td>
				<td width="120">
					<table width="100" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td></td>
							<td width="100%">
								<INPUT TYPE="button" value="��  ��" onClick="window.close();">	        	
							</td>
							<td></td>
						</tr>
					</table>
				</td>
				<td width="35%"></td>
			</tr>
		</table>		
			
		<script language="JavaScript">
			document.all.xtree.showButton=true;
			if('<%=grouptype%>' == 'form2'){
			document.all.xtree.del=false;
		}else{
			document.all.xtree.del=true;
		}
		document.all.xtree.className="xtree";
		</script>
	</form>
</body>
</html>