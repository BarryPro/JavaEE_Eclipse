<%
/********************
 
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa)[2017/2/7 15:46:09]------------------
 �����·����ӻ��мۿ�ҵ��ȫ�����췽�������߼ƻ���֪ͨ
 
 -------------------------��̨��Ա��[liyang]--------------------------------------------
 
********************/
%>
              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%
	String opCode    = WtcUtil.repNull(request.getParameter("opCode"));
  String opName    = WtcUtil.repNull(request.getParameter("opName"));
  
  String workNo     = (String)session.getAttribute("workNo");
  String password   = (String)session.getAttribute("password");
  String regionCode = (String)session.getAttribute("regCode");

	
	
%> 
 
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<SCRIPT language=JavaScript>


//����ˢ��ҳ��
function reSetThis(){
	  location = location;	
}

function go_Query(){
	if(""==$("#ipt_CardNo").val().trim()){
		rdShowMessageDialog("��������ӿ�����");
	}
}

</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi"><%=opName%></div></div>


<table cellSpacing="0">
  
	<tr >
	    <td class="blue">���ӿ�����</td>
		  <td colspan="3">
					<input type="text" id="ipt_CardNo" name="ipt_CardNo"  />	
					<input type="button" class="b_foot" value="��ѯ" onclick="go_Query()"            />		    
		  </td>
	</tr>
	 
</table>

<div class="title"><div id="title_zi">��ѯ����б�</div></div>
<table cellSpacing="0">
	<tr>
		<th>����</th>
		<th>���</th>
		<th>��ҵ������</th> 
		<th>��ҵ������</th>
		<th>����ʱ��</th>
		<th>����Ч��</th>
		<th>��״̬</th>
		<th>��ֵ����</th>
		<th>����ֵ����</th>
		<th>��ֵʱ��</th>
		<th>��ֵ������ˮ��</th>
	</tr>
</table>

<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="����" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="�ر�" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>