<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.ws3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient,java.util.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String loginNo = (String)session.getAttribute("workNo");
	String contactId = request.getParameter("contactId")==null?"":request.getParameter("contactId");
%>
<title>来电原因-->IVR语音</title>
<script type="text/javascript">
	function clickBox() {
		var ivrBoxObj = document.getElementsByName("ivrBox");
		//transButton按钮控制
		var checkedCount = 0;
		for (var i=0;i<ivrBoxObj.length;i++) {
			if (ivrBoxObj[i].checked) {
				checkedCount++;
				break;
			}
		}
		if (checkedCount == 0) {
			document.getElementById("transButton").disabled = true;
		} else {
			document.getElementById("transButton").disabled = false;
		}
		//显示短信内容
		sendSMS.messageArray = new Array();
		for (var i=0;i<ivrBoxObj.length;i++) {
			if(ivrBoxObj[i].checked && ivrBoxObj[i].msg != ''){
				sendSMS.messageArray.push(ivrBoxObj[i].msg);
			}
		}
		sendSMS.genHTMLByArray();
	}
	
	function transToIvr(){
		
		var ivrBoxObj = document.getElementsByName("ivrBox");
		var checkedCount = 0;
		var ywCheckedCount = 0;
		var zxCheckedCount = 0;
		for (var i=0;i<ivrBoxObj.length;i++) {
			if (ivrBoxObj[i].checked) {
				checkedCount++;
				if (ivrBoxObj[i].serviceFlag == '0') {
					ywCheckedCount++;
				}
				if (ivrBoxObj[i].serviceFlag == '1') {
					zxCheckedCount++;
				}
			}
		}
		if (ywCheckedCount > 0 && zxCheckedCount > 0) {
			rdShowMessageDialog("不能同时转业务办理和咨询语音",1);
			return;
		}
		if (checkedCount > 5) {
			rdShowMessageDialog("最多只能同时转5条自动语音",1);
			return;
		}
		
		//取页面选中数据
		var serviceNames = document.getElementById("serviceNames").value;
		var serviceIds = document.getElementById("serviceIds").value;
		var serviceFlags = document.getElementById("serviceFlags").value;
		var userType = document.getElementById("userType").value;
		var typeId = document.getElementById("typeId").value;
		
		//取得随路数据
		var mainWin = window.parent.pWindow.parent.opener;
		var huaWeiUserClass = mainWin.document.getElementById("huaWeiUserClass").value;
		var callData = mainWin.cCcommonTool.QueryCallDataEx(5);
		var callDataArr = callData.split(",");
		var accessCode = '';
		if (callDataArr[0] != '' && callDataArr[0].substr(4) == '12580') {
			accessCode = callDataArr[0].substr(4);
		} else {
			accessCode = '10086';
		}
		var cityCode = callDataArr[1];
		if (huaWeiUserClass == '') {
			huaWeiUserClass = callDataArr[2];
		}
		var userClass = huaWeiUserClass;
		var serviceNo = callDataArr[3];
		var digitCode = callDataArr[4];
		var callerNo = callDataArr[5];
		var userTypeBegin = callDataArr[6];		
		
		//分解ext2
		var ext2 = "";
		var tempExt2_00 = "";
		var tempExt2_01 = "";
		var ivrBoxObj = document.getElementsByName("ivrBox");
		for (var i=0;i<ivrBoxObj.length;i++) {
			var inReg = '';
			var serviceFlag = ivrBoxObj[i].serviceFlag;
			if (serviceFlag == '0') {/**转业务办理.*/
				inReg = "00";
			}
			if (serviceFlag == '1') {/**转业务咨询.*/
				inReg = "01";
			}
			/**获得ext2的数据.*/
			var tempExt2 = ivrBoxObj[i].value + "~" + inReg + "^" 
									+ ivrBoxObj[i].cityCode + "^" + ivrBoxObj[i].userClass + "^" 
									+ userTypeBegin + "^" + ivrBoxObj[i].digitCode+ "^" 
									+ serviceNo + ",";
			if (serviceFlag == '0') {/**转业务办理.*/
				tempExt2_00 += tempExt2;
			}
			if (serviceFlag == '1') {/**转业务咨询.*/
				tempExt2_01 += tempExt2;
			}
		}
		ext2 = tempExt2_01 + tempExt2_00;
		if(ext2 == ''){
			rdShowMessageDialog("请选择语音节点",1);
			return;
		}
		ext2 = ext2.substring(0,ext2.length-1);
		var Ext2 = getHuaWeiExt2(ext2,typeId);
		//转移方式
		var transType = '0';
		
		//转接信息入库
		mainWin.insertAllIvr(callerNo,transType,digitCode,"",cityCode,accessCode,userClass,serviceNames,serviceIds,"N",serviceFlags);
		//转IVR
		mainWin.cCcommonTool.toIvr(accessCode,transType,digitCode,userType,Ext2,userClass);
		//插入操作日志到db
		operation_history();
		window.parent.close();
	}
	
	function getHuaWeiExt2(ext2,typeId){
		var Ext2="";
		var temp="";
		if(ext2==''||typeId==''||ext2==undefined||typeId==undefined) {
			return false;
		}
		var arrayStr=ext2.split(",");
		if(arrayStr.length==1){
		 	Ext2=typeId+arrayStr[0].substr(arrayStr[0].indexOf("~"));
		} else {
			for(var i=0;i<arrayStr.length;i++){
			  temp+=arrayStr[i].substr(arrayStr[i].indexOf("~"));
			}
			Ext2="2000"+temp;
		}
		return Ext2;
	}
	
	//插入操作记录到数据库
	function operation_history(){
		var checked_ivrs = $("#data input:checked");
		var callcausetoivr_ids = "";
		var contactId = "<%=contactId%>";
		var loginNo = "<%=loginNo%>";
		var today = new Date();
  	var month = today.getMonth()+1;
  	month = (month < 10 ? "0"+month:month);
  	var tablename = "" + today.getFullYear() + (month < 10 ? ("0"+month) : month);
		if(!contactId || contactId == ""){
			return;gf
		}
		if(checked_ivrs.length){
			for(var i=0 ;i<checked_ivrs.length;i++){
				callcausetoivr_ids += checked_ivrs.eq(i).attr("callcause_ivr_id") + ",";
			}
			callcausetoivr_ids = callcausetoivr_ids.substring(0,callcausetoivr_ids.length-1);
		}else{
			return;
		}
		var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k171/k171_operation_history.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
		packet.data.add("operation_id",callcausetoivr_ids);
		packet.data.add("flag","1"); //标示，1代表专ivr
		packet.data.add("loginNo",loginNo);
		packet.data.add("contactId",contactId);
		packet.data.add("tablename",tablename);
		core.ajax.sendPacket(packet,function(data){},true);
		packet=null;
	}
</script>
<style type="text/css">
#data {
	height:180px;
	overflow-y:scroll;
	border:1px solid #99BBE8;
	padding:2px;
}
#operation {
	border:1px solid #99BBE8;
	border-top:0;
	padding:2px;
}
</style>
</head>
<body>
	<div id="Operation_Table">
		<div class="title"><div id="title_zi">转IVR语音</div></div>
		
		<div id="data">
			<table style="width:95%">
	<%
		String causeId = request.getParameter("causeId")==null?"":request.getParameter("causeId");
		String userClass = request.getParameter("userClass")==null?"":request.getParameter("userClass");
		String cityCode = request.getParameter("cityCode")==null?"":request.getParameter("cityCode");
		System.out.println("ts test >>>>>>>>>>>>userClass=" + userClass);
		System.out.println("ts test >>>>>>>>>>>>cityCode=" + cityCode);
		List list = null;
		String serviceIds = "";
		String serviceNames = "";
		String serviceFlags = "";
		String typeId = "";
		String userType = "";
		if (!causeId.equals("")) {
			Map pMap = new HashMap();
			pMap.put("causeId",causeId);
			pMap.put("userClass",userClass);
			pMap.put("cityCode",cityCode);
			list = KFEjbClient.queryForList("query_k171_causeToIVR", pMap);
		}
		if (list != null) {
			for (int i = 0; i < list.size(); i++) {
				Map map = (Map)list.get(i);
				String serviceId = (String)map.get("IVR_ID");
				String serviceName = (String)map.get("SERVICENAME");
				String serviceFlag = (String)map.get("FLAG");
				String digitCode = (String)map.get("DIGITCODE");
				String callcause_ivr_id = (String)map.get("ID"); //dcallcausetoivr主键
				typeId = (String)map.get("TYPEID");
				userType = (String)map.get("USERTYPE");
				//咨询语音的短信内容
				String msg = map.get("MSG")==null?"":(String)map.get("MSG");
				String serviceTypeName = "";
				if ("0".equals(serviceFlag)) {
					serviceTypeName = "[业务办理]";
				} else {
					serviceTypeName = "[咨询语音]";
				}
				
				serviceIds += serviceId + ",";
				serviceNames += serviceName + ",";
				serviceFlags += serviceFlag + "~";
	%>
				<tr>
					<td>
						<input type="checkbox" name="ivrBox" onclick="clickBox()" value="<%=serviceId%>"
						cityCode="<%=cityCode%>" userClass="<%=userClass%>" digitCode="<%=digitCode%>" serviceFlag="<%=serviceFlag%>" msg="<%=msg%>" callcause_ivr_id="<%=callcause_ivr_id%>" />
						<%=serviceName%>
						&nbsp;&nbsp;&nbsp;<%=serviceTypeName%>
					</td>
				</tr>
	<%
			}
			if (serviceIds.endsWith(",")) {
				serviceIds = serviceIds.substring(0,serviceIds.length()-1);
			}
			if (serviceNames.endsWith(",")) {
				serviceNames = serviceNames.substring(0,serviceNames.length()-1);
			}
			if (serviceFlags.endsWith("~")) {
				serviceFlags = serviceFlags.substring(0,serviceFlags.length()-1);
			}
		}
	%>
			</table>
			<input type="hidden" id="serviceIds" value="<%=serviceIds%>" />
			<input type="hidden" id="serviceNames" value="<%=serviceNames%>" />
			<input type="hidden" id="serviceFlags" value="<%=serviceFlags%>" />
			<input type="hidden" id="typeId" value="<%=typeId%>" />
			<input type="hidden" id="userType" value="<%=userType%>" />
		</div>
		
		<div id="operation">
			<div>
  			<iframe name="sendSMS" src="../K083/K083_msgSend4CallTrans.jsp"
  			 frameborder="0" width="370px" height="330px" marginwidth="0" 
  			 marginheight="0" scrolling="auto" src=""></iframe>	
			</div>
			<div style="text-align:center">
				<input type="button" class="b_foot" id="transButton" value="呼叫转移" disabled="disabled" onClick="transToIvr()" />
			</div>
		</div>
	</div>
</body>
</html>