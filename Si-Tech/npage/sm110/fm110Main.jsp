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
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		String newTime=sdf1.format(new Date());
		
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
			var opType = $("input[name='opType'][checked]").val();
			
			var opLogin = $.trim($("input[name='opLogin']").val());
			if(opLogin.length == 0){
				rdShowMessageDialog("请输入操作工号！",1);
				return false;
			}
			var startTime = $("#startCust").val();
			var endTime = $("#endCust").val();
			
			if(startTime.length ==0 ){
				rdShowMessageDialog("请选择开始时间！",1);
				return false;
			}
			if(endTime.length ==0 ){
				rdShowMessageDialog("请选择结束时间！",1);
				return false;
			}
			
				/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm110/fm110Qry_1.jsp","正在获得数据，请稍候......");
			
			var iLoginAccept = "<%=loginAccept%>";
			var iChnSource = "01";
			var iOpCode = opType;
			var iLoginNo = opLogin;
			var iLoginPwd = "<%=noPass%>";
			var iPhoneNo ="";
			var iUserPwd = "";
			var iOpNote = "操作员["+iLoginNo+"]进行"+iOpCode+"操作";
			var iBeginTime = startTime;
			var iEndTime = endTime;
			
			getdataPacket.data.add("iLoginAccept",iLoginAccept);
			getdataPacket.data.add("iChnSource",iChnSource);
			getdataPacket.data.add("iOpCode",iOpCode);
			getdataPacket.data.add("iLoginNo",iLoginNo);
			getdataPacket.data.add("iLoginPwd",iLoginPwd);
			getdataPacket.data.add("iPhoneNo",iPhoneNo);
			getdataPacket.data.add("iUserPwd",iUserPwd);
			getdataPacket.data.add("iOpNote",iOpNote);
			getdataPacket.data.add("iBeginTime",iBeginTime);
			getdataPacket.data.add("iEndTime",iEndTime);
			
			core.ajax.sendPacket(getdataPacket,doRetRegion);
			getdataPacket = null;
			
			
		}
		
	function doRetRegion(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			var retArray = packet.data.findValueByName("retArray");
			if(retCode == "000000"){
				$("#resultContent").show();
				$("#appendBody").empty();
				$("#resultContent2").hide();
				$("#appendBody2").empty();
				$("#excelExp2").attr("disabled","disabled");
				var appendTh = 
					"<tr>"
					+"<th width='8%'>操作</th>"
					+"<th width='23%'>地市名称</th>"
					+"<th width='23%'>操作时间</th>"
					+"<th width='23%'>操作工号</th>"
					+"<th width='23%'>批次号</th>"
					+"</tr>";
				$("#appendBody").append(appendTh);	
				for(var i=0;i<retArray.length;i++){
					var appendStr = "<tr>";
					appendStr += "<td width='8%'>"+"<input type='radio' name='batNoR' value='' onclick='doBatQry(\""+retArray[i][3]+"\",\""+retArray[i][1]+"\");'/>"+"</td>"
											+"<td width='23%'>"+retArray[i][0]+"</td>"
											+"<td width='23%'>"+retArray[i][1]+"</td>"
											+"<td width='23%'>"+retArray[i][2]+"</td>"
											+"<td width='23%'>"+retArray[i][3]+"</td>"

					appendStr +="</tr>";						
					$("#appendBody").append(appendStr);
				}
				$("#excelExp").attr("disabled","");
				
			}else{
				$("#resultContent").hide();
				$("#appendBody").empty();
				$("#excelExp").attr("disabled","disabled");
				rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
				
			}
		}
		var caozuoLiushui="";
		var biaoTime="";
		function doBatQry(batNo,batTime){
			caozuoLiushui=batNo;
			biaoTime=batTime;
			if(biaoTime!=""){
				biaoTime=biaoTime.substring(0,4)+"/"+biaoTime.substring(4,6)+"/"+biaoTime.substring(6);
				biaoTime=biaoTime.trim();
			}
			else{
				biaoTime="<%=newTime%>";
			}
			
			/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm110/fm110Qry_2.jsp","正在获得数据，请稍候......");
			var opType = $("input[name='opType'][checked]").val();
			var iLoginAccept = batNo;
			var iChnSource = "01";
			var iOpCode = opType;
			var iLoginNo = "<%=loginNo%>";
			var iLoginPwd = "<%=noPass%>";
			var iPhoneNo ="";
			var iUserPwd = "";
			var iOpNote = "操作员["+iLoginNo+"]进行"+"<%=opCode%>"+"操作";
			
			
			getdataPacket.data.add("iLoginAccept",iLoginAccept);
			getdataPacket.data.add("iChnSource",iChnSource);
			getdataPacket.data.add("iOpCode",iOpCode);
			getdataPacket.data.add("iLoginNo",iLoginNo);
			getdataPacket.data.add("iLoginPwd",iLoginPwd);
			getdataPacket.data.add("iPhoneNo",iPhoneNo);
			getdataPacket.data.add("iUserPwd",iUserPwd);
			getdataPacket.data.add("iOpNote",iOpNote);
			
			
			core.ajax.sendPacket(getdataPacket,doRetOneRegion);
			getdataPacket = null;
			
		}
		
		function doRetOneRegion(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			var retArray = packet.data.findValueByName("retArray");
			
			if(retCode == "000000"){
				$("#resultContent2").show();
				$("#appendBody2").empty();
				var appendTh = 
					"<tr>"
					+"<th width='12%'>地市名称</th>"
					+"<th width='12%'>手机号码</th>"
					+"<th width='12%'>SIM卡号</th>"
					+"<th width='12%'>客户名称</th>"
					+"<th width='12%'>操作时间</th>"
					+"<th width='12%'>操作工号</th>"
					+"<th width='12%'>操作结果</th>"
					+"<th width='16%'>失败原因</th>"
					+"</tr>";
				$("#appendBody2").append(appendTh);	
				var dyPhone="";
				var geshu=0;
				for(var i=0;i<retArray.length;i++){
					var opResult = retArray[i][6] == "000000"?"成功":"失败";
					var opResMsg = retArray[i][6] == "000000"?"":retArray[i][7];
					if( retArray[i][6] == "000000"){
						dyPhone+=retArray[i][1]+",";
						geshu++;
					}
					
					var appendStr = "<tr>";
					appendStr += "<td width='12%'>"+retArray[i][0]+"</td>"
											+"<td width='12%'>"+retArray[i][1]+"</td>"
											+"<td width='12%'>"+retArray[i][2]+"</td>"
											+"<td width='12%'>"+retArray[i][3]+"</td>"
											+"<td width='12%'>"+retArray[i][4]+"</td>"
											+"<td width='12%'>"+retArray[i][5]+"</td>"
											+"<td width='12%'>"+ opResult +"</td>"
											+"<td width='16%'>"+ opResMsg +"</td>";
					appendStr +="</tr>";
					$("#appendBody2").append(appendStr);
				}
				if(dyPhone!=""){
					dyPhone=dyPhone.substring(0,dyPhone.length-1);
				}
				var appendStr2 = "<tr>";
				appendStr2 += "<td  align=\"center\" colspan=\"8\"><input type='hidden' id='phoneNums' name='phoneNums' value='"+dyPhone+"'><input type='hidden' id='geshu' name='geshu' value='"+geshu+"'><input type=\"button\" class=\"b_foot_long\" value=\"打印免填单\" onclick=\"daYin()\"/></td>";
				appendStr2 +="</tr>";
				$("#appendBody2").append(appendStr2);
				
				$("#excelExp2").attr("disabled","");
				
			}else{
				$("#resultContent2").hide();
				$("#appendBody2").empty();
				$("#excelExp2").attr("disabled","disabled");
				rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
				
			}
		}
		var dayinFlag="N";
		function go_check110Print(){
			dayinFlag="N";
			var pactket2 = new AJAXPacket("fm110ChkPrint.jsp","正在进行电子工单状态修改，请稍候......");
			pactket2.data.add("iLoginAccept",caozuoLiushui);
			core.ajax.sendPacket(pactket2,do_checkPrint);
			pactket2=null;
		}
		function do_checkPrint(packet){
			
			var s_ret_code = packet.data.findValueByName("retCode");
			var s_ret_msg = packet.data.findValueByName("retMsg");
			if(s_ret_code=="000000")
			{
				dayinFlag=packet.data.findValueByName("dayinFlag");
			}
			else{
				rdShowMessageDialog("错误代码："+s_ret_code+",错误信息："+s_ret_msg,1);
				return false;
			}
		}
		
		function go_getUserInfo(){
			var getdataPacket = new AJAXPacket("fm110getUserInfo.jsp","正在获得数据，请稍候......");
			
			var iLoginAccept = caozuoLiushui;
			var iChnSource = "01";
			var iOpCode = "m349";
			var iLoginNo = "<%=loginNo%>";
			var iLoginPwd = "<%=noPass%>";
			var iPhoneNo ="";
			var iUserPwd = "";
			
			getdataPacket.data.add("iLoginAccept",iLoginAccept);
			getdataPacket.data.add("iChnSource",iChnSource);
			getdataPacket.data.add("iOpCode",iOpCode);
			getdataPacket.data.add("iLoginNo",iLoginNo);
			getdataPacket.data.add("iLoginPwd",iLoginPwd);
			getdataPacket.data.add("iPhoneNo",iPhoneNo);
			getdataPacket.data.add("iUserPwd",iUserPwd);
			
			core.ajax.sendPacket(getdataPacket,do_getUserInfo);
			getdataPacket = null;
		}
		var printUserName="";
		var printIdCard="";
		var printCardType="";
		var printJbrName="";
		var printJbrIdCard="";
		var printZfName="";
		var printZfNote="";
		function do_getUserInfo(packet){
			var s_ret_code = packet.data.findValueByName("retCode");
			var s_ret_msg = packet.data.findValueByName("retMsg");
			if(s_ret_code=="000000")
			{
				var retArray = packet.data.findValueByName("retArray");
				printUserName=retArray[0][0];
				printIdCard=retArray[0][1];
				printCardType=retArray[0][2];
				printJbrName=retArray[0][3];
				printJbrIdCard=retArray[0][4];
				printZfName=retArray[0][5];
				printZfNote=retArray[0][6];
				
				
			}
		}
		
		function daYin(){
			go_check110Print();
			if("N"==dayinFlag){
				go_getUserInfo();
				if($.trim($("#phoneNums").val())!=""){
					var returnflag=showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
					if(returnflag!=undefined){
						var pactket2 = new AJAXPacket("/npage/sm407/fm407UpDserv.jsp","正在进行电子工单状态修改，请稍候......");
						pactket2.data.add("id_no","0");
						pactket2.data.add("paySeq",caozuoLiushui);
						core.ajax.sendPacket(pactket2,doserv);
						pactket2=null;
					}
				}
				else{
					rdShowMessageDialog("当前执行结果不可打印!只有全部执行完成才可打印,且只打印成功号码!");
				}
			}
			else{
				rdShowMessageDialog("不可以重复打印免填单!");
			}
		}	

		function doserv(packet)
		{
			var s_ret_code = packet.data.findValueByName("s_ret_code");
			var s_ret_msg = packet.data.findValueByName("s_ret_msg");
			if(s_ret_code!="000000")
			{
				rdShowMessageDialog("更新电子工单状态失败!错误代码:"+s_ret_code+",错误原因:"+s_ret_msg);
			}else{
				//location = location;
			}
		}
				  
				  function showPrtDlg(printType,DlgMessage,submitCfm){  //显示打印对话框 
				      var h=180;
				      var w=350;
				      var t=screen.availHeight/2-h/2;
				      var l=screen.availWidth/2-w/2;		   	   
				      var pType="subprint";             				 	//打印类型：print 打印 subprint 合并打印
				      var billType="1";              				 			  //票价类型：1电子免填单、2发票、3收据
				      var sysAccept =caozuoLiushui;             	//流水号
				      var printStr = printInfo(printType);
					 	//调用printinfo()返回的打印内容
				      var mode_code=null;           							  //资费代码
				      var fav_code=null;                				 		//特服代码
				      var area_code=null;             				 		  //小区代码
				      var opCode="m110";                   			 	//操作代码
				      var phoneNo="";                  //客户电话
				      
				      var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
				      var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
				      path+="&mode_code="+mode_code+
				      	"&fav_code="+fav_code+"&area_code="+area_code+
				      	"&opCode=m110&sysAccept="+sysAccept+
				      	"&phoneNo="+phoneNo+
				      	"&submitCfm="+submitCfm+"&pType="+
				      	pType+"&billType="+billType+ "&printInfo=" + printStr;
				      var ret=window.showModalDialog(path,printStr,prop);
				      return ret;
				    }				
				    
				    var print_info_arr = new Array();
				    /*
				     输出参数：
								客户名称
								证件类型
								证件号码
								经办人姓名
								经办人证件号码
								主资费名称
								主资费描述
				出参。下标从0开始
				*/

						//打印模板id为：93
				    function printInfo(printType){
				      var cust_info="";
				      var opr_info="";
				      var note_info1="";
				      var note_info2="";
				      var note_info3="";
				      var note_info4="";
				      var retInfo = "";
				      var array = new Array();
				      array["8"]="营业执照";
				      array["A"]="组织机构代码";
				      array["B"]="单位法人证书";
				      array["C"]="单位证明";
				      
				      cust_info+="客户姓名："+printUserName+"|";
				      cust_info+="证件号码："+printIdCard+"|";
				      cust_info+="证件类型："+printCardType+"|";
				      cust_info+="经办人姓名："+printJbrName+"|";
						cust_info+="经办人证件号码："+printJbrIdCard+"|";
				      
						opr_info+="办理业务：批量普通开户      ";
						opr_info+="号码个数："+$("#geshu").val()+"      ";
						opr_info+="操作流水："+caozuoLiushui+"|";
						opr_info+="业务受理时间："+biaoTime+"|";
						opr_info+="主资费："+printZfName+"|";
						opr_info+="主资费描述："+printZfNote+"|";
						var phoneNums=$("#phoneNums").val().split(",");
						var showPhones="";
						for(var i=0;i<phoneNums.length;i++){
							showPhones+=phoneNums[i]+",";
							if((i+1)%5==0){
								showPhones+="|";
							}
						}
						
						opr_info+=showPhones.substring(0,showPhones.lastIndexOf(","))+"|";
				      
				      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
				      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
				      return retInfo;
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
	  		<td width=16% class="blue">开户类型</td>
	  		<td width=84% colspan="3">
	  			<input type="radio" name="opType"	value="m108" checked/>m108-批量校园预开户 &nbsp;&nbsp;
	  			<input type="radio" name="opType"	value="m109" />m109-批量渠道预开户 &nbsp;&nbsp;
	  			<input type="radio" name="opType"	value="m349" />m349-批量普通开户 &nbsp;&nbsp;
	  		</td>
	    </tr>
	    <tr>
	  		<td width=16% class="blue">操作工号</td>
	  		<td width=84% colspan="3">
	  			<input type="text" name="opLogin" value=""/>&nbsp;<font color="red">*</font>
	  		</td>
	    </tr>
	    <tr>
	  		<td width="20%" class="blue">开始时间</td>
					<td width="30%">
							<input type="text"  id="startCust"  name="startCust" readOnly onclick="WdatePicker({el:'startCust',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd 00:00:00',alwaysUseStartDate:true,maxDate:'#F{$dp.$D(\'endCust\')||\'%y-%M-%d\'}',minDate:'%y-#{%M-1}-d%'})" value=""/>
								<img id = "imgCustStart" 
									onclick="WdatePicker({el:'startCust',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd 00:00:00',alwaysUseStartDate:true,maxDate:'#F{$dp.$D(\'endCust\')||\'%y-%M-%d\'}',minDate:'%y-#{%M-1}-d%'})" 
				 					src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">&nbsp;<font color="red">*</font>
					</td>
				<td width="20%" class="blue">结束时间</td>
				<td width="30%">
					<input type="text"  id="endCust"  name="endCust" readOnly onclick="WdatePicker({el:'endCust',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd 23:59:59',alwaysUseStartDate:true,minDate:'#F{$dp.$D(\'startCust\')}',maxDate:'%y-%M-%d'})" value=""/>
								<img id = "imgCustEnd" 
									onclick="WdatePicker({el:'endCust',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd 23:59:59',alwaysUseStartDate:true,minDate:'#F{$dp.$D(\'startCust\')}',maxDate:'%y-%M-%d'})" 
				 					src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">&nbsp;<font color="red">*</font>
				</td>
	
	    </tr>
	    <tr> 
			<td align=center colspan="4" id="footer">
				<input class="b_foot" name="sure"  type="button" value="查询"  onclick="doQry();">
				<input class="b_foot" name=close  onClick="removeCurrentTab()" type=button value=关闭>
				<input  name="back1"  class="b_foot" type="button" value="导出excel" id="excelExp" onclick="printTable(exportExcel)" disabled="disabled">
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
	
	<!-- 查询结果列表 -->
	<div id="resultContent2" style="display:none">
		<div class="title">
			<div id="title_zi">详细信息</div>
		</div>
		<table id="exportExcel2" name="exportExcel2">
			<tbody id="appendBody2">
				
			
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
