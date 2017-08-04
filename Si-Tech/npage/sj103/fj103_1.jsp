<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by wangwg @ 20150511
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%
	String opCode = "J103";
	String opName = "平安互助群组";
	String workNo = (String)session.getAttribute("workNo");
    String workName = (String)session.getAttribute("workName");
    String regionCode=(String)session.getAttribute("regCode");
    String op_name =  "平安互助群组";
%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD>
		<TITLE><%=op_name%></TITLE>
		<script language=javascript>
		function doProcess(packet)
		{
			var error_code = packet.data.findValueByName("errorCode");
			var error_msg =  packet.data.findValueByName("errorMsg");
			var verifyType = packet.data.findValueByName("verifyType");
			if(verifyType=="phoneno")
			{
				if( parseInt(error_code) == 0 ){
					document.form.sure.disabled=false;
					document.form.reset.disabled=false;
					var als = document.getElementById("ViewMsg").children[0];
					if(als.firstChild!=null)
						als.removeChild(als.firstChild);
					var backArrMsg  =       packet.data.findValueByName("backArrMsg");
					var trTemp = document.getElementById("ViewMsg").children[0].insertRow();
					trTemp.insertCell().innerHTML ="<input class='InputGrey' readonly value='群组名称'></input>";
					trTemp.insertCell().innerHTML ="<input class='InputGrey' readonly value='群组归属组织架构'></input>";
					trTemp.insertCell().innerHTML ="<input class='InputGrey' readonly value='成员手机号码'></input>";
					trTemp.insertCell().innerHTML ="<input class='InputGrey' readonly value='成员姓名'></input>";
					trTemp.insertCell().innerHTML ="<input class='InputGrey' readonly value='成员角色描述'></input>";
					trTemp.insertCell().innerHTML ="<input class='InputGrey' readonly value='操作时间'></input>";
					for(var i=0;i <backArrMsg.length;i++)
                    {
						var trTemp = document.getElementById("ViewMsg").children[0].insertRow();
						trTemp.insertCell().innerHTML = 
							"<input type='text' class='InputGrey' size='10' readonly value='"+backArrMsg[i][5]+"' />";
						trTemp.insertCell().innerHTML = 
							"<input type='text' class='InputGrey' size='20' readonly value='"+backArrMsg[i][6]+"' />";
						trTemp.insertCell().innerHTML = 
							"<input type='text' class='InputGrey' size='20' readonly value='"+backArrMsg[i][1]+"' />";
						trTemp.insertCell().innerHTML = 
							"<input type='text' class='InputGrey' size='20' readonly value='"+backArrMsg[i][3]+"' />";
						trTemp.insertCell().innerHTML = 
							"<input type='text' class='InputGrey' size='20' readonly value='"+backArrMsg[i][4]+"' />";
						trTemp.insertCell().innerHTML = 
							"<input type='text' class='InputGrey' size='20' readonly value='"+backArrMsg[i][7]+"' />";
					}
					
				}
				else
				{
						rdShowMessageDialog("<br>错误代码:["+error_code+"]</br>错误信息:["+error_msg+"]",0);
				}
			}
		}
		function doCfm()
		{
			if(document.form.qryvalue.value.length<1)
			{
				rdShowMessageDialog("查询参数错误,请重新输入",0);
				document.form.qryvalue.focus();
				return false;
			}
			else 
			{
				var radios = document.getElementsByName("busyType1");
				var radioButtonVal = "PHONENO";
				var queryvalue = document.form.qryvalue.value;
				for(var i=0;i<radios.length;i++)
				{
					if(radios[i].checked)
					{
						radioButtonVal = radios[i].value;
					}
				}
				form.radiovalue.value=radioButtonVal;
				document.form.sure.disabled=true;
				document.form.reset.disabled=true;
				
				var myPacket = new AJAXPacket("fj103_Qry.jsp","正在确认，请稍候......");
				myPacket.data.add("verifyType","phoneno");
				myPacket.data.add("radiovalue",radioButtonVal);
				myPacket.data.add("queryvalue",queryvalue);
				core.ajax.sendPacket(myPacket);
				myPacket=null;
			}
		}
		</script>
	</HEAD>
	<BODY>
		<FORM action="fj103_2.jsp" method=post name=form>
		<%@ include file="/npage/include/header.jsp"%>
		<div class="title">
			<div id="title_zi">平安互助群组</div>
		</div>
		<table cellspacing="0">
			<tbody>
				<tr>
					<td class="blue" width="15%">查询类型</td>
					<td colspan="3">
						<q vType="setNg35Attr">
							<input name="busyType1" id="sl1" type="radio" value="PHONENO" checked>
							手机号所在群组（查询条件为手机号）
						</q>
						<q vType="setNg35Attr">
							<input name="busyType1" id="sl2" type="radio" value="GROUPNAME" >
							群组所有成员（查询条件为群组名称）
						</q>
					</td>
				</tr>
				<tr>
					<td class="blue" width="15%">查询参数</td>
					<td colspan="3">
						<input name=qryvalue size=60 maxlength="60" >
					</td>
				</tr>
			</tbody>
		</table>
		<div id="MemDiv">
			<div class="title">
				<div id="title_zi">查询结果</div>
			</div>
			<div id="ViewMsg">
			<table cellSpacing="0">
				</table>
			</div>
		</div>
		<table  cellspacing="0">
			<tbody> 
				<tr> 
					<td id="footer" > 
						<input class="b_foot" name=sure type=button value=查询 onClick="doCfm()">
						<input class="b_foot" name=reset type=reset value=关闭 onClick="removeCurrentTab()">
					</td>
				</tr>
			</tbody>
		</table>
		<input type="hidden" name="radiovalue"  value="">
	</FORM>
	</BODY>
</html>
