<%
  /*
   * ����: ѡ����ȼ�
�� * �汾: 1.0.0
�� * ����: 2008/11/05
�� * ����: mixh
�� * ��Ȩ: sitech
   * update:
�� */
%>
<%
	String opCode = "K214";
	String opName = "ѡ����ȼ�";
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html>
<head>
	<title>ѡ����ȼ�</title>
	<script>
	function submitErrorLevel(){
		window.returnValue = getReturnStr();
		window.close();
	}
	
	function cancel(){
		window.close();
	}
	</script>
</head>
<body >
<form name="form1">

<%@ include file="/npage/include/header.jsp" %>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td width="45%">
		<jsp:include page="fK240toK270_tree.jsp">
		<jsp:param name="op_code" value="k250"/>
		</jsp:include>
        </td>
      </tr>
    </table>
<%@ include file="/npage/include/footer.jsp" %>

</form>
</body>
</html>


