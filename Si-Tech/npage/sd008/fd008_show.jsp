<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: 
   * �汾: 1.0
   * ����: 2010/11/30
   * ����: wanglm
   * ��Ȩ: si-tech
   * update: hejwa 2013��6��23��13:49:28 Ӫ����Ŀ���� 
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%	request.setCharacterEncoding("GBK");%>
<%  
  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
	String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	String regionCode=(String)session.getAttribute("regCode");
	String[][] result = (String[][])request.getAttribute("result"); 
 
%>     
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>����״̬��Ϣ��ѯ</TITLE>
</HEAD>
<script type="text/javascript" language="javascript">
	function gogo(){
	   window.location = "fd008.jsp";	
	}

function showMarkInfo(sysAccept,phoneNo){
		var h=610;
   	var w=800;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
		var path = "showMarkInfo.jsp?sysAccept="+sysAccept+"&opCode=<%=opCode%>&phoneNo="+phoneNo;
		var ret=window.showModalDialog(path,"",prop);
}	
</script>
<body>
	<FORM method="post" name="form1" action="">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
    	<div id="title_zi">����״̬��Ϣ��ѯ</div>
    </div>
    <table cellSpacing="0">
    	<th>�����к�</th>
    	<th>�ͻ�������</th>
    	<th>�ֻ�����</th>
    	<th>״̬����</th>
    	<th>������</th>
    	<th>������ˮ</th>
    	<th>����ʱ��</th>
    	<th>����ʱ��</th>
    	<th>����ҵ��</th>
    	<%
    	    for(int i=0;i<result.length;i++){
    	%>
    	<tr>
    	  <td><%=result[i][0]%></td>	
				<td><%=result[i][8]%></td>	
    	  <td><%=result[i][1]%></td>	
    	  <td><%=result[i][2]%></td>	
    	  <td><%=result[i][3]%></td>
    	  	<td><a href="#" onclick="showMarkInfo('<%=result[i][4]%>','<%=result[i][1]%>')"><%=result[i][4]%></a></td>
    	  <td><%=result[i][5]%></td>
    	  <td><%=result[i][7]%></td>	
    	  <td><%=result[i][6]%></td>	
    	</tr>
    	<%
    	  }
    	%>
    	<tr>
			<td colspan="10" align="center" id="footer">
				<input class="b_foot" name="re"    type="button" onClick="gogo()" value="����"/>
				<input class="b_foot" name="back"    type="button" onClick="removeCurrentTab()" value="�ر�"/>
			</td>
		</tr>
    </table>
    <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
    		
    			