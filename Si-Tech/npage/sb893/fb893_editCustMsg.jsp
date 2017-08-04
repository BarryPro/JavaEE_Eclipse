


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%

    String workNo     = (String)session.getAttribute("workNo");//操作工号!!!
    String regionCode = (String)session.getAttribute("regCode");
    String passwd = ( String )session.getAttribute( "password" );
    String opCode = request.getParameter("opCode");
 	  String opName = request.getParameter("opName");
 	  String name = request.getParameter("name");
 	  String addr = request.getParameter("addr");
 	  String phone = request.getParameter("phone");
 	  String idAddrss = request.getParameter("idAddrss");
 	  String statusCode = request.getParameter("statusCode");
 	  String kaihuphoneno = request.getParameter("kaihuphoneno");
 	  
 	  System.out.println("kaihuhaoma------------------------"+kaihuphoneno);
 	  
 	  String custName = request.getParameter("custName");
 	  String custIdType = request.getParameter("custIdType");
 	  String idIccid = request.getParameter("idIccid");
 	  String custValiDate = request.getParameter("custValiDate");
 	  String custId = request.getParameter("custId");
 	  
 	  
 	  String  sql_idType = "select trim(ID_TYPE), ID_NAME from sIdType";
 	  
 	  
 	  
 	  String is_check_readcard_result = "";
 	  String is_check_readcard_sql = " select to_char(count(*)) as count_col from wWebGoodPhoneopr "+
 	  															 " where status='1' and order_flag='3' "+
 	  															 " and phone_no=:kaihuphoneno "+
 	  															 " and id_iccid=:idIccid ";
 	  String is_check_readcard_sql_p1 = "kaihuphoneno="+kaihuphoneno+",idIccid="+idIccid;
 	  String is_check_readcard_sql_p2 = "";
 	  
 	  System.out.println("hejwa------------is_check_readcard_sql------------------->"+is_check_readcard_sql);
 	  System.out.println("hejwa------------is_check_readcard_sql_p1---------------->"+is_check_readcard_sql_p1);
 	  //System.out.println("hejwa------------is_check_readcard_sql_p2---------------->"+is_check_readcard_sql_p2);
 	  
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode12" retmsg="retMsg12" outnum="1"> 
	<wtc:param value="<%=is_check_readcard_sql%>"/>
	<wtc:param value="<%=is_check_readcard_sql_p1%>"/>
</wtc:service>  
<wtc:array id="ret_is_check_readcard"  scope="end"/>
	
<%
if(ret_is_check_readcard.length>0){
	is_check_readcard_result = ret_is_check_readcard[0][0];
	System.out.println("hejwa------------is_check_readcard_result---------------->"+is_check_readcard_result);
}

%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2"> 
	<wtc:param value="<%=sql_idType%>"/>
</wtc:service>  
<wtc:array id="ret_idType"  scope="end"/>
<%
	 	StringBuffer brandSb = new StringBuffer("");
		for(int i=0;i<ret_idType.length;i++){
			if(ret_idType.length>0){
				if(ret_idType[i][0].equals(custIdType)){
					brandSb.append("<option value ='").append(ret_idType[i][0]).append("'>").append(ret_idType[i][1]).append("</option>");
				}
			}
		}
	
	String workChnFlag = "0" ;
%>

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="printAccept"/>
	
<wtc:service name="s1100Check" outnum="30"
	routerKey="region" routerValue="<%=regionCode%>" retcode="rc" retmsg="rm" >
	<wtc:param value = ""/>
	<wtc:param value = "01"/>
	<wtc:param value = "<%=opCode%>"/>
	<wtc:param value = "<%=workNo%>"/>
	<wtc:param value = "<%=passwd%>"/>
		
	<wtc:param value = ""/>
	<wtc:param value = ""/>
</wtc:service>
<wtc:array id="rst" scope="end" />
<%if ( rc.equals("000000")){
		if ( rst.length!=0 ){
			workChnFlag = rst[0][0]; //为1，则为社会渠道工号
		}else{
		%>
			<script>
				rdShowMessageDialog( "服务s1100Check没有返回结果!" );
				removeCurrentTab();
			</script>
		<%	
		}
	}else{
	%>
		<script>
			rdShowMessageDialog( "<%=rc%>:<%=rm%>" );
			removeCurrentTab();
		</script>
<%
	}
%>
<%
		String groupId =(String)session.getAttribute("groupId");
    /*关于落实打击黑卡工作的BOSS优化补充需求地市配置表start*/
    String sql_appregionset1 = "select count(*) from sOrderCheck where group_id=:groupids and flag='Y' ";
    String sql_appregionset2 = "groupids="+groupId;
    String appregionflag="0";//==0只能进行工单查询，>0可以进行工单查询或者读卡
 %>
 		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCodeappregion" retmsg="retMsgappregion" outnum="1"> 
			<wtc:param value="<%=sql_appregionset1%>"/>
			<wtc:param value="<%=sql_appregionset2%>"/>
		</wtc:service>  
		<wtc:array id="appregionarry"  scope="end"/>
<%
			if("000000".equals(retCodeappregion)){
				if(appregionarry.length > 0){
					appregionflag = appregionarry[0][0]; 
				}
		}
		/*关于落实打击黑卡工作的BOSS优化补充需求地市配置表end*/
		
		String sql_sendListOpenFlag = "select count(*) from shighlogin where login_no='K' and op_code='m194'";
		String sendListOpenFlag = "0"; //下发工单开关 0：关，>0：开
%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1"> 
			<wtc:param value="<%=sql_sendListOpenFlag%>"/>
		</wtc:service>  
		<wtc:array id="ret1"  scope="end"/>
<%
		if("000000".equals(retCode1)){
			if(ret1.length > 0){
				sendListOpenFlag = ret1[0][0]; 
			}
		}
		
		String sql_regionCodeFlag [] = new String[2];
	  sql_regionCodeFlag[0] = "select count(*) from shighlogin where op_code ='m195' and login_no=:regincode";
	  sql_regionCodeFlag[1] = "regincode="+regionCode;
		String regionCodeFlag = "N"; //地市是否可见 下发工单按钮 Y可见，N不可见
%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode12" retmsg="retMsg12" outnum="1"> 
			<wtc:param value="<%=sql_regionCodeFlag[0]%>"/>
			<wtc:param value="<%=sql_regionCodeFlag[1]%>"/>
		</wtc:service>  
		<wtc:array id="ret2"  scope="end"/>
<%
		if("000000".equals(retCode12)){
			if(ret2.length > 0){
				if(Integer.parseInt(ret2[0][0]) > 0){
					regionCodeFlag = "Y"; 
				}
			}
		}
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title><%=opName%></title>
    <script type="text/javascript" src="/npage/public/pubLightBox.js"></script>	
</head>

<script>
		$(function() {
				$('#name').val('<%=name%>');
				$('#phone').val('<%=phone%>');
				if("<%=is_check_readcard_result%>"=="1"){
				$('#addr').val("");
				$('#khxingb').show();
				$('#divPassword').show();
				$('#divemail').show();
				}else {
				$('#addr').val('<%=addr%>');
				$('#khxingb').hide();
				$('#divPassword').hide();
				$('#divemail').hide();				
				}
				$('#idAddrss').val('<%=idAddrss%>');
				$('#custName').val('<%=custName%>');
				$('#custIdType').append("<%=brandSb.toString()%>");
				$('#idIccid').val('<%=idIccid%>');
				$('#idValidDate').val('<%=custValiDate%>');
				//证件类型为身份证+社会渠道工号+集团查验开关为开+该地市需要查验
				if($('#custIdType').val() == "0" && "<%=workChnFlag%>" == "1" && (parseInt($("#sendListOpenFlag").val()) > 0) && "<%=regionCodeFlag%>" == "Y" ){
					$("#sendProjectList").show();
					$("#qryListResultBut").show();
					//$("#scan_idCard_two").hide();
					//$("#scan_idCard_two222").hide();
					//证件号码、证件名称、证件地址、有效期
					$("#idIccid").attr("class","InputGrey");
		  		$("#idIccid").attr("readonly","readonly");
		  		$("#custName").attr("class","InputGrey");
		  		$("#custName").attr("readonly","readonly");
		  		$("#idAddrss").attr("class","InputGrey");
		  		$("#idAddrss").attr("readonly","readonly");
		  		$("#idValidDate").attr("class","InputGrey");
		  		$("#idValidDate").attr("readonly","readonly");					
				}else{
					$("#sendProjectList").hide();
					$("#qryListResultBut").hide();
					//$("#scan_idCard_two").show();
					//$("#scan_idCard_two222").show();
					if("<%=workChnFlag%>" != "1"){ //自有营业厅工号
						//证件号码、证件名称、证件地址、有效期
						$("#idIccid").attr("class","InputGrey");
			  		$("#idIccid").attr("readonly","readonly");
			  		$("#custName").attr("class","InputGrey");
			  		$("#custName").attr("readonly","readonly");
			  		$("#idAddrss").attr("class","InputGrey");
			  		$("#idAddrss").attr("readonly","readonly");
			  		$("#idValidDate").attr("class","InputGrey");
			  		$("#idValidDate").attr("readonly","readonly");	
					}
				}
				checkIccIdFunc16New(document.all.idIccid,0,1);
				$('#submitBtn').click(function() {
							if(!check()){
								return false;
							}
							if(!checkElement(document.all.idValidDate)){
								return false;
							}else{
								if(!chkValid()){
									return false;
								}
							}
							//防止网站输入内容超长，没做修改就提交。
							subStrAddrLength('idAdr',$("#idAddrss").val());
							subStrAddrLength('conAdr',$("#addr").val());
							/*if("<%=workChnFlag%>" != "1"){ //自有营业厅 必须读卡
								if($("#readCardFlag").val() == "N"){ //未读卡
									rdShowMessageDialog("请先进行读卡，再进行开户!");
						    	return false;		
								}
							}*/
							//社会渠道
							if(($("#isQryListResultFlag").val() == "N") && (parseInt($("#sendListOpenFlag").val()) > 0) &&("<%=regionCodeFlag%>" == "Y" ) && ("<%=workChnFlag%>" == "1" )){ //未查询工单列表，并下发工单开关为开+该地市需要校验，则进行校验
								if("<%=appregionflag%>"=="0") {//如果不在app配置表里则只能进行工单查询。
									rdShowMessageDialog("请先进行工单结果查询，再进行开户!");
							    return false;		
						    }
							}
							
							
							if($("#readCardFlag").val() == "Y"){//如果已经读卡
								if(document.all.upbut_flag.value=="0") {//如果已经读卡但是没上传身份证信息
									rdShowMessageDialog("请先上传身份证照片",0);
                  return false;
								}
								
								
							}
							
							
							if("<%=is_check_readcard_result%>"=="1"){
								if(document.all.idIccid.value!="<%=idIccid%>"){
									rdShowMessageDialog("网站特殊号码预约的证件号码与读卡不一致，不可办理！");
									return false;
								}
							}
							
							
									 if("<%=is_check_readcard_result%>"=="1"){
									    var pwdvalues= (document.all.custPwd.value).trim();
									    
									    				var checkPwd_Packets = new AJAXPacket("/npage/s1210/queryENPass.jsp","取得加密后用户输入的密码");
															checkPwd_Packets.data.add("jiamiqianmima",pwdvalues);			
															core.ajax.sendPacket(checkPwd_Packets, doqueryjiami);
															checkPwd_Packets=null;
															
															var jiamipasswords= $("#jiamipassword").val();	
															
											$(window.opener.document).find("#custPwd<%=statusCode%>").val(jiamipasswords);
											$(window.opener.document).find("#custSex<%=statusCode%>").val($('#custSex').val());
											$(window.opener.document).find("#contactMAddr<%=statusCode%>").val($('#contactMail').val());
										}else {
										}
							
							
							$(window.opener.document).find("#contactPerson<%=statusCode%>").val($('#name').val());
							$(window.opener.document).find("#contactAddr<%=statusCode%>").val($('#addr').val());
							$(window.opener.document).find("#contactPhone<%=statusCode%>").val($('#phone').val());
							$(window.opener.document).find("#idAddr<%=statusCode%>").val($('#idAddrss').val());
							$(window.opener.document).find("#custAddr<%=statusCode%>").val($('#idAddrss').val());
							
							$(window.opener.document).find("#custName<%=statusCode%>").val($('#custName').val());
							$(window.opener.document).find("#custIdType<%=statusCode%>").val($('#custIdType').val());
							$(window.opener.document).find("#idIccid<%=statusCode%>").val($('#idIccid').val());
							$(window.opener.document).find("#custValiDate<%=statusCode%>").val($('#idValidDate').val());
							$(window.opener.document).find("#gestoresName<%=statusCode%>").val(document.all.gestoresName.value);
							$(window.opener.document).find("#gestoresAddr<%=statusCode%>").val(document.all.gestoresAddr.value);
							$(window.opener.document).find("#gestoresIdType<%=statusCode%>").val($('#gestoresIdType').val());
							$(window.opener.document).find("#gestoresIccId<%=statusCode%>").val($('#gestoresIccId').val());
							window.opener.timeout('<%=statusCode%>');
							window.close();
						
						
				});
				$('#clearBtn').click(function() {
					//$('#name').val('');
					//$('#phone').val('');
					//$('#addr').val('');
					//$('#idAddrss').val('');
					window.location.href="fb893_editCustMsg.jsp?opCode=<%=opCode%>&opName=<%=opName%>&name=<%=name%>&addr=<%=addr%>&phone=<%=phone%>&idAddrss=<%=idAddrss%>&statusCode=<%=statusCode%>&custName=<%=custName%>&custIdType=<%=custIdType%>&idIccid=<%=idIccid%>&custValiDate=<%=custValiDate%>&custId=<%=custId%>";
				});
				$('#closeBtn').click(function() {
					window.close();
				});
		});
		
		
			function doqueryjiami(packet) {
					var retResult = packet.data.findValueByName("jiamimima");
					$("#jiamipassword").val(retResult);
			}
		
		function check() {
				var name = $('#name').val();
				var phone = $('#phone').val();
				var addr = $('#addr').val();
				var idAddrss = $('#idAddrss').val();
				var custName = 	$('#custName').val();	
				var idValidDate = 	$('#idValidDate').val();	
				var idIccid = 	$('#idIccid').val();	
				if(custName == null || custName.length==0) {
						 rdShowMessageDialog("客户姓名不能为空");
						 return false;
				}
				/*if(idValidDate == null || idValidDate.length==0) {
						 rdShowMessageDialog("证件有效期不能为空");
						 return false;
				}*/
				if(idIccid == null || idIccid.length==0) {
						 rdShowMessageDialog("证件号码不能为空");
						 return false;
				}
				if($("#gestoresInfo1").css("display")!="none"){
					if(!checkElement(document.all.gestoresName)){
						return false;
					}
					if(!checkElement(document.all.gestoresAddr)){
						return false;
					}
					if(!checkElement(document.all.gestoresIccId)){
						return false;
					}
					/*经办人证件号码*/
					if(!checkIccIdFunc16New(document.all.gestoresIccId,1,1)){
						return false;
					}
		        }
				
				if(name == null || name.length==0) {
						 rdShowMessageDialog("联系人姓名不能为空");
						 return false;
				}
				if(phone == null || phone.length==0) {
						 rdShowMessageDialog("联系人电话不能为空");
						 return false;
				}
				if(addr == null || addr.length==0) {
						 rdShowMessageDialog("联系人地址不能为空");
						 return false;
				}
				else {
					var m = /^[\u0391-\uFFE5]*$/;
					var chinaLengthss = 0;
							for (var i = 0; i < addr.length; i ++){
		          var code = addr.charAt(i);
		          var flag = m.test(code);
				          if(flag){
				          	chinaLengthss ++;
				          }
		          }
				     if(chinaLengthss < 8){
						rdShowMessageDialog("联系人地址必须含有至少8个中文汉字！");
						return false;
					}
				}
				
				if(idAddrss == null || idAddrss.length==0) {
						 rdShowMessageDialog("证件地址不能为空");
						 return false;
				}else {
					var m = /^[\u0391-\uFFE5]*$/;
					var chinaLength = 0;
							for (var i = 0; i < idAddrss.length; i ++){
		          var code = idAddrss.charAt(i);
		          var flag = m.test(code);
				          if(flag){
				          	chinaLength ++;
				          }
		          }
				     if(chinaLength < 8){
						rdShowMessageDialog("证件地址必须含有至少8个中文汉字！");
						return false;
					}
				}
				
				
				if("<%=is_check_readcard_result%>"=="1"){
				
				var contactMail = 	$('#contactMail').val();	
				
				if(!checkElement(document.all.contactMail)){
						return false;
				}
							
				if(contactMail == null || contactMail.length==0) {
						 rdShowMessageDialog("联系人E_MAIL不能为空");
						 return false;
				}
				
				if(document.all.custPwd.value == "" || document.all.cfmPwd.value == ""){
                rdShowMessageDialog("必须输入客户密码！");
                return false;
         }
				
				}else {
				
				}
				


				return true;
		}
		
		function Idcard()
		{
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
			var username;
			//sfznamess1100="";
			//sfzcodess1100="";
			//sfzIDaddressss1100="";
			//sfzbir_dayss1100="";
			//sfzsexss1100="";
			//sfzidValidDate_objss1100="";
			//sfzpicturespathss1100="";
			//var photobuf;
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
					//photobuf=IdrControl1.GetPhotobuf();
						//sfznamess1100=name;
						//sfzcodess1100=code;
						//sfzIDaddressss1100=IDaddress;
						//sfzbir_dayss1100=bir_day;
						//sfzsexss1100=sex;
						//sfzidValidDate_objss1100=idValidDate_obj;
						//sfzpicturespathss1100=picpath_n;
			
					subStrAddrLength("j1",IDaddress);//校验身份证地址，如果超过60个字符，则自动截取前30个字
					document.all.custName.value =name;//姓名
					document.all.idIccid.value =code;//身份证号
					//ocument.all.idAddrss.value =IDaddress;//身份证地址
					document.all.idAddrH.value =IDaddress;//身份证地址
					//document.all.birthDay.value =bir_day;//生日
					document.all.birthDayH.value =bir_day;//生日
					
					//证件号码、证件名称、证件地址、有效期
					$("#idIccid").attr("class","InputGrey");
		  		$("#idIccid").attr("readonly","readonly");
		  		$("#custName").attr("class","InputGrey");
		  		$("#custName").attr("readonly","readonly");
		  		$("#idAddrss").attr("class","InputGrey");
		  		$("#idAddrss").attr("readonly","readonly");
		  		$("#idValidDate").attr("class","InputGrey");
		  		$("#idValidDate").attr("readonly","readonly");
		  		//checkIccIdFunc(document.all.idIccid,0,0);
		  		//checkCustNameFunc(document.all.custName,0,0);
		  		//checkAddrFunc(document.all.idAddr,0,0);
					
					if(sex!="1"&&sex!="2"&&sex!="3"){
						sex = "3"	;
					}
				  document.all.custSex.value=sex;//性别
				  document.all.idSexH.value=sex;//性别
				  
				  var aa= idValidDate_obj+"";
				  if(aa.indexOf("长期") !=-1) {
				  	document.all.idValidDate.value="21000101";
				  }else {				  
				  var bb=aa.substring(11,21);
					var cc = bb.replace("\.","");
					var dd = cc.replace("\.","");
					
				  document.all.idValidDate.value =dd;
					}
				  $("#readCardFlag").val("Y"); //已读卡标识
				  //document.all.sf_flag.value ="success";//扫描成功标志
				  document.all.pic_name.value = picpath_n;
				  
				  pubM032Cfm();
				  //document.all.but_flag.value="1";
				  //changeCardAddr(document.all.idAddr);
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
	  var v_printAccept = "<%=printAccept%>";
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
				//if(str=="1"){
				//	try{
						document.all.pic_name.value = "C:\\custID\\cert_head_"+v_printAccept+str+".jpg";
						document.all.picbase64_name.value = "cert_head_"+v_printAccept+str+".txt";
				//	document.all.but_flag.value="1";
				//	document.all.card_flag.value ="2";
				//	}catch(e){
				//			
				//	}
				//}
				//alert(ret_getImageMsg);
				//ret_getImageMsg = "0";
				if(ret_getImageMsg==0){
					//二代证正反面合成
					var xm ="测试";//CardReader_CMCC.MutiIdCardName;					
					var xb =CardReader_CMCC.MutiIdCardSex;
					var mz =CardReader_CMCC.MutiIdCardPeople;
					var cs =CardReader_CMCC.MutiIdCardBirthday;
					var yx =CardReader_CMCC.MutiIdCardSigndate+"-"+CardReader_CMCC.MutiIdCardValidterm;
					var yxqx = CardReader_CMCC.MutiIdCardValidterm;//证件有效期
					var zz ="测试地址测试地址";//CardReader_CMCC.MutiIdCardAddress; //住址
					var qfjg =CardReader_CMCC.MutiIdCardOrgans; //签发机关
					var zjhm ="230102198501010512";//CardReader_CMCC.MutiIdCardNumber; //证件号码
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

					
					if(str == "1"){ //读取客户基本信息
						//证件号码、证件名称、证件地址、有效期
						subStrAddrLength(str,zz);//校验身份证地址，如果超过60个字符，则自动截取前30个字
						document.all.custName.value =xm;//姓名
						document.all.idIccid.value =zjhm;//身份证号
						//document.all.idAddrss.value =zz;//身份证地址
						document.all.idValidDate.value =v_validDates;//证件有效期
						//document.all.birthDay.value =cs;//生日
						document.all.birthDayH.value =cs;//生日
						document.all.custSex.value=xb;//性别
			  		document.all.idSexH.value=xb;//性别
			  		document.all.idAddrH.value =zz;//身份证地址
						$("#idIccid").attr("class","InputGrey");
			  		$("#idIccid").attr("readonly","readonly");
			  		$("#custName").attr("class","InputGrey");
			  		$("#custName").attr("readonly","readonly");
			  		$("#idAddrss").attr("class","InputGrey");
			  		$("#idAddrss").attr("readonly","readonly");
			  		$("#idValidDate").attr("class","InputGrey");
			  		$("#idValidDate").attr("readonly","readonly");
			  		//checkIccIdFunc(document.all.idIccid,0,0);
			  		//checkCustNameFunc(document.all.custName,0,0);
			  		//checkAddrFunc(document.all.idAddr,0,0);
			  		$("#readCardFlag").val("Y"); //已读卡标识
			  		pubM032Cfm();
					}
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
	
	function pubM032Cfm(){
	/*2015/8/19 16:12:01 gaopeng 关于修改BOSS系统实名判断条件及在经分系统中增加全省实名补登记日报表的函-补充需求
					在这里调用服务 sM032Cfm 
				*/
				
				var myPacket = new AJAXPacket("/npage/public/pubM032Cfm.jsp","正在查询信息，请稍候......");
			  myPacket.data.add("idSexH",document.all.idSexH.value);
			  myPacket.data.add("custName",document.all.custName.value);
			  myPacket.data.add("idAddrH",document.all.idAddrH.value.replace(new RegExp("#","gm"),"%23"));
			  myPacket.data.add("birthDayH",document.all.birthDayH.value);
			  myPacket.data.add("custId",document.all.custId.value);
			  myPacket.data.add("idIccid",document.all.idIccid.value);
			  myPacket.data.add("zhengjianyxq",document.all.idValidDate.value);
			  myPacket.data.add("opCode","<%=opCode%>");
			  
			  core.ajax.sendPacket(myPacket,function(packet){
			  	var retCode=packet.data.findValueByName("retCode");
				  var retMsg=packet.data.findValueByName("retMsg");
				  
				  if(retCode == "000000"){
				  	//document.all.uploadpic_b.disabled=false;
				 	}else{
				 		//rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,0);
				 		//document.all.uploadpic_b.disabled=true;
						//return  false;
				 	}
		 		});
				myPacket = null;
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
		if(str == "1"){ //读取客户基本信息
			document.all.idAddrss.value =idAddr;//身份证地址
		}else if(str == "j1"){ //读取客户基本信息 旧版
			document.all.idAddrss.value =idAddr;//身份证地址
		}else if(str == "idAdr"){ //社会渠道+开关关闭校验 证件地址
			$("#idAddrss").val(idAddr);		
		}else if(str == "conAdr"){ //社会渠道+开关关闭校验  联系人地址
			$("#addr").val(idAddr);			
		}
	}
	
	  //下发工单
  function sendProLists(){
		var packet = new AJAXPacket("/npage/sq100/fq100_ajax_sendProLists.jsp","正在获得数据，请稍候......");
		packet.data.add("opCode","<%=opCode%>");
		packet.data.add("phoneNo","<%=kaihuphoneno%>");
		core.ajax.sendPacket(packet,doSendProLists);
		packet = null;
  } 
  
  function doSendProLists(packet){
  	var retCode = packet.data.findValueByName("retCode");
		var retMsg =  packet.data.findValueByName("retMsg");
		if(retCode != "000000"){
			rdShowMessageDialog( "下发工单失败!<br>错误代码："+retCode+"<br>错误信息："+retMsg,0 );
			//记录为没点击
			$("#isSendListFlag").val("N");
		}else{
			rdShowMessageDialog( "下发工单成功!",2 );
			//记录为点击
			$("#isSendListFlag").val("Y");
		}
  }
  
  //工单结果查询
	function qryListResults(){
		var h=450;
		var w=800;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px;dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;status:no;help:no";
		var ret=window.showModalDialog("/npage/sq100/f1100_qryListResults.jsp?opCode=<%=opCode%>&opName=<%=opName%>&accp="+Math.random(),"",prop);
		if(typeof(ret) == "undefined"){
			rdShowMessageDialog("如果没有工单查询结果，请先进行下发工单操作！");
			$("#isQryListResultFlag").val("N");//选择了工单查询结果
		}else if(ret!=null && ret!=""){
			$("#isQryListResultFlag").val("Y");//选择了工单查询结果
			$("#custName").val(ret.split("~")[0]); //客户姓名
			$("#idIccid").val(ret.split("~")[1]); //证件号码
			$("#idAddrss").val(ret.split("~")[2]);  //证件地址
			$("#idValidDate").val(ret.split("~")[3]); //证件有效期
			$("#idIccid").attr("class","InputGrey");
  		$("#idIccid").attr("readonly","readonly");
  		$("#custName").attr("class","InputGrey");
  		$("#custName").attr("readonly","readonly");
  		$("#idAddrss").attr("class","InputGrey");
  		$("#idAddrss").attr("readonly","readonly");	
  		$("#idValidDate").attr("class","InputGrey");
  		$("#idValidDate").attr("readonly","readonly");	
		}
	}
	
	function chkValid(){
	  var d= (new Date().getFullYear().toString()+(((new Date().getMonth()+1).toString().length>=2)?(new Date().getMonth()+1).toString():("0"+(new Date().getMonth()+1)))+(((new Date().getDate()).toString().length>=2)?(new Date().getDate()):("0"+(new Date().getDate()))).toString());
	  if($("#idValidDate").val().trim().length>0){
      if(validDate(frm.idValidDate)==false) return false;

      if(to_date(frm.idValidDate)<=d){
      	rdShowMessageDialog("证件有效期不能早于当前时间，请重新输入！");
        document.all.idValidDate.focus();
      	document.all.idValidDate.select();
        return false;
      }
	  }
	  return true;
	}
	
	function validDate(obj)
	{
	  var theDate="";
	  var one="";
	  var flag="0123456789";
	  for(i=0;i<obj.value.length;i++)
	  { 
	     one=obj.value.charAt(i);
	     if(flag.indexOf(one)!=-1)
	     theDate+=one;
	  }
	  if(theDate.length!=8)
	  {
	  rdShowMessageDialog("日期格式有误，正确格式为“年年年年月月日日”，请重新输入！");
	  
	  obj.select();
	  obj.focus();
	  return false;
	  }
	  else
	  {
	     var year=theDate.substring(0,4);
	   var month=theDate.substring(4,6);
	   var day=theDate.substring(6,8);
	   if(myParseInt(year)<1900 || myParseInt(year)>3000)
	   {
	       rdShowMessageDialog("年的格式有误，有效年份应介于1900-3000之间，请重新输入！");
	     
	     obj.select();
	     obj.focus();
	     return false;
	   }
	     if(myParseInt(month)<1 || myParseInt(month)>12)
	   {
	       rdShowMessageDialog("月的格式有误，有效月份应介于01-12之间，请重新输入！");
	       
	     obj.select();
	     obj.focus();
	     return false;
	   }
	     if(myParseInt(day)<1 || myParseInt(day)>31)
	   {
	       rdShowMessageDialog("日的格式有误，有效日期应介于01-31之间，请重新输入！");
	    
	     obj.select();
	       obj.focus();
	     return false;
	   }
	
	     if (month == "04" || month == "06" || month == "09" || month == "11")             
	   {
	         if(myParseInt(day)>30)
	         {
	         rdShowMessageDialog("该月份最多30天,没有31号！");
	         
	       obj.select();
	           obj.focus();
	             return false;
	         }
	      }                 
	       
	      if (month=="02")
	      {
	         if(myParseInt(year)%4==0 && myParseInt(year)%100!=0 || (myParseInt(year)%4==0 && myParseInt(year)%400==0))
	     {
	           if(myParseInt(day)>29)
	       {
	         rdShowMessageDialog("闰年二月份最多29天！");
	             //obj.value="";
	       obj.select();
	           obj.focus();
	             return false;
	       }
	     }
	     else
	     {
	           if(myParseInt(day)>28)
	       {
	         rdShowMessageDialog("非闰年二月份最多28天！");
	             //obj.value="";
	       obj.select();
	          obj.focus();
	           return false;
	       }
	     }
	      }
	  }
	  return true;
	}
	
	
	
	function chcek_pic1121()//二代证
{
	
var pic_path = document.all.filep.value;
	
var d_num = pic_path.indexOf("\.");
var file_type = pic_path.substring(d_num+1,pic_path.length);
//判断是否为jpg类型 //厂家设备生成图片固定为jpg类型
if(file_type.toUpperCase()!="JPG")
{ 
		rdShowMessageDialog("请选择jpg类型图像文件");
		resetfilp();
	return ;
	}

	var pic_path_flag= document.all.pic_name.value;
	
	if(pic_path_flag=="")
	{
	rdShowMessageDialog("请先扫描或读取证件信息");

	resetfilp();
	return;
}
	else
		{
			if(pic_path!=pic_path_flag)
			{
			rdShowMessageDialog("请选择最后一次扫描或读取证件而生成的证件图像文件"+pic_path_flag);
			resetfilp();
		return;
		}
		else{

			document.all.uploadpic_b.disabled=false;//二代证
			}
			}
			
	}
	
	function uploadpic(){//二代证
	
	if(document.all.filep.value==""){
		rdShowMessageDialog("请选择要上传的图片",0);
		return;
		}
		
		if($("#readCardFlag").val() == "N"){ //未读卡
		rdShowMessageDialog("请先进行读卡读取图片!");
		return false;		
		}	
		
		
	frm.target="upload_frame"; 
	document.frm.encoding="multipart/form-data";
	var actionstr ="sb893_uppic.jsp?custId="+document.all.custId.value+
									"&regionCode=<%=regionCode%>"+
									"&filep_j="+document.all.filep.value+
									"&card_flag=2"+ 
									"&but_flag=1"+
									"&idSexH="+document.all.idSexH.value+
									"&custName="+document.all.custName.value+
									"&idAddrH="+document.all.idAddrH.value.replace(new RegExp("#","gm"),"%23")+
									"&birthDayH="+document.all.birthDayH.value+
									"&custId="+document.all.custId.value+
									"&idIccid="+document.all.idIccid.value+
									"&workno=<%=workNo%>"+
									"&zhengjianyxq="+document.all.idValidDate.value+
									"&upflag=1"+
									"&filep_t="+document.all.picbase64_name.value+
					                "&idType="+document.all.custIdType.value;
									
	frm.action = actionstr; 
	document.all.upbut_flag.value="1";
	frm.submit();
	resetfilp();
	document.frm.encoding="application/x-www-form-urlencoded";
	}
	
	
function resetfilp(){//二代证
	document.getElementById("filep").outerHTML = document.getElementById("filep").outerHTML;
}


/*2010-8-9 8:43 wanghfa添加 验证密码过于简单 start*/
function checkPwdEasy(pwd) {
  
  if(pwd == ""){
    rdShowMessageDialog("请先输入密码！");
    return ;
  }
  
  var checkPwd_Packet = new AJAXPacket("../public/pubCheckPwdEasy.jsp","正在验证密码是否过于简单，请稍候......");
  checkPwd_Packet.data.add("password", pwd);
  checkPwd_Packet.data.add("phoneNo", "<%=kaihuphoneno%>");
  checkPwd_Packet.data.add("idNo", "");
  checkPwd_Packet.data.add("opCode", "b893");
  checkPwd_Packet.data.add("custId", "");

  core.ajax.sendPacket(checkPwd_Packet, doCheckPwdEasy);
  checkPwd_Packet=null;
}

function doCheckPwdEasy(packet) {
  var retResult = packet.data.findValueByName("retResult");
  if (retResult == "1") {
    rdShowMessageDialog("尊敬的客户，您本次设置的密码为相同数字类密码，安全性较低，为了更好地保护您的信息安全，请您设置安全性更高的密码。");
    document.all.custPwd.value="";
    document.all.cfmPwd.value="";
    return;
  } else if (retResult == "2") {
    rdShowMessageDialog("尊敬的客户，您本次设置的密码为连号类密码，安全性较低，为了更好地保护您的信息安全，请您设置安全性更高的密码。");
    document.all.custPwd.value="";
    document.all.cfmPwd.value="";
    return;
  } else if (retResult == "3") {
    rdShowMessageDialog("尊敬的客户，您本次设置的密码为手机号码中的连续数字，安全性较低，为了更好地保护您的信息安全，请您设置安全性更高的密码。");
    document.all.custPwd.value="";
    document.all.cfmPwd.value="";
    return;
  } else if (retResult == "4") {
    rdShowMessageDialog("尊敬的客户，您本次设置的密码为证件中的连续数字，安全性较低，为了更好地保护您的信息安全，请您设置安全性更高的密码。");
    document.all.custPwd.value="";
    document.all.cfmPwd.value="";
    return;
  } else if (retResult == "0") {
   
  } 
}

</script>


<body>
<form name="frm" action="" method="post" >
<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
			<div id="title_zi">客户信息修改</div>
		</div>
		
		<div>
				<table cellspacing=0>
					 <tr>
					 		<TD class="blue" >客户名称</TD>
	            <TD> 
	              <input name=custName id="custName" value=""  v_must=1 v_maxlength=60 v_type="string"   maxlength="60" size=20 index="9"  >
	              <div id="checkName" style="display:none"><input type="button" class="b_text" value="验证" onclick="checkName()"></div>
	             	<font class=orange>*</font>
           		</TD>
           		<td class="blue" >证件有效期</td>
	              <td> 
	                <input class="button" name="idValidDate" id="idValidDate" v_must=0 v_maxlength=8 v_type="date"  maxlength=8 size="8" index="13" onblur="if(checkElement(this)){chkValid();}">
              		<font class=orange>*</font>
              </td>
					 </tr>
					 <tr> 
              <td class="blue" > 证件类型</td>
              <td> 
                <select id="custIdType" name="custIdType" disabled >
                </select>
                <font class=orange>*</font>
              </td>
              <td class="blue" >证件号码</td>
              <td> 
                <input name="idIccid"  id="idIccid"   value=""  v_minlength=4 v_maxlength=20 v_type="string" onChange="change_idType()" maxlength="18"   index="11" value="" onBlur="checkIccIdFunc16New(this,0,0);" >
              	<font class=orange>*</font>
              	<input type="button" name="scan_idCard_two" id="scan_idCard_two" class="b_text"   value="读卡" onClick="Idcard()" >
        				<input type="button" name="scan_idCard_two222" id="scan_idCard_two222" class="b_text"   value="读卡(2代)" onClick="Idcard2('1')" >
								<input type="button" id="sendProjectList" name="sendProjectList" class="b_text" value="下发工单" onclick="sendProLists()" />                    
              	<input type="button" id="qryListResultBut" name="qryListResultBut" class="b_text" value="工单结果查询" onclick="qryListResults()" /> 
              </td>
            </tr>

              <tr>
            			<td  class="blue">
								      	证件照片上传
								      </td>
								      <td colspan="3">
								      	
												 <input type="file" name="filep" id="filep" onchange="chcek_pic1121();" >    &nbsp;
												 
												 <iframe name="upload_frame" id="upload_frame" style="display:none"></iframe>
												
												<input type="hidden" name="idSexH" value="1">
								  			<input type="hidden" name="birthDayH" value="20090625">
								  			<input type="hidden" name="idAddrH" value="哈尔滨">
								  			
												 <input type="button" name="uploadpic_b" class="b_text"   value="上传身份证图像" onClick="uploadpic()"  disabled>
								      	
								      	</td>
								 </tr> 
								 
								                 <TR id="khxingb" style="display:none"> 
                  <TD width=16% class="blue" > 
                    <div align="left">客户性别</div>
                  </TD>
                  <TD width=34% colspan="3"> 
                    <select align="left" name=custSex id=custSex width=50 index="26">
                      <%
        //得到输入参数
            String sqlStr6 ="select trim(SEX_CODE), SEX_NAME from ssexcode order by SEX_CODE";                 
                //retArray = callView.view_spubqry32("2",sqlStr6);
                //int recordNum = Integer.parseInt((String)retArray.get(0));
                //result = (String[][])retArray.get(1);
                //result = (String[][])retArray.get(0);
              
 %>
 <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode6" retmsg="retMsg6" outnum="2">
<wtc:sql><%=sqlStr6%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result6" scope="end" /> 

<%    
    if(retCode6.equals("000000")){
     
      System.out.println("调用服务成功！");
              
                int recordNum6 = result6.length;                  
                for(int i=0;i<recordNum6;i++){
                        out.println("<option class='button' value='" + result6[i][0] + "'>" + result6[i][1] + "</option>");
                }
      
       }else{
       System.out.println("***********************************************************************");
         System.out.println("调用服务失败！");
         
      }            
%>
                    </select>
                  </TD>
                  </tr>

     	      <TR id ="divPassword" style="display:none"> 
           <jsp:include page="/npage/sq100/f1100_pwd.jsp">
            <jsp:param name="width1" value="16%"  />
            <jsp:param name="width2" value="34%"  />
            <jsp:param name="pname" value="custPwd"  />
            <jsp:param name="pcname" value="cfmPwd"  />
            <jsp:param name="pvalue" value="" />
           </jsp:include>
            </TR>
        
            <tr>
				    	  <td class='blue'>证件地址</td>
				    	  <td colspan="3">
				    	     <input type="text" name="idAddrss" id="idAddrss" value="" size="100" v_must ='1' maxlength="60" onBlur="subStrAddrLength('idAdr',this.value)"/>	
				    	     <font class=orange>*</font>
				    	  </td>
				    </tr>
				    <tr>
				        <td class='blue'>联系人姓名</td>
				        <td >
				            <input type="text" name="name" id="name" value="" maxlength="20" v_must=1 />
				            <font class=orange>*</font>
				        </td>
				        <td class='blue'>联系人电话</td>
				    	  <td>
				    	     <input type="text" name="phone" id="phone" value="" v_must ='1' maxlength="20" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>	
				    	  	 <font class=orange>*</font>
				    	  </td>
				    </tr>
				    <tr>
				    	  <td class='blue'>联系人地址</td>
				    	  <td colspan="3">
				    	     <input type="text" name="addr" id="addr" value="" size="100" v_must ='1' maxlength="60" onBlur="subStrAddrLength('conAdr',this.value);" />	
				    	     <font class=orange>*</font>
				    	  </td>
				    </tr>
				    <tr id ="divemail" style="display:none">
				        <TD class="blue" > 
                    <div align="left">联系人E_MAIL</div>
                  </TD>
                  <TD colspan="3"> 
                    <input name=contactMail id=contactMail value="" class="button" v_must=0 v_type="email" v_name="联系人E_MAIL" maxlength="30" size=30 index="24">
                    <font class=orange>*</font>
                  </TD>
                </TR>
                <%@ include file="/npage/sq100/gestoresInfo.jsp" %>
				    <tr id='footer'>
				        <td colspan='4'>
				            <input type="button"  id="submitBtn" class='b_foot' value="确定" name="submitBtn" />
				            <input type="button"  id="clearBtn" class='b_foot' value="清除" name="clear" />
				            <input type="button"  id="closeBtn" class="b_foot" id="close" name="close" value="关闭" />
				        </td>
				    </tr>
				</table>
		</div>
<input type="hidden" name="custId" value="<%=custId%>">
<input type="hidden" name="isSendListFlag" id="isSendListFlag" value="N" />
<input type="hidden" name="isQryListResultFlag" id="isQryListResultFlag" value="N" />
<input type="hidden" name="sendListOpenFlag" id="sendListOpenFlag" value="<%=sendListOpenFlag%>" />
<input type="hidden" name="readCardFlag" id="readCardFlag" value="N" />


<input type="text" name="pic_name" value=""> 
<input type="text" name="picbase64_name" value="">   <!--标识上传图片base64文件名-->
<input type="hidden" name="upbut_flag" value="0"> 
<input type="hidden" name="jiamipassword" id="jiamipassword"  >






<%@ include file="/npage/include/footer.jsp" %>

<jsp:include page="/npage/common/pwd_comm.jsp"/>
<%@ include file="/npage/include/public_smz_check.jsp" %>
</form>
</body>
<OBJECT classid="clsid:5EB842AE-5C49-4FD8-8CE9-77D4AF9FD4FF" id="IdrControl1" width="0" height="0"></OBJECT>
<OBJECT id="CardReader_CMCC" height="0" width="0"  classid="clsid:FFD3E742-47CD-4E67-9613-1BB0D67554FF" codebase="/npage/public/CardReader_AGILE.cab#version=1,0,0,6"></OBJECT>
</html>