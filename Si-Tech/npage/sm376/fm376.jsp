<%
/********************
 version v2.0
������: si-tech
create by wanglm 20110321
********************/
%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
  request.setCharacterEncoding("GBK");
  String opCode = (String)request.getParameter("opCode");
  String opName = (String)request.getParameter("opName");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=opName%></title>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    String work_no = (String)session.getAttribute("workNo");
	String workNo = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String regionCode = (String)session.getAttribute("regCode");
    String groupId = (String)session.getAttribute("groupId");
    
    String current_timeNAME=new SimpleDateFormat("yyyyMMdd HH:mm:ss", Locale.getDefault()).format(new java.util.Date());
    String pic_Name=new SimpleDateFormat("yyyyMMddHHmmss", Locale.getDefault()).format(new java.util.Date());
    String loginAccept = getMaxAccept();
    String orgCode =(String)session.getAttribute("orgCode");
    String belongCode =orgCode.substring(0,7);
    String ip_Addr =(String)session.getAttribute("ip_Addr");
%>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
<%
     String sqlStrl ="select sMaxSysAccept.nextval from dual";
  %>
    <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCodel" retmsg="retMsgl" outnum="1">
    <wtc:sql><%=sqlStrl%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="resultl" scope="end" />
  <%
  String printAccept = "";
    if(retCodel.equals("000000")){
        printAccept = (resultl[0][0]).trim();
    }             
  %> 
    
<script type="text/javascript">
$(function (){
	$("#scan_idCard_two3").show();
})
var v_printAccept = "<%=printAccept%>";
	onload=function(){
	  	<%if("m407".equals(opCode)){
	  		%>
	  		$('input[name="yewuradio"][value=2]').attr("checked",true);
	  		<%
	  	}%>
			checkadd();
			document.all.querysss.disabled=true;
		  document.all.quchoose.disabled=false;	
	  
	}
  

	function getFileName(obj){
		var pos = obj.lastIndexOf("\\");
		return obj.substring(pos+1);
	}
	function getFileExt(obj)
	{
	    var pos = obj.lastIndexOf(".");
	    return obj.substring(pos+1);
	}
 function doCfm(){
		var radio_val = $('input[name="yewuradio"]:checked').val(); 	
		if(radio_val=="2"){
			if("Y"==$("#print_query").val()){
				if(""==$("#ipt_trnPhoneNo").val().trim()){
					rdShowMessageDialog("������ת���ֻ���");
					return false;
				}
				
				if(""==$("#ipt_conPhoneNo").val().trim()){
					rdShowMessageDialog("������ͻ���ϵ�绰");
					return false;
				}
			}
			
			if(""==$("#zhengjianhaoma").val().trim()){
				rdShowMessageDialog("������֤������");
					return false;
			}
		}
			
			
			
 			 	if(form1.feefile.value.length<1){
					rdShowMessageDialog("���ϴ��ļ�!");
					document.form1.feefile.focus();
					return false;
				}
		 		//var fileVal = getFileName($("#feefile").val());
		 		var fileVal = getFileExt($("#feefile").val());
				if("txt" == fileVal){
					//��չ����txt
				}else{
					rdShowMessageDialog("�ϴ��ļ�����չ������ȷ,ֻ���Ǻ�׺Ϊtxt�����ļ���",0);
					return false;
				}
				var ywtypes= $('input[name="yewuradio"]:checked').val(); 
				$("#ywtypes").val(ywtypes);
				document.all.querysss.disabled=true;
				document.form1.action = "fm376Cfm.jsp";
   			document.form1.submit();
 }

 	function resetPage(){
 		window.location.href = "f<%=opCode%>.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	}
	function checkadd(){
		$("#tr_trnPhone").hide();
		$("#accepts").val("");
		 $("#print_query").val("N");
		var optypes= $('input[name="radio"]:checked').val(); 
		var ywtypes= $('input[name="yewuradio"]:checked').val(); 
		
    	$("#showTab").empty();
    	$("#liushuiShow").empty();
		
		if(optypes=="0") {
			$("#zengjia").show();
			$("#table1").hide();
			document.all.querysss.disabled=true;
	  		document.all.quchoose.disabled=false;			
		}else if(optypes=="1") {
			$("#zengjia").hide();
			$("#table1").show();
			document.all.querysss.disabled=false;
	 		document.all.quchoose.disabled=true;	
		}
		
		$("#haomaleixing").val("0");
		haomaCheck();
		if(ywtypes=="0") {
			$("#xiaohuzs").hide();
			$("#zhengjianleixintr").hide();
			$("#zhengjianhaomatr").hide();
			$("#yonghuleixingtr").hide();
			$("#haomaleixingtr").hide();
			$("#showmsgs").text("�����˹��ܵĹ��ű�����С�(2355)ǿ�ƿ��ػ��ָ���Ȩ��");                            
		}else if(ywtypes=="1"){
			$("#xiaohuzs").show();
			$("#zhengjianleixintr").hide();
			$("#zhengjianhaomatr").hide();
			$("#yonghuleixingtr").hide();
			$("#haomaleixingtr").hide();
			$("#showmsgs").text("�����˹��ܵĹ��ű�����С�(1216)ע��(Ԥ��)��Ȩ��");
		}
		else if(ywtypes=="2"){
			$("#xiaohuzs").show();
			$("#zhengjianleixintr").show();
			$("#zhengjianhaomatr").show();
			$("#yonghuleixingtr").hide();
			$("#haomaleixingtr").show();
			$("#showmsgs").html("�����˹��ܵĹ��ű�����С�(1216)ע��(Ԥ��)��Ȩ��<br>��������������Ԥ�����ڡ�m239--������ҵ��ͨ״̬��ѯ����ѯ������,����ӡ���.");
			$("#liushuiShow").html("��������������Ԥ�����ڡ�m239--������ҵ��ͨ״̬��ѯ����ѯ������,����ӡ���.");
		}
		else if(ywtypes=="3"){
			$("#xiaohuzs").hide();
			$("#zhengjianleixintr").hide();
			$("#zhengjianhaomatr").hide();
			$("#yonghuleixingtr").show();
			$("#haomaleixingtr").hide();
			$("#showmsgs").html("�����˹��ܵĹ��ű�����С�(1218)ע��(����)��Ȩ��<br/>��������:�ֻ�����");
		}
	}
	
	
	 function chk_Phone() {
 
 				var accepts = $("#accepts").val();
				if(accepts.trim()=="") {
						rdShowMessageDialog("�����������ˮ���в�ѯ��");
						return false;
				}
			var ywtypes= $('input[name="yewuradio"]:checked').val(); 

			var myPacket = new AJAXPacket("fm376Qry.jsp","���ڲ�ѯ��Ϣ�����Ժ�......");
			myPacket.data.add("accepts",accepts);
			myPacket.data.add("ywtypes",ywtypes);
		
			core.ajax.sendPacketHtml(myPacket,querinfo,true);
			myPacket = null;
	
 }
 
		function querinfo(data){
				//�ҵ���ӱ���div
				var markDiv=$("#showTab"); 
				markDiv.empty();
				markDiv.append(data);
				
		}
		


function set_show_trnPhone(bt){
	var radio_val = $('input[name="yewuradio"]:checked').val(); 	
	if(radio_val=="2"){
		var is_flag = $(bt).val();
		if("Y"==is_flag){
			//ѡ����
			$("#tr_trnPhone").show();
		}else{
			$("#tr_trnPhone").hide();
		}
	}else{
		$("#tr_trnPhone").hide();
	}
}
function haomaCheck(){
	if($("#haomaleixing").val()=="1"){
		$("#gestoresInfo1").show();
		$("#gestoresInfo2").show();
		$("#haomaFont").html("14765350650<br/>14765350651");
		
	}
	else{
		$("#gestoresInfo1").hide();
		$("#gestoresInfo2").hide();
		$("#haomaFont").html("13904510001<br/>13904510002");
	}
}
function validateGesIdTypes(idtypeVal){
	
	if(idtypeVal.indexOf("���֤") != -1){
		document.all.gestoresIccId.v_type = "idcard";
		$("#scan_idCard_two3").css("display","");
		$("#scan_idCard_two31").css("display","");
		$("input[name='gestoresName']").attr("class","InputGrey");
		$("input[name='gestoresName']").attr("readonly","readonly");
		$("input[name='gestoresAddr']").attr("class","InputGrey");
		$("input[name='gestoresAddr']").attr("readonly","readonly");
		$("input[name='gestoresIccId']").attr("class","InputGrey");
		$("input[name='gestoresIccId']").attr("readonly","readonly");
		$("input[name='gestoresName']").val("");
		$("input[name='gestoresAddr']").val("");
		$("input[name='gestoresIccId']").val("");

	}else{
		document.all.gestoresIccId.v_type = "string";
		$("#scan_idCard_two3").css("display","none");
		$("#scan_idCard_two31").css("display","none");
		$("input[name='gestoresName']").removeAttr("class");
		$("input[name='gestoresName']").removeAttr("readonly");
		$("input[name='gestoresAddr']").removeAttr("class");
		$("input[name='gestoresAddr']").removeAttr("readonly");
		$("input[name='gestoresIccId']").removeAttr("class");
		$("input[name='gestoresIccId']").removeAttr("readonly");

	}
}

function subStrAddrLength(str,idAddr){
	var packet = new AJAXPacket("/npage/sq100/fq100_ajax_subStrAddrLength.jsp","���ڻ�����ݣ����Ժ�......");
	packet.data.add("str",str);
	packet.data.add("idAddr",idAddr);
	core.ajax.sendPacket(packet,doSubStrAddrLength);
	packet = null;
}
function doSubStrAddrLength(packet){
	var str = packet.data.findValueByName("str");
	var idAddr = packet.data.findValueByName("idAddr");
	if(str == "31"){ //������
		document.all.gestoresAddr.value =idAddr;//���֤��ַ
	}else if(str == "manage"){ //������ �ɰ�
		document.all.gestoresAddr.value =idAddr;//���֤��ַ
	}else if(str == "zerenren"){ //������ �ɰ�
		document.all.responsibleAddr.value =idAddr;//���֤��ַ
	}else if(str == "57"){ //������ 
		document.all.responsibleAddr.value =idAddr;//���֤��ַ
	}
}

function getCuTime(){
	 var curr_time = new Date(); 
	 with(curr_time) 
	 { 
	 var strDate = getYear()+"-"; 
	 strDate +=getMonth()+1+"-"; 
	 strDate +=getDate()+" "; //ȡ��ǰ���ڣ�������ġ��ա��ֱ�ʶ 
	 strDate +=getHours()+"-"; //ȡ��ǰСʱ 
	 strDate +=getMinutes()+"-"; //ȡ��ǰ���� 
	 strDate +=getSeconds(); //ȡ��ǰ���� 
	 return strDate; //������ 
	 } 
	}
 
 function Idcard_realUser(flag){
		//��ȡ�������֤
		//document.all.card_flag.value ="2";
		
		var picName = getCuTime();
		var fso = new ActiveXObject("Scripting.FileSystemObject");  //ȡϵͳ�ļ�����
		var tmpFolder = fso.GetSpecialFolder(0); //ȡ��ϵͳ��װĿ¼
		var strtemp= tmpFolder+"";
		var filep1 = strtemp.substring(0,1)//ȡ��ϵͳĿ¼�̷�
		var cre_dir = filep1+":\\custID";//����Ŀ¼
		//�ж��ļ����Ƿ���ڣ��������򴴽�Ŀ¼
		if(!fso.FolderExists(cre_dir)) {
			var newFolderName = fso.CreateFolder(cre_dir);  
		}
		var picpath_n = cre_dir +"\\"+picName+"_"+ document.all.custId.value +".jpg";
		
		var result;
		var result2;
		var result3;
	
		result=IdrControl1.InitComm("1001");
		if (result==1)
		{
			result2=IdrControl1.Authenticate();
			if ( result2>0)
			{              
				result3=IdrControl1.ReadBaseMsgP(picpath_n); 
				if (result3>0)           
				{     
			  var name = IdrControl1.GetName();
				var code =  IdrControl1.GetCode();
				var sex = IdrControl1.GetSex();
				var bir_day = IdrControl1.GetBirthYear() + "" + IdrControl1.GetBirthMonth() + "" + IdrControl1.GetBirthDay();
				var IDaddress  =  IdrControl1.GetAddress();
				var idValidDate_obj = IdrControl1.GetValid();
		
				if(flag == "manage"){ //������
					document.all.gestoresName.value =name;//����
					document.all.gestoresIccId.value =code;//���֤��
					//document.all.gestoresAddr.value =IDaddress;//���֤��ַ
				}
				
				if(flag == "zerenren"){  //������
					document.all.responsibleName.value =name;//����
					document.all.responsibleIccId.value =code;//���֤��
					//document.all.gestoresAddr.value =IDaddress;//���֤��ַ
				}				
				
				subStrAddrLength(flag,IDaddress);//У�����֤��ַ���������60���ַ������Զ���ȡǰ30����
				}
				else
				{
					rdShowMessageDialog(result3); 
					IdrControl1.CloseComm();
				}
			}
			else
			{
				IdrControl1.CloseComm();
				rdShowMessageDialog("�����½���Ƭ�ŵ���������");
			}
		}
		else
		{
			IdrControl1.CloseComm();
			rdShowMessageDialog("�˿ڳ�ʼ�����ɹ�",0);
		}
		IdrControl1.CloseComm();
	}
	
	function Idcard2(str){
			//ɨ��������֤
		var fso = new ActiveXObject("Scripting.FileSystemObject");  //ȡϵͳ�ļ�����
		tmpFolder = fso.GetSpecialFolder(0); //ȡ��ϵͳ��װĿ¼
		var strtemp= tmpFolder+"";
		var filep1 = strtemp.substring(0,1)//ȡ��ϵͳĿ¼�̷�
		var cre_dir = filep1+":\\custID";//����Ŀ¼
		if(!fso.FolderExists(cre_dir)) {
			var newFolderName = fso.CreateFolder(cre_dir);
		}
	var ret_open=CardReader_CMCC.MutiIdCardOpenDevice(1000);
	if(ret_open!=0){
		ret_open=CardReader_CMCC.MutiIdCardOpenDevice(1001);
	}	
	var cardType ="11";
	if(ret_open==0){
		//alert(v_printAccept+"--"+str);
			//�๦���豸RFID��ȡ
			var ret_getImageMsg=CardReader_CMCC.MutiIdCardGetImageMsg(cardType,"c:\\custID\\cert_head_"+v_printAccept+str+".jpg");
			if(str=="1"){
				try{
					document.all.pic_name.value = "C:\\custID\\cert_head_"+v_printAccept+str+".jpg";
					document.all.but_flag.value="1";
					document.all.card_flag.value ="2";
				}catch(e){
						
				}
			}
			//alert(ret_getImageMsg);
			//ret_getImageMsg = "0";
			if(ret_getImageMsg==0){
				//����֤������ϳ�
				var xm =CardReader_CMCC.MutiIdCardName;					
				var xb =CardReader_CMCC.MutiIdCardSex;
				var mz =CardReader_CMCC.MutiIdCardPeople;
				var cs =CardReader_CMCC.MutiIdCardBirthday;
				var yx =CardReader_CMCC.MutiIdCardSigndate+"-"+CardReader_CMCC.MutiIdCardValidterm;
				var yxqx = CardReader_CMCC.MutiIdCardValidterm;//֤����Ч��
				var zz =CardReader_CMCC.MutiIdCardAddress; //סַ
				var qfjg =CardReader_CMCC.MutiIdCardOrgans; //ǩ������
				var zjhm =CardReader_CMCC.MutiIdCardNumber; //֤������
				var base64 =CardReader_CMCC.MutiIdCardPhoto;
				var v_validDates = "";
				if(yxqx.indexOf("\.") != -1){
					yxqx = yxqx.split(".");
					if(yxqx.length >= 3){
						v_validDates = yxqx[0]+yxqx[1]+yxqx[2]; 
					}else{
						v_validDates = "21000101";
					}
				}else{
					v_validDates = "21000101";
				}
				
				if(str == "31"){ //������
					document.all.gestoresName.value =xm;//����
					document.all.gestoresIccId.value =zjhm;//���֤��
					document.all.gestoresAddr.value =zz;//���֤��ַ
				}else if(str == "57"){ //������
					document.all.responsibleName.value =xm;//����
					document.all.responsibleIccId.value =zjhm;//���֤��
					document.all.gestoresAddr.value =zz;//���֤��ַ
				}
				
				//subStrAddrLength(str,zz);//У�����֤��ַ���������60���ַ������Զ���ȡǰ30����

			}else{
					rdShowMessageDialog("��ȡ��Ϣʧ��");
					return ;
			}
	}else{
					rdShowMessageDialog("���豸ʧ��");
					return ;
	}
	//�ر��豸
	var ret_close=CardReader_CMCC.MutiIdCardCloseDevice();
	if(ret_close!=0){
		rdShowMessageDialog("�ر��豸ʧ��");
		return ;
	}
}

</script>

<script type="text/javascript">
var excelObj;

function printTable(obj){
	var str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	total_row = 0;
	if(document.all.t1.length > 1)	{
		excelObj = new ActiveXObject('excel.Application');
		excelObj.Visible = true;
 //excelObj.WorkBooks.Add; 
    var workB = excelObj.Workbooks.Add(); ////����µĹ�����   
   var sheet = workB.ActiveSheet;   
  sheet.Columns("A").ColumnWidth =13;//�����п� 
  sheet.Columns("A").numberformat="@";
  sheet.Columns("B").ColumnWidth =13;//�����п� 
  sheet.Columns("B").numberformat="@";
  sheet.Columns("C").ColumnWidth =8;//�����п� 
  sheet.Columns("C").numberformat="@";
  sheet.Columns("D").ColumnWidth =8;//�����п� 
  sheet.Columns("D").numberformat="@";
  sheet.Columns("E").ColumnWidth =20;//�����п�
  sheet.Columns("E").numberformat="@"; 



		for(a=0;a<document.all.t1.length;a++)
		{
			rows=obj[a].rows.length;
			if(rows>0)
			{
 				try
				{
					for(i=0;i<rows;i++)					{
						cells=obj[a].rows[i].cells.length;
						var g=0;
						for(j=0;j<cells;j++)
						{
							if(obj[a].rows[i].cells[j].colSpan > 1)
							{
							var colspan = obj[a].rows[i].cells[j].colSpan;
							for(g=0;g<colspan-1;g++)
								{
									excelObj.Cells(i+1+(total_row),1*g+1).Value='';
					            }
								g++;
					  		    excelObj.Cells(i+1+(total_row),g).Value=obj[a].rows[i].cells[j].innerText;
							}
							else
							{
							excelObj.Cells(i+1+(total_row),1*g+1).Value=obj[a].rows[i].cells[j].innerText;
							g++;
							}
						}
					}
				}
				catch(e)
				{
					alert('����excelʧ��!');
				}
			}
			else
			{
				alert('no data');
 			}
 			total_row = eval(total_row+rows);
		}
	}
	else
	{
		excelObj = new ActiveXObject('excel.Application');
		excelObj.Visible = true;
 //excelObj.WorkBooks.Add; 
   var workB = excelObj.Workbooks.Add(); ////����µĹ�����   
   var sheet = workB.ActiveSheet;  
  sheet.Columns("A").ColumnWidth =13;//�����п� 
  sheet.Columns("A").numberformat="@";
  sheet.Columns("B").ColumnWidth =13;//�����п� 
  sheet.Columns("B").numberformat="@";
  sheet.Columns("C").ColumnWidth =8;//�����п� 
  sheet.Columns("C").numberformat="@";
  sheet.Columns("D").ColumnWidth =8;//�����п� 
  sheet.Columns("D").numberformat="@";
  sheet.Columns("E").ColumnWidth =20;//�����п�
  sheet.Columns("E").numberformat="@"; 

		rows=obj.rows.length;
		if(rows>0)
		{
 			try
			{
				for(i=0;i<rows;i++)
				{
					cells=obj.rows[i].cells.length;
					var g=0;
					for(j=0;j<cells;j++)
					{
							if(obj.rows[i].cells[j].colSpan > 1)
							{
							var colspan = obj.rows[i].cells[j].colSpan;
							for(g=0;g<colspan-1;g++)
								{
									excelObj.Cells(i+1+(total_row),1*g+1).Value = '';
					            }
								g++;
					  		    excelObj.Cells(i+1+(total_row),g).Value=obj.rows[i].cells[j].innerText;
							}
							else
							{
							excelObj.Cells(i+1+(total_row),1*g+1).Value=obj.rows[i].cells[j].innerText;
							g++;
							}
					}
				}
			}
			catch(e)
			{
				alert('����excelʧ��!');
			}
			total_row = eval(total_row+rows);
		}
		else
		{
			alert('no data');
		}
	}
	excelObj.Range('A1:'+str.charAt(cells+colspan-2)+total_row).Borders.LineStyle=1;
}

</script>
</head>
<body>
<form name="form1" id="form1" method="post" enctype="multipart/form-data">
<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
      <table cellspacing="0">
      	
		<tr>
			<td class="blue" width="13%">ҵ������</td>
			<td colspan="2"><input type="radio" name="yewuradio" value="0" checked="checked"  onclick="checkadd()" />ǿ�ƿ��ػ��ָ�(����)&nbsp;&nbsp;
			    <input type="radio" name="yewuradio" value="1"  onclick="checkadd()" />ǿ��Ԥ��(����)
			    <input type="radio" name="yewuradio" value="2"  onclick="checkadd()" />��λ�ͻ�Ԥ��(����)
			    <input type="radio" name="yewuradio" value="3"  onclick="checkadd()" />ǿ������(����)
			</td>
		</tr>
		
		<tr>
			<td class="blue" width="13%">��������</td>
			<td colspan="2"><input type="radio" name="radio" value="0" checked="checked"  onclick="checkadd()" />�����ѯ
			    <input type="radio" name="radio" value="1" onclick="checkadd()" />��������
			</td>
		</tr>
		<tr id="zengjia">
			    <td class="blue" width="13%"> ������ˮ</td>
						<td >
							<input type="text" id="accepts" name="accepts"  maxlength="14"/>
							<font class="orange">*</font> 
							<input type="button" name="chkPhone" id="chkPhone" value="��ѯ" 
							 class="b_text"  onclick="chk_Phone()" />  
						</td>
						<td><font id="liushuiShow" color="red"></font></td>
		</tr>
	</table>
	

	<div id="showTab" ></div>

		<table cellspacing="0" name="table1" id="table1">

			<tr id='xiaohuzs' style="display: none">
				<td class="blue" width="13%">�Ƿ�ѡ����Ȩ����</td>
				<td colspan="3"><select id="print_query"  name="print_query" onchange="set_show_trnPhone(this)">
						<option class='button' value='N' selected="selected">��</option>
						<option class='button' value='Y' >��</option>
				</select> <font class="orange">* </font></td>
			</tr>
			
			<tr id='tr_trnPhone' style="display:none">
				<td class="blue" width="13%">ת���ֻ���</td>
				<td width="37%">
					<input type="text" id="ipt_trnPhoneNo" name="ipt_trnPhoneNo" maxlength="11" v_must="0" v_type="mobphone"  onblur = "checkElement(this)"  />
					<font class="orange">*</font>
				</td>
				<td class="blue" width="13%">�ͻ���ϵ�绰</td>
				<td>
					<input type="text" id="ipt_conPhoneNo" name="ipt_conPhoneNo" maxlength="11"  v_must="0" v_type="mobphone"  onblur = "checkElement(this)"  />
					<font class="orange">*</font>
				</td>
			</tr>

			
			<tr id='zhengjianleixintr' style="display: none">
				<td class="blue" width="13%">֤������</td>
				<td colspan="3">
					<select name="zhengjianleixing">
						<option class="button" value="8" selected="selected">Ӫҵִ��</option>
						<option class="button" value="A">��֯��������</option>
						<option class="button" value="B">��λ����֤��</option>
						<option class="button" value="C">��λ֤��</option>
					</select>
				<font class="orange">* </font></td>
			</tr>
			<tr id="zhengjianhaomatr" style="display: none">
				<td class="blue" width="13%">֤������</td>
				<td colspan="3">
				<input id="zhengjianhaoma" name="zhengjianhaoma" maxlength="25"/>
				<font class="orange">* </font></td>
			</tr>
			<tr id="yonghuleixingtr" style="display: none">
				<td class="blue" width="13%">�û�����</td>
				<td colspan="3">
				<select name="yonghuleixing">
					<option class="button" value="0" selected="selected">�����û�</option>
				</select>
				<font class="orange">* </font></td>
			</tr>
			<tr id="haomaleixingtr" style="display: none">
				<td class="blue" width="13%">��������</td>
				<td colspan="3">
				<select id="haomaleixing" name="haomaleixing" onchange="haomaCheck()">
					<option class="button" value="0" selected="selected">��������</option>
					<option class="button" value="1">����������</option>
				</select>
				<font class="orange">* </font></td>
			</tr>
			<%@ include file="/npage/sq100/gestoresInfo.jsp" %>
			<tr>
				<td width="13%" class="blue">�����ļ���</td>
				<td><input type="file" name="feefile" id="feefile"/></td>
				<td align="left" colspan="2"><font color='red'> <span id='showmsgs'></span>
						<br/> �ļ���ÿ������ռһ��,һ����ർ��500���ֻ�����,��ʽ��: <br/><font id="haomaFont"> 13904510001 <br/>
						13904510002</font>
				</font></td>
			</tr>
		</table>
		<table cellspacing="0">
          <tr>
            <td nowrap="nowrap" id="footer">
              <div align="center">	
              <input class="b_foot_long" name="updBtn" id="quchoose"   onclick="printTable(t1);" type=button value=����excel />
              <input class="b_foot" type=button name="querysss" value="�����ύ" onclick="doCfm(this)" index="2"/>
              <input class="b_foot" type=button name=back value="���" onclick="resetPage()"/>
		      <input class="b_foot" type=button name=qryP value="�ر�" onclick="removeCurrentTab()"/>
              </div>
            </td>
          </tr>
        </table>
      <input type="hidden" name="ywtypes" id="ywtypes" />
    <%@ include file="/npage/include/footer_simple.jsp"%>
    <input type="hidden" name="ReqPageName" value="f1100_1">
  <!--��ˮ�� -->
	<input type="hidden" name="printAccept" value="<%=loginAccept%>">
  <input type="hidden" name="workno" value=<%=workNo%>>
  <input type="hidden" name="opCode" value="<%=opCode%>">
  <input type="hidden" name="opName" value="<%=opName%>">
  <input type="hidden" name="regionCode" value=<%=regionCode%>> 
  <input type="hidden" name="unitCode" value=<%=orgCode%>>
  <input type="hidden" id=in6 name="belongCode" value=<%=belongCode%>>  
  <input type="hidden" id=in1 name="hidPwd" v_name="ԭʼ����">
  <input type="hidden" name="hidCustPwd">       <!--���ܺ�Ŀͻ�����-->
  <input type="hidden" name="temp_custId">
  <input type="hidden" name="custId" value="0">
  <input type="hidden" name="ip_Addr" value=<%=ip_Addr%>>
  <input type="hidden" name="inParaStr" >
  <input type="hidden" name="checkPwd_Flag" value="false">    <!--����У���־-->
  <input type="hidden" name="workName" value=<%=loginName%> >
  <input type="hidden" name="assu_name" value="">
  <input type="hidden" name="assu_phone" value="">
  <input type="hidden" name="assu_idAddr" value="">
  <input type="hidden" name="assu_idIccid" value="">
  <input type="hidden" name="assu_conAddr" value="">
  <input type="hidden" name="assu_idType" value="">
  <iframe name='hidden_frame' id="hidden_frame" style='display:none'></iframe>
  <input type="hidden" name="card_flag" value="">  <!--���֤������־-->
  <input type="hidden" name="pa_flag" value="">  <!--֤����־-->
  <input type="hidden" name="m_flag" value="">   <!--ɨ����߶�ȡ��־������ȷ���ϴ�ͼƬʱ���ͼƬ��-->
  <input type="hidden" name="sf_flag" value="">   <!--ɨ���Ƿ�ɹ���־-->
  <input type="hidden" name="pic_name" value="">   <!--��ʶ�ϴ��ļ�������-->
  <input type="hidden" name="up_flag" value="0">
  <input type="hidden" name="but_flag" value="0"> <!--��ť�����־-->
  <input type="hidden" name="upbut_flag" value="0"> <!--�ϴ���ť�����־-->
   </form>
</body>
<%@ include file="/npage/sq100/interface_provider.jsp" %>
<%@ include file="/npage/include/public_smz_check.jsp" %>
<OBJECT id="CardReader_CMCC" height="0" width="0"  classid="clsid:FFD3E742-47CD-4E67-9613-1BB0D67554FF" codebase="/npage/public/CardReader_AGILE.cab#version=1,0,0,6"></OBJECT>
</html>

