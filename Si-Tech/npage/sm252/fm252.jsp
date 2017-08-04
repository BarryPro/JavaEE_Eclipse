 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:2015/3/26 17:09:31 ningtn
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode=request.getParameter("opCode");	
	String opName=request.getParameter("opName");

	String workno = (String)session.getAttribute("workNo");
	String regioncode=(String)session.getAttribute("regCode");
	String noPass = (String)session.getAttribute("password");
	String orgcode = (String)session.getAttribute("orgCode");
  String dateStr=new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
  String regionCode= (String)session.getAttribute("regCode");


%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regioncode%>"  id="sysAccept" />
	
<HEAD>
		<TITLE><%=opName%></TITLE>
		<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
		<script language="JavaScript">
			var china=new Array('北京市','上海市','天津市','重庆市','河北省','山西省','辽宁省','吉林省','黑龙江省','江苏省','浙江省','安徽省','福建省','江西省','山东省','河南省','湖北省','湖南省','广东省','海南省','四川省','贵州省','云南省','陕西省','甘肃省','青海省','台湾省','广西壮族自治区','内蒙古自治区','西藏自治区','宁夏回族自治区','新疆维吾尔自治区','香港特别行政区');
			var oldCard,newCard = "";
			$(document).ready(function(){
				$(":radio").click(function(){
					var cardType = $(this).val();
					if(cardType == "dis"){
						$("#con").hide();
						$("#dis").show();
					}else if(cardType == "con"){
						$("#dis").hide();
						$("#con").show();
					}
				});
				
				$("#clearBtn").click(function(){doclear();});
				
				$("#cfm").click(function(){
					if(!checkForm()){
						return false;
					}
					
					var cardType = $('input[@name=cardType][@checked]').val();
					
					var input21 = "";
					if(cardType == "dis"){
						oldCard = oldCard.substring(0,oldCard.length - 1);
						newCard = newCard.substring(0,newCard.length - 1);
						input21 = "0";
					}else if(cardType == "con"){
						oldCard = $("#oldCardBegin").val() + "|" + $("#oldCardEnd").val();
						newCard = $("#newCardBegin").val() + "|" + $("#newCardEnd").val();
						input21 = "1";
					}
					
					/*调用提交服务*/
					var getdataPacket = new AJAXPacket("/npage/sm252/fm252Cfm.jsp","正在获得数据，请稍候......");
					getdataPacket.data.add("serviceName","sm252Cfm");
					getdataPacket.data.add("outnum","0");
					getdataPacket.data.add("inputParamsLength","22");
					getdataPacket.data.add("inParams0",$("#sysAccept").val());
					getdataPacket.data.add("inParams1","01");
					getdataPacket.data.add("inParams2","<%=opCode%>");
					getdataPacket.data.add("inParams3","<%=workno%>");
					getdataPacket.data.add("inParams4","<%=noPass%>");
					getdataPacket.data.add("inParams5","");
					getdataPacket.data.add("inParams6","");
					/*旧卡*/
					getdataPacket.data.add("inParams7",oldCard);
					/*新卡*/
					getdataPacket.data.add("inParams8",newCard);
					getdataPacket.data.add("inParams9",$("#isUse").val());
					getdataPacket.data.add("inParams10",$("#isOpen").val());
					getdataPacket.data.add("inParams11",$("#complaintAccept").val());
					getdataPacket.data.add("inParams12",$("#compName").val());
					getdataPacket.data.add("inParams13",$("#orderNo").val());
					getdataPacket.data.add("inParams14",$("#postage").val());
					getdataPacket.data.add("inParams15",$("#prov").val());
					getdataPacket.data.add("inParams16",$("#contactName").val());
					getdataPacket.data.add("inParams17",$("#contactPhoneNo").val());
					getdataPacket.data.add("inParams18",$("#cardNo").val());
					getdataPacket.data.add("inParams19",$("#receiveDate").val());
					getdataPacket.data.add("inParams20",$("#remark").val());
					getdataPacket.data.add("inParams21",input21);
					core.ajax.sendPacket(getdataPacket,doCfmBack);
					getdataPacket = null;
					
				});
				
				function doCfmBack(packet){
		      var retcode = packet.data.findValueByName("retcode");
		      var retmsg = packet.data.findValueByName("retmsg");
		      if(retcode == "000000"){
		        rdShowMessageDialog("操作成功",2);
		      }else{
		      	rdShowMessageDialog("提交失败！错误代码：" + retcode + "，错误信息：" + retmsg,0);
		      }
		      doclear();
		    }
		    
		    function doclear(){
		    	window.location.href = "fm252.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
		    }
				
				function checkForm(){
					/****/
					if(!check(document.frm)){
						return false;
					}
					
					var cardType = $('input[@name=cardType][@checked]').val();
					if(cardType == "dis"){
						//离散，至少填写一对
						oldCard = "";
						newCard = "";
						var chkFlag = true;
						var len = 0;
						$("#dis").find("tr:gt(0)").each(function(i,n){
							var f = $.trim($(this).find(":input:eq(0)").val());
							var s = $.trim($(this).find(":input:eq(1)").val());
							
							if((f != "" && s == "") || (f == "" && s != "")){
								chkFlag = false;
								rdShowMessageDialog("第" + (i+1) + "行的新旧卡号必须要一一对应。",0);
								return false;
							}else if(f != "" && s != ""){
								len++;
								var reg = new RegExp("^[0-9]+$");
					    	if(!reg.test(f)){
					    		chkFlag = false;
					      	rdShowMessageDialog("第" + (i+1) + "行旧卡号请输入数字!",0);
					    	}
					    	if(!reg.test(s)){
					    		chkFlag = false;
					      	rdShowMessageDialog("第" + (i+1) + "行新卡号请输入数字!",0);
					    	}
					    	if(chkFlag){
					    		//没问题
					    		oldCard += f + "|";
					    		newCard += s + "|";
					    	}
							}
						});
						
						if(chkFlag && len == 0){
							chkFlag = false;
							rdShowMessageDialog("请至少输入一对新旧卡号。",0);
							return false;
						}
						if(!chkFlag){
							return false;
						}
					}else if(cardType == "con"){
						var chkFlag = true;
						//连续，四个框都必须填写。并且数量一致。
						var oldCardBegin 	= $("#oldCardBegin").val();
						var oldCardEnd 		= $("#oldCardEnd").val();
						var newCardBegin 	= $("#newCardBegin").val();
						var newCardEnd 		= $("#newCardEnd").val();
						var reg = new RegExp("^[0-9]+$");
						
						if(!reg.test(oldCardBegin)){
							chkFlag = false;
							rdShowMessageDialog("旧开始卡号请输入数字!",0);
						}else if(!reg.test(oldCardEnd)){
							chkFlag = false;
							rdShowMessageDialog("旧结束卡号请输入数字!",0);
						}else if(!reg.test(newCardBegin)){
							chkFlag = false;
							rdShowMessageDialog("新开始卡号请输入数字!",0);
						}else if(!reg.test(newCardEnd)){
							chkFlag = false;
							rdShowMessageDialog("新结束卡号请输入数字!",0);
						}
						
						if(!chkFlag){
							return false;
						}
					}
					
					return true;
				}
			});
		</script>
</HEAD>
<BODY >
	<FORM action="" method=post name="frm" ENCTYPE="multipart/form-data">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<input type="hidden" name="sysAccept" id="sysAccept" value="<%=sysAccept%>"> 
	
	<table cellspacing="0">
		<tr>
			<td class="blue">旧卡是否刮开</td>
			<td>
				<select id="isOpen">
					<option value="0">未刮</option>
					<option value="1">已刮</option>
				</select>
				<font class=orange>*</font>
			</td>
			<td class="blue">旧卡是否充值</td>
			<td>
				<select id="isUse">
					<option value="1">已充</option>
					<option value="0">未充</option>
				</select>
				<font class=orange>*</font>
			</td>
			<td class="blue">投诉流水号</td>
			<td>
				<input type="text" id="complaintAccept" maxlength="20" v_must="1" 
						v_type="string" onblur="checkElement(this)"/>
				<font class=orange>*</font>
			</td>
		</tr>
		<tr>
			<td class="blue">外省邮寄订单号</td>
			<td>
				<input type="text" id="orderNo" maxlength="32" v_must="1" 
						v_type="string" onblur="checkElement(this)"/>
				<font class=orange>*</font>
			</td>
			<td class="blue">外省物流公司名称</td>
			<td>
				<input type="text" id="compName" maxlength="256" v_must="1" 
						v_type="string" onblur="checkElement(this)"/>
				<font class=orange>*</font>
			</td>
			<td class="blue">邮费</td>
			<td>
				<input type="text" id="postage" maxlength="10" v_must="1" 
						v_type="string" onblur="checkElement(this)"/>
				<font class=orange>*</font>
			</td>
		</tr>
		<tr>
			<td class="blue">对端省</td>
			<td>
				<select id="prov">
					<option value ="北京市">北京市 </option>
					<option value ="天津市">天津市 </option>
					<option value ="上海市">上海市 </option>
					<option value ="重庆市">重庆市 </option>
					<option value ="河北省">河北省 </option>
					<option value ="山西省">山西省 </option>
					<option value ="辽宁省">辽宁省 </option>
					<option value ="吉林省">吉林省 </option>
					<!--<option value ="黑龙江省">黑龙江省</option>-->
					<option value ="江苏省"> 江苏省 </option>
					<option value ="浙江省">浙江省 </option>
					<option value ="安徽省">安徽省 </option>
					<option value ="福建省">福建省 </option>
					<option value ="江西省">江西省 </option>
					<option value ="山东省">山东省 </option>
					<option value ="河南省">河南省 </option>
					<option value ="湖北省">湖北省 </option>
					<option value ="湖南省">湖南省 </option>
					<option value ="广东省">广东省 </option>
					<option value ="海南省">海南省 </option>
					<option value ="四川省">四川省 </option>
					<option value ="贵州省">贵州省 </option>
					<option value ="云南省">云南省 </option>
					<option value ="陕西省">陕西省 </option>
					<option value ="甘肃省">甘肃省 </option>
					<option value ="青海省">青海省 </option>
					<option value ="台湾省">台湾省 </option>
					<option value ="广西壮族自治区">广西壮族自治区</option>
					<option value ="内蒙古自治区"> 内蒙古自治区</option>
					<option value ="西藏自治区"> 西藏自治区</option>
					<option value ="宁夏回族自治区"> 宁夏回族自治区 </option>
					<option value ="新疆维吾尔自治区">新疆维吾尔自治区</option>
					<option value ="香港特别行政区">香港特别行政区</option>
					<option value ="澳门特别行政区">澳门特别行政区</option>
				</select>
				<font class=orange>*</font>
			</td>
			<td class="blue">联系人姓名</td>
			<td>
				<input type="text" id="contactName" maxlength="60"
						v_type="string" onblur="checkElement(this)"/>
			</td>
			<td class="blue">联系人电话</td>
			<td>
				<input type="text" id="contactPhoneNo" maxlength="15"
						v_type="string" onblur="checkElement(this)"/>
			</td>
		</tr>
		<tr>
			<td class="blue">证件号码</td>
			<td>
				<input id="cardNo" type="text" maxlength="30"/>
			</td>
			<td class="blue">接收日期</td>
			<td colspan="3">
				<input type="text" id="receiveDate" v_must="1"
					onClick="WdatePicker({startDate:'%y%M%d',dateFmt:'yyyyMMdd',readOnly:true,alwaysUseStartDate:true,maxDate:'%y-%M-%d'})"/>
				<font class=orange>*</font>
			</td>
		</tr>
		<tr>
			<td class="blue">备注</td>
			<td colspan="5">
				<input type="text" id="remark" maxlength="200" size="100"
						v_type="string" onblur="checkElement(this)"/>
			</td>
		</tr>
	</table>
</div>

<div id="Operation_Table">
	<div class="title">
		<div id="title_zi">卡号信息</div>
	</div>
	<table cellspacing="0">
		<tr>
			<td class="blue">类型</td>
			<td>
				<label for="radioA">
					<input type="radio" id="radioA" value="dis" name="cardType" checked/>离散卡号
				</label>
				&nbsp;&nbsp;
				<label for="radioB">
					<input type="radio" id="radioB" value="con" name="cardType"/>连续卡号
				</label>
			</td>
		</tr>
		<tbody id="dis">
		<tr>
			<th>旧卡卡号</th>
			<th>新卡卡号</th>
		</tr>
		<tr>
			<td><input type="text" size="30" maxlength="32"/><font class=orange>*</font></td>
			<td><input type="text" size="30" maxlength="32"/><font class=orange>*</font></td>
		</tr>
		
		<tr>
			<td><input type="text" size="30" maxlength="32"/><font class=orange>*</font></td>
			<td><input type="text" size="30" maxlength="32"/><font class=orange>*</font></td>
		</tr>
		<tr>
			<td><input type="text" size="30" maxlength="32"/><font class=orange>*</font></td>
			<td><input type="text" size="30" maxlength="32"/><font class=orange>*</font></td>
		</tr>
		<tr>
			<td><input type="text" size="30" maxlength="32"/><font class=orange>*</font></td>
			<td><input type="text" size="30" maxlength="32"/><font class=orange>*</font></td>
		</tr>
		<tr>
			<td><input type="text" size="30" maxlength="32"/><font class=orange>*</font></td>
			<td><input type="text" size="30" maxlength="32"/><font class=orange>*</font></td>
		</tr>
		<tr>
			<td><input type="text" size="30" maxlength="32"/><font class=orange>*</font></td>
			<td><input type="text" size="30" maxlength="32"/><font class=orange>*</font></td>
		</tr>
		<tr>
			<td><input type="text" size="30" maxlength="32"/><font class=orange>*</font></td>
			<td><input type="text" size="30" maxlength="32"/><font class=orange>*</font></td>
		</tr>
		<tr>
			<td><input type="text" size="30" maxlength="32"/><font class=orange>*</font></td>
			<td><input type="text" size="30" maxlength="32"/><font class=orange>*</font></td>
		</tr>
		<tr>
			<td><input type="text" size="30" maxlength="32"/><font class=orange>*</font></td>
			<td><input type="text" size="30" maxlength="32"/><font class=orange>*</font></td>
		</tr>
		<tr>
			<td><input type="text" size="30" maxlength="32"/><font class=orange>*</font></td>
			<td><input type="text" size="30" maxlength="32"/><font class=orange>*</font></td>
		</tr>
		<!---->
		</tbody>
		<tbody id="con" style="display:none;">
		<tr>
			<td class="blue">旧开始卡号 ~ 旧结束卡号</td>
			<td><input type="text" size="30" id="oldCardBegin" maxlength="32"/> ~ <input type="text" size="30" id="oldCardEnd" maxlength="32"/><font class=orange>*</font></td>
		</tr>
		<tr>
			<td class="blue">新开始卡号 ~ 新结束卡号</td>
			<td><input type="text" size="30" id="newCardBegin" maxlength="32"/> ~ <input type="text" size="30" id="newCardEnd" maxlength="32"/><font class=orange>*</font></td>
		</tr>
		</tbody>
	</table>
	<table cellspacing="0">
		<tr>
			<td id="footer" colspan="6">
			<input  name="cfm" id="cfm" class="b_foot" type="button" value="确认">
			&nbsp;
			<input  name="clear" id="clearBtn" class="b_foot" type="button" value="重置" />
			&nbsp;                  			
			</td>
		</tr>
	</table>
	
	
	<%@ include file="/npage/include/footer.jsp" %>
	</FORM>
</BODY>
</HTML> 