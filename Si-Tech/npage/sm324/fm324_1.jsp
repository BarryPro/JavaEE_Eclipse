<%
/********************
 
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa)2015-10-9 13:33:46------------------
 ���ں��˷���ҵ��ҵ�����Ƽ�����������չ����ĺ�
 
 
 -------------------------��̨��Ա��xiahk--------------------------------------------
 
********************/
%>
              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%
	String opCode    = WtcUtil.repNull(request.getParameter("opCode"));
  String opName    = WtcUtil.repNull(request.getParameter("opName"));
  
  String workNo    = (String)session.getAttribute("workNo");
  String password  = (String)session.getAttribute("password");
  String workName  = (String)session.getAttribute("workName");
  String orgCode   = (String)session.getAttribute("orgCode");
  String ipAddrss  = (String)session.getAttribute("ipAddr");
  
%> 
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<SCRIPT language=JavaScript>
function go_next(){
	var op_type= $("input[name='op_type']:checked").val();
	if(op_type=="1"){//ȥ����
		document.msgFORM.action="fm324_2.jsp?activePhone=<%=activePhone%>&opCode=<%=opCode%>&opName=<%=opName%>";
	}else{
		document.msgFORM.action="fm324_3.jsp?activePhone=<%=activePhone%>&opCode=<%=opCode%>&opName=<%=opName%>";
	}
	document.msgFORM.submit();
}
</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi">ѡ��ҵ������</div></div>


<table cellSpacing="0">
	<tr>
	    <td class="blue" width="35%">�ֻ�����</td>
		  <td>
			    <%=activePhone%>
		  </td>
	</tr>		  
			<td class="blue" width="35%">ҵ������</td>
			<td>
				<input type="radio"   name="op_type" value="1" checked  />����
				<input type="radio"   name="op_type" value="2" />ȡ��
			</td>
	</tr>
</table>


<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="��һ��" onclick="go_next()"           />
			<input type="button" class="b_foot" value="�ر�" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>