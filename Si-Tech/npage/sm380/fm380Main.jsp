<%
  /*
   * ����: 
   * �汾: 1.0
   * ����: gaopeng 2016/5/16 15:14:10 ���ڿ���ת��ҵ����Ժ��뿪���ȹ��ܵ�����
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
    String workNo = (String)session.getAttribute("workNo");
 		String noPass = (String)session.getAttribute("password");
 		String groupId =(String)session.getAttribute("groupId");
 		String opCode = (String)request.getParameter("opCode");
		String opName = (String)request.getParameter("opName");
		String phoneNo = (String)request.getParameter("activePhone");
		String printAccept = getMaxAccept();
		String orgCode = (String)session.getAttribute("orgCode");
		String custIccid = "";
		
		/*
	  String[][] temfavStr = (String[][])session.getAttribute("favInfo");
		String[] favStr = new String[temfavStr.length];
		boolean operFlag = false;
		for(int i = 0; i < favStr.length; i ++) {
			favStr[i] = temfavStr[i][0].trim();
		}
		if (WtcUtil.haveStr(favStr, "a996")) {
			operFlag = true;
		}*/
		
		String  inParamsMail [] = new String[2];
    inParamsMail[0] = "select t.code_id,t.code_name from pd_unicodedef_dict T where code_class =:code_class order by t.code_id";
    inParamsMail[1] = "code_class="+"ZS002";
	 
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode_mail" retmsg="retMessage_mail" outnum="2"> 
    <wtc:param value="<%=inParamsMail[0]%>"/>
    <wtc:param value="<%=inParamsMail[1]%>"/> 
  </wtc:service>  
  <wtc:array id="result_mail"  scope="end"/>

  	
<html>
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js" type="text/javascript"></script>
	<script src="/npage/public/json2.js" type="text/javascript"></script>
	<script src="/npage/sm380/fm380Obj.js" type="text/javascript"></script>
	<script language="javascript">
		
		var v_printAccept = "<%=printAccept%>";
		$(document).ready(function(){
			
		});
		
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
				
				if(str == "1"){ //��ȡ�ͻ�������Ϣ
					//֤�����롢֤�����ơ�֤����ַ����Ч��
					//xm = "����";
					//zjhm = "232332199001226318";
					//zz = "�������ϸ�����ɽ·33���й��ƶ�������Ӫҵ������";
					document.all.custName.value =xm;//����
					document.all.idIccid.value =zjhm;//���֤��
					document.all.idAddr.value =zz;//���֤��ַ
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
		  		pubM032Cfm();
		  		
				}else if(str == "31"){ //������
					document.all.gestoresName.value =xm;//����
					document.all.gestoresIccId.value =zjhm;//���֤��
					//document.all.gestoresAddr.value =zz;//���֤��ַ
				}else if(str == "57"){ //������
					document.all.responsibleName.value =xm;//����
					document.all.responsibleIccId.value =zjhm;//���֤��
					//document.all.gestoresAddr.value =zz;//���֤��ַ
				}
				
				subStrAddrLength(str,zz);//У�����֤��ַ���������60���ַ������Զ���ȡǰ30����
				
				
				
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
		//checkAddrFunc(document.all.idAddr,0,0);
	}else if(str == "31"){ //������
		document.all.gestoresAddr.value =idAddr;//���֤��ַ
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

/*
	2013/11/18 14:01:09
	gaopeng
	֤�����ͱ��ʱ��֤�������У�鷽��
*/

function checkIccIdFunc(obj,objType,ifConnect){
	var nextFlag = true;
	var idTypeVal = "";
	if(objType == 0){
		var objName = "֤������";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 1){
		objName = "������֤������";
		idTypeVal = document.all.gestoresIdType.value;
	}
	if(objType == 2){
		objName = "������֤������";
		idTypeVal = document.all.responsibleType.value;
	}	
	
	/*ֻ��Ը��˿ͻ�*/
	var opCode = "<%=opCode%>";
	/*��ȡ������ֵ*/
	var objValue = obj.value;
	objValue = $.trim(objValue);
	/*��ȡ�����ֵ�ĳ���*/
	var objValueLength = objValue.length;
	if(objValue != ""){
		/* ��ȡ��ѡ���֤������ 
		0|���֤ 1|����֤ 2|���ڲ� 3|�۰�ͨ��֤ 
		4|����֤ 5|̨��ͨ��֤ 6|��������� 7|���� 
		8|Ӫҵִ�� 9|���� A|��֯�������� B|��λ����֤�� C|������ 
		*/
		
		/*��ȡ֤���������� */
		var idTypeText = idTypeVal.split("|")[0];
		
		/*1�����֤�����ڱ�ʱ��֤�����볤��Ϊ18λ*/
		if(idTypeText == "0" || idTypeText == "2"){
			if(objValueLength != 18){
					rdShowMessageDialog(objName+"������18λ��");
					
					nextFlag = false;
					return false;
			}
		}
		/*����֤ ����֤ ���������ʱ ֤��������ڵ���6λ�ַ�*/
		if(idTypeText == "1" || idTypeText == "4" || idTypeText == "6"){
			if(objValueLength < 6){
					rdShowMessageDialog(objName+"������ڵ�����λ�ַ���");
					
					nextFlag = false;
					return false;
			}
		}
		/*֤������Ϊ�۰�ͨ��֤�ģ�֤������Ϊ9λ��11λ��������λΪӢ����ĸ��H����M��(ֻ�����Ǵ�д)������λ��Ϊ���������֡�*/
		if(idTypeText == "3"){
			if(objValueLength != 9 && objValueLength != 11){
					rdShowMessageDialog(objName+"������9λ��11λ��");
					
					nextFlag = false;
					return false;
			}
			/*��ȡ����ĸ*/
			var valHead = objValue.substring(0,1);
			if(valHead != "H" && valHead != "M"){
					rdShowMessageDialog(objName+"����ĸ�����ǡ�H����M����");
					
					nextFlag = false;
					return false;
			}
			/*��ȡ����ĸ֮���������Ϣ*/
			var varWithOutHead = objValue.substring(1,objValue.length);
			if(varWithOutHead % 2 != 0 && varWithOutHead % 2 != 1){
					rdShowMessageDialog(objName+"������ĸ֮�⣬����λ�����ǰ��������֣�");
					
					nextFlag = false;
					return false;
			}
		}
		/*֤������Ϊ
			̨��ͨ��֤ 
			֤������ֻ����8λ��11λ
			֤������Ϊ11λʱǰ10λΪ���������֣�
			���һλΪУ����(Ӣ����ĸ���������֣���
			֤������Ϊ8λʱ����Ϊ����������
		*/
		if(idTypeText == "5"){
			if(objValueLength != 8 && objValueLength != 11){
					rdShowMessageDialog(objName+"����Ϊ8λ��11λ��");
					
					nextFlag = false;
					return false;
			}
			/*8λʱ����Ϊ����������*/
			if(objValueLength == 8){
				if(objValue % 2 != 0 && objValue % 2 != 1){
					rdShowMessageDialog(objName+"����Ϊ����������");
					
					nextFlag = false;
					return false;
				}
			}
			/*11λʱ�����һλ������Ӣ����ĸ���������֣�ǰ10λ�����ǰ���������*/
			if(objValueLength == 11){
				var objValue10 = objValue.substring(0,10);
				if(objValue10 % 2 != 0 && objValue10 % 2 != 1){
					rdShowMessageDialog(objName+"ǰʮλ����Ϊ����������");
					
					nextFlag = false;
					return false;
				}
				var objValue11 = objValue.substring(10,11);
  			var m = /^[A-Za-z]+$/;
				var flag = m.test(objValue11);
				
				if(!flag && objValue11 % 2 != 0 && objValue11 % 2 != 1){
					rdShowMessageDialog(objName+"��11λ����Ϊ���������ֻ�Ӣ����ĸ��");
					
					nextFlag = false;
					return false;
				}
			}
			
		}
		/*��֯������ ֤��������ڵ���9λ��Ϊ���֡���-�����д������ĸ*/
		if(idTypeText == "A"){
		 if(objValueLength != 10){
					rdShowMessageDialog(objName+"������10λ��");				
					nextFlag = false;
					return false;
			}
			if(objValue.substr(objValueLength-2,1)!="-" && objValue.substr(objValueLength-2,1)!="��") {
					rdShowMessageDialog(objName+"�����ڶ�λ�����ǡ�-����");				
					nextFlag = false;
					return false;			
			}
		}
		/*Ӫҵִ�� ֤�����������ڵ���4λ���֣����������纺�ֵ��ַ�Ҳ�Ϲ�*/
		if(idTypeText == "8"){
		
		 if(objValueLength != 13 && objValueLength != 15 && objValueLength != 18 && objValueLength != 20){
					rdShowMessageDialog(objName+"������13λ��15λ��18λ��20λ��");				
					nextFlag = false;
					return false;
			}
				    
			var m = /^[\u0391-\uFFE5]*$/;
			var numSum = 0;
			for (var i = 0; i < objValue.length; i ++){
          var code = objValue.charAt(i);//�ֱ��ȡ��������
          var flag = m.test(code);
          if(flag){
          	numSum ++;
          }
    	}
			if(numSum > 0){
					rdShowMessageDialog(objName+"������¼�뺺�֣�");				
					nextFlag = false;
					return false;
			}

		}
		/*����֤�� ֤��������ڵ���4λ�ַ�*/
		if(idTypeText == "B"){
		 if(objValueLength != 12){
					rdShowMessageDialog(objName+"������12λ��");				
					nextFlag = false;
					return false;
			}
				    
			var m = /^[\u0391-\uFFE5]*$/;
			var numSum = 0;
			for (var i = 0; i < objValue.length; i ++){
          var code = objValue.charAt(i);//�ֱ��ȡ��������
          var flag = m.test(code);
          if(flag){
          	numSum ++;
          }
    	}
			if(numSum > 0){
					rdShowMessageDialog(objName+"������¼�뺺�֣�");				
					nextFlag = false;
					return false;
			}
			
		}
		
	}
	return nextFlag;
}

/*
	2013/11/15 15:33:56 gaopeng ���ڽ�һ������ʡ��֧��ϵͳʵ���Ǽǹ��ܵ�֪ͨ  
	ע�⣺ֻ��Ը��˿ͻ� start
*/  

/*1���ͻ����ơ���ϵ������ У�鷽�� objType 0 ����ͻ�����У�� 1������ϵ������У��  ifConnect �����Ƿ�������ֵ(���ȷ�ϰ�ťʱ��������������ֵ)*/
function checkCustNameFunc(obj,objType,ifConnect){
	var nextFlag = true;
	var objName = "";
	var idTypeVal = "";
	if(objType == 0){
		objName = "�ͻ�����";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 1){
		objName = "��ϵ������";
		idTypeVal = document.all.idType.value;
	}
	/*2013/12/16 11:24:47 gaopeng ������BOSS�����������ӵ�λ�ͻ���������Ϣ�ĺ� ���뾭��������*/
	if(objType == 2){
		objName = "����������";
		/*�����վ�����֤������*/
		idTypeVal = document.all.gestoresIdType.value;
	}
	
	if(objType == 3){
		objName = "����������";
		/*�����վ�����֤������*/
		idTypeVal = document.all.responsibleType.value;
	}	
	
	idTypeVal = $.trim(idTypeVal);
	
	/*ֻ��Ը��˿ͻ�*/
	var opCode = "<%=opCode%>";
	/*��ȡ������ֵ*/
	var objValue = obj.value;
	objValue = $.trim(objValue);
	/*��ȡ�����ֵ�ĳ���*/
	var objValueLength = objValue.length;
	if(objValue != ""){
		/* ��ȡ��ѡ���֤������ 
		0|���֤ 1|����֤ 2|���ڲ� 3|�۰�ͨ��֤ 
		4|����֤ 5|̨��ͨ��֤ 6|��������� 7|���� 
		8|Ӫҵִ�� 9|���� A|��֯�������� B|��λ����֤�� C|������ 
		*/
		/*��ȡ֤���������� */
		var idTypeText = idTypeVal.split("|")[0];
		
		/*����ʱ�����������Ķ�����*/
		if(objValue.indexOf("��ʱ") != -1 || objValue.indexOf("����") != -1){
					rdShowMessageDialog(objName+"���ܴ��С���ʱ���򡮴��졯������");
					
					nextFlag = false;
					return false;
			
		}
		
		/*�ͻ����ơ���ϵ��������Ҫ�󡰴��ڵ���2�����ĺ��֡�����������ճ��⣨��������տͻ����Ʊ������3���ַ�����ȫΪ����������)*/
		
		/*����������������*/
		if(idTypeText != "6"){
			/*ԭ�е�ҵ���߼�У�� ֻ������Ӣ�ġ����֡����ġ����ġ����ġ���������һ�����ԣ�*/
			
			/*2014/08/27 16:14:22 gaopeng ���ֹ�˾�����Ż������������Ƶ���ʾ Ҫ��λ�ͻ�ʱ���ͻ����ƿ�����дӢ�Ĵ�Сд��� Ŀǰ�ȸ�ɸ� idTypeText == "3" || idTypeText == "9" һ�����߼� �������ʿɲ�����*/
			if(idTypeText == "3" || idTypeText == "9" || idTypeText == "8" || idTypeText == "A" || idTypeText == "B" || idTypeText == "C"){
				if(objValueLength < 2){
					rdShowMessageDialog(objName+"������ڵ���2�����֣�");
					nextFlag = false;
					return false;
				}
				 var KH_length = 0;
		     var EH_length = 0;
		     var RU_length = 0;
		     var FH_length = 0;
		     var JP_length = 0;
		     var KR_length = 0;
		     var CH_length = 0;
         
         for (var i = 0; i < objValue.length; i ++){
            var code = objValue.charAt(i);//�ֱ��ȡ��������
            var key = checkNameStr(code); //У��
            if(key == undefined){
              rdShowMessageDialog("ֻ������Ӣ�ġ����֡����ġ����ġ����ġ����Ļ����롮���š��������һ�����ԣ����������룡");
              obj.value = "";
              
              nextFlag = false;
              return false;
            }
            if(key == "KH"){
            	KH_length++;
            }
            if(key == "EH"){
            	EH_length++;
            }
            if(key == "RU"){
            	RU_length++;
            }
            if(key == "FH"){
            	FH_length++;
            }
            if(key == "JP"){
            	JP_length++;
            }
            if(key == "KR"){
            	KR_length++;
            }
            if(key == "CH"){
            	CH_length++;
            }
         
         }	
            var machEH = KH_length + EH_length;
            var machRU = KH_length + RU_length;
            var machFH = KH_length + FH_length;
            var machJP = KH_length + JP_length;
            var machKR = KH_length + KR_length;
            var machCH = KH_length + CH_length;
            
            
            if((objValueLength != machEH 
            && objValueLength != machRU
            && objValueLength != machFH
            && objValueLength != machJP
            && objValueLength != machKR
            && objValueLength != machCH ) || objValueLength == KH_length){
            		rdShowMessageDialog("ֻ������Ӣ�ġ����֡����ġ����ġ����ġ����Ļ����롮���š��������һ�����ԣ����������룡");
                obj.value = "";
              	nextFlag = false;
                return false;
            }
       }
       else{
					
					/*��ȡ�������ĺ��ֵĸ����Լ�'()����'�ĸ���*/
					var m = /^[\u0391-\uFFE5]*$/;
					var mm = /^��|\.|\��*$/;
					var chinaLength = 0;
					var kuohaoLength = 0;
					var zhongjiandianLength=0;
					for (var i = 0; i < objValue.length; i ++){
								
			          var code = objValue.charAt(i);//�ֱ��ȡ��������
			          var flag22=mm.test(code);
			          var flag = m.test(code);
			          /*��У������*/
			          if(forKuoHao(code)){
			          	kuohaoLength ++;
			          }else if(flag){
			          	chinaLength ++;
			          }else if(flag22){
			          	zhongjiandianLength++;
			          }
			          
			    }
			    var machLength = chinaLength + kuohaoLength+zhongjiandianLength;
					/*���ŵ�����+���ֵ����� != ������ʱ ��ʾ������Ϣ(������Ҫע��һ�㣬��������Ҳ�����ġ�������������ֻ����Ӣ�����ŵ�ƥ������������ƥ����)*/
					if(objValueLength != machLength || chinaLength == 0){
						rdShowMessageDialog(objName+"�����������Ļ����������ŵ����(���ſ���Ϊ���Ļ�Ӣ�����š�()������)��");
						/*��ֵΪ��*/
						obj.value = "";
						
						nextFlag = false;
						return false;
					}else if(objValueLength == machLength && chinaLength != 0){
						if(objValueLength < 2){
							rdShowMessageDialog(objName+"������ڵ���2�����ĺ��֣�");
							
							nextFlag = false;
							return false;
						}
					}
					/*ԭ���߼�
					if(idTypeText == "0" || idTypeText == "2"){
						if(objValueLength > 6){
							rdShowMessageDialog(objName+"�������6�����֣�");
							
							nextFlag = false;
							return false;
						}
				}
				*/
			}
       
		}
		/*�������������� У�� ��������տͻ�����(�����������ϵ������Ҳͬ��(sunaj��ȷ��))�������3���ַ�����ȫΪ����������*/
		if(idTypeText == "6"){
			/*���У��ͻ�����*/
				if(objValue % 2 == 0 || objValue % 2 == 1){
						rdShowMessageDialog(objName+"����ȫΪ����������!");
						/*��ֵΪ��*/
						obj.value = "";
						
						nextFlag = false;
						return false;
				}
				if(objValueLength <= 3){
						rdShowMessageDialog(objName+"������������ַ�!");
						
						nextFlag = false;
						return false;
				}
				var KH_length = 0;
		     var EH_length = 0;
		     var RU_length = 0;
		     var FH_length = 0;
		     var JP_length = 0;
		     var KR_length = 0;
		     var CH_length = 0;
         
         for (var i = 0; i < objValue.length; i ++){
            var code = objValue.charAt(i);//�ֱ��ȡ��������
            var key = checkNameStr(code); //У��
            if(key == undefined){
              rdShowMessageDialog("ֻ������Ӣ�ġ����֡����ġ����ġ����ġ����Ļ����롮���š��������һ�����ԣ����������룡");
              obj.value = "";
              
              nextFlag = false;
              return false;
            }
            if(key == "KH"){
            	KH_length++;
            }
            if(key == "EH"){
            	EH_length++;
            }
            if(key == "RU"){
            	RU_length++;
            }
            if(key == "FH"){
            	FH_length++;
            }
            if(key == "JP"){
            	JP_length++;
            }
            if(key == "KR"){
            	KR_length++;
            }
            if(key == "CH"){
            	CH_length++;
            }
         
         }	
            var machEH = KH_length + EH_length;
            var machRU = KH_length + RU_length;
            var machFH = KH_length + FH_length;
            var machJP = KH_length + JP_length;
            var machKR = KH_length + KR_length;
            var machCH = KH_length + CH_length;
            
            
            if((objValueLength != machEH 
            && objValueLength != machRU
            && objValueLength != machFH
            && objValueLength != machJP
            && objValueLength != machKR
            && objValueLength != machCH ) || objValueLength == KH_length){
            		rdShowMessageDialog("ֻ������Ӣ�ġ����֡����ġ����ġ����ġ����Ļ����롮���š��������һ�����ԣ����������룡");
                obj.value = "";
              	nextFlag = false;
                return false;
            }
				
		}
		
		
		if(ifConnect == 0){
		if(nextFlag){
		 if(objType == 0){
		 	/*��ϵ��������ͻ����Ƹ������ı�*/
			  if(document.all.ownerType.value=="02"){
			    document.frm1100.contactPerson.value = frm1100.custName.value;
			    /*document.all.print.disabled=true;*/
			  }
		 	}	
		}
		}
		
	}	
	return nextFlag;
}


/*
	2013/11/18 11:15:44
	gaopeng
	�ͻ���ַ��֤����ַ����ϵ�˵�ַУ�鷽��
	���ͻ���ַ������֤����ַ���͡���ϵ�˵�ַ�����衰���ڵ���8�����ĺ��֡�
	����������պ�̨��ͨ��֤���⣬���������Ҫ�����2�����֣�̨��ͨ��֤Ҫ�����3�����֣�
*/

function checkAddrFunc(obj,objType,ifConnect){
	var nextFlag = true;
	var objName = "";
	var idTypeVal = ""
	if(objType == 0){
		objName = "֤����ַ";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 1){
		objName = "�ͻ���ַ";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 2){
		objName = "��ϵ�˵�ַ";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 3){
		objName = "��ϵ��ͨѶ��ַ";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 4){
		objName = "��������ϵ��ַ";
		idTypeVal = document.all.gestoresIdType.value;
	}
	if(objType == 5){
		objName = "��������ϵ��ַ";
		idTypeVal = document.all.responsibleType.value;
	}	
	idTypeVal = $.trim(idTypeVal);
	/*ֻ��Ը��˿ͻ�*/
	var opCode = "<%=opCode%>";
	/*��ȡ������ֵ*/
	var objValue = obj.value;
	objValue = $.trim(objValue);
	/*��ȡ�����ֵ�ĳ���*/
	var objValueLength = objValue.length;
	
	if(objValue != ""){
		/* ��ȡ��ѡ���֤������ 
		0|���֤ 1|����֤ 2|���ڲ� 3|�۰�ͨ��֤ 
		4|����֤ 5|̨��ͨ��֤ 6|��������� 7|���� 
		8|Ӫҵִ�� 9|���� A|��֯�������� B|��λ����֤�� C|������ 
		*/
		
		/*��ȡ֤���������� */
		var idTypeText = idTypeVal.split("|")[0];
		
		/*��ȡ�������ĺ��ֵĸ���*/
		var m = /^[\u0391-\uFFE5]*$/;
		var chinaLength = 0;
		for (var i = 0; i < objValue.length; i ++){
          var code = objValue.charAt(i);//�ֱ��ȡ��������
          var flag = m.test(code);
          if(flag){
          	chinaLength ++;
          }
    }
      
		/*����Ȳ������������ Ҳ����̨��ͨ��֤ */
		if(idTypeText != "6" && idTypeText != "5"){
			/*��������8�����ĺ���*/
			if(chinaLength < 8){
				rdShowMessageDialog(objName+"���뺬������8�����ĺ��֣�");
				/*��ֵΪ��*/
				obj.value = "";
				
				nextFlag = false;
				return false;
			}
		
	}
	/*��������� ����2������*/
	if(idTypeText == "6"){
		/*����2�����ĺ���*/
			if(chinaLength <= 2){
				rdShowMessageDialog(objName+"���뺬�д���2�����ĺ��֣�");
				
				nextFlag = false;
				return false;
			}
	}
	/*̨��ͨ��֤ ����3������*/
	if(idTypeText == "5"){
		/*��������3���ĺ���*/
			if(chinaLength <= 3){
				rdShowMessageDialog(objName+"���뺬�д���3�����ĺ��֣�");
				
				nextFlag = false;
				return false;
			}
	}
	/*������ֵ ifConnect ��0ʱ�Ÿ�ֵ�����򲻸�ֵ*/
	if(ifConnect == 0){
		if(nextFlag){
			/*֤����ַ�ı�ʱ����ֵ������ַ*/
			if(objType == 0){
				if(document.all.ownerType.value=="01"){
					
			    document.all.custAddr.value=objValue;
			    document.all.contactAddr.value=objValue;
			    document.all.contactMAddr.value=objValue;
			  }
			}
			/*�ͻ���ַ�ı�ʱ����ֵ��ϵ�˵�ַ����ϵ��ͨѶ��ַ*/
			if(objType == 1){
				frm1100.contactAddr.value = objValue;
	  		frm1100.contactMAddr.value = objValue;
			}
			/*��ϵ�˵�ַ�ı�ʱ����ֵ��ϵ��ͨѶ��ַ��2013/12/16 15:20:17 20131216 gaopeng ��ֵ��������ϵ��ַ����*/
			if(objType == 2){
				document.all.contactMAddr.value=objValue;
				document.all.gestoresAddr.value=objValue;
				document.all.responsibleAddr.value=objValue;
			}
		}
	}
	
	
}
return nextFlag;
}

function pubM032Cfm(){}

var chkPhoneFlag = false;
/*У�鿪���������*/
function chkPhoneFunc(){
	
		var phoneNo = $.trim($("#phoneNo").val());
		var accountNum = $.trim($("#accountNum").val());
		var idIccid = $.trim($("#idIccid").val());
		
		if(phoneNo.length == 0 ){
			rdShowMessageDialog("�������ֻ����룡");
			return false;
		}
		if(accountNum.length == 0 ){
			rdShowMessageDialog("������Ա����ţ�");
			return false;
		}
		if(idIccid.length == 0 ){
			rdShowMessageDialog("������֤�����룡");
			return false;
		}
		var idTypeSelect = $.trim($("#idTypeSelect").find("option:selected").val().split("|")[0]);
		/*ajax start*/
		var getdataPacket = new AJAXPacket("/npage/sm380/fm380ChkPhone.jsp","���ڻ�����ݣ����Ժ�......");
		
		var iLoginAccept = "<%=printAccept%>";
		var iChnSource = "01";
		var iOpCode = "<%=opCode%>";
		var iLoginNo = "<%=workNo%>";
		var iLoginPwd = "<%=noPass%>";
		var iPhoneNo = phoneNo;
		var iUserPwd = "";
		
		
		getdataPacket.data.add("iLoginAccept",iLoginAccept);
		getdataPacket.data.add("iChnSource",iChnSource);
		getdataPacket.data.add("iOpCode",iOpCode);
		getdataPacket.data.add("iLoginNo",iLoginNo);
		getdataPacket.data.add("iLoginPwd",iLoginPwd);
		getdataPacket.data.add("iPhoneNo",iPhoneNo);
		getdataPacket.data.add("iUserPwd",iUserPwd);
		getdataPacket.data.add("iOprtype","1");
		getdataPacket.data.add("iEmployeeNum",accountNum);
		getdataPacket.data.add("iIdType",idTypeSelect);
		getdataPacket.data.add("iIdIccId",idIccid);
		
		core.ajax.sendPacket(getdataPacket,doRetRegion);
		getdataPacket = null;
	
}

function doRetRegion(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
		if(retCode == "000000"){
				chkPhoneFlag = true;
				rdShowMessageDialog("У��ɹ���",2);
				$("#b_emptySimOpen").attr("disabled","");
			}else{
				chkPhoneFlag = false;
				rdShowMessageDialog("������룺"+retCode+",������Ϣ��"+retMsg,1);
				$("#b_emptySimOpen").attr("disabled","disabled");
				return false;
			}
		}


function emptySimOpenFunc(){
		/*
		if(!chkPhoneFlag){
			return false;
		}*/
 
		document.all.cardtype_bz.value="k";
			 /*��ȡ��������*/
  		 var phone = $("input[name='phoneNo']").val();
  		 /****���������ƹ���ȡSIM������****/
  		 /* 
        * diling update for �޸�Ӫҵϵͳ����Զ��д��ϵͳ�ķ��ʵ�ַ�������ڵ�10.110.0.125��ַ�޸ĳ�10.110.0.100��@2012/6/4
        */
  		 path ="http://10.110.0.100:33000/writecard/writecard/ReadCardInfo.jsp";
  		 var retInfo1 = window.showModalDialog("/npage/s1104/Trans.html",path,"","dialogWidth:10;dialogHeight:10;"); 
		 if(typeof(retInfo1) == "undefined")     
    	 {	
    		 rdShowMessageDialog("�������ͳ���!");
    		 return false;   
    	 }
    	var chPos;
    	chPosn = retInfo1.indexOf("&");
    	if(chPosn < 0)
    	{	
    		rdShowMessageDialog("�������ͳ���!");
    		return false ;
    	} 
    	retInfo1=retInfo1+"&";
    	var retVal=new Array();   
    	for(i=0;i<4;i++)
    	{   	   
    		var chPos = retInfo1.indexOf("&");
      	valueStr = retInfo1.substring(0,chPos);
      	var chPos1 = valueStr.indexOf("=");
      	valueStr1 = valueStr.substring(chPos1+1);
      	retInfo1 = retInfo1.substring(chPos+1);
      	retVal[i]=valueStr1;
        	
    	} 
    	if(retVal[0]=="0")
    	{
    		var rescode_str=retVal[2]+"|";
    		var rescode_strstr="";
    		var chPosm = rescode_str.indexOf("|");
    		for(i=0;i<4;i++)
    		{   	   
    	
    			var chPos1 = rescode_str.indexOf("|");
        		valueStr = rescode_str.substring(0,chPos1);
        		rescode_str = rescode_str.substring(chPos1+1);
        		if(i==0 && valueStr=="")
        		{
        			rdShowMessageDialog("�������ͳ���!");
    		 		  return false;
        		}
        		if(valueStr!=""){
        			rescode_strstr=rescode_strstr+"'"+valueStr+"'"+",";
        		}
        	
    		} 
    		rescode_strstr=rescode_strstr.substring(0,rescode_strstr.length-1);
    		if(rescode_strstr=="")
    		{
    			rdShowMessageDialog("�������ͳ���!");
    		 	return false;   
    		}
  		}
  		else{
  			 rdShowMessageDialog("�������ͳ���!");
  			 
    		 return false;   
    	}
    	//alert("���ص�sim�����ͣ�-----"+rescode_strstr);
    	//rescode_strstr = "10001";
  		 /****ȡSIM�����ͽ���******/
    		 var path = "<%=request.getContextPath()%>/npage/innet/fgetsimno_1104.jsp";
    		 path = path + "?regioncode=" + "<%=regionCode%>";
    	         path = path + "&phone=" + phone + "&rescode=" + rescode_strstr+ "&pageTitle=" + "����SIM������";
    	       
    		 var retInfo = window.showModalDialog(path,"","dialogWidth:40;dialogHeight:20;");
    		//alert("׼����ȡ���SIM���ţ�---"+retInfo);
    		/*���Խ�����ԴУ��*/
    		document.all.checksimN.disabled=false;
    		 if(typeof(retInfo) == "undefined")     
    			{	
    				return false;
    			}
    		var simsim=oneTok(oneTok(retInfo,"~",1));
    		var typetype=oneTok(oneTok(retInfo,"~",2));
    		var cardcard=oneTok(oneTok(retInfo,"~",3));
    		document.all.simCode.value=simsim;
    		document.all.simType.value=(cardcard).trim();
    		document.all.simTypeCfm.value=(cardcard).trim();
    		
    		
    		if((typetype).trim()=="null"){
    			
  			}else{
	 				document.all.simTypeName.value=(typetype).trim();
  			}
}

function writechg(){
					/*
				 retsimcode = "0";
    		 //retsimno = "898602A40875F5367932";
    		 retsimno = document.all.simCode.value;
    		 cardstatus = "3";
    		 if(retsimcode=="0"){rdShowMessageDialog("д���ɹ�");
	    		 document.all.writecardbz.value="0";
	    		 document.all.simCode.value=retsimno;
	    		 document.all.simCodeCfm.value=retsimno;
	    		 document.all.cardstatus.value=cardstatus;
	    		 document.all.cfmBtn.disabled=false;
    		 
    		 }*/
	//return true;
	if(document.all.simCode.value==""){
		rdShowMessageDialog("sim���Ų����ǿ�!");
		return false;
	}
	if(document.all.cardtype_bz.value=="k"){
		var phone = $("input[name='phoneNo']").val().trim();
  			document.all.b_write.disabled=true;
  			//alert(986);
    		 var path = "<%=request.getContextPath()%>/npage/innet/fwritecard.jsp";
    		 path = path + "?regioncode=" + "<%=regionCode%>";
    		 path = path + "&sim_type=" +document.all.simTypeCfm.value;
    		 path = path + "&sim_no=" +document.all.simCode.value;
    		 path = path + "&op_code=" +"<%=opCode%>";
    	         path = path + "&phone=" + phone + "&pageTitle=" + "д��";
    	         path = path + "&deleteShowCardNoFlag=" +"isDelCardNo"; //add by diling  for ���ڹ��ֹ�˾�����Ż�Զ��д�������������ʾ
    		 var retInfo = window.showModalDialog(path,"","dialogWidth:40;dialogHeight:20;");
    		 if(typeof(retInfo) == "undefined")     
    			{	
    				 
    				document.all.writecardbz.value="1"; 
    				document.all.b_write.disabled=false;
    				document.all.cfmBtn.disabled=true;   //д��ʧ�ܲ����ύ hejwa add 
    				rdShowMessageDialog("д��ʧ��");
    				return false;   
    				
    			}
    		 //retInfo = "0||3|kahao";
    		 var retsimcode=oneTok(oneTok(retInfo,"|",1));
    		 var retsimno=oneTok(oneTok(retInfo,"|",2));
    		 var cardstatus=oneTok(oneTok(retInfo,"|",3));
    		 var cardNo=oneTok(oneTok(retInfo,"|",4));
    		 //alert("�����ǣ�retsimcode="+retsimcode+",retsimno="+retsimno+",cardstatus="+cardstatus+",cardNo="+cardNo);
    		 //retsimcode = "0";
    		 //retsimno = "898602A40875F5367932";
    		 //retsimno = document.all.simCode.value;
    		 //cardstatus = "3";
    		 if(retsimcode=="0"){rdShowMessageDialog("д���ɹ�");
	    		 document.all.writecardbz.value="0";
	    		 document.all.simCode.value=retsimno;
	    		 document.all.simCodeCfm.value=retsimno;
	    		 document.all.cardstatus.value=cardstatus;
	    		 document.all.cardNo.value=cardNo;
	    		 
	    		 document.all.cfmBtn.disabled=false;
    		 
    		 }else{
    		 	document.all.writecardbz.value="1";
    		 	document.all.cfmBtn.disabled=true;
    		 	rdShowMessageDialog("д��ʧ��");
    		 }
	}
	else{
		rdShowMessageDialog("ʵ������д��");
		document.all.cfmBtn.disabled=true;   //д��ʧ�ܲ����ύ hejwa add 
		document.all.b_write.disabled=true;
		return false;
	}
}

function checksim(){
	
	if(document.all.phoneNo.value == "")
    {
        rdShowMessageDialog("�����������룡",0);
        document.all.phoneNo.focus();
        return ;
    }
    
    var giveliyana = document.all.phoneNo.value.trim();
    
    
    
    var operType = document.all.newSmCode.value;
    var sim_type = document.all.simTypeCfm.value;
    if(document.all.simCode.value == "")
    {
        rdShowMessageDialog("������SIM�����룡",0);
        return false;
    } 
   
    
		var checkResource_Packet = new AJAXPacket("/npage/s1104/f1104_5.jsp","���ڽ�����ԴУ�飬���Ժ�......");
		checkResource_Packet.data.add("retType","checkResource");
    checkResource_Packet.data.add("sIn_Phone_no",giveliyana);
    checkResource_Packet.data.add("sIn_OrgCode","<%=orgCode%>");
    checkResource_Packet.data.add("sIn_Sm_code",operType);
    checkResource_Packet.data.add("sIn_Sim_no",document.all.simCode.value);
    /*begin diling add for ���ڶ������������ר����Խ�������Ż������� ���Ӳ�����custIccid @2012/5/28 */
    checkResource_Packet.data.add("custIccid","<%=custIccid%>");
    /*end diling add*/
    checkResource_Packet.data.add("sIn_Sim_type",sim_type);
    checkResource_Packet.data.add("workno","<%=workNo%>");
    checkResource_Packet.data.add("innetType",document.all.innetType.value);
    
    checkResource_Packet.data.add("offerId","0");
    
    
    var nuCardType = document.all.cardTypeN.value;
		if(nuCardType=="1"){
			//�տ�����
			checkResource_Packet.data.add("simType",document.all.simTypeCfm.value);
		}else{
			checkResource_Packet.data.add("simType","");
		}
		checkResource_Packet.data.add("simTypeOne","");
    
    var szph = "aaa";
   	
    checkResource_Packet.data.add("zph",szph);
    checkResource_Packet.data.add("sIn_cardtype",document.all.cardtype_bz.value);
		core.ajax.sendPacket(checkResource_Packet,doChecksim2,false);
		checkResource_Packet=null;  
		
		
	}
	
	function doChecksim2(packet){
		rdShowMessageDialog("��ԴУ��ɹ���");
		if(document.all.cardtype_bz.value=='k'){
			document.all.b_write.disabled=false;
		}
	}
	
	function doChecksim(packet){
					
		var retCode = packet.data.findValueByName("retCode");
		var retMessage = packet.data.findValueByName("retMessage");
		
		var isGoodNo = packet.data.findValueByName("isGoodNo");
		var prepayFee = packet.data.findValueByName("prepayFee");
		var mode_dxpay = packet.data.findValueByName("mode_dxpay"); 
		document.all.prepayFee.value = prepayFee;		
		document.all.isGoodNo.value = isGoodNo;
 		document.all.modedxpay.value = mode_dxpay;
 		 if(retCode=="0"||retCode=="000000"){
    	
    	    //getFee();   //�õ����ò���
				    	   var tempSimType = $("#simType").val().trim();
				    	    if(tempSimType>="10013" && tempSimType<="10015"){
												if(tempSimType=='10013' && tempSimType!='bgn'){
												rdShowMessageDialog("ֻ��ҵ��Ʒ����ȫ��ͨ���û�������ȫ��64KOTA����");
												return false;}
												if(tempSimType=='10014' && tempSimType!='bdn'){
												rdShowMessageDialog("ֻ��ҵ��Ʒ���Ƕ��еش����û������ö��еش�64KOTA����");
												return false;}
												if(tempSimType=='10015' && tempSimType!='bzn'){
												rdShowMessageDialog("ֻ��ҵ��Ʒ���������е��û�������������64KOTA����");
												return false;}
										}
		            rdShowMessageDialog("��ԴУ��ɹ���");
		            //���θ������� ningtn
		            	var romaphoneNo = $("#phoneNo").val();//ȡ������
									var romaphoneNo3 = romaphoneNo.substring(0,3);//ȡ������ǰ3λ
									/* gaopeng 20120914  begin ɾ��array�����157�Ŷ�*/
									var gheadArrs = new Array("045","046","451");
									if(findStrInArr(romaphoneNo3,gheadArrs)){
										setNoneRoma(myArrs,false,false);
										var roma2042Arrs = new Array("2042");
										setNoneRoma(roma2042Arrs,true,true);
									}
								
								document.all.checksimN.disabled=true;
		            
						 if(document.all.cardtype_bz.value=='k'){
				  			document.all.b_write.disabled=false;
				  		}
			  		
				  	document.all.phoneNo.readOnly=true;
					  document.all.phoneNo.className="InputGrey";	
					  document.all.simCode.readOnly=true;
					  document.all.simCode.className="InputGrey";			
					  
    	}else{
    	    	retMessage = retMessage + "[errorCode8:" + retCode + "]";
    				rdShowMessageDialog(retMessage,0);
    				return false;
    	}
}
function findStrInArr(str1,arrObj){
	var reFlag = false;
	$.each(arrObj,function(i,n){
		if(n == str1){
			reFlag = true;
		}
	});
	return reFlag;
}

function setNoneRoma(romaArr,checkedFlag,disFlag){
		$.each(romaArr,function(i,n){
			if($("#" + n + "").length > 0){
				var romaName = $("#" + n + "").attr("name").substr(9);
				var romaAttr = $("#"+ n +"").attr("checked");
				if(checkedFlag){
					if(romaAttr != "true"){
						$("#"+ n +"").attr("checked","true");
						showDetailProd2(n,romaName,$("#"+ n +"")[0],1);
					}
				}else{
					if(romaAttr){
						$("#"+ n +"").removeAttr("checked");
						showDetailProd2(n,romaName,$("#"+ n +"")[0],1);
					}
				}
				if(disFlag){
					$("#"+ n +"").attr("disabled","true");
				}else{
					$("#"+ n +"").removeAttr("disabled");
				}
			}
		});
}

/*2016/5/27 14:44:26 gaopeng �ύ����*/
		function nextStep(){
			
			if(!check(f1)){
				return false;
			}
			
			var newtfStr = "";
			$("input[name='tef'][checked]").each(function(){
				var thisval = $(this).val();
				if(newtfStr.length == 0){
					newtfStr = thisval;
				}else{
					newtfStr += ";"+thisval;
				}
			});
			if(newtfStr.length == 0){
				rdShowMessageDialog("��ѡ���ط���Ϣ��");
				return false;
			}
			
			/* �������ı�� */
			var spgwNum = $.trim($("#spgwNum").val());
			var accountNum = $.trim($("#accountNum").val());
			var idTypeSelect = $.trim($("#idTypeSelect").find("option:selected").val().split("|")[0]);
			var custName = $.trim($("#custName").val());
			var idIccid = $.trim($("#idIccid").val());
			var idAddr = $.trim($("#idAddr").val());
			var contactPhone = $.trim($("#contactPhone").val());
			var simCode = $.trim($("#simCode").val());
			var phoneNo = $.trim($("#phoneNo").val());
			var cardNo = document.all.cardNo.value;
			
			var paramBelong		= new	param();
			
			paramBelong.setAPPROVAL_ID(spgwNum);	
			paramBelong.setLOGIN_NO(accountNum);
			paramBelong.setID_TYPE(idTypeSelect);
			paramBelong.setID_NUM(idIccid);
			paramBelong.setCUST_NAME(custName);
			paramBelong.setCUST_ADDR(idAddr);
			paramBelong.setPHONE_NO(contactPhone);
			paramBelong.setSIM_NO(simCode);
			paramBelong.setiCardNo(cardNo);
			
			/*ƴjson��*/
			var myJSONText = JSON.stringify(paramBelong,function(key,value){
				return value;
			});
		
			//alert(myJSONText);
			
			
			/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm380/fm380Cfm.jsp","���ڻ�����ݣ����Ժ�......");
			
			var iLoginAccept = "<%=printAccept%>";
			var iChnSource = "01";
			var iOpCode = "<%=opCode%>";
			var iLoginNo = "<%=workNo%>";
			var iLoginPwd = "<%=noPass%>";
			var iPhoneNo = phoneNo;
			var iUserPwd = "";
			
			
			getdataPacket.data.add("iLoginAccept",iLoginAccept);
			getdataPacket.data.add("iChnSource",iChnSource);
			getdataPacket.data.add("iOpCode",iOpCode);
			getdataPacket.data.add("iLoginNo",iLoginNo);
			getdataPacket.data.add("iLoginPwd",iLoginPwd);
			getdataPacket.data.add("iPhoneNo",iPhoneNo);
			getdataPacket.data.add("iUserPwd",iUserPwd);
			
			getdataPacket.data.add("ioprtype","1001");
			getdataPacket.data.add("vOldParam","");
			getdataPacket.data.add("vNewParam",newtfStr);
			getdataPacket.data.add("custinfostr",myJSONText);
			
			core.ajax.sendPacket(getdataPacket,doRetCfm);
			getdataPacket = null;
		
		}
		
		function doRetCfm(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			if(retCode == "000000"){
				rdShowMessageDialog("�����ɹ���",2);
			}else{
				rdShowMessageDialog("������룺"+retCode+",������Ϣ��"+retMsg,1);
			}
			resetPage();
		}
		
		function resetPage(){
			
			window.location.href="/npage/sm380/fm380Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
				
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
		<div class="title">
			<div id="title_zi">������Ϣ</div>
		</div>
		<table>
	    <tr>
	  		<td width="20%" class="blue">�������ı��</td>
	  		<td width="30%">
	  			<input type="text" id="spgwNum" v_must="1" name="spgwNum"  maxlength="40" value="" onblur="checkElement(this)"/>&nbsp;&nbsp;
	  			<font class=orange>*</font>
	  		</td>
	  		<td width="20%" class="blue">Ա�����</td>
	  		<td width="30%">
	  			<input type="text" id="accountNum" v_must="1" name="accountNum"  maxlength="10" value="" onblur="checkElement(this)"/>&nbsp;&nbsp;
	  			<font class=orange>*</font>
	  		</td>
	    </tr>
	    <tr>
	  		<td width="20%" class="blue">֤������</td>
	  		<td width="30%">
	  			<select name="idType" id="idTypeSelect">
	  				<option value="0|���֤">���֤</option>	
	  			</select>
	  		</td>
	  		<td width="20%" class="blue">�ͻ�����</td>
	  		<td width="30%">
	  			<input name=custName id="custName" value=""  v_must=1 v_maxlength=60 v_type="string"   maxlength="60" size=20 index="9"  >
	  		</td>
	    </tr>
	    <tr>
	    	<td width="50%" colspan=2 align=center>
	        <input type="button" name="scan_idCard_two" class="b_text"   value="����" onClick="Idcard()" >
	        <input type="button" name="scan_idCard_two222" id="scan_idCard_two222" class="b_text"   value="����(2��)" onClick="Idcard2('1')" >
        </td>	
	  		<td width="20%" class="blue" >֤������</td>
	      <td width="30%"> 
        	<input name="idIccid"  id="idIccid"   value=""  v_minlength=4 v_maxlength=20 v_type="string" onChange="change_idType('1')" maxlength="20"   index="11" value="">
        </td>
	    </tr>
	    <tr>
	    	<td width="20%" class="blue" >֤����ַ</td>
	      <td width="30%"> 
	        <input name=idAddr  id="idAddr" value=""   v_must=1 v_type="addrs"  maxlength="60" v_maxlength=60 size=30 index="12">
	      </td>
	    	<td class="blue" > 
          <div align="left">֤����Ч��</div>
        </td>
        <td> 
          <input class="button" name="idValidDate" id="idValidDate" v_must=0 v_maxlength=8 v_type="date" readonly  maxlength=8 size="8" index="13" >
        </td>
	    </tr>
	    <tr>
	  		<td width="20%" class="blue">��ϵ�绰</td>
	  		<td width="30%">
	  			<input id="contactPhone" name=contactPhone class="button" v_must=1 v_type="phone" maxlength="20"  index="20" size="20" >
	  		</td>
	    </tr>
	  </table>
	  <div class="title">
			<div id="title_zi">�ط���Ϣ</div>
		</div>
		<table>
	    <tr>
	  		<td>
	  			<%
	  				if(result_mail.length > 0 && "000000".equals(retCode_mail)){
	  					for(int i=0;i<result_mail.length;i++){
	  							if(i != 0 && i%6==0){
	  								%>
	  							  
	  								<%
	  							}
	  						%>
	  							<input type="checkbox" name="tef" value="<%=result_mail[i][0]%>"/><%=result_mail[i][1]%> &nbsp;
	  						<%
	  					}
	  				}
	  			%>
	  		</td>
	    </tr>
	  </table>
		<div class="title">
			<div id="title_zi">��Դ��Ϣ</div>
		</div>
		<table>
			<tr>
		     <td class="blue">��������</td>
				 <td>
				 		<input type="text" name="phoneNo" id="phoneNo" value="" maxlength="11"  onblur="checkElement(this)"/>
			   		<font class=orange>*</font>
			   		<input type="button" class="b_text" name="chkPhone" id="chkPhone" value="У��" onclick="chkPhoneFunc();"/>
			   		<input type="button" id="b_emptySimOpen" name="b_emptySimOpen" value="�տ�����" class="b_text" disabled="disabled" onClick="emptySimOpenFunc()" > 
			   </td>
	    </tr>
	    
	    <tr style="display:none">
		     <td class="blue">�տ����� </td>
				 <td>
				  	<select align="left" id="cardTypeN" name="cardTypeN"  index="28" onchange="chaCardType()">
			        <option value="0" >��</option>
			        <option value="1" selected>��</option>
			      </select>	
			   </td>
	    </tr>
	    
	    <tr  id="tr_serviceNo1">
			  <td class="blue"  id="th_simInfo"> SIM���� </td>
			  <td colspan="6"  id="td_simInfo">
			  	<input name="simType" id="simType" type=hidden value="">
			  	<input name=simTypeName type=text  readonly index="11" Class="InputGrey">
			  	<input type='text' name='simCode' id='simCode' maxlength="20" class="required numOrLetter" value="">
			  	<input type="button" id="checksimN" name="checksimN" value="��ԴУ��" class="b_text" onClick="checksim()" disabled> <font class="orange">*</font>
			  	<input type="button" name="b_write" value="д��" class="b_text" onClick="writechg()" disabled > 
			  	</td>
			</tr>
	  </table>
	</div>
	 <div>
	 
	 <table>
	   <tr>
			<td align=center colspan="4" id="footer">
				<input class="b_foot" id="cfmBtn" name="cfmBtn"  type="button" value="ȷ��&��ӡ" disabled="disabled"  onclick="nextStep();">&nbsp;&nbsp;
				<input class="b_foot" id="resetBtn" name="resetBtn"  type="button" value="����"  onclick="javascript:window.location.reload();">&nbsp;&nbsp;
				<input class="b_foot" name="close"  onClick="removeCurrentTab()" type=button value=�ر�>
			</td>
			</tr>
		</table>
	
	</div>
	<input type="hidden" name="birthDay" id="birthDay" />
	<input type="hidden" name="birthDayH" id="birthDayH" value=""/>
	<input type="hidden" name="custSex" id="custSex" value=""/>
	<input type="hidden" name="idSexH" id="idSexH" value=""/>
	<input type="hidden" name="idAddrH" id="idAddrH" value=""/>
	
	<input type="hidden" name="card_flag" value="">  <!--���֤������־-->
	<input type="hidden" name="pa_flag" value="">  <!--֤����־-->
  <input type="hidden" name="m_flag" value="">   <!--ɨ����߶�ȡ��־������ȷ���ϴ�ͼƬʱ���ͼƬ��-->
  <input type="hidden" name="sf_flag" value="">   <!--ɨ���Ƿ�ɹ���־-->
  <input type="hidden" name="pic_name" value="">   <!--��ʶ�ϴ��ļ�������-->
  <input type="hidden" name="up_flag" value="0">
  <input type="hidden" name="but_flag" value="0"> <!--��ť�����־-->
  <input type="hidden" name="upbut_flag" value="0"> <!--�ϴ���ť�����־-->
  <input name="cardtype_bz" type="hidden" value="s">	
  <input type="hidden" name="simTypeCfm" id="simTypeCfm"   />
	<input type="hidden" name="simCodeCfm" id="simCodeCfm"   />
	<input type="hidden" name="newSmCode" value="dn"/>
	<input type="hidden" name="innetType" id="innetType" value="01"/><!-- ������ͨ���� -->
	<input type="hidden" name="prepayFee" id="prepayFee"   />
	<input type="hidden" name="isGoodNo" id="isGoodNo"   />
	<input type="hidden" name="modedxpay" id="modedxpay"   />
	<input name="cardstatus" type=hidden value="">
	<input name="cardNo" type=hidden value="">
	<input name="writecardbz" type=hidden value="">
	
	

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

<OBJECT id="CardReader_CMCC" height="0" width="0"  classid="clsid:FFD3E742-47CD-4E67-9613-1BB0D67554FF" codebase="/npage/public/CardReader_AGILE.cab#version=1,0,0,6"></OBJECT>
<%@ include file="/npage/sq100/interface_provider.jsp" %>
</html>
