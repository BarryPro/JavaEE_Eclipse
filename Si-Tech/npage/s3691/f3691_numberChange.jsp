<%
/********************
 version v2.0
 开发商: si-tech
 author: liujian at 2013-1-24 14:26:09
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String loginNo = (String)session.getAttribute("workNo");
	String loginNoPass = (String)session.getAttribute("password");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = (String)session.getAttribute("regCode");
	String grpIdNo = request.getParameter("grpIdNo");
	
%>

	<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="regioncode" 
		routerValue="<%=regionCode%>"  id="loginAccept" />
<%
	String  inputParsm [] = new String[8];
	inputParsm[0] = loginAccept;
	inputParsm[1] = "01";
	inputParsm[2] = opCode;
	inputParsm[3] = loginNo;
	inputParsm[4] = loginNoPass;
	inputParsm[5] = "";
	inputParsm[6] = "";
	inputParsm[7] = grpIdNo;
	
	//测试数据
	/*
	String[][] array = new String[4][4];
	array[0][0] = "1";
	array[0][1] = "111111111";
	array[0][2] = "2013-1-24 14:45:27";
	array[0][3] = "N";
	
	array[1][0] = "2";
	array[1][1] = "222222222";
	array[1][2] = "2013-1-24 14:45:27";
	array[1][3] = "N";
	
	array[2][0] = "3";
	array[2][1] = "333333333";
	array[2][2] = "2013-1-24 14:45:27";
	array[2][3] = "N";
	
	array[3][0] = "4";
	array[3][1] = "444444444";
	array[3][2] = "2013-1-24 14:45:27";
	array[3][3] = "Y";
	*/
%>	
	
	<wtc:service name="sAccessCodeQry" routerKey="region" routerValue="<%=regionCode%>"  
			retcode="retCodeQry" retmsg="retMsgQry" outnum="4">
		<wtc:param value="<%=inputParsm[0]%>"/>
		<wtc:param value="<%=inputParsm[1]%>"/>
		<wtc:param value="<%=inputParsm[2]%>"/>
		<wtc:param value="<%=inputParsm[3]%>"/>
		<wtc:param value="<%=inputParsm[4]%>"/>
		<wtc:param value="<%=inputParsm[5]%>"/>
		<wtc:param value="<%=inputParsm[6]%>"/>
		<wtc:param value="<%=inputParsm[7]%>"/>
	</wtc:service>
	<wtc:array id="qryRst"  scope="end"/>
	
	
<%
	if(retCodeQry.equals("000000")) {
		
	}else{
%>
		<script language="JavaScript">
			rdShowMessageDialog("错误代码：<%=retCodeQry%>错误信息：<%=retMsgQry%>",0);
		</script>
<%
	}
%>

<head>
	<title><%=opName%></title>
	<META content=no-cache http-equiv=Pragma>
	<META content=no-cache http-equiv=Cache-Control>
	<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
	<script>
		var delSuccess = false;
		function delRecord(obj) {
			var $parent = $(obj).parent().parent().find('td[id^="no_"]');
			var accessId = $parent.attr('id');//接入号ID
			var accessCode = $.trim($parent.text());//接入号
			//ajax
			var packet = new AJAXPacket("../s3690/f3690_ajax_rent.jsp","正在获得数据，请稍候......");
	        packet.data.add("method","delRecord");
	        packet.data.add("idNo",'<%=grpIdNo%>');
	        packet.data.add("opCode",'<%=opCode%>');
	        packet.data.add("accessId",accessId);
	        packet.data.add("accessCode",accessCode);
	        core.ajax.sendPacket(packet,doDelRecord);
	        packet = null;	
	        if(delSuccess) {
	        	//删除当前行
				$(obj).parent().parent().remove();
	        }
	        
		}
		
		function addRecord() {
			var inNumber = $('#addRecordText').val();
			if(inNumber) {
				if(inNumber.length > 15) {
					rdShowMessageDialog("接入号不能超过15位！",0);
					return false;		
				}
			}else {
				rdShowMessageDialog("请输入正确的接入号！",0);
				return false;	
			}
			//ajax
			var packet = new AJAXPacket("../s3690/f3690_ajax_rent.jsp","正在获得数据，请稍候......");
	        packet.data.add("method","addRecord");
	        packet.data.add("idNo",'<%=grpIdNo%>');
	        packet.data.add("opCode",'<%=opCode%>');
	        packet.data.add("accessId","");
	        packet.data.add("accessCode",inNumber);
	        core.ajax.sendPacket(packet,doAddRecord);
	        packet = null;	
		}
		
		//删除记录
		function doDelRecord(packet) {
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			if(retCode == '000000') {
				rdShowMessageDialog("删除成功");
				delSuccess = true;
			}else {
				rdShowMessageDialog("错误代码:" + retCode + ",错误信息:" + retMsg,0);	
				delSuccess = false;
				return false;
			}
	    }
	    
	    function doAddRecord(packet) {
	    	var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			if(retCode == '000000') {
				rdShowMessageDialog("添加成功");
				//刷新当前页面
				window.location='f3691_numberChange.jsp?grpIdNo=<%=grpIdNo%>&opCode=<%=opCode%>&opName=<%=opName%>';	
			}else {
				rdShowMessageDialog("错误代码:" + retCode + ",错误信息:" + retMsg,0);	
			}	
	    }
	</script>	

</head>

<body>
	<form name="frm" method="post" action="">
		<%@ include file="/npage/include/header.jsp" %>
		<input type="hidden" name="opCode" value="<%=opCode%>">
		<input type="hidden" name="opName" value="<%=opName%>">
		<input type="hidden" name="grpIdNo" value="<%=grpIdNo%>">
		<div class="title">
			<div id="title_zi">虚拟呼叫中心产品接入号变更</div>
		</div>

	<table cellspacing="0">
		<thead>
			<th>接入号</th>
			<th>操作时间</th>
			<th>是否为企业显示号码</th>
			<th>操作</th>
		</thead>
		<tbody id="qryTbody">
<%
			for(int i=0;i<qryRst.length;i++) {
				out.print("<tr>");
				for(int j=1;j<qryRst[i].length;j++) {
					if(j == 1) {
						out.print("<td id='no_" + qryRst[i][0] + "'>" + qryRst[i][j] + "</td>");
					}else {
						out.print("<td>" + qryRst[i][j] + "</td>");	
					}
					if(j == 3) {
						String status = qryRst[i][j];
						if("N".equals(status)) {
							out.print("<td><input type='button' class='b_text' name='delRecordBtn' value='删除' onclick='delRecord(this)' /></td>");	
						}else {
							out.print("<td><input type='button' class='b_text' name='delRecordBtn' value='删除' disabled /></td>");		
						}
					}
					
				}
				out.print("</tr>");
			}
		
%>
		</tbody>
		<tr>
			<td colspan="4" class="blue">
				接入号
				<input type="text" value="" id="addRecordText" maxlength="15" onkeyup="this.value=this.value.replace(/\D/g,'')" 
					onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
				<input type="button" class='b_text' value="新增" onclick="addRecord()" />
			</td>	
		</tr>	
	</table>
		
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
