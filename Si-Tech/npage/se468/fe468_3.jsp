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
		String regionCode= (String)session.getAttribute("regCode");
		String workNo = (String)session.getAttribute("workNo");

		
		%>

		<script language="javascript">

		function quechoosee() {
        var addObjectId = document.frm.addObjectId.value;		
        if(addObjectId=="") {
					rdShowMessageDialog("��ѡ����֯�ڵ㣡");
					return false;
				}
        var markDiv=$("#gongdans"); 
				//���ԭ�б��
				markDiv.empty();	
				var getdataPacket = new AJAXPacket("fe468_3_qry.jsp","���ڻ�����ݣ����Ժ�......");
					getdataPacket.data.add("opCode","<%=opCode%>");
					getdataPacket.data.add("groupid",addObjectId);
					core.ajax.sendPacketHtml(getdataPacket,gongdanquery,true);
					getdataPacket = null;
	
		}
			 function gongdanquery(data){
				//�ҵ���ӱ���div
				var markDiv=$("#gongdans"); 
				//���ԭ�б��
				markDiv.empty();
				markDiv.append(data);
				
		   }
		   		function queryObjectId() {

			var path = "tree/groupTree.jsp";
			window.open(path + "?groupType=frm&groupId=addObjectId","","height=530,width=450,scrollbars=yes");
		}
		</script>
		<body>
		<form name="frm" method="POST" action="">
	<%@ include file="/npage/include/header.jsp" %>
	<input type="hidden" name="addObjectId" id="addObjectId" >
		<div class="title">
		<div id="title_zi">��ʷ��Ϣ��ѯ</div>
	</div>
	      <table cellspacing="0" >
		  <tr>
		    <td class="blue" width="15%">��֯�ڵ�</td>
		    <td colspan="3">
		  	  				<input type="text" name="groupId" value="" class="InputGrey" readonly style="width:170px;">
	            	<input class="b_text" type="button" name="" value="ѡ��" onclick="queryObjectId();" >
		  
		</td>

	</tr>
			

</table>
 
	 	<table cellspacing="0">
		<tr>
			<td noWrap id="footer">
			<div align="center">
					<input type="button"  name="quchoose" class="b_foot" value="��ѯ" onclick="quechoosee()" />		
				&nbsp;
				<input name="back" onClick="history.go(-1)" type="button" class="b_foot"  value="����">
				&nbsp;
				<input type="button" name="close" class="b_foot" value="�ر�" onClick="removeCurrentTab();"/>
			</div>
			</td>
		</tr>
	</table>
		<div id="gongdans">
		</div>    
 <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>