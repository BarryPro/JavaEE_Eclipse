<%
  /**
   * ����: �ʼ�Ȩ�޹���->�����ʼ�Ȩ��->�ʼ�Աӵ���ʼ����¹���Ȩ�޲�����
�� * �汾: 1.0.0
�� * ����: 2008/11/05
�� * ����: mixh
�� * ��Ȩ: sitech
   * update:
�� */
%>
<%@ page language="java" pageEncoding="gbk"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<HTML>
		<HEAD>
		<LINK
			href="<%=request.getContextPath()%>/nresources/default/css/dtmltree_css/dhtmlxtree.css"
			type=text/css rel=STYLESHEET>
	</HEAD>
	<BODY scroll=auto>
	<div id='dataTable' >
	</div>
	</BODY>
</html>
<SCRIPT LANGUAGE="JavaScript">
<!--

function CopyHtmlElement()
{
 document.getElementById('dataTable').innerHTML = parent.rightCenterLoginNo.document.getElementById('dataTableDiv').outerHTML;
 document.execCommand("copy","",null); // ����
}

//-->
</SCRIPT>