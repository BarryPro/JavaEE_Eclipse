<%
  /*
   * 功能: 亲情通（原邦尼老年人服务解决方案）业务
   * 版本: 2.0
   * 日期: 2011/1/5
   * 作者: weigp
   * 版权: si-tech
   * update: wanglma 
   */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%
  request.setCharacterEncoding("GBK");
  String opCode = "d076";
  String opName = "亲情通业务";
  String method = request.getParameter("method");
  String tabData = (request.getParameter("tabData")==null)?"":request.getParameter("tabData");
  /*
  	addRela
  	addFirst
  	addFrid
  	addNaber
  */
%>
<head>
<title>授权定位人信息</title>
<script type="text/javascript">
	$(document).ready(function(){
		if("<%=method%>" == "addRela"){
			$("#div1").css("display","block");
			$("#title_zi").text("授权定位人信息");
			$("#title_zi1").text("授权定位人对老人定位功能是否生效以老人二次确认回复结果为准.");
			if("<%=tabData%>" != ""){
				var tabData = "<%=tabData%>";
				var dataArr = tabData.split("-");
				var relaName = dataArr[0];
				var relaRelation = dataArr[1];
				var relaMobilephone = dataArr[2];
				var relaTelphone = dataArr[3];
				var relaAddress = dataArr[4];
				var relaComPanyTel = dataArr[5];
				var relaCompanyAddr = dataArr[6];
				$("#relaName").val(relaName);
				$("#relaRelation").val(relaRelation);
				$("#relaMobilephone").val(relaMobilephone);
				$("#relaTelphone").val(relaTelphone);
				$("#relaAddress").val(relaAddress);
				$("#relaComPanyTel").val(relaComPanyTel);
				$("#relaCompanyAddr").val(relaCompanyAddr);
			}
		}else if("<%=method%>" == "addFirst"){
			$("#div2").css("display","block");
			$("#title_zi").text("第一联系人信息");
			document.title="第一联系人信息";
			if("<%=tabData%>" != ""){
				var tabData = "<%=tabData%>";
				var dataArr = tabData.split("-");
				var firstName = dataArr[0];
				var firstRelation = dataArr[1];
				var firstMobilephone = dataArr[2];
				var firstTelphone = dataArr[3];
				var firstAddress = dataArr[4];
				var firstPropAddr = dataArr[5];
				var firstCompanyTel = dataArr[6];
				var firstCompanyAddr = dataArr[7];
				$("#firstName").val(firstName);
				$("#firstRelation").val(firstRelation);
				$("#firstMobilephone").val(firstMobilephone);
				$("#firstTelphone").val(firstTelphone);
				$("#firstAddress").val(firstAddress);
				$("#firstPropAddr").val(firstPropAddr);
				$("#firstCompanyTel").val(firstCompanyTel);
				$("#firstCompanyAddr").val(firstCompanyAddr);
			}
		}else if("<%=method%>" == "addFrid"){
			$("#div3").css("display","block");
			$("#title_zi").text("亲友信息");
			document.title="亲友信息";
			if("<%=tabData%>" != ""){
				var tabData = "<%=tabData%>";
				var dataArr = tabData.split("-");
				var secondName = dataArr[0];
				var secondRelation = dataArr[1];
				var secondTelphone = dataArr[2];
				var secondMobilephone = dataArr[3];
				var secondPropAddr = dataArr[4];
				$("#secondName").val(secondName);
				$("#secondRelation").val(secondRelation);
				$("#secondTelphone").val(secondTelphone);
				$("#secondMobilephone").val(secondMobilephone);
				$("#secondPropAddr").val(secondPropAddr);
			}
		}else if("<%=method%>" == "addNaber"){
			$("#div4").css("display","block");
			$("#title_zi").text("邻居信息");
			document.title="邻居信息";
			if("<%=tabData%>" != ""){
				var tabData = "<%=tabData%>";
				var dataArr = tabData.split("-");
				var neighborName = dataArr[0];
				var neighborTelphone = dataArr[1];
				var neighborMobilephone = dataArr[2];
				var neighborPropAddr = dataArr[3];
				$("#neighborName").val(neighborName);
				$("#neighborTelphone").val(neighborTelphone);
				$("#neighborMobilephone").val(neighborMobilephone);
				$("#neighborPropAddr").val(neighborPropAddr);
			}
		}
		//添加亲属信息
		$("#btn1").click(function(){
			if(check(frm1)){
				//if($("#relaName").val()== "" || $("#relaRelation").val() == "" || $("#relaMobilephone").val()== "" || $("#relaTelphone").val()==""|| $("#relaAddress").val()==""|| $("#relaComPanyTel").val()==""||$("#relaCompanyAddr").val()==""){
				if($("#relaName").val()== "" || $("#relaMobilephone").val()== ""){
					rdShowMessageDialog("请输入完整的亲属信息！");
					return;
				}
				validateCustInfo($("#relaName").val(),$("#relaMobilephone").val(),"btn1");
				
			}
		});
		//添加第一联系人信息
		$("#btn2").click(function(){
			if(check(frm1)){
				/*ningtn 关于协助配置亲情通ABC套餐的函 (补充需求)*/
				if($("#firstName").val()==""||$("#firstMobilephone").val()==""){
					rdShowMessageDialog("请输入完整的第一联系人信息！");
					return;
				}
				validateCustInfo($("#firstName").val(),$("#firstMobilephone").val(),"btn2");
				
			}
		});
		//添加亲友联系人
		$("#btn3").click(function(){
			if(check(frm1)){
				if($("#secondName").val()==""||$("#secondMobilephone").val() ==""){
					rdShowMessageDialog("请输入完整的亲友信息！");
					return;
				}
				validateCustInfo($("#secondName").val(),$("#secondMobilephone").val(),"btn3");
				
			}
		});
		//添加邻居联系人
		$("#btn4").click(function(){
			if(check(frm1)){
				if($("#neighborName").val()==""||$("#neighborTelphone").val()==""||$("#neighborMobilephone").val()==""||$("#neighborPropAddr").val()==""){
					rdShowMessageDialog("请输入完整的邻居信息！");
					return;
				}
				validateCustInfo($("#neighborName").val(),$("#neighborMobilephone").val(),"btn4");
				
			}
		});
	});
	
	function validateCustInfo(custName,custMobilePhone,but)
	{	
				var packet = new AJAXPacket("fd076_validateCustInfo.jsp","正在验证客户信息，请稍候......");
			  packet.data.add("custName",custName);
			  packet.data.add("custMobilePhone",custMobilePhone);
			  packet.data.add("but",but);
			  core.ajax.sendPacket(packet,doValidateCustInfo,false);
			  packet = null;			

	}
	
	function doValidateCustInfo(packet){
	  var retCode = packet.data.findValueByName("retCode");
    var retMsg = packet.data.findValueByName("retMsg");
    if (retCode != "000000")
    {
    	rdShowMessageDialog("错误信息："+retMsg+"，错误代码："+retCode+"。",2);
    	return ;
	  }else{
			    var result_long = packet.data.findValueByName("result_long");
			    if(result_long!="0")
			    {
			    	var but = packet.data.findValueByName("but");	
			    	if(but=="btn1")
			    	{
			    		var tab1 = window.opener.document.getElementById("tab1");
							var tabData = "";
							tabData += $("#relaName").val()+"|";
							tabData += $("#relaRelation").val()+"|";
							tabData += $("#relaMobilephone").val()+"|";
							tabData += $("#relaTelphone").val()+"|";
							tabData += $("#relaAddress").val()+"|";
							tabData += $("#relaComPanyTel").val()+"|";
							tabData += $("#relaCompanyAddr").val()+"|";
							tabData += "未生效"+"|";
							/*屏蔽修改按钮
							var dataInfo = tabData;
							dataInfo = dataInfo.replace("|","-").replace("|","-").replace("|","-").replace("|","-").replace("|","-").replace("|","-").replace("|","-").replace("|","-");
							tabData += "<input type='button' class='b_text' value='修改' onclick='this.parentNode.parentNode.parentNode.removeChild(this.parentNode.parentNode),window.open(\"fd076_personInfo.jsp?method=addRela&tabData="+dataInfo+"\",\"家属信息\",\"width=400,height=300,left=400,top=200\");'/>";
							*/
							tabData += "<input type='button' class='b_text' value='删除' onclick='this.parentNode.parentNode.parentNode.removeChild(this.parentNode.parentNode)'/>";
							window.opener.addTr(tab1,9,tabData);
							window.close();
			    	}else if(but=="btn2")
			    		{
			    			var tab2 = window.opener.document.getElementById("tab2");
								var tabData = "";
								tabData += $("#firstName").val()+"|";
								tabData += $("#firstRelation").val()+"|";
								tabData += $("#firstMobilephone").val()+"|";
								tabData += $("#firstTelphone").val()+"|";
								tabData += $("#firstAddress").val()+"|";
								/*tabData += $("#firstPropAddr").val()+"|";*/
								if($("#firstPropAddr").val() == "0"){
									tabData += "是"+"|";
								}else if($("#firstPropAddr").val() == "1"){
									tabData += "否"+"|";
								}
								tabData += $("#firstCompanyTel").val()+"|";
								tabData += $("#firstCompanyAddr").val()+"|";
								tabData += "未生效"+"|";
								/*var dataInfo = tabData;
								dataInfo = dataInfo.replace("|","-").replace("|","-").replace("|","-").replace("|","-").replace("|","-").replace("|","-").replace("|","-").replace("|","-").replace("|","-");
								tabData += "<input type='button' class='b_text' value='修改' onclick='this.parentNode.parentNode.parentNode.removeChild(this.parentNode.parentNode),window.open(\"fd076_personInfo.jsp?method=addFirst&tabData="+dataInfo+"\",\"第一联系人信息\",\"width=400,height=330,left=400,top=200\");'/>";
								*/
								tabData += "<input type='button' class='b_text' value='删除' onclick='this.parentNode.parentNode.parentNode.removeChild(this.parentNode.parentNode)'/>";
								window.opener.addTr(tab2,10,tabData);
								window.close();
			    		}else if(but=="btn3")
			    			{
			    				var tab3 = window.opener.document.getElementById("tab3");
									var tabData = "";
									tabData += $("#secondName").val()+"|";
									tabData += $("#secondRelation").val()+"|";
									tabData += $("#secondTelphone").val()+"|";
									tabData += $("#secondMobilephone").val()+"|";
									/*tabData += $("#secondPropAddr").val()+"|";*/
									if($("#secondPropAddr").val() == "0"){
									  tabData += "是"+"|";
								    }else if($("#secondPropAddr").val() == "1"){
									  tabData += "否"+"|";
								    }
									tabData += "未生效"+"|";
									/*屏蔽修改按钮
									var dataInfo = tabData;
									dataInfo = dataInfo.replace("|","-").replace("|","-").replace("|","-").replace("|","-").replace("|","-").replace("|","-");
									tabData += "<input type='button' class='b_text' value='修改' onclick='this.parentNode.parentNode.parentNode.removeChild(this.parentNode.parentNode),window.open(\"fd076_personInfo.jsp?method=addFrid&tabData="+dataInfo+"\",\"亲人信息\",\"width=400,height=330,left=400,top=200\");'/>";
									*/
									tabData += "<input type='button' class='b_text' value='删除' onclick='this.parentNode.parentNode.parentNode.removeChild(this.parentNode.parentNode)'/>";
									window.opener.addTr(tab3,7,tabData);
									window.close();
			    			}else
			    				{
			    					var tab4 = window.opener.document.getElementById("tab4");
										var tabData = "";
										tabData += $("#neighborName").val()+"|";
										tabData += $("#neighborTelphone").val()+"|";
										tabData += $("#neighborMobilephone").val()+"|";
										/*tabData += $("#neighborPropAddr").val()+"|";*/
										if($("#neighborPropAddr").val() == "0"){
									      tabData += "是"+"|";
								        }else if($("#neighborPropAddr").val() == "1"){
									  	  tabData += "否"+"|";
								        }
										tabData += "未生效"+"|";
										/*屏蔽修改按钮
										var dataInfo = tabData;
										dataInfo = dataInfo.replace("|","-").replace("|","-").replace("|","-").replace("|","-");
										tabData += "<input type='button' class='b_text' value='修改' onclick='this.parentNode.parentNode.parentNode.removeChild(this.parentNode.parentNode),window.open(\"fd076_personInfo.jsp?method=addNaber&tabData="+dataInfo+"\",\"邻居信息\",\"width=400,height=330,left=400,top=200\");'/>";
										*/
										tabData += "<input type='button' class='b_text' value='删除' onclick='this.parentNode.parentNode.parentNode.removeChild(this.parentNode.parentNode)'/>";
										window.opener.addTr(tab4,6,tabData);
										window.close();	
			    				}	    	
			    }else
			    	{
			    		rdShowMessageDialog("该用户手机状态不正常!",2);
			    		return ;
			    	}
	        }

}
</script>
</head>
<body>

	<form name="frm1" method="POST" onKeyUp="chgFocus(frm1)">
		<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
			<div id="title_zi">授权定位人信息</div>
		</div>
		<div class="title">
			<div id="title_zi1" class="blue"></div>
		</div>
		<div id="div1" style="display:none">
		<table cellspacing="0">
			<tr>
				<td class="blue" width="100">姓名</td>
				<td>
					<input type="text" name="relaName" id="relaName" v_type="string" maxlength="15" onblur="checkElement(this)"/>
				</td>
			</tr>
			<tr>
				<td class="blue" width="100">关系</td>
				<td>
					<input type="text" name="relaRelation" id="relaRelation" v_type="string" maxlength="10" />
				</td>
			</tr>
			<tr>
				<td class="blue" width="100">移动电话</td>
				<td>
					<input type="text" name="relaMobilephone" id="relaMobilephone" v_type="mobphone" maxlength="20" onblur="checkElement(this)"/>
				</td>
			</tr>
			<tr>
				<td class="blue" width="100">住所电话</td>
				<td>
					<input type="text" name="relaTelphone" id="relaTelphone" v_type="phone" maxlength="20" />
				</td>
			</tr>
			<tr>
				<td class="blue" width="100">住所地址</td>
				<td>
					<input type="text" name="relaAddress" id="relaAddress" v_type="string" size="40" maxlength="100" />
				</td>
			</tr>
			<tr>
				<td class="blue" width="100">单位电话</td>
				<td>
					<input type="text" name="relaCompanyTel" id="relaComPanyTel" v_type="phone" maxlength="20" />
				</td>
			</tr>
			<tr>
				<td class="blue" width="100">单位地址</td>
				<td>
					<input type="text" name="relaCompanyAddr" id="relaCompanyAddr" v_type="string" size="40" maxlength="100" />
				</td>
			</tr>
			<tr>
					<td align="center" id="footer" colspan="2">
					<input type="button" value="确定" class="b_foot" id="btn1"/>
					<input type="reset" value="重置" class="b_foot"/>
				</td>
			</tr>
		</table>
		</div>
		<div id="div2" style="display:none">
		<table cellspacing="0">
			<tr>
				<td class="blue" width="110">第一联系人姓名</td>
				<td>
					<input type="text" name="firstName" id="firstName" v_type="string" maxlength="15" onblur="checkElement(this)"/>
				</td>
			</tr>
			<tr>
				<td class="blue" width="110">联系人关系</td>
				<td>
					<input type="text" name="firstRelation" id="firstRelation" v_type="string" maxlength="10" onblur="checkElement(this)"/>
				</td>
			</tr>
			<tr>
				<td class="blue" width="110">联系人移动电话</td>
				<td>
					<input type="text" name="firstMobilephone" id="firstMobilephone" v_type="mobphone" maxlength="20" onblur="checkElement(this)"/>
				</td>
			</tr>
			<tr>
				<td class="blue" width="110">联系人住所电话</td>
				<td>
					<input type="text" name="firstTelphone" id="firstTelphone" v_type="phone" maxlength="20" onblur="checkElement(this)"/>
				</td>
			</tr>
			<tr>
				<td class="blue" width="110">联系人住所地址</td>
				<td>
					<input type="text" name="firstAddress" id="firstAddress" v_type="string" size="40" maxlength="100" onblur="checkElement(this)"/>
				</td>
			</tr>
			<tr>
				<td class="blue" width="110">是否对申请人定位</td>
				<td>
					<select name="firstPropAddr" id="firstPropAddr" style="width:135px">
						<option value="0">是</option>
						<option value="1">否</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="blue" width="110">联系人单位电话</td>
				<td>
					<input type="text" name="firstCompanyTel" id="firstCompanyTel" v_type="phone" maxlength="20" onblur="checkElement(this)"/>
				</td>
			</tr>
			<tr>
				<td class="blue" width="110">联系人单位地址</td>
				<td>
					<input type="text" name="firstCompanyAddr" id="firstCompanyAddr" v_type="string" size="40" maxlength="100" onblur="checkElement(this)"/>
				</td>
			</tr>
			<tr>
					<td align="center" id="footer" colspan="2">
					<input type="button" value="确定" class="b_foot" id="btn2"/>
					<input type="reset" value="重置" class="b_foot"/>
				</td>
			</tr>
		</table>
		</div>
		<div id="div3" style="display:none">
			<table cellspacing="0">
				<tr>
					<td class="blue" width="110">亲友姓名</td>
					<td>
						<input type="text" name="secondName" id="secondName" v_type="string" maxlength="15" onblur="checkElement(this)"/>
					</td>
				</tr>
				<tr>
					<td class="blue" width="110">与申请人关系</td>
					<td>
						<input type="text" name="secondRelation" id="secondRelation" v_type="string" maxlength="10" onblur="checkElement(this)"/>
					</td>
				</tr>
				<tr>
					<td class="blue" width="110">亲友固话</td>
					<td>
						<input type="text" name="secondTelphone" id="secondTelphone" v_type="phone" maxlength="20" onblur="checkElement(this)"/>
					</td>
				</tr>
				<tr>
					<td class="blue" width="110">亲友移动电话</td>
					<td>
						<input type="text" name="secondMobilephone" id="secondMobilephone" v_type="mobphone" maxlength="20" onblur="checkElement(this)"/>
					</td>
				</tr>

				<tr>
					<td class="blue" width="110">是否对申请人定位</td>
					<td>
						<select name="secondPropAddr" id="secondPropAddr" style="width:135px">
							<option value="0">是</option>
							<option value="1">否</option>
						</select>
					</td>
				</tr>
				<tr>
					<td align="center" id="footer" colspan="2">
						<input type="button" value="确定" class="b_foot" id="btn3"/>
						<input type="reset" value="重置" class="b_foot"/>
					</td>
				</tr>
			</table>
		</div>
		<div id="div4" style="display:none">
			<table cellspacing="0">
				<tr>
					<td class="blue" width="110">邻居姓名</td>
					<td>
						<input type="text" name="neighborName" id="neighborName" v_type="string" maxlength="15" onblur="checkElement(this)"/>
					</td>
				</tr>
				<tr>
					<td class="blue" width="110">邻居固话</td>
					<td>
						<input type="text" name="neighborTelphone" id="neighborTelphone" v_type="phone" maxlength="20" onblur="checkElement(this)"/>
					</td>
				</tr>
				<tr>
					<td class="blue" width="110">邻居移动电话</td>
					<td>
						<input type="text" name="neighborMobilephone" id="neighborMobilephone" v_type="mobphone" maxlength="20" onblur="checkElement(this)"/>
					</td>
				</tr>

				<tr>
					<td class="blue" width="110">是否对申请人定位</td>
					<td>
						<select name="neighborPropAddr" id="neighborPropAddr" style="width:135px">
							<option value="0">是</option>
							<option value="1">否</option>
						</select>
					</td>
				</tr>
				<tr>
					<td align="center" id="footer" colspan="2">
						<input type="button" value="确定" class="b_foot" id="btn4"/>
						<input type="reset" value="重置" class="b_foot"/>
					</td>
				</tr>
			</table>
		</div>
		<%@ include file="/npage/include/footer_simple.jsp" %>
	</form>
</body>
</html>