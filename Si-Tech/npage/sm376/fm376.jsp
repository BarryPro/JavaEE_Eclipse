<%
/********************
 version v2.0
开发商: si-tech
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
					rdShowMessageDialog("请输入转费手机号");
					return false;
				}
				
				if(""==$("#ipt_conPhoneNo").val().trim()){
					rdShowMessageDialog("请输入客户联系电话");
					return false;
				}
			}
			
			if(""==$("#zhengjianhaoma").val().trim()){
				rdShowMessageDialog("请输入证件号码");
					return false;
			}
		}
			
			
			
 			 	if(form1.feefile.value.length<1){
					rdShowMessageDialog("请上传文件!");
					document.form1.feefile.focus();
					return false;
				}
		 		//var fileVal = getFileName($("#feefile").val());
		 		var fileVal = getFileExt($("#feefile").val());
				if("txt" == fileVal){
					//扩展名是txt
				}else{
					rdShowMessageDialog("上传文件的扩展名不正确,只能是后缀为txt类型文件！",0);
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
			$("#showmsgs").text("操作此功能的工号必须具有“(2355)强制开关机恢复”权限");                            
		}else if(ywtypes=="1"){
			$("#xiaohuzs").show();
			$("#zhengjianleixintr").hide();
			$("#zhengjianhaomatr").hide();
			$("#yonghuleixingtr").hide();
			$("#haomaleixingtr").hide();
			$("#showmsgs").text("操作此功能的工号必须具有“(1216)注销(预销)”权限");
		}
		else if(ywtypes=="2"){
			$("#xiaohuzs").show();
			$("#zhengjianleixintr").show();
			$("#zhengjianhaomatr").show();
			$("#yonghuleixingtr").hide();
			$("#haomaleixingtr").show();
			$("#showmsgs").html("操作此功能的工号必须具有“(1216)注销(预销)”权限<br>物联网号码批量预销请在“m239--物联网业务开通状态查询”查询处理结果,并打印免填单.");
			$("#liushuiShow").html("物联网号码批量预销请在“m239--物联网业务开通状态查询”查询处理结果,并打印免填单.");
		}
		else if(ywtypes=="3"){
			$("#xiaohuzs").hide();
			$("#zhengjianleixintr").hide();
			$("#zhengjianhaomatr").hide();
			$("#yonghuleixingtr").show();
			$("#haomaleixingtr").hide();
			$("#showmsgs").html("操作此功能的工号必须具有“(1218)注销(销号)”权限<br/>导入类型:手机号码");
		}
	}
	
	
	 function chk_Phone() {
 
 				var accepts = $("#accepts").val();
				if(accepts.trim()=="") {
						rdShowMessageDialog("请输入操作流水进行查询！");
						return false;
				}
			var ywtypes= $('input[name="yewuradio"]:checked').val(); 

			var myPacket = new AJAXPacket("fm376Qry.jsp","正在查询信息，请稍候......");
			myPacket.data.add("accepts",accepts);
			myPacket.data.add("ywtypes",ywtypes);
		
			core.ajax.sendPacketHtml(myPacket,querinfo,true);
			myPacket = null;
	
 }
 
		function querinfo(data){
				//找到添加表格的div
				var markDiv=$("#showTab"); 
				markDiv.empty();
				markDiv.append(data);
				
		}
		


function set_show_trnPhone(bt){
	var radio_val = $('input[name="yewuradio"]:checked').val(); 	
	if(radio_val=="2"){
		var is_flag = $(bt).val();
		if("Y"==is_flag){
			//选择是
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
	
	if(idtypeVal.indexOf("身份证") != -1){
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
	var packet = new AJAXPacket("/npage/sq100/fq100_ajax_subStrAddrLength.jsp","正在获得数据，请稍候......");
	packet.data.add("str",str);
	packet.data.add("idAddr",idAddr);
	core.ajax.sendPacket(packet,doSubStrAddrLength);
	packet = null;
}
function doSubStrAddrLength(packet){
	var str = packet.data.findValueByName("str");
	var idAddr = packet.data.findValueByName("idAddr");
	if(str == "31"){ //经办人
		document.all.gestoresAddr.value =idAddr;//身份证地址
	}else if(str == "manage"){ //经办人 旧版
		document.all.gestoresAddr.value =idAddr;//身份证地址
	}else if(str == "zerenren"){ //责任人 旧版
		document.all.responsibleAddr.value =idAddr;//身份证地址
	}else if(str == "57"){ //责任人 
		document.all.responsibleAddr.value =idAddr;//身份证地址
	}
}

function getCuTime(){
	 var curr_time = new Date(); 
	 with(curr_time) 
	 { 
	 var strDate = getYear()+"-"; 
	 strDate +=getMonth()+1+"-"; 
	 strDate +=getDate()+" "; //取当前日期，后加中文“日”字标识 
	 strDate +=getHours()+"-"; //取当前小时 
	 strDate +=getMinutes()+"-"; //取当前分钟 
	 strDate +=getSeconds(); //取当前秒数 
	 return strDate; //结果输出 
	 } 
	}
 
 function Idcard_realUser(flag){
		//读取二代身份证
		//document.all.card_flag.value ="2";
		
		var picName = getCuTime();
		var fso = new ActiveXObject("Scripting.FileSystemObject");  //取系统文件对象
		var tmpFolder = fso.GetSpecialFolder(0); //取得系统安装目录
		var strtemp= tmpFolder+"";
		var filep1 = strtemp.substring(0,1)//取得系统目录盘符
		var cre_dir = filep1+":\\custID";//创建目录
		//判断文件夹是否存在，不存在则创建目录
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
		
				if(flag == "manage"){ //经办人
					document.all.gestoresName.value =name;//姓名
					document.all.gestoresIccId.value =code;//身份证号
					//document.all.gestoresAddr.value =IDaddress;//身份证地址
				}
				
				if(flag == "zerenren"){  //责任人
					document.all.responsibleName.value =name;//姓名
					document.all.responsibleIccId.value =code;//身份证号
					//document.all.gestoresAddr.value =IDaddress;//身份证地址
				}				
				
				subStrAddrLength(flag,IDaddress);//校验身份证地址，如果超过60个字符，则自动截取前30个字
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
				rdShowMessageDialog("请重新将卡片放到读卡器上");
			}
		}
		else
		{
			IdrControl1.CloseComm();
			rdShowMessageDialog("端口初始化不成功",0);
		}
		IdrControl1.CloseComm();
	}
	
	function Idcard2(str){
			//扫描二代身份证
		var fso = new ActiveXObject("Scripting.FileSystemObject");  //取系统文件对象
		tmpFolder = fso.GetSpecialFolder(0); //取得系统安装目录
		var strtemp= tmpFolder+"";
		var filep1 = strtemp.substring(0,1)//取得系统目录盘符
		var cre_dir = filep1+":\\custID";//创建目录
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
			//多功能设备RFID读取
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
				//二代证正反面合成
				var xm =CardReader_CMCC.MutiIdCardName;					
				var xb =CardReader_CMCC.MutiIdCardSex;
				var mz =CardReader_CMCC.MutiIdCardPeople;
				var cs =CardReader_CMCC.MutiIdCardBirthday;
				var yx =CardReader_CMCC.MutiIdCardSigndate+"-"+CardReader_CMCC.MutiIdCardValidterm;
				var yxqx = CardReader_CMCC.MutiIdCardValidterm;//证件有效期
				var zz =CardReader_CMCC.MutiIdCardAddress; //住址
				var qfjg =CardReader_CMCC.MutiIdCardOrgans; //签发机关
				var zjhm =CardReader_CMCC.MutiIdCardNumber; //证件号码
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
				
				if(str == "31"){ //经办人
					document.all.gestoresName.value =xm;//姓名
					document.all.gestoresIccId.value =zjhm;//身份证号
					document.all.gestoresAddr.value =zz;//身份证地址
				}else if(str == "57"){ //责任人
					document.all.responsibleName.value =xm;//姓名
					document.all.responsibleIccId.value =zjhm;//身份证号
					document.all.gestoresAddr.value =zz;//身份证地址
				}
				
				//subStrAddrLength(str,zz);//校验身份证地址，如果超过60个字符，则自动截取前30个字

			}else{
					rdShowMessageDialog("获取信息失败");
					return ;
			}
	}else{
					rdShowMessageDialog("打开设备失败");
					return ;
	}
	//关闭设备
	var ret_close=CardReader_CMCC.MutiIdCardCloseDevice();
	if(ret_close!=0){
		rdShowMessageDialog("关闭设备失败");
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
    var workB = excelObj.Workbooks.Add(); ////添加新的工作簿   
   var sheet = workB.ActiveSheet;   
  sheet.Columns("A").ColumnWidth =13;//设置列宽 
  sheet.Columns("A").numberformat="@";
  sheet.Columns("B").ColumnWidth =13;//设置列宽 
  sheet.Columns("B").numberformat="@";
  sheet.Columns("C").ColumnWidth =8;//设置列宽 
  sheet.Columns("C").numberformat="@";
  sheet.Columns("D").ColumnWidth =8;//设置列宽 
  sheet.Columns("D").numberformat="@";
  sheet.Columns("E").ColumnWidth =20;//设置列宽
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
					alert('生成excel失败!');
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
   var workB = excelObj.Workbooks.Add(); ////添加新的工作簿   
   var sheet = workB.ActiveSheet;  
  sheet.Columns("A").ColumnWidth =13;//设置列宽 
  sheet.Columns("A").numberformat="@";
  sheet.Columns("B").ColumnWidth =13;//设置列宽 
  sheet.Columns("B").numberformat="@";
  sheet.Columns("C").ColumnWidth =8;//设置列宽 
  sheet.Columns("C").numberformat="@";
  sheet.Columns("D").ColumnWidth =8;//设置列宽 
  sheet.Columns("D").numberformat="@";
  sheet.Columns("E").ColumnWidth =20;//设置列宽
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
				alert('生成excel失败!');
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
			<td class="blue" width="13%">业务类型</td>
			<td colspan="2"><input type="radio" name="yewuradio" value="0" checked="checked"  onclick="checkadd()" />强制开关机恢复(批量)&nbsp;&nbsp;
			    <input type="radio" name="yewuradio" value="1"  onclick="checkadd()" />强制预销(批量)
			    <input type="radio" name="yewuradio" value="2"  onclick="checkadd()" />单位客户预销(批量)
			    <input type="radio" name="yewuradio" value="3"  onclick="checkadd()" />强制销户(批量)
			</td>
		</tr>
		
		<tr>
			<td class="blue" width="13%">操作类型</td>
			<td colspan="2"><input type="radio" name="radio" value="0" checked="checked"  onclick="checkadd()" />结果查询
			    <input type="radio" name="radio" value="1" onclick="checkadd()" />批量导入
			</td>
		</tr>
		<tr id="zengjia">
			    <td class="blue" width="13%"> 操作流水</td>
						<td >
							<input type="text" id="accepts" name="accepts"  maxlength="14"/>
							<font class="orange">*</font> 
							<input type="button" name="chkPhone" id="chkPhone" value="查询" 
							 class="b_text"  onclick="chk_Phone()" />  
						</td>
						<td><font id="liushuiShow" color="red"></font></td>
		</tr>
	</table>
	

	<div id="showTab" ></div>

		<table cellspacing="0" name="table1" id="table1">

			<tr id='xiaohuzs' style="display: none">
				<td class="blue" width="13%">是否选择授权销户</td>
				<td colspan="3"><select id="print_query"  name="print_query" onchange="set_show_trnPhone(this)">
						<option class='button' value='N' selected="selected">否</option>
						<option class='button' value='Y' >是</option>
				</select> <font class="orange">* </font></td>
			</tr>
			
			<tr id='tr_trnPhone' style="display:none">
				<td class="blue" width="13%">转费手机号</td>
				<td width="37%">
					<input type="text" id="ipt_trnPhoneNo" name="ipt_trnPhoneNo" maxlength="11" v_must="0" v_type="mobphone"  onblur = "checkElement(this)"  />
					<font class="orange">*</font>
				</td>
				<td class="blue" width="13%">客户联系电话</td>
				<td>
					<input type="text" id="ipt_conPhoneNo" name="ipt_conPhoneNo" maxlength="11"  v_must="0" v_type="mobphone"  onblur = "checkElement(this)"  />
					<font class="orange">*</font>
				</td>
			</tr>

			
			<tr id='zhengjianleixintr' style="display: none">
				<td class="blue" width="13%">证件类型</td>
				<td colspan="3">
					<select name="zhengjianleixing">
						<option class="button" value="8" selected="selected">营业执照</option>
						<option class="button" value="A">组织机构代码</option>
						<option class="button" value="B">单位法人证书</option>
						<option class="button" value="C">单位证明</option>
					</select>
				<font class="orange">* </font></td>
			</tr>
			<tr id="zhengjianhaomatr" style="display: none">
				<td class="blue" width="13%">证件号码</td>
				<td colspan="3">
				<input id="zhengjianhaoma" name="zhengjianhaoma" maxlength="25"/>
				<font class="orange">* </font></td>
			</tr>
			<tr id="yonghuleixingtr" style="display: none">
				<td class="blue" width="13%">用户类型</td>
				<td colspan="3">
				<select name="yonghuleixing">
					<option class="button" value="0" selected="selected">个人用户</option>
				</select>
				<font class="orange">* </font></td>
			</tr>
			<tr id="haomaleixingtr" style="display: none">
				<td class="blue" width="13%">号码类型</td>
				<td colspan="3">
				<select id="haomaleixing" name="haomaleixing" onchange="haomaCheck()">
					<option class="button" value="0" selected="selected">正常号码</option>
					<option class="button" value="1">物联网号码</option>
				</select>
				<font class="orange">* </font></td>
			</tr>
			<%@ include file="/npage/sq100/gestoresInfo.jsp" %>
			<tr>
				<td width="13%" class="blue">批量文件：</td>
				<td><input type="file" name="feefile" id="feefile"/></td>
				<td align="left" colspan="2"><font color='red'> <span id='showmsgs'></span>
						<br/> 文件中每个号码占一行,一次最多导入500个手机号码,格式如: <br/><font id="haomaFont"> 13904510001 <br/>
						13904510002</font>
				</font></td>
			</tr>
		</table>
		<table cellspacing="0">
          <tr>
            <td nowrap="nowrap" id="footer">
              <div align="center">	
              <input class="b_foot_long" name="updBtn" id="quchoose"   onclick="printTable(t1);" type=button value=导出excel />
              <input class="b_foot" type=button name="querysss" value="批量提交" onclick="doCfm(this)" index="2"/>
              <input class="b_foot" type=button name=back value="清除" onclick="resetPage()"/>
		      <input class="b_foot" type=button name=qryP value="关闭" onclick="removeCurrentTab()"/>
              </div>
            </td>
          </tr>
        </table>
      <input type="hidden" name="ywtypes" id="ywtypes" />
    <%@ include file="/npage/include/footer_simple.jsp"%>
    <input type="hidden" name="ReqPageName" value="f1100_1">
  <!--流水号 -->
	<input type="hidden" name="printAccept" value="<%=loginAccept%>">
  <input type="hidden" name="workno" value=<%=workNo%>>
  <input type="hidden" name="opCode" value="<%=opCode%>">
  <input type="hidden" name="opName" value="<%=opName%>">
  <input type="hidden" name="regionCode" value=<%=regionCode%>> 
  <input type="hidden" name="unitCode" value=<%=orgCode%>>
  <input type="hidden" id=in6 name="belongCode" value=<%=belongCode%>>  
  <input type="hidden" id=in1 name="hidPwd" v_name="原始密码">
  <input type="hidden" name="hidCustPwd">       <!--加密后的客户密码-->
  <input type="hidden" name="temp_custId">
  <input type="hidden" name="custId" value="0">
  <input type="hidden" name="ip_Addr" value=<%=ip_Addr%>>
  <input type="hidden" name="inParaStr" >
  <input type="hidden" name="checkPwd_Flag" value="false">    <!--密码校验标志-->
  <input type="hidden" name="workName" value=<%=loginName%> >
  <input type="hidden" name="assu_name" value="">
  <input type="hidden" name="assu_phone" value="">
  <input type="hidden" name="assu_idAddr" value="">
  <input type="hidden" name="assu_idIccid" value="">
  <input type="hidden" name="assu_conAddr" value="">
  <input type="hidden" name="assu_idType" value="">
  <iframe name='hidden_frame' id="hidden_frame" style='display:none'></iframe>
  <input type="hidden" name="card_flag" value="">  <!--身份证几代标志-->
  <input type="hidden" name="pa_flag" value="">  <!--证件标志-->
  <input type="hidden" name="m_flag" value="">   <!--扫描或者读取标志，用于确定上传图片时候的图片名-->
  <input type="hidden" name="sf_flag" value="">   <!--扫描是否成功标志-->
  <input type="hidden" name="pic_name" value="">   <!--标识上传文件的名称-->
  <input type="hidden" name="up_flag" value="0">
  <input type="hidden" name="but_flag" value="0"> <!--按钮点击标志-->
  <input type="hidden" name="upbut_flag" value="0"> <!--上传按钮点击标志-->
   </form>
</body>
<%@ include file="/npage/sq100/interface_provider.jsp" %>
<%@ include file="/npage/include/public_smz_check.jsp" %>
<OBJECT id="CardReader_CMCC" height="0" width="0"  classid="clsid:FFD3E742-47CD-4E67-9613-1BB0D67554FF" codebase="/npage/public/CardReader_AGILE.cab#version=1,0,0,6"></OBJECT>
</html>

