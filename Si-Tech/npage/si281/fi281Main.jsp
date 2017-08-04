<%
  /*
   * 功能:R_CMI_HLJ_xueyz_2013_1148982@关于大兴安岭分公司协同宽带提速的请示
   * 版本: 1.0
   * 日期: 2013/12/11 14:28:37
   * 作者: gaopeng
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="../../npage/common/serverip.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    String regionCode = (String)session.getAttribute("regCode");
    String regioncode =regionCode;
    String loginNo = (String)session.getAttribute("workNo");
 		String noPass = (String)session.getAttribute("password");
 		String serverIp=realip.trim();
 		String chnSource="01";
 		String phoneNo = "";
 		String opCode = (String)request.getParameter("opCode");		
 		String opName = (String)request.getParameter("opName");
 		String broadPhone = request.getParameter("broadPhone");  //宽带账号
 		String phone_no = request.getParameter("activePhone");  //手机号码
 		String cccTime=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date());

 		
%>
<!--取流水号方法 -->
<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="region" 
		 routerValue="<%=regionCode%>"  id="seq"/>
<%
		String printAccept = seq;
%>
<wtc:service name="sLoginNoCheck" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCodeNoCheck" retmsg="retMsgNoCheck" outnum="1">
				<wtc:param value="vi281"/>
				<wtc:param value="<%=loginNo%>"/>
				<wtc:param value="<%=noPass%>"/>
		</wtc:service>
		<wtc:array id="infoRetNoCheck"  scope="end"/>
<%

/*gaopeng 2014/01/14 10:32:17  获取i281免密权限*/
	boolean pwrf = false;
	if("000000".equals(retCodeNoCheck)){
		pwrf = true;
	}
	
%>


<%
	String dkStr = 
	"<option value='&&' selected>--请选择--</option> "
	+"<option value='10M'>10M</option>"
	+"<option value='20M'>20M</option>"
	+"<option value='50M'>50M</option>"
	+"<option value='100M'>100M</option>";
	
	if(!pwrf){
		dkStr = 
		"<option value='&&' selected>--请选择--</option> "
		+"<option value='20M'>20M</option>";
		
	}

%>


<%
	String ipAddrM = (String)session.getAttribute("ipAddr");
 		String inst = "通过phoneNo[" + phone_no  + "]查询";
		String gCustId = "";
		String custSql = "";
		String custName = "";
		String  inParamsMail [] = new String[2];
    inParamsMail[0] = "select trim(t.cust_id) from dcustmsg t where phone_no =:phoneNo";
    inParamsMail[1] = "phoneNo="+phone_no ;
		
%>
 <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regioncode%>" retcode="retCode_mail" retmsg="retMessage_mail" outnum="1"> 
    <wtc:param value="<%=inParamsMail[0]%>"/>
    <wtc:param value="<%=inParamsMail[1]%>"/> 
  </wtc:service>  
  <wtc:array id="result_mail"  scope="end"/>
<%
	if("000000".equals(retCode_mail) && result_mail.length > 0){
		gCustId = result_mail[0][0];
	}else{
		%>
		<script language="javascript">
			rdShowMessageDialog("获取客户信息失败！");
			removeCurrentTab();
		</script>
		<%
	}

String beizhussdese1="根据custid=["+gCustId+"]进行查询";
%>  	
	 	
	<wtc:service name="sUserCustInfo" outnum="100" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regioncode%>">
			<wtc:param value="0" />
			<wtc:param value="01" />	
			<wtc:param value="<%=opCode%>" />	
			<wtc:param value="<%=loginNo%>" />
			<wtc:param value="<%=noPass%>" />
			<wtc:param value="" />
			<wtc:param value="" />
			<wtc:param value="<%=ipAddrM%>" />
			<wtc:param value="<%=beizhussdese1%>" />
			<wtc:param value="<%=gCustId%>" />
</wtc:service>
<wtc:array id="result_custInfo" scope="end"/>	
<%	 	

String custiccids = "";
String custAddr = "";
String custiccidtypes = "";
String custditypesnames="";
if(result_custInfo.length>0){
if(result_custInfo[0][0].equals("01")) {
	custAddr = result_custInfo[0][11];
	custiccids = result_custInfo[0][13];
	custName = result_custInfo[0][5];
	custiccidtypes = result_custInfo[0][12].trim();
	}
}
if("0".equals(custiccidtypes)) {
		custditypesnames="身份证";
  }else if("1".equals(custiccidtypes)) {
  	custditypesnames="军官证";
 	}else if("2".equals(custiccidtypes)) {
 		custditypesnames="军官证";
 	}else if("3".equals(custiccidtypes)) {
 		custditypesnames="港澳通行证";
 	}else if("4".equals(custiccidtypes)) {
 		custditypesnames="警官证";
 	}else if("5".equals(custiccidtypes)) {
 		custditypesnames="台湾通行证";
 	}else if("6".equals(custiccidtypes)) {
 		custditypesnames="外国公民护照";
 	}else if("7".equals(custiccidtypes)) {
 		custditypesnames="其它";
 	}else if("8".equals(custiccidtypes)) {
 		custditypesnames="营业执照";
 	}else if("9".equals(custiccidtypes)) {
 		custditypesnames="护照";
 	}else if("A".equals(custiccidtypes)) {
 		custditypesnames="组织机构代码";
 	}else if("B".equals(custiccidtypes)) {
 		custditypesnames="单位法人证书";
 	}else if("C".equals(custiccidtypes)) {
 		custditypesnames="单位证明";
 	}else if("00".equals(custiccidtypes)) {
 		custditypesnames="身份证";
 	}
%>	

<html>
<head>
	<title><%=opName%></title>
	<script language="javascript">
		
		$(document).ready(function(){
			
			showAndHideDiv();
		
		});
		/*2013/12/11 15:27:10 gaopeng 显隐方法*/
		function showAndHideDiv(){
			var radioFlag = $("input[name='radioFlag'][checked]").val();
			if(radioFlag == "0"){
				$("#sinConstants").show();
				$("#mutiConstants").hide();
			}else if(radioFlag == "1"){
				$("#sinConstants").hide();
				$("#mutiConstants").show();
			}
		}
		
		/*2013/12/11 14:19:07 gaopeng 查询用户的套餐信息以及安装联系信息 调用服务sE474Init 和 sProductInfoQry*/
		function qryKdBtn(){
			
			var iKdNo = $("input[name='kdNo']").val();
			if($.trim(iKdNo).length == 0){
				rdShowMessageDialog("请输入宽带号码！",1);
				return false;
				
			}
			var getdataPacket = new AJAXPacket("/npage/si281/fi281QryInfo.jsp","正在获得数据，请稍候......");
			
			var iLoginAccept = "<%=printAccept%>";
			var iChnSource = "<%=chnSource%>";
			var iOpCode = "<%=opCode%>";
			var iLoginNo = "<%=loginNo%>";
			var iLoginPwd = "<%=noPass%>";
			var iPhoneNo = "<%=phone_no%>";
			var iUserPwd = "";
			
			
			
			getdataPacket.data.add("iLoginAccept",iLoginAccept);
			getdataPacket.data.add("iChnSource",iChnSource);
			getdataPacket.data.add("iOpCode",iOpCode);
			getdataPacket.data.add("opName","<%=opName%>");
			getdataPacket.data.add("iLoginNo",iLoginNo);
			getdataPacket.data.add("iLoginPwd",iLoginPwd);
			getdataPacket.data.add("iPhoneNo",iPhoneNo);
			getdataPacket.data.add("iUserPwd",iUserPwd);
			getdataPacket.data.add("iKdNo",iKdNo);
			
			
			core.ajax.sendPacket(getdataPacket,retQryInfo);
			getdataPacket = null;
			
			
		}
		/*回调函数*/
		function retQryInfo(packet){
			var errCode = packet.data.findValueByName("errCode");
			var errMsg = packet.data.findValueByName("errMsg");
			
			var constactName = packet.data.findValueByName("constactName");
			var constactPhone = packet.data.findValueByName("constactPhone");
			var constactAddr = packet.data.findValueByName("constactAddr");
			var offerName = packet.data.findValueByName("offerName");
			
			if(errCode == "000000"){
				rdShowMessageDialog("查询成功！",2);
				/*单选按钮置无效*/
				$("input[name='radioFlag']").each(function(){
					$(this).attr("disabled","disabled");
				});
				$("#constactName").html(constactName);
				$("#constactPhone").html(constactPhone);
				$("#constactAddr").html(constactAddr);
				$("#offerName").html(offerName);
				
				$("#intablediv").show();
				$("#doconf").attr("disabled","");
			}else{
				rdShowMessageDialog("错误代码："+errCode+",错误信息："+errMsg,1);
				$("#doconf").attr("disabled","disabled");
				return false;
			}
		}
		/*上传txt文件的方法*/
		function uploadBroad(){
			if($("#workNoList").val() == ""){
				rdShowMessageDialog("请上传宽带提速信息文件！");
				$("#workNoList").focus();
				return false;
			}
			var formFile=frm.workNoList.value.lastIndexOf(".");
			var beginNum=Number(formFile)+1;
			var endNum=frm.workNoList.value.length;
			formFile=frm.workNoList.value.substring(beginNum,endNum);
			formFile=formFile.toLowerCase(); 
			if(formFile!="txt"){
				rdShowMessageDialog("上传文件格式只能是txt，请重新选择宽带提速信息文件！",1);
				document.frm.workNoList.focus();
				return false;
			}
			else
				{
					/*准备上传*/
					document.frm.target="hidden_frame";
			    document.frm.encoding="multipart/form-data";
			    document.frm.action="/npage/si281/fi281Upload.jsp";
			    document.frm.method="post";
			    document.frm.submit();
					return true;
				}
			
		}
		/*上传成功后要做的事儿*/
		function doSetFileName(oldFileName,newFileName,newFilePath){
			rdShowMessageDialog("上传文件"+oldFileName+"成功！",2);
			$("input[name='serviceFileName']").val(newFileName);
			$("input[name='serviceFilePath']").val(newFilePath);
			/*上传置无效*/
			$("#uploadFile").attr("disabled","disabled");
			/*提交置有效*/
			$("#doconf").attr("disabled","");
			/*单选按钮置无效*/
			$("input[name='radioFlag']").each(function(){
				$(this).attr("disabled","disabled");
			});
		}
		/*上传失败后要做的事儿*/
		function showUploadError(errorInfo){
			rdShowMessageDialog(errorInfo,1);
			window.location.href='/npage/si281/fi281Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>&broadPhone=<%=broadPhone%>&activePhone=<%=activePhone%>';
			
		}
		/*提交方法*/
		function doConfBtn(){
			
			
			var iLoginAccept = "<%=printAccept%>";
			var iChnSource = "<%=chnSource%>";
			var iOpCode = "<%=opCode%>";
			var iLoginNo = "<%=loginNo%>";
			var iLoginPwd = "<%=noPass%>";
			var iPhoneNo = $.trim($("input[name='kdNo']").val());
			var iUserPwd = "";
			/*提速类型*/
			var inKdType = $("select[name='kdType']").find("option:selected").val();
			/*操作类型 0单个 1批量*/
			var inOpFlag = $("input[name='radioFlag'][checked]").val();
			if(inOpFlag == "0"){
				if(inKdType == "&&"){
					rdShowMessageDialog("请选择带宽！",1);
					return false;
				}
			}
			if("<%=pwrf%>" == "false" && inOpFlag == "0"){
				if(!printCfm()){
					return false;
				}
			}
			
			
			
			/*文件名称*/
			var inFileName = $("input[name='serviceFileName']").val();
			/*realIP*/
			var inServerIP = "<%=serverIp%>";
			/*文件上传的路径*/
			var inFileDir = $("input[name='serviceFilePath']").val();
			
			var MydataPacket = new AJAXPacket("/npage/si281/fi281Cfm.jsp","正在处理批量工号置无效，请稍候......");
				MydataPacket.data.add("iLoginAccept",iLoginAccept);
				MydataPacket.data.add("iChnSource",iChnSource);
				MydataPacket.data.add("iOpCode",iOpCode);
				MydataPacket.data.add("iLoginNo",iLoginNo);
				MydataPacket.data.add("iLoginPwd",iLoginPwd);
				MydataPacket.data.add("iPhoneNo",iPhoneNo);
				MydataPacket.data.add("iUserPwd",iUserPwd);
				MydataPacket.data.add("inKdType",inKdType);
				MydataPacket.data.add("inOpFlag",inOpFlag);
				MydataPacket.data.add("inFileName",inFileName);
				MydataPacket.data.add("inServerIP",inServerIP);
				MydataPacket.data.add("inFileDir",inFileDir);
				core.ajax.sendPacket(MydataPacket,reti281Cfm);
				MydataPacket = null;
			
			
		}
		function reti281Cfm(packet){
			var errCode = packet.data.findValueByName("errCode");
			var errMsg = packet.data.findValueByName("errMsg");
			var inOpFlag = packet.data.findValueByName("inOpFlag");
			//单个带宽处理
			if(inOpFlag == "0"){
				if(errCode == "000000"){
					rdShowMessageDialog("操作成功！",2);
				}else{
					rdShowMessageDialog("错误代码："+errCode+",错误信息："+errMsg,1);
				}
			}
			/*批量处理带宽*/
			else if(inOpFlag == "1"){
				var successNo = packet.data.findValueByName("successNo");
				
				if(errCode=="000000"){
					rdShowMessageDialog("操作成功！,请查看成功失败条数！失败信息为空表示全部成功！",2);
					$("#errorMsgContent").show();
					$("#successNo").html(successNo);
					
					
				}else{
					rdShowMessageDialog("错误代码："+errCode+",错误信息："+errMsg,1);
				}
			}
			
		}
		
		//查看错误文档方法
		function seeInformation()
		{
			var inFileName = $("input[name='serviceFileName']").val();
			//alert(inFileName);
			var path = "/npage/si281/fi281Error.jsp?fileName="+inFileName;
			window.open(path,"","height=500, width=700,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
		}
		function tellMore100(){
			rdShowMessageDialog("最多只能上传100条数据！，请重新选择文件",1);
			return false;
		}
		
		function showPrtDlg(printType,DlgMessage,submitCfm){
			var h=198;
			var w=350;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var pType="subprint";
			var billType="1";
			var sysAccept = "<%=printAccept%>";
			var phone_no = "<%=phone_no%>";
			var mode_code = "";
	
	
			var fav_code = "";
			var area_code = "";
			var printStr = printInfo(printType);
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
			var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
			var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phone_no+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
			var ret=window.showModalDialog(path,printStr,prop);
			return path;
	}
function printInfo(printType){
	var retInfo = "";
	var cust_info="";
	var opr_info="";
	var note_info1="";
	var note_info2="";
	var note_info3="";
	var note_info4="";
	var servNo = "<%=broadPhone%>";
	
	cust_info+="宽带帐号："+servNo+"|";
	cust_info+="客户姓名："+"<%=custName%>"+"|";

	var cTime = "<%=cccTime%>";
	opr_info += "业务受理时间："+cTime +"|";
	opr_info += "业务类型：<%=opName%>      操作流水:"+"<%=printAccept%>"+"|";
	opr_info += "当前资费名称："+$("#offerName").html()+"|";
	//opr_info += "当前资费带宽："+"|";
	opr_info += "申请提速后带宽： "+$("select[name='kdType']").find("option:selected").val()+"     新带宽生效时间:"+cTime+"|";
	
	

	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	return retInfo;
}

function printCfm(){
	var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
	if(typeof(ret)!="undefined"){
		if((ret=="confirm")){
			if(rdShowConfirmDialog('确认电子免填单吗？')==1){
				return true;
			}else{
				return false;
			}
		}
		if(ret=="continueSub"){
			if(rdShowConfirmDialog('确认要提交信息吗？')==1){
				return true;
			}else{
				return false;
			}
		}else{
			if(rdShowConfirmDialog('确认要提交信息吗？')==1){
				return true;
			}else{
				return false;
			}
		}
	}
	else{
		if(rdShowConfirmDialog('确认要提交信息吗？')==1){
			return true;
		}else{
			return false;
		}
	}
}

		
	</script>
	</head>
<body>
	<form action="" method="post" name="frm">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<table>
		<tr>
			<td class="blue" width="20%">操作类型</td>
			<td ><input type="radio" name="radioFlag" value="0" checked  onclick = "showAndHideDiv();" />单个用户 
				&nbsp;&nbsp;
				<%if(pwrf){%>
			    <input type="radio" name="radioFlag" value="1" onclick = "showAndHideDiv();" />批量用户	
				<%}%>
			</td>
		</tr>
		</table>
		<div id="sinConstants">
			<table>
				<tr>
				<td class="blue" width="20%">宽带账号</td>
				<td width="30%"><input type="text" name="kdNo" value = "<%=broadPhone%>" class="InputGrey" readonly/>&nbsp;&nbsp;<input type="button" class="b_text" name="qryKd" value="查询" onclick="qryKdBtn();"/></td>
				<td class="blue" width="20%">带宽</td>
				<td width="30%">
					<select name="kdType"> 
						<%=dkStr%>
					</select>	
				</td>
				</tr>
			</table>
		</div>
		<div id="intablediv" style="display:none">
			<table>
				<tr>
					<td class="blue" width="20%">安装人姓名</td>
					<td id="constactName"></td>
					<td class="blue">安装人电话</td>
					<td id="constactPhone"></td>
				</tr>
				<tr>
					<td class="blue">安装地址</td>
					<td id="constactAddr"></td>
					<td class="blue">主资费名称</td>
					<td id="offerName"></td>
				</tr>
				
			</table>
		</div>
		<div id="mutiConstants">
			<table>
				<tr>
					<td width="20%" class="blue">
						批量信息导入
					</td>
					<td>
						<input type="file" name="workNoList" id="workNoList" class="button"
						style='border-style:solid;border-color:#7F9DB9;border-width:1px;font-size:12px;' />
						&nbsp;&nbsp;
						<input type="button" name="uploadFile" id="uploadFile" class="b_text" value="上传" onclick="uploadBroad();"/>
					</td>
				</tr>
				<tr>
					<td class="blue">
						文件格式说明
					</td>
		      <td> 
		          上传文件文本格式为“宽带账号|提速带宽|”，示例如下：<br>
		          <font class='orange'>
		          	&nbsp;&nbsp; ttkd1010|10M|<br/>
		          	&nbsp;&nbsp; ttkd1011|10M|<br/>
		          	&nbsp;&nbsp; ttkd1012|20M|<br/>
		          	&nbsp;&nbsp; ttkd1013|20M|<br/>
		          	&nbsp;&nbsp; ttkd1014|20M|<br/>
		          	&nbsp;&nbsp; ttkd1015|50M|<br/>
		          	&nbsp;&nbsp; ttkd1016|50M|<br/>
		          	&nbsp;&nbsp; ttkd1017|100M|
		          </font>
		          <b>
		          <br>&nbsp;&nbsp; 注：格式中的每一项均不允许存在空格,且每条信息都需要回车换行。
		          </b> 
		      </td>
		    </tr>
			</table>
		</div>
		<div id="errorMsgContent" style="display:none">
			<table  cellSpacing=0 >
					<tr>
						<td class="blue" width="20%">
							操作结果
						</td>
						<td id="successNo" width="30%">
							
						</td>
						<td id="errorbutton" colspan="2">
							<input class="b_foot_long" name="seeInfo" type="button" value="失败信息查看" onClick="seeInformation()">
						</td>
					</tr>
			</table>
		</div>
		
	
		<table  cellSpacing=0>
				<tbody>
					<tr>
						<td id="footer">
							<input  name="submitr"  class="b_foot" type="button" value="确认&打印" onclick="doConfBtn()"   id="doconf" disabled="disabled">&nbsp;&nbsp;
							<input  name="resetsd"  class="b_foot" type="button" value="重置" onclick="javascript:window.location.href='/npage/si281/fi281Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>&broadPhone=<%=broadPhone%>&activePhone=<%=activePhone%>'" id="Button3">&nbsp;&nbsp;
							<input  name="back1"  class="b_foot" type="button" value=关闭 id="Button2" onclick="removeCurrentTab()">
						</td>
					</tr>
				</tbody>
			</table>
			<!--流水号 -->
			<input type="hidden" name="printAccept" value="<%=printAccept%>">
			<!-- 操作代码 -->
			<input type="hidden" name="opCode" value="<%=opCode%>">		
			<!--上传文件名 -->	
			<input type="hidden" name="serviceFileName" value=""/>
			<!--上传文件全路径名 -->	
			<input type="hidden" name="serviceFilePath" value=""/>
			<iframe name='hidden_frame' id="hidden_frame" style='display:none'></iframe>
	<%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>