<%
  /*
   * ����: 
   * �汾: 1.0
   * ����: liangyl 2016/10/31 ����Э���������Ż�BOSSϵͳ���ҵ���ܵĺ�
   * ����: liangyl
   * ��Ȩ: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ include file="/npage/bill/getMaxAccept.jsp"%>

<%@ page import="javax.servlet.*"%>
<%@ page import="java.security.*"%>
<%@ page import="javax.crypto.*;"%>
<%@ page import="com.sitech.util.*"%>



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
		//String loginAccept = getMaxAccept();�ͱ�ǩһ��
	//	String accountType = (String)session.getAttribute("accountType");
		String dateStr =  new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
%>

<html>
<head>
<title><%=opName%></title>
<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js"></script>
<script src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js" type="text/javascript"></script>
<%@ include file="/npage/include/header.jsp"%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAcceptl" />
<script language="javascript">
		$(document).ready(function(){
			
		});
		function doCommit(){			
			if($("#kuandaiNum").val().length == 0){
				rdShowMessageDialog("���������˺ţ�",0);
				return false;
			}
			if($("#kdZdFee").val().length == 0){
				rdShowMessageDialog("���������ն˷��ã�",0);
				return false;
			}
			if(!forMoney($("#kdZdFee")[0],false)){
				rdShowMessageDialog("�����ʽ����ȷ���޸ģ�",0);
				return false;
			}
			
			var getdataPacket = new AJAXPacket("fm419getPP.jsp","���ڻ�ȡƷ�ƣ����Ժ�......");
			getdataPacket.data.add("kuandaiNum",$("#kuandaiNum").val());
			core.ajax.sendPacket(getdataPacket,doRetCfm);
			getdataPacket = null;
		}
		var ppName="";
		var phoneNum="";
		function doRetCfm(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			if(retCode == "000000"){
				ppName = packet.data.findValueByName("ppName");
				phoneNum = packet.data.findValueByName("phoneNum");
				//alert(ppName);
				if("kf"==ppName){
					if(!printCommit()){
				    	return false;
				    }
				}
				else{
					rdShowMessageDialog("�ú��벻��kfƷ�Ʋ���������ҵ��",0);
					return false;
				}
			}else{
				rdShowMessageDialog("������룺"+retCode+",������Ϣ��"+retMsg,1);
			}
		}
		function printCommit(){
			go_getUserInfo();
		}
		function go_getUserInfo(){
			var getdataPacket = new AJAXPacket("fm419getUserInfo.jsp","���ڻ�ȡ�û���Ϣ�����Ժ�......");
			getdataPacket.data.add("kuandaiNum",$("#kuandaiNum").val());
			core.ajax.sendPacket(getdataPacket,do_getUserInfo);
			getdataPacket = null;
		}
		var userName="";
		var userAddr="";
		var idType = "";
		var idIccid = "";
		function do_getUserInfo(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			if(retCode == "000000"){
				userName = packet.data.findValueByName("userName");
				userAddr = packet.data.findValueByName("userAddr");
				idType = packet.data.findValueByName("idType");
				idIccid = packet.data.findValueByName("idIccid");
				//alert(userName+"-"+userAddr+"-"+idType+"-"+idIccid);
				getAfterPrompt();
				var ret = showPrtDlg("Detail", "ȷʵҪ���е��������ӡ��", "Yes");
				showBroadKdZdBill("Bill","ȷʵҪ���п���ն˷�Ʊ��ӡ��","Yes");
				if(rdShowConfirmDialog('ȷ��Ҫ�ύѺ������')==1) {
					submitCfm();
				   return false;
				  }
			}else{
				userName="";
				userAddr="";
				idType = "";
				idIccid = "";
				rdShowMessageDialog("������룺"+retCode+",������Ϣ��"+retMsg,1);
			}
		}
		function showPrtDlg(printType, DlgMessage, submitCfn){//��ʾ��ӡ�Ի��� 
			var h=210;
			var w=400;
		    var t = screen.availHeight / 2 - h / 2;
		    var l = screen.availWidth / 2 - w / 2;
		    var opCode="<%=opCode%>";
			var pType="subprint";
			var billType="1";
			var mode_code=null;
			var fav_code=null;
			var area_code=null;
			var sysAccept = "<%=sysAcceptl%>";
		    var printStr = printInfo(printType);
		    var prop = "dialogHeight:" + h + "px; dialogWidth:" + w + "px; dialogLeft:" + l + "px; dialogTop:" + t + "px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
			var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
		    var path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode="+opCode+"&sysAccept="+sysAccept+"&phoneNo="+phoneNum+"&submitCfm=" + submitCfn+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		    var ret = window.showModalDialog(path, printStr, prop);
		}
		
		function printInfo(printType){
			var retInfo = "";
		    if (printType == "Detail"){
				var cust_info="";
				var opr_info="";
				var note_info1="";
				var note_info2="";
				var note_info3="";
				var note_info4="";        
				cust_info += "����ʺţ�" + $("#kuandaiNum").val() + "|";
				cust_info += "�ͻ�������" + userName + "|";
				cust_info += "�ͻ���ַ��" + userAddr + "|";
				
				opr_info += "ҵ������ʱ�䣺<%=dateStr%>" + "|";
				opr_info += "����ҵ��������ƣ���èѺ����" + "      ";
				opr_info += "������ˮ��" + <%=sysAcceptl%> + "|";
				opr_info += "��èѺ��"+$("#kdZdFee").val()+ "Ԫ|";
				
				note_info1 += "��ע���𾴵��û����������������������ʱ����Я��ONT�豸��Ѻ��Ʊ��|";
				note_info1 += "��Ч֤�������ƶ�ָ������Ӫҵ��������Ѻ�𣬿���ն�Ѻ�𷵻���ֹ|";
				note_info1 += "���ڣ��û�����90���ڣ�����90�죩��|";
				retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
				retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
			}
		    return retInfo;
		}
		
		//��ӡ�վ�
		//showBroadKdZdBill("Bill","ȷʵҪ���п���ն˷�Ʊ��ӡ��","Yes");
			function showBroadKdZdBill(printType,DlgMessage,submitCfm){
				var printInfo = "";
				var prtLoginAccept = "<%=sysAcceptl%>";
				var zhengjianType = ["���֤","����֤","���ڲ�","�۰�ͨ��֤","����֤","̨��ͨ��֤","���������","����","Ӫҵִ��","����"];
				zhengjianType["A"]="��֯��������";
				zhengjianType["B"]="��λ����֤��";
				zhengjianType["C"]="��λ֤��";
				
				var iccidtypess=zhengjianType[idType];
				var iccidnoss=idIccid;
				var  billArgsObj = new Object();
				
				var custName = userName;
				var phoneNo = $("#kuandaiNum").val();
				var feeName = "Ѻ����";
			  
		 		/*2014/09/11 15:18:07 gaopeng ����ʷ�չ�ּ��ն˹��������ϵͳ֧���Ż�����
			  		���� ����豸�ն˿� 
			  	*/
		  		var kdZdFee = $("#kdZdFee").val();
				$(billArgsObj).attr("10001","<%=loginNo%>");     //����
				$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
				$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
				$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
				$(billArgsObj).attr("10005",custName);   //�ͻ�����
				$(billArgsObj).attr("10006","Ѻ����");    //ҵ�����
				$(billArgsObj).attr("10008",phoneNo);    //�û�����
				$(billArgsObj).attr("10015", kdZdFee+"");   //���η�Ʊ���
				$(billArgsObj).attr("10016", kdZdFee+"");   //��д���ϼ�
				$(billArgsObj).attr("10017","*");        //���νɷѣ��ֽ�
				/*10028 10029 ����ӡ*/
			  	$(billArgsObj).attr("10028","");   //�����Ӫ������ƣ�
				$(billArgsObj).attr("10029","");	 //Ӫ������	
				$(billArgsObj).attr("10030",prtLoginAccept);   //��ˮ�ţ�--ҵ����ˮ
				$(billArgsObj).attr("10036","e916");   //��������
				$(billArgsObj).attr("10042","̨");                   //��λ
				$(billArgsObj).attr("10043","1");	                   //����
				$(billArgsObj).attr("10044",kdZdFee+"");	                //����
				/*10045����ӡ*/
				$(billArgsObj).attr("10045","");	       //IMEI
				/*�ͺŲ���*/
				$(billArgsObj).attr("10061","");	       //�ͺ�
	 			$(billArgsObj).attr("10078", ppName); //���Ʒ��		
	 			$(billArgsObj).attr("10071","6");
	 			
	 			$(billArgsObj).attr("10083", iccidtypess); //֤������
	 			$(billArgsObj).attr("10084", iccidnoss); //֤������
	 			$(billArgsObj).attr("10085", "zsj"); //���������ȡ��ʽ
	 			$(billArgsObj).attr("10086", "�𾴵��û���������������������ʱ����Я��ONT�豸��Ѻ��Ʊ����Ч֤�������ƶ�ָ������Ӫҵ��������Ѻ�𡣿���ն�Ѻ�𷵻���ֹ���ڣ��û�������90���ڣ�����90�죩��"); //��ע
	 			$(billArgsObj).attr("10041", "����ն�Ѻ�����");           //Ʒ����� ʵ���ǿ���ն�����
	 			$(billArgsObj).attr("10065", $("#kuandaiNum").val()); //����˺�
				var h=210;
				var w=400;
				var t=screen.availHeight/2-h/2;
				var l=screen.availWidth/2-w/2;
				var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
				var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + "ȷʵҪ���з�Ʊ��ӡ��"+"&feeName="+feeName;
				var loginAccept = prtLoginAccept;
				var path = path +"&loginAccept="+loginAccept+"&opCode=e916"+"&submitCfm=submitCfm";
				var ret = window.showModalDialog(path,billArgsObj,prop);		

			}
		
		
		
		/**********ҳ����ύ***************/
		function submitCfm(){	
			var myPacket = new AJAXPacket("fm419Cfm.jsp", "�����ύ�����Ժ�......");
			var iLoginAccept = "<%=sysAcceptl%>";
			var iChnSource = "01";
			var iOpCode = "<%=opCode%>";
			var iLoginNo = "<%=loginNo%>";
			var iLoginPwd = "<%=noPass%>";
			var iPhoneNo ="";
			var iUserPwd = "";
			
			myPacket.data.add("iLoginAccept",iLoginAccept);
			myPacket.data.add("iChnSource",iChnSource);
			myPacket.data.add("iOpCode",iOpCode);
			myPacket.data.add("iLoginNo",iLoginNo);
			myPacket.data.add("iLoginPwd",iLoginPwd);
			myPacket.data.add("iPhoneNo",iPhoneNo);
			myPacket.data.add("iUserPwd",iUserPwd);
			
			myPacket.data.add("yajinType", $("#yajinType").val());
			myPacket.data.add("yewuType", $("#yewuType").val());
			myPacket.data.add("kuandaiNum",$("#kuandaiNum").val().trim());
			myPacket.data.add("kdZd", $("#kdZd").val()); 
			myPacket.data.add("fysqfs", $("#fysqfs").val()); 
			myPacket.data.add("kdZdFee", $("#kdZdFee").val());
			myPacket.data.add("snNumber", $("#snNumber").val());
			//core.ajax.sendPacket(myPacket);
			core.ajax.sendPacket(myPacket,do_submitCfm);
		    myPacket=null;
			   
		}
		
		function do_submitCfm(packet){
			var code = packet.data.findValueByName("retCode"); 
			var msg = packet.data.findValueByName("retMsg"); 
			if(code=="000000"){
				rdShowMessageDialog("��ӳɹ�",2);
				location=location;
			}else{
				rdShowMessageDialog("����ʧ��"+code+"��"+msg,0);
			}
		}
	</script>
</head>
<body>
	<form action="" method="post" name="f1">
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
		<table>
			<tr>
				<td width="8%" class="blue" align="center">Ѻ������</td>
				<td width="20%">
					<select id="yajinType" name="yajinType">
						<option value="0">��èѺ��</option>
					</select>
				</td>
				<td width="8%" class="blue" align="center">ҵ������</td>
				<td width="20%">
					<select id="yewuType" name="yewuType">
						<option value="0">���</option>
					</select>
				</td>
				<td width="8%" class="blue" align="center">����˺�</td>
				<td>
					<input type="text" id="kuandaiNum" name="kuandaiNum" value="" maxlength="15"/>
					<font color="orange">*</font>
				</td>
			</tr>
			<tr>
				<td class="blue" align="center">����ն�</td>
				<td>
					<select name="kdZd" id="kdZd">
						<option value="ONT">ONT</option>
					</select>
					<font class="orange">*</font>
				</td>
				<td class="blue" align="center">������ȡ��ʽ</td>
				<td>
					<select id="fysqfs" name="fysqfs">
						<option value="0">Ѻ��</option>
					</select>
					<font class="orange">*</font></td>
				<td class="blue" align="center">����ն˷���</td>
				<td id="kdzdfydisplay">
					<input type="text" name="kdZdFee" id="kdZdFee" value="" v_must="0" v_type="money" class='forMoney required' v_minvalue="50" v_maxvalue="200" onblur="forMoney(this,false)"/>
					<font class="orange">*</font>
					<span id="yjfwxianshi">Ѻ��Χ50-200Ԫ</span>
				</td>
			</tr>
			<tr>
				<td class="blue" id="sntitletd" align="center">S/N��</td>
	        	<td id="sntexttd">
	        		<input type="text" name="snNumber" id="snNumber" maxlength="30" value="" size="40" v_must ="1" v_type="" class='required'/><font class="orange">*</font>
	        	</td>
	        	<td></td>
	        	<td></td>
	        	<td></td>
	        	<td></td>
	     	</tr>
		</table>
		<div>
			<table>
				<tr>
					<td align=center colspan="6" id="footer">
						<input type="button" class="b_foot" id="configBtn2" name="configBtn2" value="ȷ��" onclick="doCommit();"/>
					</td>
				</tr>
			</table>
		</div>
		
		<%@ include file="/npage/include/footer.jsp"%>
	</form>
</body>
</html>