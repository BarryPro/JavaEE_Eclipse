<%
/********************
 
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa)2016-3-9 10:18:39------------------
 

 -------------------------��̨��Ա��wangzc��zuolf--------------------------------------------
 
********************/
%>
              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%
	String opCode        = WtcUtil.repNull(request.getParameter("opCode"));
  String opName        = WtcUtil.repNull(request.getParameter("opName"));
  
  String outClssName   = WtcUtil.repNull(request.getParameter("outClssName"));
  String offer_name    = WtcUtil.repNull(request.getParameter("offer_name"));
  String offer_desc    = WtcUtil.repNull(request.getParameter("offer_desc"));
  String offer_sum     = WtcUtil.repNull(request.getParameter("offer_sum"));
  
%>  

<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<SCRIPT language=JavaScript>
//ESC �ر�ҳ��
	document.onkeydown = function() {
		if (window.event.keyCode == 27) {
			window.close();
		}  
	};
</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<%@ include file="/npage/include/header_pop.jsp" %>	
<div class="title"><div id="title_zi">�ʷ�����</div></div>


<table cellSpacing="0">
	<tr>
	    <td class="blue" width="25%">�ʷѷ���</td>
		  <td>
		  	<%=outClssName%>
		  </td>
	</tr>
	<tr>
	    <td class="blue" width="25%">�ʷ�����</td>
		  <td>
		  	<%=offer_name%>
		  </td>
	</tr>
	<tr>
	    <td class="blue" width="25%">�ʷѽ��</td>
		  <td>
		  	<%=offer_sum%>
		  </td>
	</tr>
	<tr>
	    <td class="blue" width="25%">�ʷ�����</td>
		  <td>
		  	<%=offer_desc%>
		  </td>
	</tr>
</table>

<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
			<input type="button" class="b_foot" value="�ر�" onclick="window.close()"  /> 
	 	</td>
	</tr>
</table>

<%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
</BODY>
</HTML>