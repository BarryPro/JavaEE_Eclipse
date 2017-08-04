<%
  /*
   * 功能:
   * 版本: 1.0
   * 日期: 
   * 作者: gaopeng
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    String regionCode = (String)session.getAttribute("regCode");
    String loginNo = (String)session.getAttribute("workNo");
 		String noPass = (String)session.getAttribute("password");
 		String groupID = (String)session.getAttribute("groupId");
 		String opCode = (String)request.getParameter("opCode");
		String opName = (String)request.getParameter("opName");
		String phoneNo = (String)request.getParameter("activePhone");
		String loginAccept = getMaxAccept();
		
%>
<html>
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js" type="text/javascript"></script>
	<script language="javascript">
		
		$(document).ready(function(){
		
		});
		
		function doQry(){
			
			var cfmFlag = false;
			var opType = $("input[name='opType'][checked]").val();
			var mainUnitCode = $.trim($("input[name='mainUnitCode']").val());
			var otherUnitCode = $.trim($("input[name='otherUnitCode']").val());
			
			/*2014/08/08 10:49:02 gaopeng R_CMI_HLJ_xueyz_2014_1666493@关于实现融合通信联合集团的需求
				查询时，两个至少得填写一个 
			*/
			if(opType == "2"){
				if(mainUnitCode.length == 0 && otherUnitCode.length == 0){
					rdShowMessageDialog("主集团编码和附属集团编码至少需要输入一项!",1);
					return false;
				}
			}else if(opType == "0" || opType == "1"){
				if(mainUnitCode.length == 0 || otherUnitCode.length == 0){
					rdShowMessageDialog("主集团编码和附属集团编码必须都输入!",1);
					return false;
				}
			}
			
			if(opType == "0" || opType == "1"){
				
				if($("#mainUnitCode_ID").val().trim()==""){
					rdShowMessageDialog("请选择主集团编码产品ID",1);
					return false;
				}
				if($("#otherUnitCode_ID").val().trim()==""){
					rdShowMessageDialog("请选择附属集团编码产品ID",1);
					return false;
				}
				
				
				if(rdShowConfirmDialog("是否确认操作?")==1){
					cfmFlag = true;
				}else{
					cfmFlag = false;
				}
			}else if(opType == "2"){
				cfmFlag = true;
			}
			
			if(cfmFlag){
				/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm136/fm136Qry.jsp","正在获得数据，请稍候......");
			
			var iLoginAccept = "<%=loginAccept%>";
			var iChnSource = "01";
			var iOpCode = "<%=opCode%>";
			var iLoginNo = "<%=loginNo%>";
			var iLoginPwd = "<%=noPass%>";
			var iPhoneNo = "";
			var iUserPwd = "";
			
			getdataPacket.data.add("iLoginAccept",iLoginAccept);
			getdataPacket.data.add("iChnSource",iChnSource);
			getdataPacket.data.add("iOpCode",iOpCode);
			getdataPacket.data.add("iLoginNo",iLoginNo);
			getdataPacket.data.add("iLoginPwd",iLoginPwd);
			getdataPacket.data.add("iPhoneNo",iPhoneNo);
			getdataPacket.data.add("iUserPwd",iUserPwd);
			getdataPacket.data.add("mainUnitCode",mainUnitCode);
			getdataPacket.data.add("otherUnitCode",otherUnitCode);
			
			getdataPacket.data.add("mainUnitCode_ID",$("#mainUnitCode_ID").val().trim());
			getdataPacket.data.add("otherUnitCode_ID",$("#otherUnitCode_ID").val().trim());
			
			getdataPacket.data.add("opType",opType);
			
			
			core.ajax.sendPacket(getdataPacket,doRetRegion);
			getdataPacket = null;
		}
			
	}
	
	function doRetRegion(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			var infoArray = packet.data.findValueByName("infoArray");
			var iOpType = packet.data.findValueByName("opType");
			
		if(retCode == "000000"){
			
				if(iOpType == "2"){
					$("#resultContent").show();
					$("#appendBody").empty();
					
					var appendTh = 
						"<tr>"
						+"<th width='25%'>主集团编码</th>"
						+"<th width='25%'>主集团编码产品ID</th>"
						+"<th width='25%'>附属集团编码</th>"
						+"<th width='25%'>附属集团编码产品ID</th>"
						
						+"</tr>";
					$("#appendBody").append(appendTh);	
					for(var i=0;i<infoArray.length;i++){
					
					var orderAccept = infoArray[i][0];
					var opType = infoArray[i][1];
					
					
					
							var appendStr = "<tr>";
							
							appendStr += "<td width='25%'>"+orderAccept+"</td>"
													+"<td width='25%'>"+infoArray[i][2]+"</td>"
													+"<td width='25%'>"+opType+"</td>"
													
													
													+"<td width='25%'>"+infoArray[i][3]+"</td>"
													
													;
							appendStr +="</tr>";	
											
							$("#appendBody").append(appendStr);
					}
			}else{
				rdShowMessageDialog("操作成功！",2);
				location = location;
			}
				
			}else{
				$("#resultContent").hide();
				$("#appendBody").empty();
				rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
				
			}
		}
	function doResetS(tmp){
		$("#resultContent").hide();
		$("#appendBody").empty();
		
		if(tmp=="2"){
			$("#tr_Unitids").hide();
			$("#btn_go_QryUnitCode1").hide();
			$("#btn_go_QryUnitCode2").hide();
			
		}else{
			$("#tr_Unitids").show();
			$("#btn_go_QryUnitCode1").show();
			$("#btn_go_QryUnitCode2").show();
		}
		
	}


function go_QryUnitCode(flag){
	
		var In_UnitId   = "";
		var In_BandFlag = $("input[name='opType']:checked").val();   // 绑定或解绑标识0绑定，1解绑
		
		
		
		var In_MainFlag = flag; //主附属集团标识0主，1附属
				
		if(flag=="0"){
			In_UnitId = $("#mainUnitCode").val();
		}else{
			In_UnitId = $("#otherUnitCode").val();
		}		
				
    var packet = new AJAXPacket("fm136_go_QryUnitCode.jsp","请稍后...");
        packet.data.add("opCode","<%=opCode%>");//
        packet.data.add("flag",flag);//
        
        packet.data.add("In_UnitId",In_UnitId);//
        packet.data.add("In_MainFlag",In_MainFlag);//
        packet.data.add("In_BandFlag",In_BandFlag);//
        
    core.ajax.sendPacket(packet,do_QryUnitCode);
    packet =null;	
}	

function do_QryUnitCode(packet){
    var error_code = packet.data.findValueByName("code");//返回代码
    var error_msg =  packet.data.findValueByName("msg");//返回信息

    if(error_code!="000000"){//调用服务失败
      rdShowMessageDialog(error_code+":"+error_msg);
	    return;
    }else{//操作成功
			
			var In_MainFlag = packet.data.findValueByName("In_MainFlag");
			var retArray    = packet.data.findValueByName("retArray");
			
			
			
			var option_str = "<option value=''>--请选择--</option>";
			if(retArray.length>0){
				
					for(var i=0;i<retArray.length;i++){
							option_str += "<option value='"+retArray[i][0]+"'>"+retArray[i][0]+"</option>";
					}
					
					
					if(In_MainFlag=="0"){
							$("#mainUnitCode_ID option").remove();
							$("#mainUnitCode_ID").append(option_str);
					}else{
							$("#otherUnitCode_ID option").remove();
							$("#otherUnitCode_ID").append(option_str);
					}
					
					
			}else{
					rdShowMessageDialog("未查询到结果");
			}
			
    }
}

	</script>
	</head>
<body>
	<form action="" method="post" name="f1">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<div>
		<table>
			
	    <tr>
	  		<td width=20% class="blue">操作类型</td>
	  		<td width=80% colspan="3">
		  		<input type="radio" name="opType"  value="0" onclick="doResetS(0)"/>解绑 &nbsp;
		  		<input type="radio" name="opType"   value="1" onclick="doResetS(1)"/>绑定 &nbsp;
		  		<input type="radio" name="opType"  value="2" checked onclick="doResetS(2)"/>查询 &nbsp;
	  		</td>
	    </tr>
	    <tr>
	    	<td width="20%" class="blue">主集团编码</td>
	    	<td width=30%>
	    		<input type="text" name="mainUnitCode" id="mainUnitCode"	value="" maxlength="10"/>
	    		<input type="button" class="b_text" id="btn_go_QryUnitCode1" value="查询" onclick="go_QryUnitCode(0);" style="display:none" />
	    	</td>
	    	<td width=20% class="blue">附属集团编码</td>
	    	<td width=30%>
	    		<input type="text" name="otherUnitCode" id="otherUnitCode"	value="" maxlength="10"/>
	    		<input type="button" class="b_text" id="btn_go_QryUnitCode2" value="查询" onclick="go_QryUnitCode(1);" style="display:none" />
	    	</td>
	    </tr>
	    
	    
	    <tr id="tr_Unitids" style="display:none">
	    	<td width="20%" class="blue">主集团编码产品ID</td>
	    	<td width=30%>
	    		
	    		<select id="mainUnitCode_ID" name="mainUnitCode_ID" >
					    <option value="">--请选择--</option>
					</select>
					
					
	    	</td>
	    	<td width=20% class="blue">附属集团编码产品ID</td>
	    	<td width=30%>
	    		<select id="otherUnitCode_ID" name="otherUnitCode_ID" >
					    <option value="">--请选择--</option>
					</select>
					
	    	</td>
	    </tr>
	    
	    <tr> 
	    	
 
			<td align=center colspan="4" id="footer">
				<input class="b_foot" name="sure"  type="button" value="确认"  onclick="doQry();">
				<input class="b_foot" name=close  onClick="removeCurrentTab()" type=button value=关闭>
				
			</td>
		</tr>
		</table>
	</div>
	<!-- 查询结果列表 -->
	<div id="resultContent" style="display:none">
		<div class="title">
			<div id="title_zi">查询结果列表</div>
		</div>
		<table id="exportExcel" name="exportExcel">
			<tbody id="appendBody">
				
			
			</tbody>
		</table>
	</div>

	<%@ include file="/npage/include/footer.jsp" %>
</form>
<script>
var excelObj;
function printTable(object)
{
	var obj=document.all.exportExcel2;
	rows=obj.rows.length;
	if(rows>0){
		try{
			excelObj = new ActiveXObject("excel.Application");
			excelObj.Visible = true;
			excelObj.WorkBooks.Add;
			  for(i=0;i<rows;i++){
			    cells=obj.rows[i].cells.length;
			    for(j=0;j<cells;j++)
			      excelObj.Cells(i+1,j+1).Value="'" + obj.rows[i].cells[j].innerText;
			}
		}
		catch(e){}
	} else {
		
	}
}
</script>
</body>


</html>
