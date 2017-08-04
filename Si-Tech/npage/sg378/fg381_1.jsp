<%
/*************************************
* 功  能: g381·虚拟V网用户查询 
* 版  本: version v1.0
* 开发商: si-tech
* 创建者: liujian @ 2012-12-31 13:51:37
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
			rdShowMessageDialog('集团号和客户手机号必须输入一项！');	
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
  	
  	function submitForm(oprType){
  	    if(checkQuestion()) {
			var groupNo = $('#groupNo').val();
			var phoneNo = $('#phoneNo').val();
			document.groupIframe.location="fg381_2.jsp?opCode=<%=opCode%>&groupNo="+ groupNo + "&phoneNo=" + phoneNo + '&oprType='+ oprType;
			showBox();
		} 
  	}
  	
  $(function() {
  	 $('#searchBtn').click(function() {
		submitForm('0');
  	 });
  	 
  	 $('#exportBtn').click(function() {
		var groupNo = $('#groupNo').val();
		var phoneNo = $('#phoneNo').val();
		
		var myPacket = new AJAXPacket("syncExport.jsp","正在获得记录总数，请稍候...");
			myPacket.data.add("opCode","<%=opCode%>");
			myPacket.data.add("groupNo", groupNo);
			myPacket.data.add("phoneNo", phoneNo);
			myPacket.data.add("oprType", '1');

			core.ajax.sendPacket(myPacket, function(packet){
    			var errorCode = packet.data.findValueByName('retCode');
    			var errorMsg = packet.data.findValueByName('retMsg');
    			if (errorCode == '000000'){
    				rdShowMessageDialog("导出申请记录成功，请到g079模块查询导出结果！");
    			} else {
    				rdShowMessageDialog("导出失败！" + errorCode + errorMsg);
    			}
    		});
		    myPacket=null;
  	 });
  	 
  	 
  	 $('#clearBtn').click(function() {
		$('#groupNo').val('');
		$('#phoneNo').val('')
	 	window.frames["groupIframe"].clearTable();
  	 });
  	 
  	 $('#opCode').val('<%=opCode%>');
  	 $('#opName').val('<%=opName%>');
  });
  
  	
</script>

<body>
<form name="frm" action="" method="post" >
<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
			<div id="title_zi">查询条件</div>
		</div>
		<input type="hidden" value=""  id="opCode" name="opCode" />
		<input type="hidden" value=""  id="opName" name="opName" />
		<div>
				<table cellspacing=0>
				    <tr>
				    	<td class='blue'>手机号码</td>
						<td>
							<input type="text" name="phoneNo" id="phoneNo" value="" maxlength='11' onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>	
						</td>
						<td class='blue'>集团号</td>
						<td >
							<input type="text" name="groupNo" id="groupNo" value="" maxlength="10"  v_type=0_9 v_minlength=10 />
						</td>
						
				    </tr>
				    <tr id='footer'>
				        <td colspan='4'>
				            <input type="button"  id="searchBtn" class='b_foot' value="查询" name="searchBtn" />
				            <input type="button"  id="exportBtn" class='b_foot' value="全量导出" name="exportBtn" />
				            <input type="button"  id="clearBtn" class='b_foot' value="清除" name="clearBtn" />
				            <input type="button" class="b_foot" id="closeBtn" name="close" value="关闭" onclick="removeCurrentTab()"/>
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