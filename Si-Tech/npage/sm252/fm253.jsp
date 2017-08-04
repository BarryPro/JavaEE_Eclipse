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
			$(document).ready(function(){
				
				$("#clearBtn").click(function(){
					doclear();
				});
				
				$("#qryBtn").click(function(){
					$(":input").each(function(){
						hiddenTip($(this)[0]);
					});
					
					
					var qryType = $("#qryType").val();
					if(qryType == "2"){
						if(!checkElement($("#startDate")[0])){
							return false;
						}else if(!checkElement($("#endDate")[0])){
							return false;
						}
					}else{
						if(!checkElement($("#qryTxt")[0])){
							return false;
						}
					}
					
					qryfunc();
				});
				
				$("#qryType").change(function(){
					if($(this).val() == "0"){
						$("#timeTr").hide();
						$("#qryLabel").text("投诉单号");
						$("#qryLabel").show();
						$("#qryInput").show();
					}else if($(this).val() == "1"){
						$("#timeTr").hide();
						$("#qryLabel").text("证件号码");
						$("#qryLabel").show();
						$("#qryInput").show();
					}else if($(this).val() == "2"){
						$("#qryLabel").hide();
						$("#qryInput").hide();
						$("#timeTr").show();
					}
				});
			});
			
			function doclear(){
				window.location.href = "fm253.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
			}
			
			function qryfunc(){
					/*调用提交服务*/
					var param9,param10 = "";
					if($("#qryType").val() == "2"){
						param9 = $("#startDate").val();
						param10 = $("#endDate").val();
					}else{
						param9 = $("#qryTxt").val();
					}
					
					var getdataPacket = new AJAXPacket("/npage/public/pubCallServ.jsp","正在获得数据，请稍候......");
					getdataPacket.data.add("serviceName","sm253Qry");
					getdataPacket.data.add("outnum","22");
					getdataPacket.data.add("inputParamsLength","11");
					getdataPacket.data.add("inParams0",$("#sysAccept").val());
					getdataPacket.data.add("inParams1","01");
					getdataPacket.data.add("inParams2","<%=opCode%>");
					getdataPacket.data.add("inParams3","<%=workno%>");
					getdataPacket.data.add("inParams4","<%=noPass%>");
					getdataPacket.data.add("inParams5","");
					getdataPacket.data.add("inParams6","");
					getdataPacket.data.add("inParams7",$("#status").val());
					getdataPacket.data.add("inParams8",$("#qryType").val());
					getdataPacket.data.add("inParams9",param9);
					getdataPacket.data.add("inParams10",param10);
					core.ajax.sendPacket(getdataPacket,doQryBack);
					getdataPacket = null;
			}
			
			function doQryBack(packet){
		      var retcode = packet.data.findValueByName("retcode");
		      var retmsg = packet.data.findValueByName("retmsg");
		      if(retcode == "000000"){
		        var result = packet.data.findValueByName("result");
		        $("#qryTab").empty();
		        $.each(result,function(i,n){
		        	var tr = $("#qryTmp").clone();
		        	var tmpStr = "";
		        	if(n[0] == "0"){
		        		tmpStr = "未邮寄";
		        	}else if(n[0] == "1"){
		        		tmpStr = "邮寄中";
		        	}else if(n[0] == "2"){
		        		tmpStr = "已完结";
		        		tr.find(":input").hide();
		        	}
		        	tr.find("td:eq(0)").text(tmpStr);
		        	tmpStr = "";
		        	if(n[1] == "0"){
		        		tmpStr = "未刮";
		        	}else if(n[1] == "1"){
		        		tmpStr = "已刮";
		        	}
		        	tr.find("td:eq(1)").text(tmpStr);
		        	tmpStr = "";
		        	if(n[2] == "0"){
		        		tmpStr = "未充";
		        	}else if(n[2] == "1"){
		        		tmpStr = "已充";
		        	}
		        	tr.find("td:eq(2)").text(tmpStr)
		        										.attr("oldCardNo",n[15])
		        										.attr("compName",n[16])
		        										.attr("orderNo",n[17])
		        										.attr("addr",n[18])
		        										.attr("reviceDate",n[19])
		        										.attr("phoneDate",n[20])
		        										.attr("activateDate",n[21]);
		        	tr.find("td:eq(3)").text(n[3]);
		        	tr.find("td:eq(4)").text(n[4]);
		        	tr.find("td:eq(5)").text(n[5]);
		        	tr.find("td:eq(6)").text(n[6]);
		        	tr.find("td:eq(7)").text(n[7]);
		        	tr.find("td:eq(8)").text(n[8]);
		        	tr.find("td:eq(9)").text(n[9]);
		        	tr.find("td:eq(10)").text(n[10]);
		        	tr.find("td:eq(11)").text(n[11]);
		        	tr.find("td:eq(12)").text(n[12]);
		        	tr.find("td:eq(13)").text(n[13]);
		        	tr.find("td:eq(14)").text(n[14]);
		        	tr.removeAttr("style");
		        	$("#qryTab").append(tr);
		        	
		        });
		        
		        $("#qryTab").find(":input").click(function(){
		        	openWin($(this));
		        });
		        
		      }else{
		      	rdShowMessageDialog("查询失败！错误代码：" + retcode + "，错误信息：" + retmsg,0);
		      	doclear();
		      }
		      
		    }
		    
		    function openWin(obj){
		    	
		    	var h=400;
   				var w=700;
   				var t=screen.availHeight/2-h/2;
   				var l=screen.availWidth/2-w/2;
   
		    	var oldCardNo 	= obj.parent().parent().find("td:eq(2)").attr("oldCardNo");
		    	var compName 		= obj.parent().parent().find("td:eq(2)").attr("compName");
		    	var orderNo 		= obj.parent().parent().find("td:eq(2)").attr("orderNo");
		    	var addr 				= obj.parent().parent().find("td:eq(2)").attr("addr");
		    	var reviceDate 	= obj.parent().parent().find("td:eq(2)").attr("reviceDate");
		    	var phoneDate 	= obj.parent().parent().find("td:eq(2)").attr("phoneDate");
		    	var activateDate = obj.parent().parent().find("td:eq(2)").attr("activateDate");
		    	var path = "<%=request.getContextPath()%>/npage/sm252/fm253Info.jsp";
		    	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
		    	var winObj = new Object();
          winObj.oldCardNo 	= oldCardNo;
          winObj.compName 	= compName;
          winObj.orderNo 		= orderNo;
          winObj.addr 			= addr;
          winObj.reviceDate = reviceDate;
          winObj.phoneDate 	= phoneDate;
          winObj.activateDate = activateDate;
		    	var ret=window.showModalDialog(path,winObj,prop);
		    	
		    	$("#qryBtn").click();

		    }
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
			<td class="blue">处理状态</td>
			<td>
				<select id="status">
					<option value="0">未邮寄</option>
					<option value="1">邮寄中</option>
					<option value="2">已完结</option>
				</select>
			</td>
			<td class="blue">查询条件</td>
			<td>
				<select id="qryType">
					<option value="0">投诉单号</option>
					<option value="1">证件号码</option>
					<option value="2">全部</option>
				</select>
			</td>
			<td class="blue" id="qryLabel">投诉单号</td>
			<td id="qryInput">
				<input type="text" id="qryTxt" v_must="1" v_type="string"/>
				<font class=orange>*</font>
			</td>
		</tr>
		<tr id="timeTr" style="display:none;">
			<td class="blue">开始时间</td>
			<td>
				<input type="text" id="startDate" v_must="1" value="<%=dateStr%>"
					onClick="WdatePicker({startDate:'%y%M%d',dateFmt:'yyyyMMdd',readOnly:true,alwaysUseStartDate:true})"/>
				<font class=orange>*</font>
			</td>
			<td class="blue">结束时间</td>
			<td>
				<input type="text" id="endDate" v_must="1" value="<%=dateStr%>"
					onClick="WdatePicker({startDate:'%y%M%d',dateFmt:'yyyyMMdd',readOnly:true,alwaysUseStartDate:true})"/>
				<font class=orange>*</font>
			</td>
		</tr>
	</table>
	<table cellspacing="0">
		<tr>
			<td id="footer" >
			<input  name="qryBtn" id="qryBtn" class="b_foot" type="button" value="查询">
			&nbsp;
			<input  id="clearBtn" class="b_foot" type="button" value="重置" />
			&nbsp;                  			
			</td>
		</tr>
	</table>
	<table cellspacing="0" >
		<tr>
			<th>处理状态</th>
			<th>旧卡是否刮开</th>
			<th>旧卡是否充值</th>
			<th>投诉流水号</th>
			<th>外省物流公司名称</th>
			<th>外省邮寄订单号</th>
			<th>邮费</th>
			<th>对端省</th>
			<th>联系人姓名</th>
			<th>联系人电话</th>
			<th>证件号码</th>
			<th>接收日期</th>
			<th>备注</th>
			<th>操作时间</th>
			<th>操作工号</th>
			<th>操作</th>
		</tr>
		<tr id="qryTmp" style="display:none;">
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td><input type="button" value="记录" class="b_text" /></td>
		</tr>
		<tbody id="qryTab">
		</tbody>
	</table>
		
	<%@ include file="/npage/include/footer.jsp" %>
	</FORM>
</BODY>
</HTML> 