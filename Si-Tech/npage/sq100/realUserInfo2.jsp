<TR id="realUserInfo5" style='display:none'> 
  <TD class="blue" > 
    <div align="left">使用人姓名</div>
  </TD>
  <TD> 
    <input name="realUserName" id="realUserName" value="啊啊" v_type="string"  maxlength="60" size=20 index="19" v_maxlength=60 class="InputGrey" onblur="checkCustNameFunc16New(this,3,0);" readonly />
  </TD>
 <TD class="blue" > 
    <div align="left">使用人联系地址</div>
  </TD>
  <TD> 
    <input name="realUserAddr" id="realUserAddr"  v_type="addrs" value="啊啊啊啊啊啊啊啊啊啊"  size=30 index="21"  class="InputGrey" readonly />
  </TD>
</TR>
 <tr id="realUserInfo6"  style='display:none'> 
  <td class="blue" > 
    <div align="left">使用人证件类型</div>
  </td>
  <td> 
  
    <select name="realUserIdType" id="realUserIdType" onchange="valiRealUserIdTypes(this.value)">
    	<option value="0" selected>身份证</option>
    	<option value="D">军人身份证</option>
    </select>
    &nbsp;&nbsp;
    
    <input type="button" name="scan_idCard_two2" id="scan_idCard_two2" class="b_text"   value="读卡" onClick="Idcard_realUser('real')" />
    <input type="button" name="scan_idCard_two22" id="scan_idCard_two22" class="b_text"   value="读卡(2代)" onClick="Idcard2('22')" />
  	<br/>
  	<span id="realUserSpan">
	  	<input type="file" name="filep3" id="filep3" onchange="chcek_pic3();" >&nbsp;
		<iframe name="upload_frame3" id="upload_frame3" style="display:none"></iframe>
		<input type="hidden" id="idSexH3" name="idSexH3" value="1">
		<input type="hidden" id="birthDayH3" name="birthDayH3" value="20090625">
		<input type="hidden" id="zhengjianYXQ3" name="zhengjianYXQ3" value="20500101">
		<input type="button" name="uploadpic_b3" class="b_text" value="上传照片" onClick="uploadpic3()"  disabled>
	</span>
  </td>
  <td class="blue" > 
    <div align="left">使用人证件号码</div>
  </td>
  <td> 
    <input name="realUserIccId"  id="realUserIccId"  value="230101199201011112"  v_minlength=4 v_maxlength=20 v_type="string"  maxlength="18"    value="" class="InputGrey"  onblur="checkIccIdFunc16New(this,3,0);" readonly />
    </td>
</tr>
<script type="text/javascript" language="JavaScript">

	function Idcard_realUser(flag){
		//读取二代身份证
		//document.all.card_flag.value ="2";
		
		var picName = getCuTime1();
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
				if(flag == "real"){ //实际使用人
					document.all.realUserName.value =name;//姓名
					document.all.realUserIccId.value =code;//身份证号
					document.all.realUserAddr.value =IDaddress;//身份证地址
					if("<%=opCode%>" == "1993"){
						document.all.idSexH3.value =sex;//性别
						document.all.birthDayH3.value =bir_day;//生日
						$("#zhengjianYXQ3").val(idValidDate_obj);
						document.all.pic_name3.value = picpath_n;
						document.all.picbase64_name3.value = picName+"_"+ document.all.custId.value+".txt";
						document.all.but_flag3.value="1";
						document.all.card_flag3.value ="2";
						document.all.up_flag3.value=0;
					//	document.all.zhengjianYXQ3.val=idValidDate_obj;//证件有效期
					}
					
				}else if(flag == "zerenren"){  //责任人
					document.all.responsibleName.value =name;//姓名
					document.all.responsibleIccId.value =code;//身份证号
					document.all.responsibleAddr.value =IDaddress;//身份证地址
					if("<%=opCode%>" == "1993"){
						document.all.idSexH2.value =sex;//性别
						document.all.birthDayH2.value =bir_day;//生日
						$("#zhengjianYXQ2").val(idValidDate_obj);
						document.all.pic_name2.value = picpath_n;
						document.all.picbase64_name2.value = picName+"_"+ document.all.custId.value+".txt";
						document.all.but_flag2.value="1";
						document.all.card_flag2.value ="2";
						document.all.up_flag2.value=0;
					//	document.all.zhengjianYXQ2.val=idValidDate_obj;//证件有效期
					}
				}else{  //经办人
					document.all.gestoresName.value =name;//姓名
					document.all.gestoresIccId.value =code;//身份证号
					document.all.gestoresAddr.value =IDaddress;//身份证地址
					if("<%=opCode%>" == "1993"){
						document.all.idSexH1.value =sex;//性别
						document.all.birthDayH1.value =bir_day;//生日
						$("#zhengjianYXQ1").val(idValidDate_obj);
						document.all.pic_name1.value = picpath_n;
						document.all.picbase64_name1.value = picName+"_"+ document.all.custId.value+".txt";
						document.all.but_flag1.value="1";
						document.all.card_flag1.value ="2";
						document.all.up_flag1.value=0;
					//	document.all.zhengjianYXQ1.val=idValidDate_obj;//证件有效期
					}
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
	function getCuTime1(){
		 var curr_time = new Date(); 
		 with(curr_time) 
		 { 
		 var strDate = getYear()+"-"; 
		 strDate +=getMonth()+1+"-"; 
		 strDate +=getDate()+""; //取当前日期，后加中文“日”字标识 
		 strDate +=getHours()+"-"; //取当前小时 
		 strDate +=getMinutes()+"-"; //取当前分钟 
		 strDate +=getSeconds(); //取当前秒数 
		 return strDate; //结果输出 
		 } 
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
					document.all.picbase64_name.value = "cert_head_"+v_printAccept+str+".txt";
					document.all.but_flag.value="1";
					document.all.card_flag.value ="2";
				}catch(e){
						
				}
			}
			if(str=="31"&&"<%=opCode%>"=="1993"){
				try{
					document.all.pic_name1.value = "C:\\custID\\cert_head_"+v_printAccept+str+".jpg";
					document.all.picbase64_name1.value = "cert_head_"+v_printAccept+str+".txt";
					document.all.but_flag1.value="1";
					document.all.card_flag1.value ="2";
					document.all.up_flag1.value=0;
				}catch(e){
						
				}
			}
			if(str=="57"&&"<%=opCode%>"=="1993"){
				try{
					document.all.pic_name2.value = "C:\\custID\\cert_head_"+v_printAccept+str+".jpg";
					document.all.picbase64_name2.value = "cert_head_"+v_printAccept+str+".txt";
					document.all.but_flag2.value="1";
					document.all.card_flag2.value ="2";
					document.all.up_flag2.value=0;
				}catch(e){
						
				}
			}
			if(str=="22"&&"<%=opCode%>"=="1993"){
				try{
					document.all.pic_name3.value = "C:\\custID\\cert_head_"+v_printAccept+str+".jpg";
					document.all.picbase64_name3.value = "cert_head_"+v_printAccept+str+".txt";
					document.all.but_flag3.value="1";
					document.all.card_flag3.value ="2";
					document.all.up_flag3.value=0;
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
				
				if(str == "1"){ //读取客户基本信息
					//证件号码、证件名称、证件地址、有效期
					document.all.custName.value =xm;//姓名
					document.all.idIccid.value =zjhm;//身份证号
					//document.all.idAddr.value =zz;//身份证地址
					document.all.idValidDate.value =v_validDates;//证件有效期
					document.all.birthDay.value =cs;//生日
					document.all.birthDayH.value =cs;//生日
					document.all.custSex.value=xb;//性别
		  		document.all.idSexH.value=xb;//性别
					$("#idIccid").attr("class","InputGrey");
		  		$("#idIccid").attr("readonly","readonly");
		  		$("#custName").attr("class","InputGrey");
		  		$("#custName").attr("readonly","readonly");
		  		$("#idAddr").attr("class","InputGrey");
		  		$("#idAddr").attr("readonly","readonly");
		  		$("#idValidDate").attr("class","InputGrey");
		  		$("#idValidDate").attr("readonly","readonly");
		  		checkIccIdFunc(document.all.idIccid,0,0);
		  		checkCustNameFunc(document.all.custName,0,0);
		  		if("<%=opCode%>" == "1238" || "<%=opCode%>" == "m058"){
		  		$("#loginacceptJT").val(""); //集团流水
		  		}
		  		/*gaopeng 读卡2代按钮*/
		  		document.all.card2flag.value="1";
					pubM032Cfm();
				}else if(str == "31"){ //经办人
					document.all.gestoresName.value =xm;//姓名
					document.all.gestoresIccId.value =zjhm;//身份证号
					document.all.gestoresAddr.value =zz;//身份证地址
					if("<%=opCode%>" == "1993"){
						document.all.idSexH1.value =xb;//性别
						document.all.birthDayH1.value =cs;//生日
						$("#zhengjianYXQ1").val(yxqx);
					//	document.all.zhengjianYXQ1.val=yxqx;//证件有效期
					}
				}else if(str == "57"){ //责任人
					document.all.responsibleName.value =xm;//姓名
					document.all.responsibleIccId.value =zjhm;//身份证号
					document.all.responsibleAddr.value =zz;//身份证地址
					if("<%=opCode%>" == "1993"){
						document.all.idSexH2.value =xb;//性别
						document.all.birthDayH2.value =cs;//生日
						$("#zhengjianYXQ2").val(yxqx);
					//	document.all.zhengjianYXQ2.val=yxqx;//证件有效期
					}
				}else{ //实际使用人 22
					document.all.realUserName.value =xm;//姓名
					document.all.realUserIccId.value =zjhm;//身份证号
					document.all.realUserAddr.value =zz;//身份证地址
					if("<%=opCode%>" == "1993"){
						document.all.idSexH3.value =xb;//性别
						document.all.birthDayH3.value =cs;//生日
						$("#zhengjianYXQ3").val(yxqx);
				//		document.all.zhengjianYXQ3.val=yxqx;//证件有效期
					}
				}
				subStrAddrLength(str,zz);//校验身份证地址，如果超过60个字符，则自动截取前30个字
				document.all.sf_flag.value ="success";//扫描成功标志
				
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
/* begin update for 关于开发智能终端CRM模式APP的函 - 第二批@2015/3/10 */
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
		document.all.idAddr.value =idAddr;//身份证地址
		document.all.idAddrH.value =idAddr;//身份证地址
		checkAddrFunc(document.all.idAddr,0,0);
	}else if(str == "31"){ //经办人
		document.all.gestoresAddr.value =idAddr;//身份证地址
	}else if(str == "22"){ //实际使用人 22
		document.all.realUserAddr.value =idAddr;//身份证地址
	}else if(str == "real"){ //实际使用人 旧版
		document.all.realUserAddr.value =idAddr;//身份证地址
	}else if(str == "manage"){ //经办人 旧版
		document.all.gestoresAddr.value =idAddr;//身份证地址
	}else if(str == "j1"){ //读取客户基本信息 旧版
		document.all.idAddr.value =idAddr;//身份证地址
		document.all.idAddrH.value =idAddr;//身份证地址
	}else if(str == "zerenren"){ //责任人 旧版
		document.all.responsibleAddr.value =idAddr;//身份证地址
	}else if(str == "57"){ //责任人 
		document.all.responsibleAddr.value =idAddr;//身份证地址
	}
}
/* end update for 关于开发智能终端CRM模式APP的函 - 第二批@2015/3/10 */
function chcek_pic3(){
			var pic_path = document.all.filep3.value;
			var d_num = pic_path.indexOf("\.");
			var file_type = pic_path.substring(d_num+1,pic_path.length);
			//判断是否为jpg类型 //厂家设备生成图片固定为jpg类型
			if(file_type.toUpperCase()!="JPG"){ 
				rdShowMessageDialog("请选择jpg类型图像文件");
				document.all.up_flag3.value=3;
				//document.all.print.disabled=true;
				resetfilp3();
				return ;
			}
			
			var pic_path_flag= document.all.pic_name3.value;
			
			if(pic_path_flag==""){
				rdShowMessageDialog("请先扫描或读取证件信息");
				document.all.up_flag3.value=4;
				//document.all.print.disabled=true;
				resetfilp3();
				return;
			}
			else{
				if(pic_path!=pic_path_flag){
					rdShowMessageDialog("请选择最后一次扫描或读取证件而生成的证件图像文件"+pic_path_flag);
					document.all.up_flag3.value=5;
					//document.all.print.disabled=true;
					resetfilp3();
					return;
				}
				else{
					//document.all.up_flag3.value=2;
					document.all.uploadpic_b3.disabled=false;//二代证
				}
			}
		}
		function resetfilp3(){//二代证
			document.getElementById("filep3").outerHTML = document.getElementById("filep3").outerHTML;
		}
		
		function uploadpic3(){//二代证
			if(document.all.filep3.value==""){
				rdShowMessageDialog("请选择要上传的图片",0);
				return;
			}
			if(document.all.but_flag3.value=="0"){
				rdShowMessageDialog("请先扫描或读取图片",0);
				return;
			}
			if(document.all.custId.value==""){
				rdShowMessageDialog("请先获取客户ID!",0);
				return;
			}
			frm1100.target="upload_frame3"; 
			document.frm1100.encoding="multipart/form-data";
			var actionstr ="/npage/s1210/s1238Main_uppic2.jsp?custId="+document.all.custId.value+
										"&regionCode="+document.all.regionCode.value+
										"&filep_j="+document.all.filep3.value+
										"&card_flag="+document.all.card_flag3.value+ 
										"&but_flag="+document.all.but_flag3.value+
										"&idSexH="+document.all.idSexH3.value+
										"&custName="+document.all.realUserName.value+
										"&idAddrH="+document.all.realUserAddr.value.replace(new RegExp("#","gm"),"%23")+
										"&birthDayH="+document.all.birthDayH3.value+
										"&custId="+document.all.custId.value+
										"&idIccid="+document.all.realUserIccId.value+
										"&workno="+document.all.workno.value+
										"&zhengjianyxq="+document.all.zhengjianYXQ3.value+
										"&upflag=1"+
										"&opCode=1993"+
										"&filep_t="+document.all.picbase64_name3.value+
										"&idType="+(document.all.realUserIdType.value+"|占位")+
										"&isCheckIdCard=1"+
										"&checkPage=3";;
			frm1100.action = actionstr; 
			document.all.upbut_flag3.value="1";
			frm1100.submit();
			resetfilp3();
			document.frm1100.encoding="application/x-www-form-urlencoded";
		}

</script>