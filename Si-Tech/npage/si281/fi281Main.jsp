<%
  /*
   * ����:R_CMI_HLJ_xueyz_2013_1148982@���ڴ��˰���ֹ�˾Эͬ������ٵ���ʾ
   * �汾: 1.0
   * ����: 2013/12/11 14:28:37
   * ����: gaopeng
   * ��Ȩ: si-tech
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
 		String broadPhone = request.getParameter("broadPhone");  //����˺�
 		String phone_no = request.getParameter("activePhone");  //�ֻ�����
 		String cccTime=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date());

 		
%>
<!--ȡ��ˮ�ŷ��� -->
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

/*gaopeng 2014/01/14 10:32:17  ��ȡi281����Ȩ��*/
	boolean pwrf = false;
	if("000000".equals(retCodeNoCheck)){
		pwrf = true;
	}
	
%>


<%
	String dkStr = 
	"<option value='&&' selected>--��ѡ��--</option> "
	+"<option value='10M'>10M</option>"
	+"<option value='20M'>20M</option>"
	+"<option value='50M'>50M</option>"
	+"<option value='100M'>100M</option>";
	
	if(!pwrf){
		dkStr = 
		"<option value='&&' selected>--��ѡ��--</option> "
		+"<option value='20M'>20M</option>";
		
	}

%>


<%
	String ipAddrM = (String)session.getAttribute("ipAddr");
 		String inst = "ͨ��phoneNo[" + phone_no  + "]��ѯ";
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
			rdShowMessageDialog("��ȡ�ͻ���Ϣʧ�ܣ�");
			removeCurrentTab();
		</script>
		<%
	}

String beizhussdese1="����custid=["+gCustId+"]���в�ѯ";
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
		custditypesnames="���֤";
  }else if("1".equals(custiccidtypes)) {
  	custditypesnames="����֤";
 	}else if("2".equals(custiccidtypes)) {
 		custditypesnames="����֤";
 	}else if("3".equals(custiccidtypes)) {
 		custditypesnames="�۰�ͨ��֤";
 	}else if("4".equals(custiccidtypes)) {
 		custditypesnames="����֤";
 	}else if("5".equals(custiccidtypes)) {
 		custditypesnames="̨��ͨ��֤";
 	}else if("6".equals(custiccidtypes)) {
 		custditypesnames="���������";
 	}else if("7".equals(custiccidtypes)) {
 		custditypesnames="����";
 	}else if("8".equals(custiccidtypes)) {
 		custditypesnames="Ӫҵִ��";
 	}else if("9".equals(custiccidtypes)) {
 		custditypesnames="����";
 	}else if("A".equals(custiccidtypes)) {
 		custditypesnames="��֯��������";
 	}else if("B".equals(custiccidtypes)) {
 		custditypesnames="��λ����֤��";
 	}else if("C".equals(custiccidtypes)) {
 		custditypesnames="��λ֤��";
 	}else if("00".equals(custiccidtypes)) {
 		custditypesnames="���֤";
 	}
%>	

<html>
<head>
	<title><%=opName%></title>
	<script language="javascript">
		
		$(document).ready(function(){
			
			showAndHideDiv();
		
		});
		/*2013/12/11 15:27:10 gaopeng ��������*/
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
		
		/*2013/12/11 14:19:07 gaopeng ��ѯ�û����ײ���Ϣ�Լ���װ��ϵ��Ϣ ���÷���sE474Init �� sProductInfoQry*/
		function qryKdBtn(){
			
			var iKdNo = $("input[name='kdNo']").val();
			if($.trim(iKdNo).length == 0){
				rdShowMessageDialog("�����������룡",1);
				return false;
				
			}
			var getdataPacket = new AJAXPacket("/npage/si281/fi281QryInfo.jsp","���ڻ�����ݣ����Ժ�......");
			
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
		/*�ص�����*/
		function retQryInfo(packet){
			var errCode = packet.data.findValueByName("errCode");
			var errMsg = packet.data.findValueByName("errMsg");
			
			var constactName = packet.data.findValueByName("constactName");
			var constactPhone = packet.data.findValueByName("constactPhone");
			var constactAddr = packet.data.findValueByName("constactAddr");
			var offerName = packet.data.findValueByName("offerName");
			
			if(errCode == "000000"){
				rdShowMessageDialog("��ѯ�ɹ���",2);
				/*��ѡ��ť����Ч*/
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
				rdShowMessageDialog("������룺"+errCode+",������Ϣ��"+errMsg,1);
				$("#doconf").attr("disabled","disabled");
				return false;
			}
		}
		/*�ϴ�txt�ļ��ķ���*/
		function uploadBroad(){
			if($("#workNoList").val() == ""){
				rdShowMessageDialog("���ϴ����������Ϣ�ļ���");
				$("#workNoList").focus();
				return false;
			}
			var formFile=frm.workNoList.value.lastIndexOf(".");
			var beginNum=Number(formFile)+1;
			var endNum=frm.workNoList.value.length;
			formFile=frm.workNoList.value.substring(beginNum,endNum);
			formFile=formFile.toLowerCase(); 
			if(formFile!="txt"){
				rdShowMessageDialog("�ϴ��ļ���ʽֻ����txt��������ѡ����������Ϣ�ļ���",1);
				document.frm.workNoList.focus();
				return false;
			}
			else
				{
					/*׼���ϴ�*/
					document.frm.target="hidden_frame";
			    document.frm.encoding="multipart/form-data";
			    document.frm.action="/npage/si281/fi281Upload.jsp";
			    document.frm.method="post";
			    document.frm.submit();
					return true;
				}
			
		}
		/*�ϴ��ɹ���Ҫ�����¶�*/
		function doSetFileName(oldFileName,newFileName,newFilePath){
			rdShowMessageDialog("�ϴ��ļ�"+oldFileName+"�ɹ���",2);
			$("input[name='serviceFileName']").val(newFileName);
			$("input[name='serviceFilePath']").val(newFilePath);
			/*�ϴ�����Ч*/
			$("#uploadFile").attr("disabled","disabled");
			/*�ύ����Ч*/
			$("#doconf").attr("disabled","");
			/*��ѡ��ť����Ч*/
			$("input[name='radioFlag']").each(function(){
				$(this).attr("disabled","disabled");
			});
		}
		/*�ϴ�ʧ�ܺ�Ҫ�����¶�*/
		function showUploadError(errorInfo){
			rdShowMessageDialog(errorInfo,1);
			window.location.href='/npage/si281/fi281Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>&broadPhone=<%=broadPhone%>&activePhone=<%=activePhone%>';
			
		}
		/*�ύ����*/
		function doConfBtn(){
			
			
			var iLoginAccept = "<%=printAccept%>";
			var iChnSource = "<%=chnSource%>";
			var iOpCode = "<%=opCode%>";
			var iLoginNo = "<%=loginNo%>";
			var iLoginPwd = "<%=noPass%>";
			var iPhoneNo = $.trim($("input[name='kdNo']").val());
			var iUserPwd = "";
			/*��������*/
			var inKdType = $("select[name='kdType']").find("option:selected").val();
			/*�������� 0���� 1����*/
			var inOpFlag = $("input[name='radioFlag'][checked]").val();
			if(inOpFlag == "0"){
				if(inKdType == "&&"){
					rdShowMessageDialog("��ѡ�����",1);
					return false;
				}
			}
			if("<%=pwrf%>" == "false" && inOpFlag == "0"){
				if(!printCfm()){
					return false;
				}
			}
			
			
			
			/*�ļ�����*/
			var inFileName = $("input[name='serviceFileName']").val();
			/*realIP*/
			var inServerIP = "<%=serverIp%>";
			/*�ļ��ϴ���·��*/
			var inFileDir = $("input[name='serviceFilePath']").val();
			
			var MydataPacket = new AJAXPacket("/npage/si281/fi281Cfm.jsp","���ڴ���������������Ч�����Ժ�......");
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
			//����������
			if(inOpFlag == "0"){
				if(errCode == "000000"){
					rdShowMessageDialog("�����ɹ���",2);
				}else{
					rdShowMessageDialog("������룺"+errCode+",������Ϣ��"+errMsg,1);
				}
			}
			/*�����������*/
			else if(inOpFlag == "1"){
				var successNo = packet.data.findValueByName("successNo");
				
				if(errCode=="000000"){
					rdShowMessageDialog("�����ɹ���,��鿴�ɹ�ʧ��������ʧ����ϢΪ�ձ�ʾȫ���ɹ���",2);
					$("#errorMsgContent").show();
					$("#successNo").html(successNo);
					
					
				}else{
					rdShowMessageDialog("������룺"+errCode+",������Ϣ��"+errMsg,1);
				}
			}
			
		}
		
		//�鿴�����ĵ�����
		function seeInformation()
		{
			var inFileName = $("input[name='serviceFileName']").val();
			//alert(inFileName);
			var path = "/npage/si281/fi281Error.jsp?fileName="+inFileName;
			window.open(path,"","height=500, width=700,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
		}
		function tellMore100(){
			rdShowMessageDialog("���ֻ���ϴ�100�����ݣ���������ѡ���ļ�",1);
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
	
	cust_info+="����ʺţ�"+servNo+"|";
	cust_info+="�ͻ�������"+"<%=custName%>"+"|";

	var cTime = "<%=cccTime%>";
	opr_info += "ҵ������ʱ�䣺"+cTime +"|";
	opr_info += "ҵ�����ͣ�<%=opName%>      ������ˮ:"+"<%=printAccept%>"+"|";
	opr_info += "��ǰ�ʷ����ƣ�"+$("#offerName").html()+"|";
	//opr_info += "��ǰ�ʷѴ���"+"|";
	opr_info += "�������ٺ���� "+$("select[name='kdType']").find("option:selected").val()+"     �´�����Чʱ��:"+cTime+"|";
	
	

	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	return retInfo;
}

function printCfm(){
	var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
	if(typeof(ret)!="undefined"){
		if((ret=="confirm")){
			if(rdShowConfirmDialog('ȷ�ϵ��������')==1){
				return true;
			}else{
				return false;
			}
		}
		if(ret=="continueSub"){
			if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
				return true;
			}else{
				return false;
			}
		}else{
			if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
				return true;
			}else{
				return false;
			}
		}
	}
	else{
		if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
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
			<td class="blue" width="20%">��������</td>
			<td ><input type="radio" name="radioFlag" value="0" checked  onclick = "showAndHideDiv();" />�����û� 
				&nbsp;&nbsp;
				<%if(pwrf){%>
			    <input type="radio" name="radioFlag" value="1" onclick = "showAndHideDiv();" />�����û�	
				<%}%>
			</td>
		</tr>
		</table>
		<div id="sinConstants">
			<table>
				<tr>
				<td class="blue" width="20%">����˺�</td>
				<td width="30%"><input type="text" name="kdNo" value = "<%=broadPhone%>" class="InputGrey" readonly/>&nbsp;&nbsp;<input type="button" class="b_text" name="qryKd" value="��ѯ" onclick="qryKdBtn();"/></td>
				<td class="blue" width="20%">����</td>
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
					<td class="blue" width="20%">��װ������</td>
					<td id="constactName"></td>
					<td class="blue">��װ�˵绰</td>
					<td id="constactPhone"></td>
				</tr>
				<tr>
					<td class="blue">��װ��ַ</td>
					<td id="constactAddr"></td>
					<td class="blue">���ʷ�����</td>
					<td id="offerName"></td>
				</tr>
				
			</table>
		</div>
		<div id="mutiConstants">
			<table>
				<tr>
					<td width="20%" class="blue">
						������Ϣ����
					</td>
					<td>
						<input type="file" name="workNoList" id="workNoList" class="button"
						style='border-style:solid;border-color:#7F9DB9;border-width:1px;font-size:12px;' />
						&nbsp;&nbsp;
						<input type="button" name="uploadFile" id="uploadFile" class="b_text" value="�ϴ�" onclick="uploadBroad();"/>
					</td>
				</tr>
				<tr>
					<td class="blue">
						�ļ���ʽ˵��
					</td>
		      <td> 
		          �ϴ��ļ��ı���ʽΪ������˺�|���ٴ���|����ʾ�����£�<br>
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
		          <br>&nbsp;&nbsp; ע����ʽ�е�ÿһ�����������ڿո�,��ÿ����Ϣ����Ҫ�س����С�
		          </b> 
		      </td>
		    </tr>
			</table>
		</div>
		<div id="errorMsgContent" style="display:none">
			<table  cellSpacing=0 >
					<tr>
						<td class="blue" width="20%">
							�������
						</td>
						<td id="successNo" width="30%">
							
						</td>
						<td id="errorbutton" colspan="2">
							<input class="b_foot_long" name="seeInfo" type="button" value="ʧ����Ϣ�鿴" onClick="seeInformation()">
						</td>
					</tr>
			</table>
		</div>
		
	
		<table  cellSpacing=0>
				<tbody>
					<tr>
						<td id="footer">
							<input  name="submitr"  class="b_foot" type="button" value="ȷ��&��ӡ" onclick="doConfBtn()"   id="doconf" disabled="disabled">&nbsp;&nbsp;
							<input  name="resetsd"  class="b_foot" type="button" value="����" onclick="javascript:window.location.href='/npage/si281/fi281Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>&broadPhone=<%=broadPhone%>&activePhone=<%=activePhone%>'" id="Button3">&nbsp;&nbsp;
							<input  name="back1"  class="b_foot" type="button" value=�ر� id="Button2" onclick="removeCurrentTab()">
						</td>
					</tr>
				</tbody>
			</table>
			<!--��ˮ�� -->
			<input type="hidden" name="printAccept" value="<%=printAccept%>">
			<!-- �������� -->
			<input type="hidden" name="opCode" value="<%=opCode%>">		
			<!--�ϴ��ļ��� -->	
			<input type="hidden" name="serviceFileName" value=""/>
			<!--�ϴ��ļ�ȫ·���� -->	
			<input type="hidden" name="serviceFilePath" value=""/>
			<iframe name='hidden_frame' id="hidden_frame" style='display:none'></iframe>
	<%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>