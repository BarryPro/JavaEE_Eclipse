<%
  /*
   * 功能: 关于优化客服CRM系统功能六月份第一次需求的函
   * 版本: 1.0
   * 日期: 2014/08/11 9:23:54
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
		
		String inParamsRegion [] = new String[2];
		inParamsRegion[0] = "select t.region_code,t.region_code ||'-'|| t.region_name as recname from sregioncode t where 1=1 and t.use_flag =:useFlag order by t.region_code ";
		inParamsRegion[1] = "useFlag=Y";
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode_region" retmsg="retMessage_region" outnum="2"> 
    <wtc:param value="<%=inParamsRegion[0]%>"/>
    <wtc:param value="<%=inParamsRegion[1]%>"/> 
  </wtc:service>  
  <wtc:array id="result_region"  scope="end"/>
<%
	if("000000".equals(retCode_region) && result_region.length > 0){
		
	}else{
		%>
		<script language="javascript">
			rdShowMessageDialog("获取地市信息失败!",1);
			removeCurrentTab();
		</script>
		<%
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
				rdShowMessageDialog("请输入手机号码！",1);
				return false;
			}
				/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm202/fm202Qry.jsp","正在获得数据，请稍候......");
			
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
					+"<th width='12%'>集团客户名称</th>"
					+"<th width='12%'>业务模式</th>"
					+"<th width='12%'>操作类型</th>"
					+"<th width='12%'>添加时间</th>"
					+"<th width='12%'>失效时间</th>"
					+"<th width='12%'>流量</th>"
					+"<th width='12%'>订购关系ID</th>"
					+"<th width='12%'>定向流量SID</th>"
					+"</tr>";
				$("#appendBody").append(appendTh);	
			for(var i=0;i<infoArray.length;i++){
			
					var msg0 = infoArray[i][0];
					var msg1 = infoArray[i][1];
					var msg2 = infoArray[i][2];
					var msg3 = infoArray[i][3];
					var msg4 = infoArray[i][4];
					var msg5 = infoArray[i][5];
					var msg6 = infoArray[i][6];
					var msg7 = infoArray[i][7];
			
			
					var appendStr = "<tr>";
					
					appendStr += "<td width='12%'>"+msg0+"</td>"
											+"<td width='12%'>"+msg1+"</td>"
											+"<td width='12%'>"+msg2+"</td>"
											+"<td width='12%'>"+msg3+"</td>"
											+"<td width='12%'>"+msg4+"</td>"
											+"<td width='12%'>"+msg5+"</td>"
											+"<td width='12%'>"+msg6+"</td>"
											+"<td width='12%'>"+msg7+"</td>"
					appendStr +="</tr>";	
									
					$("#appendBody").append(appendStr);
				}
				if(infoArray.length != 0){
					//$("#export").attr("disabled","");
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
	  		<td width="80%" colspan="3">
	  			<input type="text" id="phoneNo" name="phoneNo" value="" />
	  		</td>
	    </tr>
			<td align=center colspan="4" id="footer">
				<input class="b_foot" name="sure"  type="button" value="查询"  onclick="doQry();">&nbsp;&nbsp;
				<input class="b_foot" name="sure"  type="button" value="重置"  onclick="javascript:window.location.reload();">&nbsp;&nbsp;
				<input class="b_foot" name="close"  onClick="removeCurrentTab()" type=button value=关闭>
				
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
