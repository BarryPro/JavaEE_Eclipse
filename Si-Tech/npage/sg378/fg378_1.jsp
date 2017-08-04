<%
/*************************************
* ��  ��: g378������V���û����� 
* ��  ��: version v1.0
* ������: si-tech
* ������: liujian @ 2012-12-31 13:52:45
**************************************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
    String workNo     = (String)session.getAttribute("workNo");
    String regionCode = (String)session.getAttribute("regCode");
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title><%=opName%></title>
    <script type="text/javascript" src="/npage/public/pubLightBox.js"></script>	
</head>

<script type=text/javascript>
   
    
    function checkQuestion() {
		var groupNo = $('#groupNo').val();
		var phoneNo = $('#phoneNo').val();
		if(!groupNo && !phoneNo) {
			rdShowMessageDialog('���źźͼ����ֻ��ű�������һ�');	
			return false;
		}
		return true;
    }
    
    function showBox() {
  		showLightBox();
  	}
  	
  	function hideBox() {
  		hideLightBox();	
  	}
  $(function() {
  	 $('#searchBtn').click(function() {
		if(checkQuestion()) {
			var groupNo = $('#groupNo').val();
			var phoneNo = $('#phoneNo').val();
			document.groupIframe.location="fg378_2.jsp?opCode=<%=opCode%>&groupNo="+ groupNo + "&phoneNo=" + phoneNo;
			showBox();
		} 
  	 });
  	 
  	 
  	 $('#clearBtn').click(function() {
		$('#groupNo').val('');
		$('#phoneNo').val('')
		window.frames["groupIframe"].clearTable();
  	 });
  	 
  	 $('#opCode').val('<%=opCode%>');
  	 $('#opName').val('<%=opName%>');
  });
  
  
  function showIfTable() {
  	window.frames["groupIframe"].showTable();	
  }
  	
  	
</script>

<body>
<form name="frm" action="fg378_2.jsp" method="post" >
<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
			<div id="title_zi">��ѯ����</div>
		</div>
		<input type="hidden" value=""  id="opCode" name="opCode" />
		<input type="hidden" value=""  id="opName" name="opName" />
		<div>
				<table cellspacing=0>
				    <tr>
						<td class='blue'>���ź�</td>
						<td >
							<input type="text" name="groupNo" id="groupNo" value="" maxlength="10"  v_type=0_9 v_minlength=10 />
						</td>
						<td class='blue'>�������ֻ�����</td>
						<td>
							<input type="text" name="phoneNo" id="phoneNo" value="" maxlength='11' onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>	
						</td>
				    </tr>
				    <tr id='footer'>
				        <td colspan='4'>
				            <input type="button"  id="searchBtn" class='b_foot' value="��ѯ" name="searchBtn" />
				            <input type="button"  id="clearBtn" class='b_foot' value="���" name="clearBtn" />
				            <input type="button" class="b_foot" id="closeBtn" name="close" value="�ر�" onclick="removeCurrentTab()"/>
				        </td>
				    </tr>
				</table>
		</div>
		<IFRAME frameBorder=0 id="groupIframe" name="groupIframe" style="HEIGHT: 100px; WIDTH: 100%; Z-INDEX: 2">
		</IFRAME>
					
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>