<%
/*************************************
* 功  能: 集团信息查询结果下载  g079
* 版  本: version v1.0
* 开发商: si-tech
* 创建者: liujian @ 2012-9-5 10:21:26
**************************************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode     =  request.getParameter("opCode");
    String opName     =  request.getParameter("opName");
    String workNo     = (String)session.getAttribute("workNo");
    String regionCode = (String)session.getAttribute("regCode");
    String op_strong_pwd = (String) session.getAttribute("password");
    String phoneNo = activePhone;
	String sql_select = "select model_code,op_code||'->'||op_note from sresultdatacfg";
%>

	<wtc:pubselect name="TlsPubSelCrm" outnum="2" routerKey="region" routerValue="<%=regionCode%>" 
		retcode="retCode" retmsg="retMsg">
		<wtc:sql><%=sql_select%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="rst" scope="end" />
		
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title><%=opName%></title>
    <script type="text/javascript" src="/npage/public/pubLightBox.js"></script>	
</head>

<script type=text/javascript>
	$(function() {
		if('<%=retCode%>' == '000000') {
				
		}else {
			 rdShowMessageDialog("错误代码：<%=retCode%>，错误信息：<%=retMsg%>",0);
			 removeCurrentTab();
		}
		
		$('#searchSel').change(function() {
			if($('#searchSel').val() == '') {
				$('#rstDiv').css('display','none');	
			}else {
				 var packet = new AJAXPacket("fg079_ajax.jsp","正在获得相关信息，请稍候......");
				 var _data = packet.data;
				 _data.add("modelCode",$('#searchSel').val());
				 _data.add("opCode",'<%=opCode%>');
				 _data.add("method","search");
				 core.ajax.sendPacket(packet,getFileListProcess);
				 packet = null;	
			}
		});
		
		$('#reset_btn').click(function() {
			$('#searchSel').val('');
			$('#rstDiv').css('display','none');	
		});
	});

	function getFileListProcess(package) {
		var retCode = package.data.findValueByName("retcode");
		var retMsg = package.data.findValueByName("retmsg");
		var result = package.data.findValueByName("result");
		$('#fileTbody').empty();
		var htmlStm = new Array();
		if(retCode == "000000") {	
			for(var i=0,len=result.length;i<len;i++) {
				var fileObj = result[i];
				htmlStm.push('<tr>');
				htmlStm.push('	<td>' + fileObj.fnName+ '</td>');
				htmlStm.push('	<td>' + fileObj.opNote+ '</td>');
				htmlStm.push('	<td>' + fileObj.opTime+ '</td>');
				htmlStm.push('	<td>' + fileObj.dealMsg+ '</td>');
				htmlStm.push('	<td>' + fileObj.dealTime+ '</td>');
				htmlStm.push('	<td>' + fileObj.dealMsg2+ '</td>');
				if(fileObj.fileName == '' || fileObj.fileName == 'null' || fileObj.fileName == 'undefined') {
					htmlStm.push('	<td>' + fileObj.fileName+ '</td>');
				}else {
					htmlStm.push('	<td><a href="#" onclick="downloadFile(this,\'' + fileObj.fileName + '\');"><p>' + fileObj.fileName+ '</p><a></td>');
				}
				htmlStm.push('</tr>');
			}	
			if(htmlStm.length > 0) {
				$('#fileTbody').append(htmlStm.join(''));	
				$('#rstDiv').css('display','block');
			}
		}else {
			rdShowMessageDialog("错误代码："+retCode+"，错误信息："+retMsg,0);
			return false;
		}
	}
	
	function downloadFile(v,charName) {
		
		var path = "fg079_download.jsp?fileName=" + charName;
		var ret = window.open(path);
		/*
		showLightBox();
		var _this = v;
		var fileName = $(_this).parent().find('p').text();
		var packet = new AJAXPacket("fg079_ajax.jsp","正在获得相关信息，请稍候......");
		var _data = packet.data;
		_data.add("fileName",fileName);
		_data.add("opCode",'<%=opCode%>');
		_data.add("method","download");
		core.ajax.sendPacket(packet,getDownloadProcess);
		packet = null;	
		*/
	}
	
	function getDownloadProcess(package) {
		hideLightBox();	
		var retCode = package.data.findValueByName("retcode");
		var retMsg = package.data.findValueByName("retmsg");
		if(retCode == "000000") {
			var fileName = package.data.findValueByName("fileName");
			var path = "fg079_download.jsp?fileName=" + fileName;
			var ret = window.open(path);
		}else {
			rdShowMessageDialog("错误代码："+retCode+"，错误信息："+retMsg,0);
			return false;
		}
	}
</script>

<body>
<form name="frm2" action="" method="post" >
	<%@ include file="/npage/include/header.jsp" %>
	<div id="Operation_Table">
		<div class="title">
			<div id="title_zi"><span id="sale_name_span"></span>查询条件</div>
		</div>
		<table>
			<tr>
				<td class="blue">
					集团信息查询条件	
				</td>
				<td>
					<select id="searchSel">
						<%
							out.print("<option value='' selected>请选择</option>");
							out.print("<option value='0'>全部业务</option>");
							if(retCode.equals("000000")) {
								for(int i=0;i<rst.length;i++) {
									out.print("<option value='" + rst[i][0] + "'>" + rst[i][1] + "</option>");
								}
							}
						%>
					</select>	
				</td>	
			</tr>
		</table>
		<div id="rstDiv" style="display:none">
			<div class="title" style="margin-top="10px"">
				<div id="title_zi"><span id="sale_name_span"></span>查询结果</div>
			</div>
			<table id="tabList">
				<thead>
					<tr>                           
						<th>业务功能名称</th>
						<th>操作概要</th>
						<th>操作时间</th>
						<th>数据提取结果</th>
						<th>数据提取时间</th>
						<th>文件生成处理结果</th>
						<th>文件名</th>
					</tr>
				</thead>
				<tbody id="fileTbody">
						
				</tbody>
			</table>	
		</div>
		
		<table>
			<tr> 
				<td colspan="4" align="center" id="footer">  
					<input class="b_foot" type=button name="reset_btn" id="reset_btn" value="重置"">
					<input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab();">
				</td>
			</tr>
		</table>
	</div>
</form>
</body>
</html>