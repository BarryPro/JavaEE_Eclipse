<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.ws3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient,java.util.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>

<%!
	boolean isChinaMobile(String telephone) {
		String[] CMStartNoArr = {"134","135","136","137","138","139","147",
		                         "150","151","152","157","158","159","182",
		                         "187","188","183"};
		if (telephone == null || telephone.length() < 11) {
			return false;
		}
		String startNo = telephone.substring(0,3);
		for (int i = 0; i < CMStartNoArr.length; i++) {
			if (startNo.equals(CMStartNoArr[i])) {
				return true;
			}
		}
		return false;
	}
%>

<%
	String loginNo = (String)session.getAttribute("workNo");
	String contactId = request.getParameter("contactId")==null?"":request.getParameter("contactId");
	String acceptPhone = request.getParameter("acceptPhone")==null?"":request.getParameter("acceptPhone");
	String callerPhone = request.getParameter("callerPhone")==null?"":request.getParameter("callerPhone");
	String acceptUserType = null;
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);	
%>
<title>来电原因-->知识库</title>
<script type="text/javascript">
	function clicklink(knowledgeId,callcause_knowledge_id) {
			/*修改知识库路径by sunbya20120531 
		var pathhead = "http://10.110.45.7/csp/kbs/showKng.action?kngId=";
		var pathend="&dispId=&kngTblFlag=0&articleFlag=true&relativeKngFlag=true&buttonFlag=true&coluKngType=2&coluKngName=&kngPointName=&kngPointPath=&showType=1";						
		var features = "titlebar=no,resizable=yes";*/
		var pathhead = "http://10.110.45.10/csp/kbs/showKng.action?kngId=";
		var pathend="&kngTblFlag=0&relativeKngFlag=true&buttonFlag=true&articleFlag=true&showType=1&clickingLogFlag=1&channelId=0";						
		var features = "titlebar=no,resizable=yes";
		//插入操作
		window.open(pathhead+knowledgeId+pathend,"_blank",features);
		var  mainWin = window.top.pWindow.top.opener;//三位一体页面
		if(mainWin.parPhone.IsTalking==1){
			operation_history(callcause_knowledge_id);
			}
	}
	
	function operation_history(callcause_knowledge_id){
	
		var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k171/k171_operation_history.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
		var contactId = "<%=contactId%>";
		
		var today = new Date();
  	var month = today.getMonth()+1;
  	month = (month < 10 ? "0"+month:month);		
  	var tablename = "" + today.getFullYear() +  month;
  	
		if(contactId==null || contactId == ""){
			return;
		}
		var loginNo = "<%=loginNo%>";
		packet.data.add("operation_id",callcause_knowledge_id);
		packet.data.add("loginNo",loginNo);
		packet.data.add("flag","0");
		packet.data.add("contactId",contactId);
		packet.data.add("tablename",tablename);
			
		core.ajax.sendPacket(packet,function(data){},true);
		packet=null;
	}
	
	//add by lipf校验短信节点没有短信内容，发送邮件按钮置灰
	function checkOption(msgContent){
		if(msgContent>0){
			$('#sendMail').attr('disabled',false);
		}else{
			$('#sendMail').attr('disabled',true);
		}
	}
	//add by lipf 12_02_23 发送邮件
	$(function(){
		$('#sendMail').click(function(){
			//取主页面对象
			var winObj=window.parent.dialogArguments.parent.opener;
			//取IVR页面对象
			var frameObj=window.parent.frames["ivrframe"];
			var caller_phone_no = "";//获取主叫号码
			if(winObj.cCcommonTool.getOp_code()=="K025"){
				caller_phone_no = winObj.cCcommonTool.getCalled();
			}else{
				caller_phone_no = winObj.cCcommonTool.getCaller();
			}
			var reg = /^1((3[4-9])||(5[0-2])||(5[7-9])||(8[7-8])||(8[2-3])||(47))\d{8}$/g; 
			var sm_code=frameObj.$('#userClass_0').val();//用户级别
			if(caller_phone_no==""){
				rdShowMessageDialog('来电号码为空', 0);
				return false;
			}else if (!reg.test(caller_phone_no)){ 
				rdShowMessageDialog("只能发送给移动用户！",0);
				return false; 
			}else if(sm_code=="20"){
				rdShowMessageDialog('不能发送给它网异地用户', 0);
				return false;
			}
			var belong_code=frameObj.$('#cityCode_0').val();//用户地市
			var accept_phone = winObj.$("#phone_no1").html();//获取受理号码
			var contactId=winObj.$("#contactIdnew").html();//获取接触流水
			var msg_content=window.frames["sendSMS"].messageArray;
			var requestXml="";
			var ivrName = "";
			ivr_id = "";
			var serviceName = window.parent.ivrframe.document.getElementById("ivr_serviceName").value;
			ivrName = serviceName.split(";");
			serviceName = "";
			for(var k = 0; k < ivrName.length; k++){
				serviceName += ivrName[k].substring(ivrName[k].indexOf("→")+1,ivrName[k].length) + ";";
				ivr_id += ivrName[k].substring(0,ivrName[k].indexOf("→")) + ";";
			}
			var flag = 1;
			requestXml+=" <request>"+
									"<msisdn name=\"手机号码\">"+caller_phone_no+"</msisdn>"+
									"<consultation name=\"咨询内容\">";
			for(var i=0;i<msg_content.length;i++){
				var j=0;
				while(typeof(frameObj.$('#serviceName_'+j).val())!="undefined"){
					if($.trim(msg_content[i])==$.trim(frameObj.$('#msg_'+j).val())){
						requestXml+="<service_name name=\"业务名称\">"+frameObj.$('#serviceName_'+j).val()+"</service_name>"+
										"<detailed_content name=\"详细内容\">"+msg_content[i]+"</detailed_content>";
					}
					j++;
				}
			}
			requestXml+="</consultation>"+
									"</request>";
			$.ajax({
				url:'<%=request.getContextPath()%>/npage/callbosspage/K139/k139_sendEmail.jsp',
				data:{'accept_phone':accept_phone,'belong_code':belong_code,'contactId':contactId,
					'sm_code':sm_code,'requestXml':requestXml,'caller_phone_no':caller_phone_no,
					'ivr_id':ivr_id,'serviceName':serviceName,'flag':flag},
				type:'POST',
				dataType:'json',
				success:function(res){
					if(res.retCode=="000000"){
						rdShowMessageDialog("发送成功！",2);
					}else{
						rdShowMessageDialog("发送失败！",0);
					}
				},
				error:function(res){
					rdShowMessageDialog("网络异常 "+res.status,0);
				}
			});
		});
	})

	//add by tangsong 20120305 记录电子答案库发送日志
	function insertQuestionLibLog() {
		var doc = window.parent.questionframe.document;
		var sendData = "selectid=" + doc.getElementById("selectid").value
					+ "&question_name=" + doc.getElementById("question_name").value
					+ "&question_answser=" + doc.getElementById("question_answser").value
					+ "&user_class=" + doc.getElementById("user_class").value
					+ "&city_code=" + doc.getElementById("city_code").value
					+ "&contactid=" + doc.getElementById("contactid").value;	
		
		$.ajax({
			url: '<%=request.getContextPath()%>/npage/callbosspage/questionlibrary/sendLog_do.jsp',
			data: sendData,
			type:"POST", 
			dataType:"html",
			success: function(data){
				return;
			}
		});
	}
	//add by tangsong 20120307 下发10086123宣传短信
	//update by liuhaoa 20121214
	function send10086123Msg(phoneNo,callerphone,ides,userClass,digitCodes,flag) {
		var bool = 0;
		var reg = /^19.*|.*[a-zA-Z].*$/;
		var DigitCodes = digitCodes.split("~");
		for(var i = 0; i < DigitCodes.length; i++){
			if(reg.test(DigitCodes[i])){
				bool = 1;
			}
		}
		var jsonStr = $.ajax({
			url:"../callTrans/send10086123MsgValidate.jsp?phoneNo="+phoneNo+"&ides="+ides+"&userClass="+userClass+"&contactId="+window.parent.dialogArguments.parent.opener.document.getElementById('contactId').value+"&flag="+flag+"&callerphone="+callerphone,
			cache:false,
			async:false
		}).responseText;
		var jsonObj = eval('(' + jsonStr + ')');
		if(bool == 1){
			if (jsonObj.flag) {
				$.ajax({
					type: "post",
					url: "../callTrans/send10086123MsgDo.jsp",
					data: {'phoneNo':phoneNo,'contactId':window.parent.dialogArguments.parent.opener.document.getElementById('contactId').value},
					success: function(data){
						return;
					}
				});
			}
		}
	}	
</script>
<style type="text/css">
#data {
	height:200px;
	overflow-y:scroll;
	border:1px solid #99BBE8;
	padding:2px;
	width:368px;
}

#operation {
	border:1px solid #99BBE8;
	padding:2px;
	margin-top:3px;
}
</style>
</head>
<body>
	<iframe src="/npage/login/ssouse.jsp" style="display:none" width="100" height="100"></iframe>
	<div id="Operation_Table">
		<div class="title"><div id="title_zi">链接到知识库</div></div>
		<div id="data">
			<table style="width:95%">
	<%
		String causeId = request.getParameter("causeId")==null?"":request.getParameter("causeId");
		String serviceName = request.getParameter("serviceName") == null ? "" : request.getParameter("serviceName");
		String isProcessing = request.getParameter("isProcessing")==null?"":request.getParameter("isProcessing");
		List list = null;
		if (!causeId.equals("")) {
			StringBuffer selectSql = new StringBuffer();
			selectSql.append("select t.knowledge_id, t.knowledge_caption,t.id");
			selectSql.append("  from dcallcausetoknowledge t");
			selectSql.append(" where t.callcause_id in (" + causeId + ")");
			list = KFEjbClient.queryForList("selectPublic", selectSql.toString());
		}
		if (list != null) {
			for (int i = 0; i < list.size(); i++) {
				Map map = (Map)list.get(i);
				String knowledgeId = (String)map.get("KNOWLEDGE_ID");
				String knowledgeCaption = (String)map.get("KNOWLEDGE_CAPTION");
				String callcause_knowledge_id = (String)map.get("ID");
	%>
				<tr>
					<td>
						<a href="#" onclick="clicklink('<%=knowledgeId%>','<%=callcause_knowledge_id%>');return false;"><%=knowledgeCaption%></a>
					</td>
				</tr>
	<%
			}
		}
	%>
			</table>
		</div>
		
		<div id="operation">
			<div>
				<input type="hidden" id="accept_flag" value="1" /><!--短信标识-->
  			<iframe name="sendSMS" src="../K083/K083_msgSend4CallTrans.jsp?tab=1"
  			 frameborder="0" width="370px" height="330px" marginwidth="0"
  			 marginheight="0" scrolling="auto"></iframe>
			</div>
		</div>
		
		<div id="operation">
			<div>
  			<input name="sendMail" type="button" class="b_foot" style="border: 0px;margin: 0px;
  			 background: url(/nresources/default/images/form_bg.png) no-repeat scroll -73px -106px""
					id="sendMail" disabled value="139邮件发送">
			</div>
		</div>
	</div>
</body>
</html>