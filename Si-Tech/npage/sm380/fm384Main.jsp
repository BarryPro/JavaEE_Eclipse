<%
  /*
   * 功能: 
   * 版本: 1.0
   * 日期: 2016/5/30 14:25:14 转售业务查询
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
		

	  String[][] temfavStr = (String[][])session.getAttribute("favInfo");
		String[] favStr = new String[temfavStr.length];
		boolean operFlag = false;
		for(int i = 0; i < favStr.length; i ++) {
			favStr[i] = temfavStr[i][0].trim();
		}
		if (WtcUtil.haveStr(favStr, "a996")) {
			operFlag = true;
		}
	
	 
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
			
			
			var phoneNo = $.trim($("#phoneNo").val());
			if(phoneNo.length == 0){
				rdShowMessageDialog("请输入手机号码！");
				return false;
			}
		
			/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm380/fm384Qry.jsp","正在获得数据，请稍候......");
			
			var iLoginAccept = "<%=loginAccept%>";
			var iChnSource = "01";
			var iOpCode = "<%=opCode%>";
			var iLoginNo = "<%=loginNo%>";
			var iLoginPwd = "<%=noPass%>";
			var iPhoneNo = phoneNo;
			var iUserPwd = "";
			
			
			getdataPacket.data.add("iLoginAccept",iLoginAccept);
			getdataPacket.data.add("iChnSource",iChnSource);
			getdataPacket.data.add("iOpCode",iOpCode);
			getdataPacket.data.add("iLoginNo",iLoginNo);
			getdataPacket.data.add("iLoginPwd",iLoginPwd);
			getdataPacket.data.add("iPhoneNo",iPhoneNo);
			getdataPacket.data.add("iUserPwd",iUserPwd);
			
			core.ajax.sendPacket(getdataPacket,doRetRegion);
			getdataPacket = null;
			
			
		}
		
	function doRetRegion(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			var infoArray = packet.data.findValueByName("infoArray");
			
		if(retCode == "000000"){
			
			
				$("#resultContent").show();
				$("#appendBody").empty();
				$("#phoneNo").attr("readonly","readonly");
				$("#phoneNo").attr("class","InputGrey");
				
				var appendTh = 
					"<tr>"
					+"<th width='11%'>归属地市</th>"
					+"<th width='11%'>员工编号</th>"
					+"<th width='11%'>证件类型</th>"
					+"<th width='11%'>证件号码</th>"
					+"<th width='11%'>客户姓名</th>"
					+"<th width='11%'>客户地址</th>"
					+"<th width='11%'>开户时间</th>"
					+"<th width='11%'>操作工号</th>"
					+"<th width='12%'>操作营业厅</th>"
					+"</tr>";
				$("#appendBody").append(appendTh);	
			for(var i=0;i<infoArray.length;i++){
					
					var appendStr = "<tr>";
					
					appendStr += "<td width='11%' align='center' id='cardType'>"+infoArray[i][0]+"</td>"
											+"<td width='11%' align='center' id='cardPrice'>"+infoArray[i][1]+"</td>"
											+"<td width='11%' align='center' id='cardDiscount'>"+infoArray[i][2]+"</td>"
											+"<td width='11%' align='center' id='cardRealPrice'>"+infoArray[i][3]+"</td>"
											+"<td width='11%' align='center' id='cardSum'>"+infoArray[i][4]+"</td>"
											+"<td width='11%' align='center' id='cardRealMoney'>"+infoArray[i][5]+"</td>"
											+"<td width='11%' align='center' id='cardValid'>"+infoArray[i][6]+"</td>"
											+"<td width='11%' align='center' id='cardValid'>"+infoArray[i][7]+"</td>"
											+"<td width='12%' align='center' id='cardValid'>"+infoArray[i][8]+"</td>"
					appendStr +="</tr>";	
									
					$("#appendBody").append(appendStr);
				}
				
				
			}else{
				$("#resultContent").hide();
				$("#appendBody").empty();
				//$("#export").attr("disabled","disabled");
				rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
				
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
	  		<td width="20%" class="blue">手机号码</td>
	  		<td width="30%">
	  			<input type="text" id="phoneNo" name="phoneNo" v_type="0_9" maxlength="11" value="" onblur="checkElement(this)"/>&nbsp;&nbsp;
	  			<input type="button" id="qryUnitBtn" class="b_text" name="qryUnitBtn" value="查询" onclick="doQry();"/>
	  		</td>
	  		
	    </tr>
	  </table>
	 <div>
	 	
	
	 <!-- 查询结果列表 -->
	<div id="resultContent" style="display:none">
		<div class="title">
			<div id="title_zi">转售信息查询结果</div>
		</div>
		<table id="exportExcel" name="exportExcel">
			<tbody id="appendBody">
				
			
			</tbody>
		</table>
	</div>
	
	</div>
	<input type="hidden" name="iLoginAcceptnew" id="iLoginAcceptnew" />
	<input type="hidden" name="oCustName" id="oCustName" value=""/>
	<input type="hidden" name="oIccidNo" id="oIccidNo" value=""/>
	<input type="hidden" name="oCustId" id="oCustId" value=""/>
	 

	<%@ include file="/npage/include/footer.jsp" %>
</form>
<script>
var excelObj;
function printTable(object)
{
	var obj=document.all.exportExcel;
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
