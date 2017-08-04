<%
  /*
   * 功能: 关于优化4GLTE-FI业务相关功能的需求
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
		
		String ipAddrM = (String)session.getAttribute("ipAddr");
 		String inst = "通过phoneNo[" + phoneNo + "]查询";
		String custName = "";
		
%>

 <wtc:service name="sUserCustInfo" outnum="41" >
      <wtc:param value="<%=loginAccept%>"/>
      <wtc:param value="01"/>
      <wtc:param value="<%=opCode%>"/>
      <wtc:param value="<%=loginNo%>"/>
      <wtc:param value="<%=noPass%>"/>
      <wtc:param value="<%=phoneNo%>"/>
      <wtc:param value=""/>
      <wtc:param value="<%=ipAddrM%>"/>
      <wtc:param value="<%=inst%>"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
  </wtc:service>

	<wtc:array id="result11" scope="end" />

<%
		if(result11.length <= 0)
		{
%>
<script language="JavaScript">
			rdShowMessageDialog("该用户不是在网用户或状态不正常！");
			window.location = '/npage/sm231/fm231Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>';
</script>
<%
			return ;
		}
		else
		{
			custName = result11[0][5];
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
			var filedName = $.trim($("#filedName").val());
				
				/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm237/fm237Qry.jsp","正在获得数据，请稍候......");
			
			getdataPacket.data.add("offerId","");
		 	getdataPacket.data.add("phoneNo","<%=phoneNo%>");
			getdataPacket.data.add("opCode","<%=opCode%>");
			getdataPacket.data.add("offerName",filedName);
			
			
			core.ajax.sendPacket(getdataPacket,doRetRegion);
			getdataPacket = null;
			
			
		}
		
	function doRetRegion(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			var infoArray = packet.data.findValueByName("infoArray");
			
			var inOffer = packet.data.findValueByName("inOffer");
			var vProdOfferName = packet.data.findValueByName("vProdOfferName");
			var vBothName = packet.data.findValueByName("vBothName");
			var vFlagCode = packet.data.findValueByName("vFlagCode");
			var vFlagName = packet.data.findValueByName("vFlagName");
			var vBothFlagName = packet.data.findValueByName("vBothFlagName");
			
			
		
		if(retCode == "000000"){
				if(infoArray.length == 0){
					rdShowMessageDialog("没有可变更的小区!",1);
					return false;
				}	
				$("#resultContent").show();
				$("#appendBody").empty();
				$("#phoneNo").attr("readonly","readonly");
				$("#phoneNo").attr("class","InputGrey");
				
				var appendTh = 
					"<tr>"
					+"<th width='20%'>主资费代码</th>"
					+"<th width='20%'>主资费名称</th>"
					+"<th width='20%'>用户当前小区代码</th>"
					+"<th width='20%'>用户当前小区名称</th>"
					+"<th width='20%'>可选小区</th>"
					+"</tr>";
				$("#appendBody").append(appendTh);	
			
			
					var appendSelectStart = "<select name='selCode' >";
					var appendSelectEnd = "</select>";
					
					var appendSelectCons = "";
					for(var i=0;i<infoArray.length;i++){
						var msg0 = infoArray[i][0];
						var msg1 = infoArray[i][1];
						var appendStr = "<option value='"+msg0+"'>"+msg1+"</option>";
						appendSelectCons += appendStr;
					}
					
					
			
			
					var appendStr = "<tr>";
					
					appendStr += "<td width='20%'>"+inOffer+"</td>"
											+"<td width='20%'>"+vProdOfferName+"</td>"
											+"<td width='20%'>"+vFlagCode+"</td>"
											+"<td width='20%'>"+vFlagName+"</td>"
											+"<td width='20%'>"+appendSelectStart+appendSelectCons+appendSelectEnd+"</td>"
											
					appendStr +="</tr>";	
									
					$("#appendBody").append(appendStr);
				
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
		
		function showPrtDlg(printType,DlgMessage,submitCfm)
		{  //显示打印对话框
			var pType="print";                     // 打印类型print 打印 subprint 合并打印
			var billType="1";                      //  票价类型1电子免填单、2发票、3收据
			var sysAccept ="<%=loginAccept%>";       // 流水号
			var printStr = printInfo(printType);   //调用printinfo()返回的打印内容
			var mode_code=null;                    //资费代码
			var fav_code=null;                     //特服代码
			var area_code=null;                    //小区代码
			var opCode =   "<%=opCode%>";          //操作代码
			var phoneNo = "<%=phoneNo%>";                      //客户电话
			var h=150;
			var w=350;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
			var path= "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
			var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
			var ret=window.showModalDialog(path,printStr,prop);
		}
		
		function printInfo(printType)
		{
		         		
			var cust_info=""; //客户信息
			var opr_info=""; //操作信息
			var retInfo = "";  //打印内容
			var note_info1=""; //备注1
			var note_info2=""; //备注2
			var note_info3=""; //备注3
			var note_info4=""; //备注4
		
			var idno = "";
			var ocontact_phone = "";
			var ocontact_name = "";
			//获取信息
			$("#appendBody tr:gt(0)").each(function(){
				
					idno           = $(this).find("td:eq(0)").text().trim();
					ocontact_phone = $.trim($("#phoneNo").val());
					ocontact_name  = $.trim($("#custName").val());
				
			});
			
		  cust_info+="手机号码：   "+ocontact_phone+"|";
		  cust_info+="客户姓名：   "+ocontact_name+"|";
		  
		 	
			opr_info += "办理业务：小区迁移"+"|";
			opr_info +="主资费代码："+idno+"|";
			opr_info += "操作流水：<%=loginAccept%>"+"|";
			
			
			
			$("#appendBody tr:gt(0)").each(function(){
					var custOldAddr = $(this).find("td:eq(2)").text().trim() + "-->" +$(this).find("td:eq(3)").text().trim();
					var custNewAddr = $(this).find("td:eq(4)").find("select").find("option:selected").text().trim();
					
					opr_info += "客户原小区："+custOldAddr+"|";
					opr_info += "客户新小区："+custNewAddr+"|";
					
			});
			
			
			note_info1 += "备注："+"|";
			
			
			retInfo= strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		 	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //把“#"替换为url格式
		 	
		  return retInfo;
		  
		}
		
		function doCfm(){
			
			showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
			if(rdShowConfirmDialog("确认提交么?") == 1){
				/*提交*/
				/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm237/fm237Cfm.jsp","正在获得数据，请稍候......");
			
			var iLoginAccept = "<%=loginAccept%>";
			var iChnSource = "01";
			var iOpCode = "<%=opCode%>";
			var iLoginNo = "<%=loginNo%>";
			var iLoginPwd = "<%=noPass%>";
			var iPhoneNo = "<%=phoneNo%>";
			var iUserPwd = "";
			var selectCode = $("select[name='selCode']").find("option:selected").val();
			
			
			
			getdataPacket.data.add("iLoginAccept",iLoginAccept);
			getdataPacket.data.add("iChnSource",iChnSource);
			getdataPacket.data.add("iOpCode",iOpCode);
			getdataPacket.data.add("iLoginNo",iLoginNo);
			getdataPacket.data.add("iLoginPwd",iLoginPwd);
			getdataPacket.data.add("iPhoneNo",iPhoneNo);
			getdataPacket.data.add("iUserPwd",iUserPwd);
			getdataPacket.data.add("selectCode",selectCode);
			
			core.ajax.sendPacket(getdataPacket,doRetCfm);
			getdataPacket = null;
				
			}
			
		}
		
		function doRetCfm(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			if(retCode == "000000"){
				rdShowMessageDialog("操作成功！",2);
				window.location.reload();
			}else{
				rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
				window.location.reload();
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
	  		<td width="20%" class="blue">服务号码</td>
	  		<td width="30%">
	  			<input type="text" id="phoneNo" name="phoneNo" value="<%=phoneNo%>" class="InputGrey" readonly />
	  		</td>
	  		<td width="20%" class="blue">客户名称</td>
	  		<td width="30%">
	  			<input type="text" id="custName" name="custName" value="<%=custName%>" class="InputGrey" readonly />
	  		</td>
	  	</tr>
	  	<tr>
	  		<td width="20%" class="blue">小区名称</td>
	  		<td width="80%" colspan="3">
	  			<input type="text" id="filedName" name="filedName" value="" />
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
	<div id="OfferAttribute"></div><!--销售品属性-->
	<!-- 查询结果列表 -->
	<div id="resultContent" style="display:none">
		<div class="title">
			<div id="title_zi">查询结果列表</div>
		</div>
		<table id="exportExcel" name="exportExcel">
			<tbody id="appendBody">
				
			
			</tbody>
		</table>
		<table>
			<tr>
				<td align=center colspan="4" id="footer">
					<input class="b_foot" name="sure"  type="button" value="确定&打印"  onclick="doCfm();">&nbsp;&nbsp;
					<input class="b_foot" name="close"  onClick="removeCurrentTab()" type=button value=关闭>
				</td>
			</tr>
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
