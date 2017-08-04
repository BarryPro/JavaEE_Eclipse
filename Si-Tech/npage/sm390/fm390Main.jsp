<%
  /*
   * 功能: 
   * 版本: 1.0
   * 日期: gaopeng 2015/02/11 9:50:29 关于11月份集团客户部CRM、BOSS和经分系统需求的函-7-行业应用流量卡BOSS系统需求
   * 作者: gaopeng
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%@ page import="java.text.SimpleDateFormat"%>
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
		String nowMonth =new SimpleDateFormat("yyyyMM").format(new java.util.Date()).toString();
		
    
		/*
	  String[][] temfavStr = (String[][])session.getAttribute("favInfo");
		String[] favStr = new String[temfavStr.length];
		boolean operFlag = false;
		for(int i = 0; i < favStr.length; i ++) {
			favStr[i] = temfavStr[i][0].trim();
		}
		if (WtcUtil.haveStr(favStr, "a996")) {
			operFlag = true;
		}*/
		
		
	
	 
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
			
			
			var batOpCode = $.trim($("select[name='batOpCode']").find("option:selected").val());
			var opAccept = $.trim($("#opAccept").val());
			if(opAccept.length == 0){
				rdShowMessageDialog("请输入操作流水！");
				return false;
			}
			/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm390/fm390Qry.jsp","正在获得数据，请稍候......");
			
			var iLoginAccept = "<%=loginAccept%>";
			var iChnSource = "01";
			var iOpCode = batOpCode;
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
			getdataPacket.data.add("opAccept",opAccept);
			
			
			core.ajax.sendPacket(getdataPacket,doRetRegion);
			getdataPacket = null;
			
			
		}
	var phoneIdNo = "";
	function doRetRegion(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			var infoArray = packet.data.findValueByName("infoArray");
			
			var phoneMsg = packet.data.findValueByName("phoneMsg");
			var phoneIdNo1 = packet.data.findValueByName("phoneIdNo");
			phoneIdNo = phoneIdNo1;
			
		if(retCode == "000000"){
			
				$("#phoneMsg").val(phoneMsg);
				$("#resultContent").show();
				$("#appendBody").empty();
				var batOpCode = $.trim($("select[name='batOpCode']").find("option:selected").val());
				var batOpName = $.trim($("select[name='batOpCode']").find("option:selected").text());
				var showOpCode = "";
				var showOpName = "";
				if(batOpCode == "m389"){
					showOpCode = "m058";
					showOpName = "实名登记";
				}
				var appendTh = 
					"<tr>"
					+"<th style='display:none' width='10%'><input type='checkbox' style='display:none' name='checkall' onclick='checkAllCG();'/> 全选</th>"
					+"<th width='10%'>手机号码</th>"
					+"<th width='12%'>操作工号</th>"
					+"<th width='12%'>操作时间</th>"
					+"<th width='12%'>批量业务操作代码</th>"
					+"<th width='12%'>批量业务操作名称</th>"
					+"<th width='12%'>操作结果</th>"
					+"<th width='12%'>失败原因</th>"
					+"</tr>";
				$("#appendBody").append(appendTh);	
			for(var i=0;i<infoArray.length;i++){
			
					var arr0 = infoArray[i][0];
					var arr1 = infoArray[i][1];
					var arr2 = infoArray[i][2];
					var arr3 = infoArray[i][3];
					var arr4 = infoArray[i][4];
					var arr5 = infoArray[i][5];
					
					var appendStr = "<tr>";
					
					appendStr +=
											"<td style='display:none' width='10%' align='center' >"+"<input type='checkbox' style='display:none' name='checkOne'/>"+"</td>" 
											+"<td width='12%' align='center' >"+arr0+"</td>"
											+"<td width='12%' align='center' >"+arr2+"</td>"
											+"<td width='12%' align='center' >"+arr1+"</td>"
											+"<td width='12%' align='center' >"+batOpCode+"</td>"
											+"<td width='12%' align='center' >"+batOpName+"</td>"
											+"<td width='12%' align='center' >"+arr5+"</td>"
											+"<td width='12%' align='center' >"+arr4+"</td>"
					appendStr +="</tr>";	
					
					
									
					$("#appendBody").append(appendStr);
					$("input[name='checkall']").attr("checked","checked")
					checkAllCG();
				}
				
				
			}else{
				$("#resultContent").hide();
				$("#appendBody").empty();
				//$("#export").attr("disabled","disabled");
				rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
				
			}
		}
		
		/*将所有成功的都选中*/
		function checkAllCG(){
			var checkall = $("input[name='checkall']").attr("checked");
			$("#appendBody").find("tr").each(function(){
				var cgFlag = $(this).find("td").eq(6).html();
				if(cgFlag == "成功"){
					if(checkall){
						$(this).find("td").eq(0).find("input").attr("checked","checked");
					}else{
						$(this).find("td").eq(0).find("input").attr("checked",false);
					}
				}
				
			});
			
		}
		/*打印免填单*/
		var banliNum = 0;
		function doprintM(){
			
			doChkPrint();
			if(!chkFlag){
				return false;
			}
			
			var phoneMsg = $("#phoneMsg").val();
			var msgArr = new Array();
			msgArr = phoneMsg.split("\\|");
			//手机号码|老客户名称|新客户名称|新证件号码|新客户地址|24个月限制标识
			var phoneNo = msgArr[0];
			
			/*获取成功的并打印免填单*/
			var i=0;
			var phoneNo = "";
			$("#appendBody").find("tr").each(function(){
				var checkOne = $(this).find("td").eq(0).find("input").attr("checked");
				var cgFlag = $(this).find("td").eq(6).html();
				if(cgFlag == "成功"){
					if(checkOne){
						i++;
					}else{
						
					}
				}
				
			});
			
			if(i==0){
				rdShowMessageDialog("没有操作成功的信息！");
				return false;
			}
			banliNum = i;
			phoneNo = phoneNo+"等"+i+"个";
			
			var  ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes",phoneNo);
			
			var pactket2 = new AJAXPacket("/npage/sm390/fm390UpDserv.jsp","正在进行电子工单状态修改，请稍候......");
			//alert(phoneIdNo);
			pactket2.data.add("id_no",phoneIdNo);
			pactket2.data.add("paySeq",$.trim($("#opAccept").val()));
			core.ajax.sendPacket(pactket2,doserv);
			pactket2=null;
			
		}
		
		function doserv(packet)
		{
			var s_ret_code = packet.data.findValueByName("s_ret_code");
			var s_ret_msg = packet.data.findValueByName("s_ret_msg");
		//	alert("s_ret_code is "+s_ret_code);
			if(s_ret_code!="000000")
			{
				//rdShowMessageDialog("更新电子工单状态失败!错误代码:"+s_ret_code+",错误原因:"+s_ret_msg);
			}
		}
		
		function showPrtDlg(printType,DlgMessage,submitCfm){  //显示打印对话框 
			
			var phoneMsg = $("#phoneMsg").val();
			var msgArr = new Array();
			msgArr = phoneMsg.split("|");
			//手机号码|老客户名称|新客户名称|新证件号码|新客户地址|24个月限制标识
			var phoneNo = msgArr[0];
      var h=180;
      var w=350;
      var t=screen.availHeight/2-h/2;
      var l=screen.availWidth/2-w/2;		   	   
      var pType="subprint";             				 	//打印类型：print 打印 subprint 合并打印
      var billType="1";              				 			  //票价类型：1电子免填单、2发票、3收据
      var sysAccept =$.trim($("input[name='opAccept']").val());             	//流水号
        var printStr = printInfo(printType);
      
	 		                      //调用printinfo()返回的打印内容
      var mode_code=null;           							  //资费代码
      var fav_code=null;                				 		//特服代码
      var area_code=null;             				 		  //小区代码
      var opCode="m389" ;                   			 	//操作代码
      
      
      var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
      var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
      path+="&mode_code="+mode_code+
      	"&fav_code="+fav_code+"&area_code="+area_code+
      	"&opCode="+opCode+"&sysAccept="+$.trim($("input[name='opAccept']").val())+
      	"&phoneNo="+phoneNo+
      	"&submitCfm="+submitCfm+"&pType="+
      	pType+"&billType="+billType+ "&printInfo=" + printStr;
      var ret=window.showModalDialog(path,printStr,prop);
      return ret;
    }				
			
    function printInfo(printType){
    	
    	var phoneMsg = $("#phoneMsg").val();
			var msgArr = new Array();
			msgArr = phoneMsg.split("|");
			//手机号码|老客户名称|新客户名称|新证件号码|新客户地址|24个月限制标识
			var phoneNo = msgArr[0];
			var custNameOld = msgArr[1];
			var custNameNew = msgArr[2];
			var custIdIccId = msgArr[3];
			var addr = msgArr[4];
			var flag24 = msgArr[5];
			
			var flag24Show = "";
			if(flag24 == "N"){
				flag24Show = "不能过户和实名登记(时间为2050年)";
			}
			else if(flag24 == "Y"){
				flag24Show = "不限制过户和实名登记";
			}
			else if(flag24 == "K"){
				flag24Show = "24个月不能过户和实名登记";
			}
			
			
      var cust_info="";
      var opr_info="";
      var note_info1="";
      var note_info2="";
      var note_info3="";
      var note_info4="";
      var retInfo = "";
      
			cust_info += "手机号码：   "+phoneNo+"等"+banliNum+"个|";
			cust_info += "客户姓名：   "+custNameOld+"|";
      opr_info += "办理业务：   "+"单位批量实名登记" +"|";
      opr_info += "操作流水：   "+$.trim($("input[name='opAccept']").val())+"|";
      opr_info +="本次批量将"+banliNum+"个用户号码 由 "+custNameOld+" 实名登记到 "+custNameNew+"|";
      opr_info +="新客户资料："+" 客户名称："+custNameNew+"  证件号码："+custIdIccId+"|";
      opr_info +="客户地址："+addr+"|";     
      opr_info +="批量实名登记号码明细：|";
      var kkk=0;
 			$("#appendBody").find("tr").each(function(){
				var checkOne = $(this).find("td").eq(0).find("input").attr("checked");
				var cgFlag = $(this).find("td").eq(6).html();
				if(cgFlag == "成功"){
					if(checkOne){
						kkk++;
						var	phoneNo2 = $(this).find("td").eq(1).html();
						if(kkk%4==0 && kkk!=0){
							opr_info +=phoneNo2+"|";
						}else{
							opr_info +=phoneNo2+"  ";
						}
						
						
					}else{
						
					}
					
				}
			});
 			/*最后也加一个竖线*/
					opr_info += "|";
 			note_info1+="备注：操作员<%=loginNo%>对用户"+banliNum+"个手机号码进行实名登记，此批号码所有业务实名登记后均保留。|";
 			note_info1+=flag24Show+"|";
      
      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
      return retInfo;
    } 
    
    var chkFlag = false;
    function doChkPrint(){
			
			var opAccept = $.trim($("#opAccept").val());
			if(opAccept.length == 0){
				rdShowMessageDialog("请输入操作流水！");
				return false;
			}
			/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm390/fm390ChkPrint.jsp","正在获得数据，请稍候......");
			
			
			getdataPacket.data.add("iLoginAccept",opAccept);
			
			core.ajax.sendPacket(getdataPacket,doRetRegion2);
			getdataPacket = null;
			
			
		}
		
		function doRetRegion2(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			var miguFlag = packet.data.findValueByName("miguFlag");
			if(retCode =="000000"){
				if(miguFlag == "Y"){
					rdShowMessageDialog("免填单已打印！，不允许重复打印！");
					chkFlag = false;
					return false;
				}else{
					chkFlag = true;
				}
			}else{
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
	  		<td width="20%" class="blue">批量业务操作代码</td>
	  		<td width="30%">
	  			<select name="batOpCode">
	  				<option value="m389" selected>单位批量实名登记</option>
	  			</select>
	  		</td>
	  		<td width="20%" class="blue">操作流水</td>
	  		<td width="30%">
	  			<input type="text" id="opAccept"  name="opAccept" value="" />
	  		</td>
	    </tr>
	  </table>
	 <div>
	
	 <table>
	   <tr>
			<td align=center colspan="4" id="footer">
				<input class="b_foot" id="configBtn" name="configBtn"  type="button" value="查询"   onclick="doQry();">&nbsp;&nbsp;
				<input class="b_foot" id="resetBtn" name="resetBtn"  type="button" value="重置"  onclick="javascript:window.location.reload();">&nbsp;&nbsp;
				<input class="b_foot" name="close"  onClick="removeCurrentTab()" type=button value=关闭>
			</td>
		</tr>
		
		</table>
		
		<!-- 查询结果列表 -->
		<div id="resultContent" style="display:none">
			<div class="title">
				<div id="title_zi">信息查询结果</div>
			</div>
			<table id="exportExcel" name="exportExcel">
				<tbody id="appendBody">
					
				
				</tbody>
			</table>
			<table>
			   <tr>
					<td align=center colspan="4" id="footer">
						<input class="b_foot" id="configBtn1" name="configBtn1"  type="button" value="打印免填单"   onclick="doprintM();">&nbsp;&nbsp;
						<input class="b_foot" id="configBtn2" name="configBtn2"  type="button" value="导出Excel表格"   onclick="printTable();">&nbsp;&nbsp;
					</td>
				</tr>
				
				</table>
		</div>
		
		
	
	</div>
	<input type="hidden" name="iLoginAcceptnew" id="iLoginAcceptnew" />
	<input type="hidden" name="oCustName" id="oCustName" value=""/>
	<input type="hidden" name="oIccidNo" id="oIccidNo" value=""/>
	<input type="hidden" name="oCustId" id="oCustId" value=""/>
	<input type="hidden" name="phoneMsg" id="phoneMsg" value=""/>
	
	 

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
			    for(j=1;j<cells;j++)
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
