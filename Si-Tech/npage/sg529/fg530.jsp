<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<head>
	<%
   response.setHeader("Pragma","No-cache");
   response.setHeader("Cache-Control","no-cache");
   response.setDateHeader("Expires", 0);
		String opCode = request.getParameter("opCode");
		String opName = request.getParameter("opName");
		String workNo = (String)session.getAttribute("workNo");
		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		%>

		<body >
		<form name="frm" method="POST" action="">
	<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
<table cellspacing=0>
						<tr>

		<td class="blue" width="30%">

			��������

		</td>

	
         	<td><input type="radio" name="opFlag" value="0"  >����
         		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
         		<input type="radio" name="opFlag" value="1"  >д��
         		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
         		<!--input type="radio" name="opFlag" value="2" disabled >��д��������
         		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
         		<input type="radio" name="opFlag" value="3" disabled >���ͽ����¼--></td>
         				 
					</tr>

				</table>

	 	<table cellspacing="0">
		<tr>
			<td noWrap id="footer">
			<div align="center">
 <input type="button" name="addsd" class="b_foot" value="ȷ��" onclick="add()">
			</div>
			</td>
		</tr>
	</table> 
	    
 <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
<script language="javascript">

function add() {
	
				if (document.getElementsByName("opFlag")[0].checked) {
					/*���������ѯ*/
		    	frm.action = "/npage/sg529/fg530RemoveMain.jsp?opCode=i229&opName=�����ۿ�����";
			    frm.submit();
					
		   }
				else if (document.getElementsByName("opFlag")[1].checked) {

		    	frm.action = "fg530writecard.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
			    frm.submit();

		   } else if (document.getElementsByName("opFlag")[2].checked) {

				frm.action = "fg530addlogistics.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
				frm.submit();

			}else if (document.getElementsByName("opFlag")[3].checked){
				frm.action = "fg530addresult.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
				frm.submit();
				}else {
				rdShowMessageDialog("��ѡ��һ�������");
 	  		return false;
					}

	}
</script>
