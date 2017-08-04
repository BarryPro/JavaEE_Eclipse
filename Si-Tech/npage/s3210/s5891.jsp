<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	/*
	 * 功能: 综合V网成员查询
	 * 版本: v1.0
	 * 日期: 2009年08月06日
	 * 作者: wangzn
	 * 版权: sitech
	 */
%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page contentType="text/html; charset=GBK"%>
<%
	response.setHeader("Pragma", "No-Cache");
	response.setHeader("Cache-Control", "No-Cache");
	response.setDateHeader("Expires", 0);
	String workName = (String) session.getAttribute("workName");
	String ipAddr = (String) session.getAttribute("ipAddr");
	String orgCode = (String) session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0, 2);
	String districtCode = orgCode.substring(2,4);
	String opCode = "5891";
	String opName = "综合V网成员查询";
	String sqlStr = "";
%>

<HTML xmlns="http://www.w3.org/1999/xhtml">
<html>

	<link href="s2002.css" rel="stylesheet" type="text/css">
	<script language="JavaScript">

	function doProcess(packet){
		
		error_code = packet.data.findValueByName("errorCode");
		error_msg  = packet.data.findValueByName("errorMsg");
		verifyType = packet.data.findValueByName("verifyType");
		var backArrMsg = packet.data.findValueByName("backArrMsg");     
		self.status="";
		if(verifyType=="GroupNo"){
			if(backArrMsg==""){
				rdShowMessageDialog("非综合V网集团",0);
				document.getElementById('nextoper').disabled = true;		
			}else{
				var temp = backArrMsg+"";
				
				var region_code = temp.split(",")[1];
				var district_code = temp.split(",")[2];
				if(region_code != '<%=regionCode%>' || district_code !='<%=districtCode%>' ){
					rdShowMessageDialog("你没有权限查看该集团!",0);
				  document.getElementById('nextoper').disabled = true;	
				  return;	
				}
				document.getElementById('nextoper').disabled = false;
				document.getElementById('group_no').readOnly="readOnly";
			}	
		}
	}

	function checkGroupNo()
	{
		var myPacket = new AJAXPacket("s5891_1.jsp","正在检验group_no，请稍候......");				      			    
		var groupNo = document.getElementById('group_no').value.trim();
		if(groupNo==""){
				     	rdShowMessageDialog("集团编号不能为空",0);
				     	document.getElementById('nextoper').disabled = true;
				     	return false;
		}
		myPacket.data.add("groupNo",groupNo);
		myPacket.data.add("verifyType","GroupNo");
		core.ajax.sendPacket(myPacket);	
		myPacket=null;	
	}
	function disInfo(){
		var but = document.getElementById('nextoper');
		if(but.disabled){
			//验证为通过，可以添加一些提示信息，说明“下一步”在验证成功后生效。
		}
	}
</script>
	</head>
	<body>
		<form name="form1" method="post" action="s5891_2.jsp">
			<input type="hidden" name="pageOpCode" value="<%=opCode%>">
			<input type="hidden" name="pageOpName" value="<%=opName%>">
			<input type="hidden" id="grpIdNo" name="grpIdNo" value="">
			<input type="hidden" name="productSpecNum" value=""><%@ include
				file="/npage/include/header.jsp"%>
			<div class="title">
				<div id="title_zi">
					查询条件
				</div>
			</div>
			<table cellSpacing=0>
				<tr>
					<td class="blue" width="15%">
						集团编号
					</td>
					<td width="35%">
						<input name="group_no" id="group_no" v_type="string" v_must="1"
							size="20" maxlength="20">
						<font class="orange">*</font>
						<input name="CustomerNumberQuery" type="button" class="b_text"
							onclick="checkGroupNo()" id="getCustomerNumberBtn" value="验证">
					</td>
					<td class="blue" width="15%">
						运营商类型
					</td>
					<td width="35%">
						<select name=phone_type id=phone_type>
							<option value=0>
								移动
							</option>
							<option value=1>
								铁通
							</option>
						</select>
						<input type="hidden" value="" name="orderSourceName">
					</td>
				</tr>

				
				<tr style="display: none">
				<td class="blue" rowspan="4" colspan="2" align="center">列表属性显示</td>
				<td class="blue"><input type="checkbox" name="disProperty" value="region">地市</td><td class="blue"><input type="checkbox" name="disProperty" value="district">区县</td>
				</tr>
				<tr style="display: none">
				<td class="blue"><input type="checkbox" name="disProperty" value="service_no">客户经理</td><td class="blue"><input type="checkbox" name="disProperty" value="group_id">集团编号</td>
				</tr>
				<tr style="display: none">
				<td class="blue"><input type="checkbox" name="disProperty" value="group_name">集团名称</td><td class="blue"><input type="checkbox" name="disProperty" value="field_value">综合V网类型</td>
				</tr>
				<tr style="display: none">
				<td class="blue"><input type="checkbox" name="disProperty" vaule="phone_no">手机号码</td><td class="blue">&nbsp;</td>
				</tr>
				
				
				<tr>
					<td align="center" id="footer" colspan="4">
						<a onmouseover="disInfo();"><input class="b_foot" name=next id=nextoper type=submit
							value="下一步" disabled></input></a>
						<input class="b_foot" name=res id=res type="reset"
							value="重置"
							onclick="document.getElementById('group_no').readOnly=false;document.getElementById('nextoper').disabled = true;"></input>
						<input class="b_foot" name=reset type=button value="关闭"
							onClick="removeCurrentTab()" />
					</td>
				</tr>
			</table>
			<%@ include file="/npage/include/footer.jsp"%>
		</form>
	</body>
</html>
