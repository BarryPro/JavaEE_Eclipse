<%
  /*
   * ����:
   * �汾: 1.0
   * ����: 
   * ����: 2017-01-19 liangyl �����Ż���è����ϵͳ��������ĺ�
   * ��Ȩ: si-tech
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
		
function gom447Qry(){
	var broadAccount = $("#broadAccount").val();
	if(broadAccount.length ==0){
		rdShowMessageDialog("����д����˺ţ�",1);
		return false;
	}
	
	var getdataPacket = new AJAXPacket("fm447Qry_1.jsp","���ڻ�����ݣ����Ժ�......");
	var iLoginAccept = "<%=loginAccept%>";
	var iChnSource = "01";
	var iOpCode = "<%=opCode%>";
	var iLoginNo = "<%=loginNo%>";
	var iLoginPwd = "<%=noPass%>";
	var iPhoneNo ="";
	var iUserPwd = "";
	var iCfmLogin = broadAccount;
	
	getdataPacket.data.add("iLoginAccept",iLoginAccept);
	getdataPacket.data.add("iChnSource",iChnSource);
	getdataPacket.data.add("iOpCode",iOpCode);
	getdataPacket.data.add("iLoginNo",iLoginNo);
	getdataPacket.data.add("iLoginPwd",iLoginPwd);
	getdataPacket.data.add("iPhoneNo",iPhoneNo);
	getdataPacket.data.add("iUserPwd",iUserPwd);
	getdataPacket.data.add("iCfmLogin",iCfmLogin);
	
	core.ajax.sendPacket(getdataPacket,doQry);
	getdataPacket = null;
}
		
function doQry(packet){
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	var retArray = packet.data.findValueByName("retArray");
	
	if(retCode == "000000"){
		$("#resultContent").show();
		$("#appendBody").empty();
		var appendTh = 
			"<tr>"
			+"<th width='25%'>����ONT</th>"
			+"<th width='25%'>�滻ONT</th>"
			+"<th width='25%'>����ʱ��</th>"
			+"<th width='15%'>���</th>"
			+"<th width='10%'>��ӡ���</th>"
			+"</tr>";
		$("#appendBody").append(appendTh);	
		var dyPhone="";
		var geshu=0;
		for(var i=0;i<retArray.length;i++){
			var str=retArray[i][5]=="Y"?"disabled='disabled'":"";
			var appendStr = "<tr>";
			appendStr += "<td width='25%'>"+retArray[i][0]+"</td>"
			+"<td width='25%'>"+retArray[i][1]+"</td>"
			+"<td width='25%'>"+retArray[i][2]+"</td>"
			+"<td width='25%'>"+retArray[i][3]+"</td>"
			+"<td width='25%'><input type=\"button\" "+str+" class=\"b_foot_long\" value=\"��ӡ�վ�\" onclick=\"daYin('"+retArray[i][4]+"','"+retArray[i][3]+"','"+retArray[i][6]+"','"+retArray[i][7]+"','"+retArray[i][8]+"')\"/></td>"
			appendStr +="</tr>";
			$("#appendBody").append(appendStr);
		}
		if(dyPhone!=""){
			dyPhone=dyPhone.substring(0,dyPhone.length-1);
		}
		var appendStr2 = "<tr>";
		appendStr2 += "<td  align=\"center\" colspan=\"8\"></td>";
		appendStr2 +="</tr>";
		$("#appendBody").append(appendStr2);
		
		$("#excelExp").attr("disabled","");
		
	}else{
		$("#resultContent").hide();
		$("#appendBody").empty();
		$("#excelExp").attr("disabled","disabled");
		rdShowMessageDialog("������룺"+retCode+",������Ϣ��"+retMsg,1);
		
	}
}
		
function daYin(liushui,jine,idtype,idnum,userPhoneNum){
	var billFlag=sm447_show_Bill_Prt(liushui,jine,idtype,idnum,userPhoneNum);
	gom447Cfm(liushui);
	
}
function sm447_show_Bill_Prt(liushui,jine,idtype,idnum,userPhoneNum){
	//0|���֤ 1|����֤ 2|���ڲ� 3|�۰�ͨ��֤ 
	//4|����֤ 5|̨��ͨ��֤ 6|��������� 7|���� 
	//8|Ӫҵִ�� 9|���� A|��֯�������� B|��λ����֤�� C|������ 
	var idTypeStr="";
	if(idtype=="0"){
		idTypeStr="���֤";
	}
	else if(idtype=="1"){
		idTypeStr="����֤";
	}
	else if(idtype=="2"){
		idTypeStr="���ڲ�";
	}
	else if(idtype=="3"){
		idTypeStr="�۰�ͨ��֤ ";
	}
	else if(idtype=="4"){
		idTypeStr="����֤";
	}
	else if(idtype=="5"){
		idTypeStr="̨��ͨ��";
	}
	else if(idtype=="6"){
		idTypeStr="���������";
	}
	else if(idtype=="7"){
		idTypeStr="����";
	}
	else if(idtype=="8"){
		idTypeStr="Ӫҵִ��";
	}
	else if(idtype=="9"){
		idTypeStr="����";
	}
	else if(idtype=="A"){
		idTypeStr="��֯��������";
	}
	else if(idtype=="B"){
		idTypeStr="��λ����֤��";
	}
	else if(idtype=="C"){
		idTypeStr="������";
	}
	else{
		idTypeStr="���֤";
	}
	var  billArgsObj = new Object();
	$(billArgsObj).attr("10001","<%=loginNo%>");     //����
	$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
	$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
	$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
	$(billArgsObj).attr("10005","�ͻ�����");   //�ͻ�����
	$(billArgsObj).attr("10006","����豸�����վݲ���");    //ҵ�����
	
	$(billArgsObj).attr("10008",userPhoneNum);    //�û�����
	$(billArgsObj).attr("10015", jine);   //���η�Ʊ���
	$(billArgsObj).attr("10016", jine);   //��д���ϼ�
	$(billArgsObj).attr("10017",jine);        //���νɷѣ��ֽ�
	/*10028 10029 ����ӡ*/
	$(billArgsObj).attr("10028","");   //�����Ӫ������ƣ�
	$(billArgsObj).attr("10029","");	 //Ӫ������	
	$(billArgsObj).attr("10030",liushui);   //��ˮ�ţ�--ҵ����ˮ
	$(billArgsObj).attr("10036","m432");   //��������
	/**/
	/*�ͺŲ���*/
	$(billArgsObj).attr("10061","");	       //�ͺ�
	$(billArgsObj).attr("10062","");	//˰��
	$(billArgsObj).attr("10063","");	//˰��	   
 	$(billArgsObj).attr("10071","6");	//
	$(billArgsObj).attr("10076",jine);	//��д���ϼ�
		
	$(billArgsObj).attr("10083",idTypeStr); //֤������
	$(billArgsObj).attr("10084",idnum); //֤������
	$(billArgsObj).attr("10086", "�𾴵Ŀͻ�����������ҵ���˶���ȡ������ֹҵ��ʹ�õĲ���ʱ����Я�����վݡ���Ч���֤��������ҵ��ʱ����ħ�ٺ��ն˵��ƶ�ָ������Ӫҵ������Ѻ���˻�����������ն�Ѻ�𷵻���ֹ���ڣ��û�������90���ڣ�����90�죩��"); //��ע
	$(billArgsObj).attr("10065", $("#broadAccount").val()); //����˺�
	$(billArgsObj).attr("10087", "000000"); //imei����
	$(billArgsObj).attr("10041", "����豸�����վݲ���");           //Ʒ�����
	$(billArgsObj).attr("10042","̨");                   //��λ
	$(billArgsObj).attr("10043","1");	                   //����
	$(billArgsObj).attr("10044",jine);	                //����
	 			
	$(billArgsObj).attr("10085", "zsj"); //���������ȡ��ʽ ֻ������ӡ�վݵĿ�
	$(billArgsObj).attr("10072","1"); //1--������Ʊ  2--�����෢Ʊ  2--�˷��෢Ʊ
	$(billArgsObj).attr("10088","m447"); //�վ�ģ��
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
	//var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + "ȷʵҪ���з�Ʊ��ӡ��";
	$(billArgsObj).attr("11213","REC");  //�°淢Ʊ����Ʊ�ݱ�־λ��Ĭ�Ͽ�λ��Ʊ REC == ֻ�� ��ӡֽ���վ�
	var path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=" + "ȷʵҪ���з�Ʊ��ӡ��";
	var loginAccept = "<%=loginAccept%>";
	var path = path +"&loginAccept="+loginAccept+"&opCode=<%=opCode%>&submitCfm=submitCfm";
	var ret = window.showModalDialog(path,billArgsObj,prop);
}

function gom447Cfm(liushui){
	var broadAccount = $("#broadAccount").val();
	if(broadAccount.length ==0){
		rdShowMessageDialog("����д����˺ţ�",1);
		return false;
	}
	
	var getdataPacket = new AJAXPacket("fm447Cfm.jsp","���ڻ�����ݣ����Ժ�......");
	var iLoginAccept = liushui;
	var iChnSource = "01";
	var iOpCode = "<%=opCode%>";
	var iLoginNo = "<%=loginNo%>";
	var iLoginPwd = "<%=noPass%>";
	var iPhoneNo ="";
	var iUserPwd = "";
	var iCfmLogin = broadAccount;
	
	getdataPacket.data.add("iLoginAccept",iLoginAccept);
	getdataPacket.data.add("iChnSource",iChnSource);
	getdataPacket.data.add("iOpCode",iOpCode);
	getdataPacket.data.add("iLoginNo",iLoginNo);
	getdataPacket.data.add("iLoginPwd",iLoginPwd);
	getdataPacket.data.add("iPhoneNo",iPhoneNo);
	getdataPacket.data.add("iUserPwd",iUserPwd);
	getdataPacket.data.add("iCfmLogin",iCfmLogin);
	
	core.ajax.sendPacket(getdataPacket,dom447Cfm);
	getdataPacket = null;
}
		
function dom447Cfm(packet){
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");	
	if(retCode == "000000"){
		gom447Qry();
	}else{
		rdShowMessageDialog("������룺"+retCode+",������Ϣ��"+retMsg,1);
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
		  		<td width="20%" class="blue">����ն�</td>
				<td width="30%">
					<select id="broadTerminal" name="broadTerminal">
						<option value="ONT" selected="selected">ONT</option>
					</select>
					<font color="red">*</font>
				</td>
				<td width="20%" class="blue">����˺�</td>
				<td width="30%">
					<input type="text" id="broadAccount" name="broadAccount" value=""/>
					<font color="red">*</font>
				</td>
		    </tr>
		    <tr>
				<td align=center colspan="4" id="footer">
					<input class="b_foot" name="sure"  type="button" value="��ѯ" onclick="gom447Qry();"/>
					<!-- <input  name="back1"  class="b_foot" type="button" value="����excel" id="excelExp" onclick="printTable(exportExcel)" disabled="disabled"/> -->
				</td>
			</tr>
		</table>
	</div>
	<!-- ��ѯ����б� -->
	<div id="resultContent" style="display:none">
		<div class="title">
			<div id="title_zi">��ѯ����б�</div>
		</div>
		<table id="exportExcel" name="exportExcel">
			<tbody id="appendBody"></tbody>
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