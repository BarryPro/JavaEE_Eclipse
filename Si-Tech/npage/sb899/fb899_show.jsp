<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: Ӫҵ��״̬ʵʱչʾ 
   * �汾: 1.0
   * ����: 2010/11/30
   * ����: wanglm
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%	request.setCharacterEncoding("GBK");%>
<%  
    String opCode="b899";
	String opName="Ӫҵ��״̬ʵʱչʾ";
	String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	String regionCode=(String)session.getAttribute("regCode");
	String[][] result = (String[][])request.getAttribute("result"); 
%>     
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>Ӫҵ��״̬ʵʱչʾ</TITLE>
</HEAD>

<body>
	<FORM method="post" name="form1" action="">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
    	<div id="title_zi">Ӫҵ��״̬ʵʱչʾ</div>
    </div>
    <table cellSpacing="0">
    	<th>ҵ������</th>
    	<th>��������</th>
    	<th>�ȴ�����</th>
    	<th>�ȴ�ʱ��</th>
    	<th>ƽ������ʱ��</th>
    	<th>����̨ϯ��</th>
    	<th>��æ״̬</th>
    	<th>չʾʱ��</th>
    	<%
    	    for(int i=0;i<result.length;i++){
    	%>
    	<tr>
    	  <td><%=result[i][0]%></td>	
    	  <td><%=result[i][2]%></td>	
    	  <td><%=result[i][4]%></td>	
    	  <td><%=result[i][5]%></td>
    	  <td><%=result[i][7]%></td>
    	  <td><%=result[i][9]%></td>
    	  <td><%=result[i][12]%></td>	
    	  <td><%=result[i][13]%></td>
    	</tr>
    	<%
    	  }
    	%>
    	<tr>
			<td colspan="8" align="center" id="footer">
			<input class="b_foot" name="re"    type="button" onClick="javascript:history.go(-1);" value="����"/>
			<input class="b_foot" name="back"    type="button" onClick="removeCurrentTab()" value="�ر�"/>
			</td>
		</tr>
    </table>
    <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
    		
    			