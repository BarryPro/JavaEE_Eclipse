<%
/********************
 
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa)2015-8-19 13:35:58------------------
 ����7����Ѯ���ſͻ���CRM��BOSSϵͳ����ĺ�--2��BOSSϵͳ���ݵ�����ӡ�ɾ����Ա������
 
 
 -------------------------��̨��Ա��haoyy--------------------------------------------
 
********************/
%>
              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%
	String opCode    = WtcUtil.repNull(request.getParameter("opCode"));
  String opName    = "ѡ���ʷ�";
  String workNo    = (String)session.getAttribute("workNo");
  String password  = (String)session.getAttribute("password");
  String workName  = (String)session.getAttribute("workName");
  String orgCode   = (String)session.getAttribute("orgCode");
  String ipAddrss  = (String)session.getAttribute("ipAddr");
  String regionCode = (String)session.getAttribute("regCode");
  
  String p_id = WtcUtil.repNull(request.getParameter("p_id"));
  
%>
	<wtc:service name="sGetAddProduct" outnum="4" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="" />                       
		<wtc:param value="<%=p_id%>" />
		<wtc:param value="" />
		<wtc:param value="" />
		<wtc:param value="<%=regionCode%>" />
		<wtc:param value="JT" />
		<wtc:param value="" />	
		<wtc:param value="<%=opCode%>" />	
		<wtc:param value="" />	
		<wtc:param value="" />	
		<wtc:param value="" />				
		<wtc:param value="<%=workNo%>" />		
		<wtc:param value="" />	
		<wtc:param value="" />	
		<wtc:param value="" />	
	</wtc:service>
	<wtc:array id="result_t" scope="end" />
		

<%
	if("000000".equals(code1)){
		 
	}else{
%>
<SCRIPT language=JavaScript>
	rdShowMessageDialog("sGetAddProduct����<%=code1%>��<%=msg1%>");
	window.close();
</SCRIPT>		
<%		
	}
	
%>
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE></TITLE>
<SCRIPT language=JavaScript>
	function save(){
		var radio_obj   = $("input[name='list_radio']:checked");
		var td_obj      = radio_obj.parent();
		var offer_id    = td_obj.next().text().trim();
		var offer_name  = td_obj.next().next().text().trim();
		if(offer_id==""){
			rdShowMessageDialog("��ѡ���ʷ�");
			return;
		}
		opener.getmebProdCode(offer_id,offer_name);
		window.close(); 
	}
</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi">�ʷ��б�</div></div>


<table cellSpacing="0">
	<tr>
		<tr>
			<th>ѡ��</th>
			<th>�ʷѴ���</th>
			<th>�ʷ�����</th>
		</tr>
<%
for(int i=0;i<result_t.length;i++){
%>
<tr>
	<td><input type="radio" name="list_radio" ></td>
	<td><%=result_t[i][2]%></td>
	<td><%=result_t[i][3]%></td>
</tr>	
<%
}
%>
 	</tr>
</table>
 
<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="ȷ��" onclick="save()"           />
			<input type="button" class="b_foot" value="�ر�" onclick="window.close()"  /> 
	 	</td>
	</tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>