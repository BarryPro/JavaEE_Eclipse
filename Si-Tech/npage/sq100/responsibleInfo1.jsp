<TR id="responsibleInfo1" style="display:none"> 
  <TD class="blue" > 
    <div align="left">责任人姓名</div>
  </TD>
  <TD> 
    <input name="responsibleName" id="responsibleName" class="button" value="啊啊" v_type="string"  maxlength="60" size=20 index="19" v_must='0' v_maxlength=60 onblur="if(checkElement(this)){checkCustNameFunc16New(this,2,0)}">
    <font class=orange>*</font>
    <font class=orange></font>
  </TD>
 <TD class="blue" > 
    <div align="left">责任人联系地址</div>
  </TD>
  <TD> 
    <input name="responsibleAddr" id="responsibleAddr"  class="button" value="啊啊啊啊啊啊啊啊啊啊" v_must='1' v_type="addrs" size=30 index="21"  onblur="if(checkElement(this)){ checkAddrFunc(this,5,0);}">
    <font class=orange>*</font> </TD>
</TR>
 <tr id="responsibleInfo2" style="display:none"> 
  <td width=16% class="blue" > 
    <div align="left">责任人证件类型</div>
  </td>
  <td id="tdappendSome2" width=34%> 
    <select name="responsibleType" id="responsibleType" onchange="validateresponIdTypes(this.value)">
    	<option value="0|身份证" selected>身份证</option>
    	<option value="D|军人身份证">军人身份证</option>
    </select>
    &nbsp;&nbsp;
   	<input type="button" name="scan_idCard_two3zrr" id="scan_idCard_two3zrr" class="b_text"   value="读卡" onClick="Idcard_realUser('zerenren')"/>
	<input type="button" name="scan_idCard_two57zrr" id="scan_idCard_two57zrr" class="b_text"   value="读卡(2代)" onClick="Idcard2('57')" />
   	<br/>
   	<span id="responsibleSpan">
	  	<input type="file" name="filep2" id="filep2" onchange="chcek_pic2();" >&nbsp;
		<iframe name="upload_frame2" id="upload_frame2" style="display:none"></iframe>
		<input type="hidden" id="idSexH2" name="idSexH2" value="1">
		<input type="hidden" id="birthDayH2" name="birthDayH2" value="20090625">
		<input type="hidden" id="zhengjianYXQ2" name="zhengjianYXQ2" value="20500101">
		<input type="button" name="uploadpic_b2" class="b_text" value="上传照片" onClick="uploadpic2()"  disabled>
	</span>
  </td>
  <td width=16% class="blue" > 
    <div align="left">责任人证件号码</div>
  </td>
  <td width=34%> 
    <input name="responsibleIccId"  id="responsibleIccId" v_must='0'  value="230103198006019655"  v_minlength=4 v_maxlength=20 v_type="string"  maxlength="18"   onBlur="if(checkElement(this)){ checkIccIdFunc16New(this,2,0);}">
    <font class=orange>*</font>
    </td>
</tr>

<script>
	//默认身份证显示
  		$("#scan_idCard_two3zrr").css("display","");
  		$("#scan_idCard_two57zrr").css("display","");
  		$("input[name='responsibleName']").attr("class","InputGrey");
  		$("input[name='responsibleName']").attr("readonly","readonly");
  		$("input[name='responsibleAddr']").attr("class","InputGrey");
  		$("input[name='responsibleAddr']").attr("readonly","readonly");
  		$("input[name='responsibleIccId']").attr("class","InputGrey");
  		$("input[name='responsibleIccId']").attr("readonly","readonly");
  		function chcek_pic2(){
			var pic_path = document.all.filep2.value;
			var d_num = pic_path.indexOf("\.");
			var file_type = pic_path.substring(d_num+1,pic_path.length);
			//判断是否为jpg类型 //厂家设备生成图片固定为jpg类型
			if(file_type.toUpperCase()!="JPG"){ 
				rdShowMessageDialog("请选择jpg类型图像文件");
				document.all.up_flag2.value=3;
				//document.all.print.disabled=true;
				resetfilp2();
				return ;
			}
			
			var pic_path_flag= document.all.pic_name2.value;
			
			if(pic_path_flag==""){
				rdShowMessageDialog("请先扫描或读取证件信息");
				document.all.up_flag2.value=4;
				//document.all.print.disabled=true;
				resetfilp2();
				return;
			}
			else{
				if(pic_path!=pic_path_flag){
					rdShowMessageDialog("请选择最后一次扫描或读取证件而生成的证件图像文件"+pic_path_flag);
					document.all.up_flag2.value=5;
					//document.all.print.disabled=true;
					resetfilp2();
					return;
				}
				else{
				//	document.all.up_flag2.value=2;
					document.all.uploadpic_b2.disabled=false;//二代证
				}
			}
		}
		function resetfilp2(){//二代证
			document.getElementById("filep2").outerHTML = document.getElementById("filep2").outerHTML;
		}
		
		function uploadpic2(){//二代证
			if(document.all.filep2.value==""){
				rdShowMessageDialog("请选择要上传的图片",0);
				return;
			}
			if(document.all.but_flag2.value=="0"){
				rdShowMessageDialog("请先扫描或读取图片",0);
				return;
			}
			if(document.all.custId.value==""){
				rdShowMessageDialog("请先获取客户ID!",0);
				return;
			}
			frm1100.target="upload_frame2"; 
			document.frm1100.encoding="multipart/form-data";
			var actionstr ="/npage/s1210/s1238Main_uppic2.jsp?custId="+document.all.custId.value+
										"&regionCode="+document.all.regionCode.value+
										"&filep_j="+document.all.filep2.value+
										"&card_flag="+document.all.card_flag2.value+ 
										"&but_flag="+document.all.but_flag2.value+
										"&idSexH="+document.all.idSexH2.value+
										"&custName="+document.all.responsibleName.value+
										"&idAddrH="+document.all.responsibleAddr.value.replace(new RegExp("#","gm"),"%23")+
										"&birthDayH="+document.all.birthDayH2.value+
										"&custId="+document.all.custId.value+
										"&idIccid="+document.all.responsibleIccId.value+
										"&workno="+document.all.workno.value+
										"&zhengjianyxq="+document.all.zhengjianYXQ2.value+
										"&upflag=1"+
										"&opCode=1993"+
										"&filep_t="+document.all.picbase64_name2.value+
										"&idType="+document.all.responsibleType.value+
										"&isCheckIdCard=1&checkPage=2";
			frm1100.action = actionstr; 
			document.all.upbut_flag2.value="1";
			frm1100.submit();
			resetfilp2();
			document.frm1100.encoding="application/x-www-form-urlencoded";
		}
</script>