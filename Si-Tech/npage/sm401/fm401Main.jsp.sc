<%
  /*
   * ����: 
   * �汾: 1.0
   * ����: gaopeng 2015/02/11 9:50:29 ����11�·ݼ��ſͻ���CRM��BOSS�;���ϵͳ����ĺ�-7-��ҵӦ��������BOSSϵͳ����
   * ����: gaopeng
   * ��Ȩ: si-tech
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
<%
	String ipAddrM = (String)session.getAttribute("ipAddr");
 		String inst = "ͨ��phoneNo[" + phoneNo + "]��ѯ";
		String gCustId = "";
		String custSql = "";
		String custName = "";
		String  inParamsMail [] = new String[2];
    inParamsMail[0] = "select trim(t.cust_id) from dcustmsg t where phone_no =:phoneNo";
    inParamsMail[1] = "phoneNo="+phoneNo;
		
%>
 <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode_mail" retmsg="retMessage_mail" outnum="1"> 
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
	 	
	<wtc:service name="sUserCustInfo" outnum="100" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
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
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js" type="text/javascript"></script>
	<script language="javascript">
		
		$(document).ready(function(){
			
		});
		
		function doQry(){
			
			
			
			var kdNo = $.trim($("#kdNo").val());
			var startCust = $.trim($("#startCust").val());
			var endCust = $.trim($("#endCust").val());
			
			if(startCust.length == 0 || endCust.length == 0){
				rdShowMessageDialog("��ѡ��ʼ�ͽ���ʱ�䣡",1);
				return false;
			}
			
			var yyyymmStart = startCust.substring(0,6);
			var yyyymmEnd = endCust.substring(0,6);
			if(yyyymmStart != yyyymmEnd){
				rdShowMessageDialog("��ʼ�ͽ���ʱ�䲻�ܿ��£�",1);
				return false;
			}
			
			
			if(kdNo.length == 0 ){
				//rdShowMessageDialog("���������˺ţ�",1);
				//return false;
			}
			
			/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm401/fm401Qry.jsp","���ڻ�����ݣ����Ժ�......");
			
			var iLoginAccept = "<%=loginAccept%>";
			var iChnSource = "01";
			var iOpCode = "<%=opCode%>";
			var iLoginNo = "<%=loginNo%>";
			var iLoginPwd = "<%=noPass%>";
			var iPhoneNo = "<%=phoneNo%>";
			var iUserPwd = "";
			
			
			getdataPacket.data.add("iLoginAccept",iLoginAccept);
			getdataPacket.data.add("iChnSource",iChnSource);
			getdataPacket.data.add("iOpCode",iOpCode);
			getdataPacket.data.add("iLoginNo",iLoginNo);
			getdataPacket.data.add("iLoginPwd",iLoginPwd);
			getdataPacket.data.add("iPhoneNo",iPhoneNo);
			getdataPacket.data.add("iUserPwd",iUserPwd);
			getdataPacket.data.add("opType","0");
			getdataPacket.data.add("startCust",startCust);
			getdataPacket.data.add("endCust",endCust);
			
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
				
				var appendTh = 
					"<tr>"
					+"<th width='5%'>ѡ��</th>"
					+"<th width='15%'>�ֻ�����</th>"
					+"<th width='20%'>����ʱ��</th>"
					+"<th width='20%'>���</th>"
					+"<th width='20%'>�ʷ�����</th>"
					+"<th width='20%'>������ˮ</th>"
					+"</tr>";
				$("#appendBody").append(appendTh);	
			for(var i=0;i<infoArray.length;i++){
        	
					var appendStr = "<tr>";
					
					appendStr += "<td width='5%' align='center' id='cardType'>"+"<input type='radio' name='chkone' value='"+infoArray[i][3]+"'/>"+"</td>"
											+"<td width='15%' align='center' id='cardType'>"+"<%=phoneNo%>"+"</td>"
											+"<td width='20%' align='center' id='cardPrice'>"+infoArray[i][0]+"</td>"
											+"<td width='20%' align='center' id='cardDiscount'>"+infoArray[i][1]+"</td>"
											+"<td width='20%' align='center' id='cardRealPrice'>"+infoArray[i][2]+"</td>"
											+"<td width='20%' align='center' id='cardSum'>"+infoArray[i][3]+"</td>"
					appendStr +="</tr>";	
									
					$("#appendBody").append(appendStr);
				}
				if(infoArray.length != 0){
					
				}
				
			}else{
				$("#resultContent").hide();
				$("#appendBody").empty();
				//$("#export").attr("disabled","disabled");
				rdShowMessageDialog("������룺"+retCode+",������Ϣ��"+retMsg,1);
				//window.location.reload();
			}
		}
		
		function showBroadKdZdBill(printType,DlgMessage,submitCfm){
			
			var chkoneObj = $("input[name='chkone'][checked]");
			var phoneNo = chkoneObj.parent().parent().find("td").eq(1).html();
			
			var printAccept = chkoneObj.parent().parent().find("td").eq(5).html();
			var offerName = chkoneObj.parent().parent().find("td").eq(4).html();
			
			var myFee = chkoneObj.parent().parent().find("td").eq(3).html();
			
	var printInfo = "";
	var prtLoginAccept = "";
	var iccidtypess="<%=custditypesnames%>";
	var iccidnoss="<%=custiccids%>";
	var fysqfss="";
	var  billArgsObj = new Object();
	  	
	  	
		var shuilv = 0.0;
		
		var feeName = "�ƶ��̳�����ֱ����";
		var kdZdFee = myFee;
		var danjia = 0;
		var shuie = 0;
		
		danjia = Number(kdZdFee) - Number(kdZdFee)*shuilv;
		shuie = Number(kdZdFee)*shuilv;
 		
			$(billArgsObj).attr("10001","<%=loginNo%>");     //����
			$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10005","<%=custName%>");   //�ͻ�����
			$(billArgsObj).attr("10006","����ֱ��");    //ҵ�����
			$(billArgsObj).attr("10008","<%=phoneNo%>");    //�û�����
			$(billArgsObj).attr("10015", kdZdFee+"");   //���η�Ʊ���
			$(billArgsObj).attr("10016", kdZdFee+"");   //��д���ϼ�
			$(billArgsObj).attr("10017","*");        //���νɷѣ��ֽ�
			/*10028 10029 ����ӡ*/
		  //$(billArgsObj).attr("10028","");   //�����Ӫ������ƣ�
			//$(billArgsObj).attr("10029","");	 //Ӫ������	
			$(billArgsObj).attr("10030",printAccept);   //��ˮ�ţ�--ҵ����ˮ
			$(billArgsObj).attr("10036","<%=opCode%>");   //��������
			$(billArgsObj).attr("10042","��");                   //��λ
			$(billArgsObj).attr("10043","1");	                   //����
			$(billArgsObj).attr("10044",kdZdFee+"");	                //����
			/*10045����ӡ*/
			$(billArgsObj).attr("10045","");	       //IMEI
			/*�ͺŲ���*/
			$(billArgsObj).attr("10061",offerName);	       //�ͺ�
			$(billArgsObj).attr("10062",shuilv+"");	//˰��
			$(billArgsObj).attr("10063",shuie+"");	//˰��	   
	    $(billArgsObj).attr("10071","7");	//˰��	
	 		$(billArgsObj).attr("10076",danjia+"");
	 		$(billArgsObj).attr("10077", kdZdFee+""); //����ն˽��
 			//$(billArgsObj).attr("10078", "111"); //���Ʒ��			
 			$(billArgsObj).attr("10085", "onlyFapiao"); //��������	
 			
 			
 			$(billArgsObj).attr("10041", "�ƶ��̳�����ֱ��");           //Ʒ����� ʵ���ǿ���ն�����
 			
 			
	 		
			var h=210;
			var w=400;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
			var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + "ȷʵҪ���з�Ʊ��ӡ��"+"&feeName="+feeName;
			var loginAccept = prtLoginAccept;
			var path = path +"&loginAccept="+loginAccept+"&opCode=<%=opCode%>"+"&submitCfm=submitCfm";
			var ret = window.showModalDialog(path,billArgsObj,prop);
			
			
			if(ret==""){
				var getdataPacket = new AJAXPacket("/npage/sm401/fm401SaveFP.jsp","��ӡ��ɸ������ݿ⣬���Ժ�......");
				
				var iLoginAccept = printAccept;
				var iChnSource = "01";
				var iOpCode = "m401";
				var iLoginNo = "<%=loginNo%>";
				var iLoginPwd = "<%=noPass%>";
				var iPhoneNo = "<%=phoneNo%>";
				var iUserPwd = "";
				
				getdataPacket.data.add("iLoginAccept",iLoginAccept);
				getdataPacket.data.add("iChnSource",iChnSource);
				getdataPacket.data.add("iOpCode",iOpCode);
				getdataPacket.data.add("iLoginNo",iLoginNo);
				getdataPacket.data.add("iLoginPwd",iLoginPwd);
				getdataPacket.data.add("iPhoneNo",iPhoneNo);
				getdataPacket.data.add("iUserPwd",iUserPwd);
				
				core.ajax.sendPacket(getdataPacket,function(packet){});
				getdataPacket = null;
				doQry();
			}
}

function fpdy(){
	var chkone = $.trim($("input[name='chkone'][checked]").val());
	if(chkone.length == 0){
		rdShowMessageDialog("��ѡ��һ����Ϣ���д�ӡ��");
		return false;
	}
	
	showBroadKdZdBill("Bill","ȷʵҪ���п���ն˷�Ʊ��ӡ��","Yes");	
	
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
	  		<td width="20%" class="blue">ҵ������</td>
	  		<td width="80%" colspan="3">
	  			<select name="opType">
	  				<option value="0">�ƶ��̳�����ֱ��</option>
	  			</select>
	  		</td>
	    </tr>
	    <tr>
	  		<td width="20%" class="blue">�ֻ�����</td>
	  		<td width="30%"">
	  			<input type="text" id="phoneNo" name="phoneNo" v_must="0" value="<%=phoneNo%>" class="InputGrey" readonly onblur="checkElement(this)"/>
	  		</td>
	  		<td width="20%" class="blue">�ͻ�����</td>
	  		<td width="30%">
	  			<input type="text" id="custName" name="custName" v_must="0" value="<%=custName%>" class="InputGrey" readonly onblur="checkElement(this)"/>
	  		</td>
	    </tr>
	    <tr>
	    	<td class="blue">��ʼʱ��</td>
				<td>
						<input type="text" id="startCust"  name="startCust" readOnly onclick="WdatePicker({el:'startCust',startDate:'%y%M%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true,maxDate:'#F{$dp.$D(\'endCust\')||\'%y%M%d\'}'})"/>
							<img id = "imgCustStart" 
								First. onclick="WdatePicker({el:'startCust',startDate:'%y%M%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true,maxDate:'#F{$dp.$D(\'endCust\')||\'%y%M%d\'}'})" 
			 					src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
				</td>
				<td class="blue">����ʱ��</td>
				<td>
					<input type="text" id="endCust"  name="endCust" readOnly onclick="WdatePicker({el:'endCust',startDate:'%y%M%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true,minDate:'#F{$dp.$D(\'startCust\')}'})"/>
								<img id = "imgCustEnd" 
									onclick="WdatePicker({el:'endCust',startDate:'%y%M%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true,minDate:'#F{$dp.$D(\'startCust\')}'})" 
				 					src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
				</td>
	    </tr>
	  </table>
	 <div>
	 	<table>
	   <tr>
			<td align=center colspan="4" id="footer">
				<input class="b_foot" id="QryBtn" name="QryBtn"  type="button" value="��ѯ"   onclick="doQry();">&nbsp;&nbsp;
				<input class="b_foot" id="resetBtn" name="resetBtn"  type="button" value="����"  onclick="javascript:window.location.reload();">&nbsp;&nbsp;
				<input class="b_foot" name="close"  onClick="removeCurrentTab()" type=button value=�ر�>
			</td>
		</tr>
		
		</table>
	 <!-- ��ѯ����б� -->
	<div id="resultContent" style="display:none">
		<div class="title">
			<div id="title_zi">��ѯ�����Ϣ�б�</div>
		</div>
		<table id="exportExcel" name="exportExcel">
			<tbody id="appendBody">
				
			
			</tbody>
		</table>
		<table>
	   <tr>
				<td align=center colspan="4" id="footer">
					<input class="b_foot" id="configBtn" name="configBtn"  type="button" value="��ӡ��Ʊ"  onclick="fpdy();">&nbsp;&nbsp;
					<input class="b_foot" id="resetBtn" name="resetBtn"  type="button" value="����"  onclick="javascript:window.location.href='/npage/sm225/fm225Main.jsp?opName=<%=opName%>&opCode=<%=opCode%>'">&nbsp;&nbsp;
					<input class="b_foot" name="close"  onClick="removeCurrentTab()" type=button value=�ر�>
				</td>
			</tr>
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
