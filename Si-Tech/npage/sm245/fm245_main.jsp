<%
  /*
   * ����: m245��ʵ��ʹ������Ϣ�޸� 
   * �汾: 1.0
   * ����: 2015/3/30 
   * ����: diling
   * ��Ȩ: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*"%>
<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
    
  String regionCode = (String)session.getAttribute("regCode");
  String loginNo = (String)session.getAttribute("workNo");
	String noPass = (String)session.getAttribute("password");
	String phoneNo = (String)request.getParameter("activePhone");
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName"); 

		/*2017.4.18��������ȡ����������M2M�ͻ���������ʹ����¼��ĺ� ��*/
		String m2mFlag = "";
		
%>
		<wtc:service name="sM2mChk" outnum="3"
			routerKey="region" routerValue="<%=regionCode%>" retcode="m2mrc" retmsg="m2mrm" >
			<wtc:param value = ""/>
			<wtc:param value = "01"/>
			<wtc:param value = "<%=opCode%>"/>
			<wtc:param value = "<%=loginNo%>"/>
			<wtc:param value = "<%=noPass%>"/>
			<wtc:param value = "<%=phoneNo%>"/>	
			<wtc:param value = ""/>
			<wtc:param value = ""/>
			<wtc:param value = ""/>
		</wtc:service>
		<wtc:array id="outM2mFlag" scope="end" />

<%
	if("000000".equals(m2mrc)){
			if(outM2mFlag.length > 0){

			System.out.println("----duming---------m2mrc--"+m2mrc+"m2mrm"+m2mrm+"outM2mFlag"+outM2mFlag[0][0]);
				m2mFlag = outM2mFlag[0][0];

			}
		}




%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="printAccept"/>
	
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
	<script src="../public/json2.js" type="text/javascript"></script>   
<script language="JavaScript">
var v_printAccept = "<%=printAccept%>";
function query(){
	$("#queryDiv").hide();
	var phoneNo = "<%=activePhone%>";
	var myPacket = new AJAXPacket("fm245_ajax_queryInfo.jsp","�����ύ��Ϣ�����Ժ�......");
  myPacket.data.add("opCode","<%=opCode%>");
  myPacket.data.add("opName","<%=opName%>");
  myPacket.data.add("phoneNo",phoneNo);
  core.ajax.sendPacket(myPacket,doQuery);
  myPacket = null;
}

function doQuery(packet){
	
	//2017.4.18��������ȡ����������M2M�ͻ���������ʹ����¼��ĺ�
	if("<%=m2mFlag%>"=="Y"){
	   			
		rdShowMessageDialog("�ʷ���M2M���ԣ�������¼��ʵ��ʹ����",3);
		return;
	}
	
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	var qPhoneNo = packet.data.findValueByName("qPhoneNo");
	var qCustName = packet.data.findValueByName("qCustName");
	var qRealUserIdType = packet.data.findValueByName("qRealUserIdType");
	var qRealUserIccId = packet.data.findValueByName("qRealUserIccId");
	var qRealUserName = packet.data.findValueByName("qRealUserName");
	var qRealUserAddr = packet.data.findValueByName("qRealUserAddr");
	if(retCode == "000000"){
		if(qRealUserIdType.length == 0 && qRealUserIccId.length == 0 && qRealUserName.length == 0 && qRealUserAddr.length == 0){
			if(rdShowConfirmDialog('û�в�ѯ������Ƿ�������������Ϣ��')==1){
				//�Ƿ���ҪУ�飺�û���ǰ��֤������Ϊ����λ�ͻ�����֤�����ͣ���
	    	$("#addBtn").attr("disabled",false); //�ɽ�������
	    }else{
	    	$("#addBtn").attr("disabled",true);
	    	$("#queryDiv").hide();
	    }
	    if(qPhoneNo.length > 0){
	    	$("#qPhoneNoHid").val(qPhoneNo);
	    }
	    if(qCustName.length > 0){
				$("#qCustNameHid").val(qCustName);
	    }
		}else{
			$("#queryDiv").show();
			$("#qPhoneNo").val(qPhoneNo);
			$("#qCustName").val(qCustName);
			$("#realUserIdType option").each(function(){
	      if($(this).val().indexOf(qRealUserIdType) != -1){ //���֤������ͬ
					$(this).attr("selected","true");
					if($(this).val() == "0"){ //���֤
						$("#scan_idCard_two2").css("display","");
						$("#scan_idCard_two222").css("display","");
					}else{ //�����֤
						$("#scan_idCard_two2").css("display","none");
						$("#scan_idCard_two222").css("display","none");
					}
				}
	    });
	    $("input[name='realUserName']").attr("class","InputGrey");
			$("input[name='realUserName']").attr("readonly","readonly");
			$("input[name='realUserAddr']").attr("class","InputGrey");
			$("input[name='realUserAddr']").attr("readonly","readonly");
			$("input[name='realUserIccId']").attr("class","InputGrey");
			$("input[name='realUserIccId']").attr("readonly","readonly");
	    
	    $("#realUserIccId").val(qRealUserIccId);
	    $("#realUserName").val(qRealUserName);
	    $("#realUserAddr").val(qRealUserAddr);
	    
	    $("#realUserIdTypeHid").val(qRealUserIdType);
			$("#realUserIccIdHid").val(qRealUserIccId);
			$("#realUserNameHid").val(qRealUserName);
			$("#realUserAddrHid").val(qRealUserAddr);
			$("#realUserIdType").attr("disabled",true);
			$("#updBtn").val("�޸�");
		}
	}else{
		rdShowMessageDialog("��ѯʧ�ܣ�<br>������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
		return false;
	}
}

function addInfo(){
	var qPhoneNoHid = $("#qPhoneNoHid").val();
	var qCustNameHid = $("#qCustNameHid").val();
	$("#qPhoneNo").val(qPhoneNoHid);
	$("#qCustName").val(qCustNameHid);
	
	$("#qryBtn").attr("disabled",true);
	$("#addBtn").attr("disabled",true);
	$("#queryDiv").show();
	$("#updBtn").val("ȷ��");
	$("#realUserIccId").val("");
	$("#realUserName").val("");
	$("#realUserAddr").val("");
	$("#qPhoneNo").removeAttr("class");
	$("#qCustName").removeAttr("class");
	$("#realUserIdType").attr("disabled",false);
	
	$("input[name='qPhoneNo']").attr("class","InputGrey");
	$("input[name='qPhoneNo']").attr("readonly","readonly");
	$("input[name='qCustName']").attr("class","InputGrey");
	$("input[name='qCustName']").attr("readonly","readonly");
	$("input[name='realUserName']").attr("class","InputGrey");
	$("input[name='realUserName']").attr("readonly","readonly");
	$("input[name='realUserAddr']").attr("class","InputGrey");
	$("input[name='realUserAddr']").attr("readonly","readonly");
	$("input[name='realUserIccId']").attr("class","InputGrey");
	$("input[name='realUserIccId']").attr("readonly","readonly");
}

function validateRealIdTypes(idtypeVal){
	var qRealUserIdType = $("#realUserIdTypeHid").val();
	var qRealUserIccId = $("#realUserIccIdHid").val();
	var qRealUserName = $("#realUserNameHid").val();
	var qRealUserAddr = $("#realUserAddrHid").val();
	if($("#realUserIdType").val().indexOf(qRealUserIdType) != -1){
		$("#realUserIccId").val(qRealUserIccId);
    $("#realUserName").val(qRealUserName);
    $("#realUserAddr").val(qRealUserAddr);
	}else{
		$("#realUserIccId").val("");
    $("#realUserName").val("");
    $("#realUserAddr").val("");
	}
	if(idtypeVal == "0"){
		document.all.realUserIccId.v_type = "idcard";
		$("#scan_idCard_two2").css("display","");
		$("#scan_idCard_two222").css("display","");
		$("input[name='realUserName']").attr("class","InputGrey");
		$("input[name='realUserName']").attr("readonly","readonly");
		$("input[name='realUserAddr']").attr("class","InputGrey");
		$("input[name='realUserAddr']").attr("readonly","readonly");
		$("input[name='realUserIccId']").attr("class","InputGrey");
		$("input[name='realUserIccId']").attr("readonly","readonly");
		$("input[name='realUserName']").val("");
		$("input[name='realUserAddr']").val("");
		$("input[name='realUserIccId']").val("");
	}else{
		document.all.realUserIccId.v_type = "string";
  	$("#scan_idCard_two2").css("display","none");
		$("#scan_idCard_two222").css("display","none");
		$("input[name='realUserName']").removeAttr("class");
		$("input[name='realUserName']").removeAttr("readonly");
		$("input[name='realUserAddr']").removeAttr("class");
		$("input[name='realUserAddr']").removeAttr("readonly");
		$("input[name='realUserIccId']").removeAttr("class");
		$("input[name='realUserIccId']").removeAttr("readonly");
	}
}

//�޸�����
function updInfo(obj){



	//alert($(obj).val());
	if($(obj).val() == "�޸�"){
		$("#updBtn").val("ȷ��");
		$("#realUserIdType").attr("disabled",false);
		if($("#realUserIdType").val() == "0"){
			
		}else{
			$("#realUserIccId").removeAttr("class");
			$("#realUserName").removeAttr("class");
			$("#realUserAddr").removeAttr("class");
			$("#qPhoneNo").removeAttr("readonly");
			$("#qCustName").removeAttr("readonly");
			$("#realUserIccId").removeAttr("readonly");
			$("#realUserName").removeAttr("readonly");
			$("#realUserAddr").removeAttr("readonly");
		}
	}else{
		if(!check(document.frm)) return false;
		
	if(!checkCustNameFunc(document.all.realUserName,3,1)){
		return false;
	}

	if(!checkAddrFunc(document.all.realUserAddr,5,1)){
				return false;
		}

	if(!checkIccIdFunc(document.all.realUserIccId,2,1)){
						return false;
	}
		
		
		
		if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
      document.frm.action="fm245_ajax_subInfo.jsp";
			document.frm.submit();
     }
		
	}
}





/*1���ͻ����ơ���ϵ������ У�鷽�� objType 0 ����ͻ�����У�� 1������ϵ������У��  ifConnect �����Ƿ�������ֵ(���ȷ�ϰ�ťʱ��������������ֵ)*/
function checkCustNameFunc(obj,objType,ifConnect){
	var nextFlag = true;
	
	if(document.all.realUserName.v_must !="1") {
	  return nextFlag;
	  return false;		
	}
	
	
	
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
		objName = "ʵ��ʹ��������";
		/*�����վ�����֤������*/
		idTypeVal = document.all.realUserIdType.value;
	}
	
	idTypeVal = $.trim(idTypeVal);
	
	/*ֻ��Ը��˿ͻ�*/
	var opCode = "<%=opCode%>";
	/*��ȡ������ֵ*/
	var objValue = obj.value;
	var objValue1 = obj.value;
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
		var idTypeText = idTypeVal;
		
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
            if(objValue1.charAt(0).trim() == ""){
                rdShowMessageDialog("ֻ������Ӣ�ġ����֡����ġ����ġ����ġ����Ļ����롮���š��������һ�����ԣ����������룡");
                obj.value = "";
                
                nextFlag = false;
                return false;
              }
            var key = checkNameStr1(code); //У��
            alert("key:"+key);
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
	
		if(document.all.realUserAddr.v_must !="1") {
	  return nextFlag;
	  return false;		
	}
	
	
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
		objName = "ʵ��ʹ������ϵ��ַ";
		idTypeVal = document.all.realUserIdType.value;
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
		var idTypeText = idTypeVal;
		
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
	
	
}
return nextFlag;
}

/*
	2013/11/18 14:01:09
	gaopeng
	֤�����ͱ��ʱ��֤�������У�鷽��
*/

function checkIccIdFunc(obj,objType,ifConnect){
	var nextFlag = true;
	
	if(document.all.realUserIccId.v_must !="1") {
	  return nextFlag;
	  return false;		
	}
	
	
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
		objName = "ʵ��ʹ����֤������";
		idTypeVal = document.all.realUserIdType.value;
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
		var idTypeText = idTypeVal;
		
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
			var m = /^([0-9\-A-Z]*)$/;
			var flag = m.test(objValue);
			if(!flag){
					rdShowMessageDialog(objName+"���������֡���-�������д��ĸ��ɣ�");
					
					nextFlag = false;
					return false;
			}
			if(objValueLength < 9){
					rdShowMessageDialog(objName+"������ڵ���9λ��");
					
					nextFlag = false;
					return false;
				
			}
		}
		/*Ӫҵִ�� ֤�����������ڵ���4λ���֣����������纺�ֵ��ַ�Ҳ�Ϲ�*/
		if(idTypeText == "8"){
			var m = /^[0-9]+$/;
			var numSum = 0;
			for (var i = 0; i < objValue.length; i ++){
          var code = objValue.charAt(i);//�ֱ��ȡ��������
          var flag = m.test(code);
          if(flag){
          	numSum ++;
          }
    	}
			if(numSum < 4){
					rdShowMessageDialog(objName+"��������4�����֣�");
					
					nextFlag = false;
					return false;
			}
			/*20131216 gaopeng ������BOSS�����������ӵ�λ�ͻ���������Ϣ�ĺ� �����е�֤������Ϊ��Ӫҵִ�ա�ʱ��Ҫ��֤�������λ��Ϊ15λ�ַ�*/
			if(objValueLength != 15){
					rdShowMessageDialog(objName+"����Ϊ15���ַ���");
					nextFlag = false;
					return false;
			}
		}
		/*����֤�� ֤��������ڵ���4λ�ַ�*/
		if(idTypeText == "B"){
			if(objValueLength < 4){
					rdShowMessageDialog(objName+"������ڵ���4λ��");
					
					nextFlag = false;
					return false;
			}
			
		}


	}else if(opCode == "1993"){

	}
	return nextFlag;
}


function forKuoHao(obj){ //�����������š�.�� �⼸�ָ���
	var m = /^(\(?\)?\��?\��?)\��|\.|\��+$/;
  	var flag = m.test(obj);
  	if(!flag){
  		return false;
  	}else{
  		return true;
  	}
}
function forEnKuoHao(obj){
	var m = /^(\(?\)?)+$/;
  	var flag = m.test(obj);
  	if(!flag){
  		return false;
  	}else{
  		return true;
  	}
}
function forHanZi1(obj)
  {
  	var m = /^[\u0391-\uFFE5]+$/;
  	var flag = m.test(obj);
  	if(!flag){
  		//showTip(obj,"�������뺺�֣�");
  		return false;
  	}
  		if (!isLengthOf(obj,obj.v_minlength*2,obj.v_maxlength*2)){
  		//showTip(obj,"�����д���");
  		return false;
  	}
  	return true;
  }
  
  //ƥ����26��Ӣ����ĸ��ɵ��ַ���
  function forA2sssz1(obj)
  {
  	var patrn = /^[A-Za-z]+$/;
  	var sInput = obj;
  	if(sInput.search(patrn)==-1){
  		//showTip(obj,"����Ϊ��ĸ��");
  		return false;
  	}
  	if (!isLengthOf(obj,obj.v_minlength,obj.v_maxlength)){
  		//showTip(obj,"�����д���");
  		return false;
  	}
  
  	return true;
  }
  
  
  function checkNameStr(code){
			/* gaopeng 2014/01/17 9:50:35 ����ƥ������ ��Ϊ���ſ���������Ҳ������Ӣ�ģ����ȷ���KH ��֤�߼���ʧ��*/
				if(forKuoHao(code)) return "KH";//����
		    if(forA2sssz1(code)) return "EH"; //Ӣ��
		    var re2 =new RegExp("[\u0400-\u052f]");
		    if(re2.test(code)) return "RU"; //����
		    var re3 =new RegExp("[\u00C0-\u00FF]");
		    if(re3.test(code)) return "FH"; //����
		    var re4 = new RegExp("[\u3040-\u30FF]");
		    var re5 = new RegExp("[\u31F0-\u31FF]");
		    if(re4.test(code)||re5.test(code)) return "JP"; //����
		    var re6 = new RegExp("[\u1100-\u31FF]");
		    var re7 = new RegExp("[\u1100-\u31FF]");
		    var re8 = new RegExp("[\uAC00-\uD7AF]");
		    if(re6.test(code)||re7.test(code)||re8.test(code)) return "KR"; //����
		    if(forHanZi1(code)) return "CH"; //����
    
   }
  function checkNameStr1(code){
		/* gaopeng 2014/01/17 9:50:35 ����ƥ������ ��Ϊ���ſ���������Ҳ������Ӣ�ģ����ȷ���KH ��֤�߼���ʧ��*/
			if(forKuoHao(code)) return "KH";//����
	    if(forA2sssz1(code)) return "EH"; //Ӣ��
	    var re2 =new RegExp("[\u0400-\u052f]");
	    if(re2.test(code)) return "RU"; //����
	    var re3 =new RegExp("[\u00C0-\u00FF]");
	    if(re3.test(code)) return "FH"; //����
	    var re4 = new RegExp("[\u3040-\u30FF]");
	    var re5 = new RegExp("[\u31F0-\u31FF]");
	    if(re4.test(code)||re5.test(code)) return "JP"; //����
	    var re6 = new RegExp("[\u1100-\u31FF]");
	    var re7 = new RegExp("[\u1100-\u31FF]");
	    var re8 = new RegExp("[\uAC00-\uD7AF]");
	    if(re6.test(code)||re7.test(code)||re8.test(code)) return "KR"; //����
	    if(forHanZi1(code)) return "CH"; //����
	    /*add 20170527���֤����Ϊ���������У��ͻ������м����Ϊ�ո�*/
	    if(forKuoHao16New1(code)) return "EH";//Ӣ�ķ���

}
  /*add 20170527���֤����Ϊ���������У��ͻ������м����Ϊ�ո�*/
  function forKuoHao16New1(obj){ //�����������š�.�� �⼸�ָ���
		var m = /^[\s]+$/;
	  	var flag = m.test(obj);
	  	//alert(flag);
	  	if(flag){
	  		return true;
	  	}else{
	  		return false;
	  	}
	}


</script> 
 
<title><%=opName%></title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>
<BODY>
<form name="frm"  >
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<table cellspacing="0">           
    <tr>
    	<td class="blue">�û�����</td>
    	<td colspan="3">
	    	<input type="text" id="phoneNo" name="phoneNo" value="<%=activePhone%>" class="InputGrey" readonly />
    	</td>
    </tr>
		<tr> 
			<td align="center" id="footer" colspan="4"> 
				<input type="button" name="qryBtn" id="qryBtn"  class="b_foot" value="��ѯ" onclick="query()" />
				&nbsp;
				<input type="button" name="addBtn" id="addBtn"  class="b_foot" value="����" onclick="addInfo()" disabled />
				&nbsp;
				<input type="button" name="closeBtn1" class="b_foot" value="�ر�" onclick="removeCurrentTab()" />
			</td>
		</tr>
	</table>
	<div id="queryDiv" style="display:none">
		<div id="Operation_Table">
			<div class="title">
				<div id="title_zi">��ѯ���</div>
			</div>
			<table cellspacing="0">           
		    <tr>
		    	<td class="blue">�ͻ�����</td>
		    	<td>
			    	<input type="text" id="qCustName" name="qCustName" value="" class="InputGrey" readonly />
			    	<font class=orange>*</font>
		    	</td>
		    	<td class="blue">�ֻ�����</td>
		    	<td>
			    	<input type="text" id="qPhoneNo" name="qPhoneNo" value="" class="InputGrey" readonly />
			    	<font class=orange>*</font>
		    	</td>
		    </tr>
		    <%@ include file="/npage/sm245/realUserInfo.jsp" %>
				<tr> 
					<td align="center" id="footer" colspan="4"> 
						<input type="button" name="updBtn" id="updBtn"  class="b_foot" value="�޸�" onclick="updInfo(this)">
					</td>
				</tr>
			</table>
	</div>
</div>
	<input type="hidden" id="qPhoneNoHid" name="qPhoneNoHid" value="" />
	<input type="hidden" id="qCustNameHid" name="qCustNameHid" value="" />
	<input type="hidden" id="realUserIdTypeHid" name="realUserIdTypeHid" value="" />
	<input type="hidden" id="realUserIccIdHid" name="realUserIccIdHid" value="" />
	<input type="hidden" id="realUserNameHid" name="realUserNameHid" value="" />
	<input type="hidden" id="realUserAddrHid" name="realUserAddrHid" value="" />
	<input type="hidden" name="custId" value="0" />
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</BODY>
<OBJECT classid="clsid:5EB842AE-5C49-4FD8-8CE9-77D4AF9FD4FF" id="IdrControl1" width="0" height="0"></OBJECT>
<OBJECT id="CardReader_CMCC" height="0" width="0"  classid="clsid:FFD3E742-47CD-4E67-9613-1BB0D67554FF" codebase="/npage/public/CardReader_AGILE.cab#version=1,0,0,6"></OBJECT>
</HTML>