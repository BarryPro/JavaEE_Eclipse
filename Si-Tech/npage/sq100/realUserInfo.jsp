<TR id="realUserInfo1"> 
  <TD class="blue" > 
    <div align="left">ʵ��ʹ��������</div>
  </TD>
  <TD> 
    <input name="realUserName" id="realUserName" value="" v_type="string"  maxlength="60" size=20 index="19" v_maxlength=60 class="InputGrey" onblur="checkCustNameFunc16New(this,3,0);" readonly />
  </TD>
 <TD class="blue" > 
    <div align="left">ʵ��ʹ������ϵ��ַ</div>
  </TD>
  <TD> 
    <input name="realUserAddr" id="realUserAddr"  v_type="addrs"  size=30 index="21"  class="InputGrey" readonly />
  </TD>
</TR>
 <tr id="realUserInfo2" > 
  <td class="blue" > 
    <div align="left">ʵ��ʹ����֤������</div>
  </td>
  <td> 
    <select name="realUserIdType" id="realUserIdType" onchange="valiRealUserIdTypes(this.value)">
    	<option value="0" selected>���֤</option>
    	<!-- <option value="1">����֤</option> -->
    	<option value="2">���ڲ�</option>
    	<option value="3">�۰�ͨ��֤</option>
    	<!-- <option value="4">����֤</option> -->
    	<option value="5">̨��ͨ��֤</option>
    	<option value="6">���������</option>
    </select>
    &nbsp;&nbsp;
    <input type="button" name="scan_idCard_two2" id="scan_idCard_two2" class="b_text"   value="����" onClick="Idcard_realUser('real')" />
    <input type="button" name="scan_idCard_two22" id="scan_idCard_two22" class="b_text"   value="����(2��)" onClick="Idcard2('22')" />
  </td>
  <td class="blue" > 
    <div align="left">ʵ��ʹ����֤������</div>
  </td>
  <td> 
    <input name="realUserIccId"  id="realUserIccId"  value=""  v_minlength=4 v_maxlength=20 v_type="string"  maxlength="18"    value="" class="InputGrey"  onblur="checkIccIdFunc16New(this,3,0);" readonly />
    </td>
</tr>
<script type="text/javascript" language="JavaScript">
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
		
				if(flag == "real"){ //ʵ��ʹ����
					document.all.realUserName.value =name;//����
					document.all.realUserIccId.value =code;//���֤��
					//document.all.realUserAddr.value =IDaddress;//���֤��ַ
				}else if(flag == "zerenren"){  //������
					document.all.responsibleName.value =name;//����
					document.all.responsibleIccId.value =code;//���֤��
					//document.all.gestoresAddr.value =IDaddress;//���֤��ַ
				}else{  //������
					document.all.gestoresName.value =name;//����
					document.all.gestoresIccId.value =code;//���֤��
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
	
	function Idcard2(str){
			//ɨ��������֤
			alert("�����������");
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
					document.all.picbase64_name.value = "cert_head_"+v_printAccept+str+".txt";
					document.all.but_flag.value="1";
					document.all.card_flag.value ="2";
				}catch(e){
						
				}
			}
			//alert(ret_getImageMsg);
			//ret_getImageMsg = "0";
			if(ret_getImageMsg==0){
				//����֤������ϳ�
				var xm ="����";//CardReader_CMCC.MutiIdCardName;					
				var xb =CardReader_CMCC.MutiIdCardSex;
				var mz =CardReader_CMCC.MutiIdCardPeople;
				var cs =CardReader_CMCC.MutiIdCardBirthday;
				var yx =CardReader_CMCC.MutiIdCardSigndate+"-"+CardReader_CMCC.MutiIdCardValidterm;
				var yxqx = CardReader_CMCC.MutiIdCardValidterm;//֤����Ч��
				var zz ="���Ե�ַ���Ե�ַ";//CardReader_CMCC.MutiIdCardAddress; //סַ
				var qfjg =CardReader_CMCC.MutiIdCardOrgans; //ǩ������
				var zjhm ="230102198501010512";//CardReader_CMCC.MutiIdCardNumber; //֤������
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
				
				if(str == "1"){ //��ȡ�ͻ�������Ϣ
					//֤�����롢֤�����ơ�֤����ַ����Ч��
					document.all.custName.value =xm;//����
					document.all.idIccid.value =zjhm;//���֤��
					//document.all.idAddr.value =zz;//���֤��ַ
					document.all.idValidDate.value =v_validDates;//֤����Ч��
					document.all.birthDay.value =cs;//����
					document.all.birthDayH.value =cs;//����
					document.all.custSex.value=xb;//�Ա�
		  		document.all.idSexH.value=xb;//�Ա�
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
		  		$("#loginacceptJT").val(""); //������ˮ
		  		}
		  		/*gaopeng ����2����ť*/
		  		document.all.card2flag.value="1";
					pubM032Cfm();
				}else if(str == "31"){ //������
					document.all.gestoresName.value =xm;//����
					document.all.gestoresIccId.value =zjhm;//���֤��
					//document.all.gestoresAddr.value =zz;//���֤��ַ
				}else if(str == "57"){ //������
					document.all.responsibleName.value =xm;//����
					document.all.responsibleIccId.value =zjhm;//���֤��
					//document.all.gestoresAddr.value =zz;//���֤��ַ
				}else{ //ʵ��ʹ���� 22
					document.all.realUserName.value =xm;//����
					document.all.realUserIccId.value =zjhm;//���֤��
					//document.all.realUserAddr.value =zz;//���֤��ַ
				}
				subStrAddrLength(str,zz);//У�����֤��ַ���������60���ַ������Զ���ȡǰ30����
				document.all.sf_flag.value ="success";//ɨ��ɹ���־
				
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
/* begin update for ���ڿ��������ն�CRMģʽAPP�ĺ� - �ڶ���@2015/3/10 */
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
	if(str == "1"){ //��ȡ�ͻ�������Ϣ
		document.all.idAddr.value =idAddr;//���֤��ַ
		document.all.idAddrH.value =idAddr;//���֤��ַ
		checkAddrFunc(document.all.idAddr,0,0);
	}else if(str == "31"){ //������
		document.all.gestoresAddr.value =idAddr;//���֤��ַ
	}else if(str == "22"){ //ʵ��ʹ���� 22
		document.all.realUserAddr.value =idAddr;//���֤��ַ
	}else if(str == "real"){ //ʵ��ʹ���� �ɰ�
		document.all.realUserAddr.value =idAddr;//���֤��ַ
	}else if(str == "manage"){ //������ �ɰ�
		document.all.gestoresAddr.value =idAddr;//���֤��ַ
	}else if(str == "j1"){ //��ȡ�ͻ�������Ϣ �ɰ�
		document.all.idAddr.value =idAddr;//���֤��ַ
		document.all.idAddrH.value =idAddr;//���֤��ַ
	}else if(str == "zerenren"){ //������ �ɰ�
		document.all.responsibleAddr.value =idAddr;//���֤��ַ
	}else if(str == "57"){ //������ 
		document.all.responsibleAddr.value =idAddr;//���֤��ַ
	}
}
/* end update for ���ڿ��������ն�CRMģʽAPP�ĺ� - �ڶ���@2015/3/10 */
</script>