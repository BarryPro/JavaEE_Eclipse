
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
   /*
   * 功能: 外省用户换本省卡信息记录
　 * 版本: v1.0
　 * 日期: 2015/4/2 14:50:54
　 * 作者: ningtn
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
			<%@ page contentType= "text/html;charset=gb2312" %>
		<%@ include file="/npage/include/public_title_name.jsp" %>
<%
			response.setHeader("Pragma","No-Cache"); 
			response.setHeader("Cache-Control","No-Cache");
			response.setDateHeader("Expires", 0); 
			
			String opCode = "m253";
			String opName = "外省用户换本省卡信息记录";
			
			String regionCode = (String)session.getAttribute("regCode");
			String workno = (String)session.getAttribute("workNo");
			String noPass = (String)session.getAttribute("password");
			
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAccept" />
<html>
	<head>
	<title>外省用户换本省卡信息记录</title>
	<meta content=no-cache http-equiv=Pragma>
	<meta content=no-cache http-equiv=Cache-Control>
	<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
	<script language="javascript">
		<!--
			
			$(document).ready(function(){
				
				var winObj = window.dialogArguments;
				var oldCardNo 		= winObj.oldCardNo;
				var compName			= winObj.compName;
				var orderNo				= winObj.orderNo;
				var addr					= winObj.addr;
				var reviceDate		= winObj.reviceDate;
				var phoneDate			= winObj.phoneDate;
				var activateDate	= winObj.activateDate;
				
				if(typeof(compName) != "undefined" && compName != "-"){
					$("#compName").val(compName);
					$("#compName").attr("readonly","readonly").addClass("InputGrey");
				}
				if(typeof(orderNo) != "undefined" && orderNo != "-"){
					$("#orderNo").val(orderNo);
					$("#orderNo").attr("readonly","readonly").addClass("InputGrey");
				}
				if(typeof(addr) != "undefined" && addr != "-"){
					$("#addr").val(addr);
					$("#addr").attr("readonly","readonly").addClass("InputGrey");
				}
				if(typeof(reviceDate) != "undefined" && reviceDate != "-"){
					$("#reviceDate").val(reviceDate);
					$("#reviceDate").attr("readonly","readonly").addClass("InputGrey");
				}
				if(typeof(phoneDate) != "undefined" && phoneDate != "-"){
					$("#phoneDate").val(phoneDate);
					$("#phoneDate").attr("readonly","readonly").addClass("InputGrey");
				}
				if(typeof(activateDate) != "undefined" && activateDate != "-"){
					$("#activateDate").val(activateDate);
					$("#activateDate").attr("readonly","readonly").addClass("InputGrey");
				}
				
				
				$("#confirmButton").click(function(){
					var cardStatus 	= $.trim($("#status").val());
					var compName 		= $.trim($("#compName").val());
					var orderNo 		= $.trim($("#orderNo").val());
					var addr 				= $.trim($("#addr").val());
					var reviceDate 	= $.trim($("#reviceDate").val());
					var phoneDate 	= $.trim($("#phoneDate").val());
					var activateDate 	= $.trim($("#activateDate").val());
					
					if(compName == ""
							&& orderNo == ""
							&& addr == ""
							&& reviceDate == ""
							&& phoneDate == ""
							&& activateDate == ""){
							rdShowMessageDialog("请至少填写一项信息",1);
							return false;
					}
					
					//填写“有价卡激活时间” 必须都填写，状态只能是已完结
					if(activateDate != ""){
						if(cardStatus == "1"){
							rdShowMessageDialog("填写“有价卡激活时间” ，处理状态只能是已完结",1);
							return false;
						}
						if(compName == ""
							|| orderNo == ""
							|| addr == ""
							|| reviceDate == ""
							|| phoneDate == ""
							|| activateDate == ""){
							rdShowMessageDialog("填写“有价卡激活时间”，所有信息都不能为空。",1);
							return false;
					}
					}
					
					var getdataPacket = new AJAXPacket("/npage/sm252/fm253Cfm.jsp","正在获得数据，请稍候......");
					getdataPacket.data.add("serviceName","sm253Cfm");
					getdataPacket.data.add("outnum","0");
					getdataPacket.data.add("inputParamsLength","15");
					getdataPacket.data.add("inParams0",$("#sysAccept").val());
					getdataPacket.data.add("inParams1","01");
					getdataPacket.data.add("inParams2","<%=opCode%>");
					getdataPacket.data.add("inParams3","<%=workno%>");
					getdataPacket.data.add("inParams4","<%=noPass%>");
					getdataPacket.data.add("inParams5","");
					getdataPacket.data.add("inParams6","");
					getdataPacket.data.add("inParams7",oldCardNo);
					getdataPacket.data.add("inParams8",cardStatus);
					getdataPacket.data.add("inParams9",compName);
					getdataPacket.data.add("inParams10",orderNo);
					getdataPacket.data.add("inParams11",addr);
					getdataPacket.data.add("inParams12",reviceDate);
					getdataPacket.data.add("inParams13",phoneDate);
					getdataPacket.data.add("inParams14",activateDate);
					core.ajax.sendPacket(getdataPacket,doCfmBack);
					getdataPacket = null;
					
				});
				
				
				$("#closeButton").click(function(){
					goBack(0);
				});
				
			});
			
			function doCfmBack(packet){
		      var retcode = packet.data.findValueByName("retcode");
		      var retmsg = packet.data.findValueByName("retmsg");
		      if(retcode == "000000"){
		        rdShowMessageDialog("操作成功",2);
		        goBack(1);
		      }else{
		      	rdShowMessageDialog("查询失败！错误代码：" + retcode + "，错误信息：" + retmsg,0);
		      	return false;
		      }
			}
			
			function goBack(s){
				if(s == 1){
					window.returnValue="1";
				}else{
					window.returnValue="0";
				}
				window.close();
			}
			
		//-->
	</script>
</head>
<body>
		<%@ include file="/npage/include/header_pop.jsp" %>
		<input type="hidden" name="sysAccept" id="sysAccept" value="<%=sysAccept%>"> 
     <table cellspacing="0">
     	<tr>
	  		<td class="blue">处理状态</td>
	  		<td colspan="3">
	  			<select id="status">
						<option value="1">邮寄中</option>
						<option value="2">已完结</option>
					</select>
				</td>
	  	</tr>
			<tr>
	  		<td class="blue">物流公司</td>
	  		<td>
	  			<input type="text" id="compName" maxlength="256" v_must="1" 
							v_type="string" onblur="checkElement(this)"/>
				</td>
	  		<td class="blue">邮寄订单号</td>
	  		<td>
	  			<input type="text" id="orderNo" maxlength="32" v_must="1" 
							v_type="string" onblur="checkElement(this)"/>
	  		</td>
	  	</tr>
	  	
	  	<tr>
	  		<td class="blue">邮寄地址</td>
	  		<td>
	  			<input type="text" id="addr" maxlength="256" v_must="1" 
							v_type="string" onblur="checkElement(this)"/>
				</td>
	  		<td class="blue">客户签收时间</td>
	  		<td>
	  			<input type="text" id="reviceDate" v_must="1" 
	  				onClick="WdatePicker({startDate:'%y%M%d',dateFmt:'yyyyMMdd',readOnly:true,alwaysUseStartDate:true,maxDate:'%y-%M-%d'})"/>
	  		</td>
	  	</tr>
	  	
	  	<tr>
	  		<td class="blue">电话回复时间</td>
	  		<td>
	  			<input type="text" id="phoneDate" v_must="1" 
	  				onClick="WdatePicker({startDate:'%y%M%d',dateFmt:'yyyyMMdd',readOnly:true,alwaysUseStartDate:true,maxDate:'%y-%M-%d'})"/>
				</td>
	  		<td class="blue">有价卡激活时间</td>
	  		<td>
	  			<input type="text" id="activateDate" v_must="1" 
	  				onClick="WdatePicker({startDate:'%y%M%d',dateFmt:'yyyyMMdd',readOnly:true,alwaysUseStartDate:true,maxDate:'%y-%M-%d'})"/>
	  		</td>
	  	</tr>
		</table>
		<table cellspacing="0">
			<tr> 
				<td id="footer"> 
					<input type="button" id="confirmButton" class="b_foot" value="确定" />&nbsp;
					<input type="button" id="closeButton" class="b_foot" value="关闭" />&nbsp;
				</td>
			</tr>
		</table>
 	<%@ include file="/npage/include/footer_pop.jsp" %>
</body>
</html>    		

 
