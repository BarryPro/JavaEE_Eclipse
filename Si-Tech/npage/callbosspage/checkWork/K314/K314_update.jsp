<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * 功能: 接触时长定义
   * 版本: 1.0
   * 日期: 
   * 作者: 
   * 版权: si-tech
  */
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  /*midify by guozw 20091114 公共查询服务替换*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

	String opCode = "K314";
	String opName = "接触时长定义";
  request.setCharacterEncoding("gb2312");
  String sql = "";

	String workNo = (String)session.getAttribute("workNo");
	String opType = request.getParameter("op").trim();
	String id = new String();
	String title = new String();
	
	String minlength = new String();
	String maxlength = new String();
	String getcount = new String();
	String description = new String();
	String getCountResult = request.getParameter("getCountResult").trim();
	String getTCResult = request.getParameter("getTCResult").trim();
	String readonly = new String();
	if(opType.equals("add")){
		title = "新增";
		
		sql = "select to_char(SEQ_dserialnodate.nextval) from dual";
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="3">
		<wtc:param value="<%=sql%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>		
<%
		id = result[0][0];
	}else{
		title = "修改";
		id = request.getParameter("id");
		
		minlength = request.getParameter("minlength");
		maxlength = request.getParameter("maxlength");
		description = request.getParameter("description");
		getcount = request.getParameter("getcount");
		
	}
%>
<html>
	<head>
		<title>接触时长<%=title%></title> 
		
		<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>
		
		<script language="javascript">
			function modCfm(){
				if(document.form1.minlength.value == ""){
					similarMSNPop("请输入最小时长！");
					document.form1.minlength.select();
					return;
				}
				if(document.form1.maxlength.value == ""){
					similarMSNPop("请输入最大时长！");
					document.form1.maxlength.select();
					return;
				}
				if(document.form1.getcount.value == ""){
					similarMSNPop("请输入条数！");
					document.form1.getcount.select();
					return;
				}
				var   r   =   /^\+?[1-9][0-9]*$/;
				var count1 = document.form1.minlength.value;
				var count2 = document.form1.maxlength.value;
				var count = document.form1.getcount.value;
				if(!r.test(count1) && parseInt(count1) != 0){
					similarMSNPop("最小时长只能是0或正整数！ ");
					return;
				}
				if(!r.test(count2)){
					similarMSNPop("最大时长只能是正整数！ ");
					return;
				}
				if(parseInt(count1)>parseInt(count2)){
					similarMSNPop("最小时长不能大于最大时长！");
					return;
				}
				if(parseInt(count1)>10000){
					similarMSNPop("最小时长不能大于10000！ ");
					return;
				}
				if(parseInt(count2)>10000){
					similarMSNPop("最大时长不能大于10000！ ");
					return;
				}
				if(!r.test(count)){
					similarMSNPop("条数只能是正整数！ ");
					return;
				}
				opType = '<%=opType%>';
				var getCountResult = '<%=getCountResult%>';
				var getTCResult = '<%=getTCResult%>';
				var tmpCount;
				if("add" == opType){
						tmpCount = parseInt(getTCResult) + parseInt(document.form1.getcount.value);
						if(tmpCount>parseInt(getCountResult)){
								var tNum = parseInt(getCountResult)-parseInt(getTCResult);
								similarMSNPop("设置条数超过总条数,目前允许增加的最大条数为【"+tNum+"条】");
								return;
						}
				}else{
					var getNum = '<%=getcount%>';
					tmpCount = parseInt(getTCResult) + parseInt(document.form1.getcount.value)-parseInt(getNum);
					if(tmpCount>parseInt(getCountResult)){
								var tNum = parseInt(getCountResult)-parseInt(getTCResult)+parseInt(getNum);
								similarMSNPop("设置条数超过总条数,目前允许设置的最大条数为【"+tNum+"条】");
								return;
						}
				}		
				
				var myPacket = new AJAXPacket("K314I_AddMod.jsp","正在提交，请稍候......");
				myPacket.data.add("retType","<%=opType%>");
				myPacket.data.add("id","<%=id%>");
				myPacket.data.add("minlength",trim(document.form1.minlength.value));
				myPacket.data.add("maxlength",trim(document.form1.maxlength.value));
				myPacket.data.add("getcount",trim(document.form1.getcount.value));
				myPacket.data.add("description",trim(document.form1.description.value));
				core.ajax.sendPacket(myPacket,doProcess,true);
				myPacket=null;
			
			}
			
			function doProcess(packet){
				var retType = packet.data.findValueByName("retType");		
				var retCode = packet.data.findValueByName("retCode");
				var retMsg = packet.data.findValueByName("retMsg");	
				if(retCode=='000000'){
					similarMSNPop("操作成功" + "[" + retCode + "]");
					window.returnValue =retCode+"~"+<%=id%>+"~"+trim(document.form1.minlength.value)+"~"+trim(document.form1.maxlength.value)+"~"+trim(document.form1.getcount.value)+"~"+trim(document.form1.description.value) ;
					setTimeout("window.close()",2500);
					//window.close();
				}
				else
				{
					similarMSNPop(retMsg + "[" + retCode + "]");
					window.returnValue =retCode+ "" ;
					//window.close();
				}
			}			
			
			function ltrim(s){
			 return s.replace( /^\s*/, ""); 
			} 
			function rtrim(s){
			 return s.replace( /\s*$/, ""); 
			} 
			function trim(s){
			 return rtrim(ltrim(s)); 
			}		
		</script>
	</head>
	<body>
		<form name="form1" method="POST">
			<div id="Main">
			<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
			  <tr>
			    <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="LeftFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeft.jpg" width="20" height="75" /></td>
				<td valign="top">
				<div id="Operation_Title"><B>接触时长定义</B></div>
    		<div id="Operation_Table" >
			<!--%@ include file="/npage/include/header.jsp" %-->	
				<div class="title"><div id="title_zi">接触时长</div> </div>
				<table cellspacing="0">
					<tr>
						<td>
							<div align="right" class="blue" >最小时长</div>
						</td>
						<td >
							<div align="left"><input type="text" name="minlength" value="<%=minlength%>" maxlength="8"  /></div>
						</td>
					</tr>
					<tr>
						<td>
							<div align="right"  class="blue" >最大时长</div>
						</td>
						<td>
							<div align="left"><input type="text" name="maxlength" value="<%=maxlength%>" maxlength="8"  /></div>
						</td>
					</tr>
					<tr>
						<td>
							<div align="right" class="blue" >条数</div>
						</td>
						<td>
							<div align="left"><input type="text" name="getcount" value="<%=getcount%>" maxlength="4"  /></div>
						</td>
					</tr>
					<tr>
						<td style="border-right:0px;border-bottom:0px"  class="blue" >
							<div align="right">描述</div>
						</td>
						<td>
							<div align="left" style="border-bottom:0px">&nbsp;&nbsp;</div>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<div align="center"><textarea name="description" cols="40" rows="5"><%=description%></textarea></div>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<div align="center">
								<input type="button" name="cfm" class="b_foot" value="确认" onclick="modCfm()"/>
								<input type="button" name="clo" class="b_foot" value="关闭" onclick="javascript:window.close();"/>
							</div>
						</td>
					</tr>
				</table>
			<!--%@ include file="/npage/include/footer.jsp" %-->
			<br/>          
			  </td>
			  <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="RightFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerRight.jpg" width="20" height="45" /></td>
			</tr>
			      
			<tr>
			  <td><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeftDown.gif" width="20" height="20" /></td>
			  <td valign="bottom">
			  <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#D8D8D8">
			    <tr>
			      <td height="1"></td>
			    </tr>
			  </table>
			  </td>
			  <td><img src="<%=request.getContextPath()%>/nresources/default/images/CornerRightDown.gif" width="20" height="20" /></td>
			</tr>
		</table>
		</form>
	</body>
</html>
