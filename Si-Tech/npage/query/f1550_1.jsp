<%
/********************
 version v2.0
������: si-tech
update:anln@2009-01-08
********************/
%> 
<%@ page contentType="text/html; charset=GB2312" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
<HTML>
	<HEAD>
		<TITLE>�ۺ���ʷ��Ϣ��ѯ</TITLE>			
		<%	
			String workNo = (String)session.getAttribute("workNo");    //����  	
			String workName = (String)session.getAttribute("workName");//��������  	
			String regionCode= (String)session.getAttribute("regCode");//����	
			String ip_Addr = "172.16.23.13";         
		        String opCode = request.getParameter("opCode");	//header.jsp��Ҫ�Ĳ���
			String opName = request.getParameter("opName");	//header.jsp��Ҫ�Ĳ���       
			System.out.println("gaopengSeeLohg===1550_1===init!!");
		%>
		<SCRIPT language="JavaScript">
			function doCheck(){
				if(document.frm1550.condText.value==""){					
					rdShowMessageDialog("�������ѯ��������");
					document.frm1550.condText.select();
					return false;
				}else{
					document.frm1550.action="f1550_2.jsp";
					frm1550.submit();
				}
				return true;
			}
		</SCRIPT> 
	</HEAD>
	<body>
		<FORM method=post name="frm1550" OnSubmit="return doCheck()">
			<%@ include file="/npage/include/header.jsp" %>
			<div class="title" id="changxun">
				<div id="title_zi">��ѯ���� </div>
			</div>
			<input type="hidden" name="opCode"  value="1550">
			<input type="hidden" name="opName"  value="<%=opName%>">
			<TABLE  cellspacing="0">
        			<TR> 
          				<TD width=16% class="blue">��ѯ���� </TD>
          				<TD width=34%>
						<select align="left" name="QueryType" width=50>
							<option class="button" value="0">�������</option>
						        <option class="button" value="2">֤������</option>
							<option class="button" value="3">�ͻ�����</option>
							<option class="button" value="4">SIM����</option>
						</select> 
		  			</TD>
          				<TD width=16% class="blue">�������ѯ���� </TD>
          				<TD width=34%>
          					<input type="text" class="button" name="condText" size="20" maxlength="60" onKeyDown="if(event.keyCode==13){ doCheck();return false}" >
          					<input type="button" class="b_text" name="Button1" value="��ѯ" onclick="doCheck()" >
          				</TD>
       				</TR>       				
      			</TABLE>    
      			<br>      			
      			<div class="title" id="jieguo">
				<div id="title_zi">��ѯ���</div>
			</div>   				 
			<table  id=contentList cellspacing="0">				
				<tr>					    
					<th>�������</th>
					<th>�û�ID��</th>
					<th>��������</th>
					<th>��ǰ״̬</th>  
					<th>״̬���ʱ��</th>  
					<th>����ʱ��</th>					     
				</tr>
			</table>
			<table cellspacing="0">
				  <tr> 
					    <td id="footer">
					      &nbsp; <input class="b_foot" name=reset  type=reset  value=���>
					      &nbsp; <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=�ر�>
					      &nbsp; 
					    </td>
				  </tr>			   
			</table>
			<%@ include file="/npage/include/footer.jsp" %> 
		</FORM>
	</BODY>
</HTML>

