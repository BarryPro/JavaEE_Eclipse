<TR id="gestoresInfo1" style="display:none"> 
  <TD class="blue" > 
    <div align="left">����������</div>
  </TD>
  <TD> 
    <input name="gestoresName" id="gestoresName" class="button" value="������" v_type="string"  maxlength="60" size=20 index="19" v_must='0' v_maxlength=60 onblur="if(checkElement(this)){checkCustNameFunc16New(this,1,0)}">
    <font class=orange>*</font>
    <font class=orange></font>
  </TD>
 <TD class="blue" > 
    <div align="left">��������ϵ��ַ</div>
  </TD>
  <TD> 
    <input name="gestoresAddr" id="gestoresAddr" class="button" value="����������������" v_must='0' v_type="addrs" size=30 index="21"  onblur="if(checkElement(this)){ checkAddrFunc(this,4,0);}">
    <font class=orange>*</font> </TD>
</TR>
 <tr id="gestoresInfo2" style="display:none"> 
  <td width=16% class="blue" > 
    <div align="left">������֤������</div>
  </td>
  <td id="tdappendSome2" width=34%> 
    <select name="gestoresIdType" id="gestoresIdType" onchange="validateGesIdTypes(this.value)">
    	<option value="0|���֤">���֤</option>
    	<option value="D|�������֤">�������֤</option>
    </select>
    &nbsp;&nbsp;
   	<input type="button" name="scan_idCard_two3" id="scan_idCard_two3" class="b_text"   value="����" onClick="Idcard_realUser('manage')" style="display:none" />
  	<input type="button" name="scan_idCard_two31" id="scan_idCard_two31" class="b_text"   value="����(2��)" onClick="Idcard2('31')" />
  	<br/>
  	<span id="gestoresSpan">
	  	<input type="file" name="filep1" id="filep1" onchange="chcek_pic1();" >    &nbsp;
		<iframe name="upload_frame1" id="upload_frame1" style="display:none"></iframe>
		<input type="hidden" id="idSexH1" name="idSexH1" value="1">
		<input type="hidden" id="birthDayH1" name="birthDayH1" value="20090625">
		<input type="hidden" id="zhengjianYXQ1" name="zhengjianYXQ1" value="20500101">
		<input type="button" name="uploadpic_b1" id="uploadpic_b1" class="b_text" value="�ϴ���Ƭ" onClick="uploadpic1()"  disabled>
	</span>
  </td>
  <td width=16% class="blue" > 
    <div align="left">������֤������</div>
  </td>
  <td width=34%> 
    <input name="gestoresIccId"  id="gestoresIccId" v_must='0'  value="230103198006016112"  v_minlength=4 v_maxlength=20 v_type="string"  maxlength="18"   onBlur="if(checkElement(this)){ checkIccIdFunc16New(this,1,0);}">
    <font class=orange>*</font>
    </td>
</tr>

<script type="text/javascript">
	//Ĭ�����֤��ʾ
  		$("#scan_idCard_two3").css("display","");
  		$("#scan_idCard_two31").css("display","");
  		$("input[name='gestoresName']").attr("class","InputGrey");
  		$("input[name='gestoresName']").attr("readonly","readonly");
  		$("input[name='gestoresAddr']").attr("class","InputGrey");
  		$("input[name='gestoresAddr']").attr("readonly","readonly");
  		$("input[name='gestoresIccId']").attr("class","InputGrey");
  		$("input[name='gestoresIccId']").attr("readonly","readonly");
  		function chcek_pic1(){
			var pic_path = document.all.filep1.value;
			var d_num = pic_path.indexOf("\.");
			var file_type = pic_path.substring(d_num+1,pic_path.length);
			//�ж��Ƿ�Ϊjpg���� //�����豸����ͼƬ�̶�Ϊjpg����
			if(file_type.toUpperCase()!="JPG"){ 
				rdShowMessageDialog("��ѡ��jpg����ͼ���ļ�");
				document.all.up_flag1.value=3;
				//document.all.print.disabled=true;
				resetfilp1();
				return ;
			}
			
			var pic_path_flag= document.all.pic_name1.value;
			
			if(pic_path_flag==""){
				rdShowMessageDialog("����ɨ����ȡ֤����Ϣ");
				document.all.up_flag1.value=4;
				//document.all.print.disabled=true;
				resetfilp1();
				return;
			}
			else{
				if(pic_path!=pic_path_flag){
					rdShowMessageDialog("��ѡ�����һ��ɨ����ȡ֤�������ɵ�֤��ͼ���ļ�"+pic_path_flag);
					document.all.up_flag1.value=5;
					//document.all.print.disabled=true;
					resetfilp1();
					return;
				}
				else{
					//document.all.up_flag1.value=2;
					document.all.uploadpic_b1.disabled=false;//����֤
				}
			}
		}
		function resetfilp1(){//����֤
			document.getElementById("filep1").outerHTML = document.getElementById("filep1").outerHTML;
		}
		
		function uploadpic1(){//����֤
			if(document.all.filep1.value==""){
				rdShowMessageDialog("��ѡ��Ҫ�ϴ���ͼƬ",0);
				return;
			}
			if(document.all.but_flag1.value=="0"){
				rdShowMessageDialog("����ɨ����ȡͼƬ",0);
				return;
			}
			if(document.all.custId.value==""){
				rdShowMessageDialog("���Ȼ�ȡ�ͻ�ID!",0);
				return;
			}
			frm1100.target="upload_frame1"; 
			document.frm1100.encoding="multipart/form-data";
			var actionstr ="/npage/s1210/s1238Main_uppic2.jsp?custId="+document.all.custId.value+
										"&regionCode="+document.all.regionCode.value+
										"&filep_j="+document.all.filep1.value+
										"&card_flag="+document.all.card_flag1.value+ 
										"&but_flag="+document.all.but_flag1.value+
										"&idSexH="+document.all.idSexH1.value+
										"&custName="+document.all.gestoresName.value+
										"&idAddrH="+document.all.gestoresAddr.value.replace(new RegExp("#","gm"),"%23")+
										"&birthDayH="+document.all.birthDayH1.value+
										"&custId="+document.all.custId.value+
										"&idIccid="+document.all.gestoresIccId.value+
										"&workno="+document.all.workno.value+
										"&zhengjianyxq="+document.all.zhengjianYXQ1.value+
										"&upflag=1"+
										"&opCode=1993"+
										"&filep_t="+document.all.picbase64_name1.value+
										"&idType="+document.all.gestoresIdType.value+
										"&isCheckIdCard=1"+
										"&checkPage=1";
										
			frm1100.action = actionstr; 
			document.all.upbut_flag1.value="1";
			frm1100.submit();
			resetfilp1();
			document.frm1100.encoding="application/x-www-form-urlencoded";
		}
		
</script>