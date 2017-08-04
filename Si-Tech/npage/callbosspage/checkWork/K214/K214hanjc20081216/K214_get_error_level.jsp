<%
  /*
   * 功能: 选择差错等级
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
   * update:
　 */
%>
<%
	String opCode = "K214";
	String opName = "选择差错等级";
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html>
<head>
	<title>选择差错等级</title>
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


