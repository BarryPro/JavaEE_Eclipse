<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * 功能: 接触时间定义
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

	String opCode = "K313";
	String opName = "接触时间定义";
  request.setCharacterEncoding("gb2312");
  String sql = "";

	String workNo = (String)session.getAttribute("workNo");
	String opType = request.getParameter("op").trim();
	String id = new String();
	String title = new String();
	
	String mintime = "00:00:00";
	String maxtime = "23:59:59";
	String getcount = new String();
	String description = new String();
	String getCountResult = request.getParameter("getCountResult").trim();
	String getTCResult = request.getParameter("getTCResult").trim();
	String readonly = new String();
	if(opType.equals("add")){
		title = "新增";		
		sql = "select to_char(SEQ_dserialnotime.nextval) from dual";
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
		
		mintime = request.getParameter("mintime");
		maxtime = request.getParameter("maxtime");
		description = request.getParameter("description");
		getcount = request.getParameter("getcount");
		
	}
%>
<html>
	<head>
		<title>接触时间<%=title%></title> 
		
		<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>
		
		<script language="javascript">
			function modCfm(){
				var mintime = document.form1.mintime.value;
				var maxtime = document.form1.maxtime.value;
				if(mintime == ""){
					similarMSNPop("请输最小时间！");
					document.form1.mintime.select();
					return;
				}
				if(maxtime == ""){
					similarMSNPop("请输最大时间！");
					document.form1.maxtime.select();
					return;
				}
				var timeJudge =/^(0\d{1}|1\d{1}|2[0-3]):[0-5]\d{1}:([0-5]\d{1})$/;
				//var timeJudge = /^[2][0-3]|[0-1](\d):[0-5](\d):[0-5](\d)$/;
				if(!(timeJudge.test(mintime))){
					similarMSNPop("最小时间输入格式不对，请输入正确格式！");
					document.form1.mintime.select();
					return;
				}
				if(!(timeJudge.test(maxtime))){
					similarMSNPop("最大时间输入格式不对，请输入正确格式！");
					document.form1.maxtime.select();
					return;
				}
				//判断时间大小最小时间不能超过最大时间
				var arr1 = mintime.split(":");
				var arr2 = maxtime.split(":");
				for(var i=0; i<arr1.length; i++){
					if(parseInt(arr2[i],10) > parseInt(arr1[i],10)){
							break;
					}
					if(parseInt(arr2[i],10) == parseInt(arr1[i],10)){
							continue;
					}else{
							similarMSNPop("最小时间不能大于最大时间！");
							return;
					}
				}
				if(document.form1.getcount.value == ""){
					similarMSNPop("请输入条数！");
					document.form1.getcount.select();
					return;
				}
				
				var   r   =   /^\+?[1-9][0-9]*$/;
				var count = document.form1.getcount.value;
				if(!r.test(count)){
					similarMSNPop("条数只能是正整数！ ");
					return;
				}
				if(parseInt(count)>1000){
					similarMSNPop("抽取条数不能超过1000！");
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
				
				var myPacket = new AJAXPacket("K313I_AddMod.jsp","正在提交，请稍候......");
				myPacket.data.add("retType","<%=opType%>");
				myPacket.data.add("id","<%=id%>");
				myPacket.data.add("mintime",trim(document.form1.mintime.value));
				myPacket.data.add("maxtime",trim(document.form1.maxtime.value));
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
					window.returnValue =retCode+"~"+<%=id%>+"~"+trim(document.form1.mintime.value)+"~"+trim(document.form1.maxtime.value)+"~"+trim(document.form1.getcount.value)+"~"+trim(document.form1.description.value) ;
					setTimeout("window.close()",2500);			
				}
				else{
					similarMSNPop(retMsg+ "[" + retCode + "]");
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
			<!--%@ include file="/npage/include/header.jsp" %-->	
			<div id="Main">
			<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
			  <tr>
			    <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="LeftFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeft.jpg" width="20" height="75" /></td>
				<td valign="top">
				<div id="Operation_Title"><B>接触时间定义</B></div>
    <div id="Operation_Table">
				<div class="title"><div id="title_zi">接触时间</div> </div>
				<table cellspacing="0">
					<tr>
						<td>
							<div align="right" class="blue" >最小时间</div>
						</td>
						<td  class="blue" >
							<div align="left"><input type="text" name="mintime" value="<%=mintime%>" maxlength="8"  />&nbsp;&nbsp;<font color="red">(格式：00:00:00)</font></div>
						</td>
					</tr>
					<tr>
						<td>
							<div align="right" class="blue" >最大时间</div>
						</td>
						<td  class="blue" >
							<div align="left"><input type="text" name="maxtime" value="<%=maxtime%>" maxlength="8"  />&nbsp;&nbsp;<font color="red">(格式：00:00:00)</font></div>
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
						<td style="border-right:0px;border-bottom:0px">
							<div align="right" class="blue" >描述</div>
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
