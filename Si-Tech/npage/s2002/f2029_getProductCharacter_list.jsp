<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.GregorianCalendar" %>
<!--�·�ҳ�õ�����-->
<%@ page import="com.sitech.crmpd.core.wtc.util.*" %>
<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);
%>

<%
		String opCode = "";
		String opName = "";
    //String workNo = (String)session.getAttribute("workNo");
    //String org_code = (String)session.getAttribute("orgCode");
    String workNo = request.getParameter("workNo");
    String org_code = request.getParameter("orgCode");
    String regionCode=org_code.substring(0,2);	
    String product_OperType	=request.getParameter("product_OperType");
    String p_OperType = request.getParameter("p_OperType");
    String dataConsult = request.getParameter("dataConsult");//wangzn 090927
    String prpValue = "".equals(request.getParameter("prpValue"))?"-1":request.getParameter("prpValue");//yuanqs add 2010/8/27 23:19:27 400��������
    String product_add_flag = WtcUtil.repNull((String)request.getParameter("product_add_flag"));
    int siMMSSumFlag = -1; //diling add for EC���Ż��������λ�ñ�ʶ@2012/5/31
   // out.print("["+dataConsult+"]");
    
    System.out.println("###################### product_add_flag = "+product_add_flag);
    System.out.println("@@@@@@@@@@@@@@@@@@@@@@@product_OperType="+product_OperType);
     System.out.println("@@@@@@@@@@@@@@@@@@@@@@@p_OperType="+p_OperType);
     String typeFlag="one";/*diling add @2012/9/25 */
    
%>
<%
    /*
    SQL���        sql_content
    ѡ������       sel_type   
    ����           title      
    �ֶ�1����      field_name1
    */        
    String pageTitle = request.getParameter("pageTitle");
    String fieldNum  = "";
    String fieldName = request.getParameter("fieldName");
    String retQuence = request.getParameter("retQuence");    
    String sqlFilter = "";   
    String selType   = "M";                                           
    String sPOSpecNumber       = request.getParameter("sPOSpecNumber"      );//��Ʒ����� 
    String sPOOrderNumber      = request.getParameter("sPOOrderNumber"     );
    String sPOSpecRatePolicyID = request.getParameter("sPOSpecRatePolicyID");
    String sProductSpecNumber = request.getParameter("sProductSpecNumber");//��Ʒ�����
	String maxgroup = request.getParameter("maxgroup");
	String rowlength=request.getParameter("rowlength");
	int irowlength=Integer.parseInt(rowlength.trim());
       
    if (selType.compareTo("S") == 0) {
        selType = "radio";
    }
    if (selType.compareTo("M") == 0) {
        selType = "checkbox";
    }
    if (selType.compareTo("N") == 0) {
        selType = "";
    }
    //=====================
    int chPos = 0;
    String typeStr = "";
    String inputStr = "";
    String valueStr = "";
    
%>

<HEAD>
    <TITLE>��Ʒ����ѡ��
    </TITLE>
</HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<BODY>

<script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js"></script>

<SCRIPT type=text/javascript>
	//wangzn add 2011/12/14 14:12:53 ����һ�������ֽ������Ƴ��ȵĺ��� BEGIN
	function limitLength(value, byteLength, title, attribute) { 
		var newvalue = value.replace(/[^\x00-\xff]/g, "**"); 
		var length = newvalue.length; 

		//����д���ֽ���С�����õ��ֽ��� 
		if (length * 1 <=byteLength * 1){ 
			return; 
		} 
		var limitDate = newvalue.substr(0, byteLength); 
		var count = 0; 
		var limitvalue = ""; 
		for (var i = 0; i < limitDate.length; i++) { 
	        var flat = limitDate.substr(i, 1); 
			if (flat == "*") { 
				count++; 
			} 
		} 
      	var size = 0; 
      	var istar = newvalue.substr(byteLength * 1 - 1, 1);//У����Ƿ�Ϊ������ 
   
      	//if �����ǡ�; �ж��ڻ������С�Ϊż���������� 
      	if (count % 2 == 0) { 
	        //��Ϊż��ʱ 
	        size = count / 2 + (byteLength * 1 - count); 
	        limitvalue = value.substr(0, size); 
      	} else { 
        	//��Ϊ����ʱ 
	        size = (count - 1) / 2 + (byteLength * 1 - count); 
	        limitvalue = value.substr(0, size); 
      	}	 
	    alert(title + " �������" + byteLength + "���ֽڣ��൱��"+byteLength /2+"�����֣���"); 
	    //document.getElementById(attribute).value = limitvalue; 
	    attribute.val(limitvalue);
	    return false; 
    }
	//wangzn add 2011/12/14 14:12:53 ����һ�������ֽ������Ƴ��ȵĺ��� END
	//wangzn add 2011/12/14 9:39:49 �����ҵ�ֻ�����Ʒ��������У�� BEGIN
	$(document).ready(function(){	//2011/11/10 wanghfa����
		if(('<%=p_OperType%>'=='0'&&'<%=product_OperType%>'=='')||('<%=p_OperType%>'=='4'&&'<%=product_OperType%>'==''))
		{
			var defaultObj = document.getElementsByName("texCharacterSel910601001")[0];
				if(defaultObj!=undefined) {
			defaultObj.value = "451";
			defaultObj.disabled = true;
			getRinput(defaultObj, "910601001");
			defaultObj = document.getElementsByName("texCharacterSel910601009")[0];
			defaultObj.value = "02";
			defaultObj.disabled = true;
			getRinput(defaultObj, "910601009");
			//$("#texCharacterVal910601001").attr("readOnly", true);
			//$("#texCharacterVal910601001").val("451");
			//$("#List910601001").attr("checked", true);
			//$("#List910601001").attr("disabled", true);
			}
		}
			//�������·���ʼʱ�� ��ʽ�磺113400��HHMMSS��
		$("input[@name='texCharacterVal1102241034']").each(function()
		{
			$(this).attr('v_type','time');
			
		});
		//�������·�����ʱ�� ��ʽ�磺113400��HHMMSS��
		$("input[@name='texCharacterVal1102241035']").each(function()
		{
			$(this).attr('v_type','time');
		});
		//���ſͻ����Ž����ֻ��� 11λ�ֻ����룬����
		$("input[@name='texCharacterVal1102240003']").each(function()
		{
			$(this).attr('v_type','mobphone');
		});
		
		//��Ĭ��ֵ��ͬ�����ܸ���
		$("input[@name='texCharacterVal1102240006']").each(function(){$(this).attr('readonly',true);});
		$("input[@name='texCharacterVal1102240010']").each(function(){$(this).attr('readonly',true);});
		$("input[@name='texCharacterVal1102240019']").each(function(){$(this).attr('readonly',true);});
		$("input[@name='texCharacterVal1102240020']").each(function(){$(this).attr('readonly',true);});
		$("input[@name='texCharacterVal1102240041']").each(function(){$(this).attr('readonly',true);});
		$("input[@name='texCharacterVal1102240051']").each(function(){$(this).attr('readonly',true);});
		$("input[@name='texCharacterVal1102241011']").each(function(){$(this).attr('readonly',true);});
		$("input[@name='texCharacterVal1102241013']").each(function(){$(this).attr('readonly',true);});
		$("input[@name='texCharacterVal1102241014']").each(function(){$(this).attr('readonly',true);});
		$("input[@name='texCharacterVal1102241015']").each(function(){$(this).attr('readonly',true);});
		$("input[@name='texCharacterVal1102241016']").each(function(){$(this).attr('readonly',true);});
		$("input[@name='texCharacterVal1102241022']").each(function(){$(this).attr('readonly',true);});
		$("input[@name='texCharacterVal1102241024']").each(function(){$(this).attr('readonly',true);});
		$("input[@name='texCharacterVal1102241026']").each(function(){$(this).attr('readonly',true);});
		$("input[@name='texCharacterVal1102242015']").each(function(){$(this).attr('readonly',true);});
		$("input[@name='texCharacterVal1102246105']").each(function(){$(this).attr('readonly',true);});
		
		//Ӣ�Ķ���/��������ǩ�� ��дӢ��ǩ����������16λ
		$("input[@name='texCharacterVal1102240050']").each(function(){$(this).attr('maxlength','16');});
		
		//EC��ҵ�� ����ֵ����������6λ�������֣�ϵͳ���Զ�����һ����ȷ����ҵ�뽫�������
		$("input[@name='texCharacterVal1102241028']").each(function()
		{
			$(this).attr('maxlength','6');
			$(this).attr('v_type','0_9');
		});
		
		//ÿ���·���������� 9λ���ڴ�����
		$("input[@name='texCharacterVal1102241032']").each(function()
		{
			$(this).attr('maxlength','9');
			$(this).attr('v_type','int');
		});
		//ÿ���·���������� 9λ���ڴ�����
		$("input[@name='texCharacterVal1102241033']").each(function()
		{
			$(this).attr('maxlength','9');
			$(this).attr('v_type','int');
		});
		
		//���Ķ���/��������ǩ�� ���������Ļ���Ӣ���ַ������ܳ����ɳ���8���֣�ÿ��Ӣ����ĸ��һ���֣�
		$("input[@name='texCharacterVal1102241031']").each(function()
		{
			$(this).attr('maxLength','8');
			//$(this).bind('keyup',function (){
			//	limitLength($(this).val(), 8, "���Ķ���/��������ǩ��", $(this));
			//});
		});
		//��ע 100���ֽ����ڣ���һ�������������ֽڣ�
		$("input[@name='texCharacterVal1102241036']").each(function()
		{
			//$(this).attr('v_maxlength','100');
			$(this).bind('keyup',function (){
				limitLength($(this).val(), 100, "��ע", $(this));
			});
		});
	});
	//wangzn add 2011/12/14 9:39:49 �����ҵ�ֻ�����Ʒ��������У�� END
	var v_phoneCheck = true;//yuanqs add 2011/5/23 8:45:36 
	function doUpload(retField){
    	document.fPubSimpSel.target="hidden_frame";
      document.fPubSimpSel.encoding="multipart/form-data";
      document.fPubSimpSel.action="f2029_uploadProductCharacter.jsp?retField="+retField;
      document.fPubSimpSel.method="post";
      document.fPubSimpSel.submit();
      loading();
    }
    function doUnLoading(){
      unLoading();
    }
	function preSaveTo()
	{ 	
	  	//wangzn 2010-3-23 14:39:35
	  	if (document.getElementsByName("List910601006")[0] != undefined 
	  		&& document.getElementsByName("List910601006")[0].checked == true 
	  		&& (!forMail(document.getElementsByName("texCharacterVal910601006")[0]))) {	//2011/11/10 wanghfa���
	  		rdShowMessageDialog("���ſͻ���ϵ�����䲻����ȷ�����䣡", 1);
	  		return false;
	  	}
	  	if (document.getElementsByName("List910601007")[0] != undefined && document.getElementsByName("List910601007")[0].checked == true) {	//2011/11/10 wanghfa���
				document.getElementById("texCharacterVal910601007").v_type = "0_9";
				if (!checkElement(document.getElementById("texCharacterVal910601007"))) {
					return false;
				}
				var thePhoneNo = document.getElementById("texCharacterVal910601007").value;
				if (thePhoneNo.length != 11) {
					rdShowMessageDialog("���ſͻ���ϵ���ֻ����볤�ȱ���Ϊ11λ��");
					return false;
				}
				var phoneHead = thePhoneNo.substr(0,3);
				var getdataPacket = new AJAXPacket("f2029_getProductCharacter_checkPhone.jsp","���ڲ�ѯ�����Ժ�......");
				getdataPacket.data.add("phoneHead",phoneHead);
				core.ajax.sendPacket(getdataPacket, checkPhoneHead);
				getdataPacket = null;
				if(!v_phoneCheck) {
					return false;
				}
	  	}
	  	if (document.getElementsByName("List910601008")[0] != undefined && document.getElementsByName("List910601008")[0].checked == true) {	//2011/11/10 wanghfa���
				var val = document.getElementsByName("texCharacterVal910601008")[0].value;
				if (val.substring(0,2) != "1:") {
		  		rdShowMessageDialog("��ҵ������ֵ��ʽ����", 1);
		  		return false;
				}
				
				var patrn = /^-?\d+$/;
				if(val.substring(2).search(patrn)==-1){
					rdShowMessageDialog("��ҵ������ֵ��ʽ����", 1);
					return false;
				} else if (parseInt(val.substring(2)) <= 0) {
					rdShowMessageDialog("��ҵ������ֵ��ʽ����", 1);
					return false;
				}
	  	}
	  	/*
	  	if (document.getElementsByName("List910601007")[0] != undefined && document.getElementsByName("List910601007")[0].checked == true) {	//2011/11/10 wanghfa���
	  		//rdShowMessageDialog("���ſͻ���ϵ�����䲻����ȷ�����䣡", 1);
	  		return false;
	  	}*/
	  	      /*begin diling add for �Ƿ�У����EC���Ż�������� @2012/5/31*/
      var siMMSSumFlagHidd = $("#siMMSSumFlagHidd").val();
      /*
      if((siMMSSumFlagHidd!=-1)&&(v_siMMSCheckFlag=="N")){
        rdShowMessageDialog("�ύǰ�����Ƚ���EC���Ż�������ŵ�У�飡");
	  		return;
      }*/
      /*end diling add@2012/5/31*/
      /*���������������ſͻ���Ϣ����Ŀ(��Ʒ)Ͷ�ʺ������Զ���ƥ�䱨��ĺ�
		* liangyl 2016-08-22
		* 10985
		*/
      if(undefined!=document.getElementsByName("texCharacterVal10985")[0]&&document.getElementById("List10985").checked==true) {
	  		  var tempValue = document.getElementsByName("texCharacterVal10985")[0].value; //��Ŀ���
	  		  if(tempValue !=""){
	  			ajax_check_F10985();
		  			if(F10985_flag==0) {
	  					return;
		  			}
	  		 	}
	  	}
      
	  	//yuanqs add 2010/8/28 0:38:17 400�������� begin
	  	if(undefined!=document.getElementsByName("texCharacterVal4115017007")[0]&&undefined!=document.getElementsByName("texCharacterVal4115017001")[0]) {
	  		  var tempValue = document.getElementsByName("texCharacterVal4115017001")[0].value; //400�����ֵ
	  		  var tempValue1 = document.getElementsByName("texCharacterVal4115017007")[0].value; //Ԥռ����ˮ��
	  		  if(tempValue !="" && tempValue1 !="" ){
		  		  var tempValue_2 = 0;	//400�����ֺ���ӵĺ�
		  		  var tempValue_4 = 0;	//Ԥռ����ˮ�ŵ�ǰ5λ��ֺ���ӵĺ�
		  		  for(var i=0; i<tempValue.length; i++) {	//400�����ֺ����
		  		  	tempValue_2 = tempValue_2 + parseInt(tempValue.substr(i, 1)); //400�����ֺ���Ӹ�ֵ��tempValue_2
		  		  }
		  			var tempValue_1 = document.getElementsByName("texCharacterVal4115017007")[0].value.substr(4, 1); //Ԥռ����ˮ�ŵĵ�5λ
		  			var tempValue_5 = document.getElementsByName("texCharacterVal4115017007")[0].value.substr(5, 1); //Ԥռ����ˮ�ŵĵ�6λ
		  			var tempValue_3 = document.getElementsByName("texCharacterVal4115017007")[0].value.substr(0, 5); //Ԥռ����ˮ�ŵ�ǰ5λ
		  			for(var i=0; i<tempValue_3.length; i++) {//Ԥռ����ˮ�ŵ�ǰ5λ��ֺ����
		  		  	tempValue_4 = tempValue_4 + parseInt(tempValue_3.substr(i, 1));//Ԥռ����ˮ�ŵ�ǰ5λ��ֺ���Ӹ�ֵ��tempValue_4
		  		  }
		  			if(tempValue_1 != tempValue_2%10 || tempValue_5 != tempValue_4%10) {//��5λΪ400�����У��λ��400�����10λ����֮�͵ĸ�λ��������6λΪǰ5λ���ֵ�У��λ��ǰ5λ����֮�͵ĸ�λ����
		  					rdShowMessageDialog("Ԥռ����ˮ�Ų����Ϲ���");
		  					return;
		  			}
	  		 	}
	  	}
	  	if(undefined!=document.getElementsByName("texCharacterVal4115017032")[0]) {
		  		var checkBoxList = document.getElementsByName("List");
		  		var checkedFlag = false;
		  		for(var i=0; i<checkBoxList.length; i++) {
			  		var rinputValue = document.getElementById("Rinput" + i + "0").value;
			  		if("4115017032" == rinputValue) {
			  				checkedFlag = document.getElementsByName("List")[i].checked;
			  		}
		  		}
	  			var prp = document.getElementsByName("texCharacterVal4115017032")[0].value;
	  			var i_prp = <%=prpValue%>;
	  			if(prp<i_prp&&-1!=i_prp&&checkedFlag) {
	  					rdShowMessageDialog("���ȵ�ƽ̨ɾ�����룬�����������");
	  					//return;
	  			}
	  	} 
	  	
	  	//zhouby add   	1112084333, 1112054333, 1112064333 ����������ֵ��ҵ�񣬶Ը�����ʽ��Ҫ��
	  	var fileTypes = {'JPG': true, 'BMP': true, 'JPEG': true, 'PNG': true, 'GIF': true, 'PDF': true,
	  	                  'jpg': true, 'bmp': true, 'jpeg': true, 'png': true, 'gif': true, 'pdf': true};
	  	var fileTypeChecker = {flag : false, code: ''};
	  	
	  	var $files = $('input[name="PosFile_1112054333"], input[name="PosFile_1112084333"], input[name="PosFile_1112064333"]');
	  	$files.each(function(i, e){
	  	    var v = $(this).val();
	  	    if (v == ''){
	  	        return false;
	  	    }
	  	    v = v.substr(v.lastIndexOf('.') + 1);
	  	    if (!fileTypes[v]){
	  	        fileTypeChecker.flag = true;
	  	        var n = $(e).attr('name');
  	          fileTypeChecker.code = n.substr(8);
	  	    }
	  	});
	  	
	  	if (fileTypeChecker.flag){
	  	    var m = "����Ϊ" + fileTypeChecker.code + 
	  	            "��ҵ�񣬸����ĸ�ʽ������չ������Ϊ�������и�ʽ֮һ��JPG��BMP��JPEG��PNG��GIF��PDF";
	  	    rdShowMessageDialog(m);
	  	    return;
	  	}
	
	  	//yuanqs add 2010/8/28 0:38:17 400�������� end
	  	document.fPubSimpSel.target="_self";
	    document.fPubSimpSel.encoding="application/x-www-form-urlencoded";
	    document.fPubSimpSel.method="post";
      document.fPubSimpSel.action="#";
	  	
	  	
	  	for (i = 0; i < document.fPubSimpSel.elements.length; i++)
      {
            if (document.fPubSimpSel.elements[i].type == "checkbox"&&document.fPubSimpSel.elements[i].checked)
            {    //�ж��Ƿ��ǵ�ѡ��ѡ��
                
                	var character_num = document.fPubSimpSel.elements[i].id.substring(4,document.fPubSimpSel.elements[i].id.length);
                
                  if(document.getElementsByName('texCharacterVal'+character_num)[0].type=="hidden"){
                  	doUpload('texCharacterVal'+character_num);
                  	return;
                  }
               
            }
      }
      //yuanqs add 2011/5/13 17:24:42 �ֻ��������ƺ���������
      	if(undefined!=document.getElementById("List9104010002")) {
			v_phoneCheck = true;
			if (document.getElementById("List9104010002").checked) {
				var thePhoneNo = document.getElementById("texCharacterVal9104010002").value;
				if (thePhoneNo.length != 11) {
					rdShowMessageDialog("�ֻ����볤�ȱ���Ϊ11λ��");
					return false;
				}
				var phoneHead = thePhoneNo.substr(0,3);
				var getdataPacket = new AJAXPacket("f2029_getProductCharacter_checkPhone.jsp","���ڲ�ѯ�����Ժ�......");
				getdataPacket.data.add("phoneHead",phoneHead);
				core.ajax.sendPacket(getdataPacket, checkPhoneHead);
				getdataPacket = null;
				if(!v_phoneCheck) {
					return false;	
				}
			}
		}
      if(undefined!=document.getElementById("List9104010001")) {
			if (document.getElementById("List9104010001").checked) {
				var theEmail = document.getElementById("texCharacterVal9104010001");
				
				
				if(!forMail(theEmail)) return false;
				
				
				
			}
		}
      
      
      //wuxy add 20110525 �ƶ��绰������������У��
      
      	if(undefined!=document.getElementById("List9105010002")) {
			v_phoneCheck = true;
			if (document.getElementById("List9105010002").checked) {
				var thePhoneNo = document.getElementById("texCharacterVal9105010002").value;
				if (thePhoneNo.length != 11) {
					rdShowMessageDialog("�ֻ����볤�ȱ���Ϊ11λ��");
					return false;
				}
				var phoneHead = thePhoneNo.substr(0,3);
				var getdataPacket = new AJAXPacket("f2029_getProductCharacter_checkPhone.jsp","���ڲ�ѯ�����Ժ�......");
				getdataPacket.data.add("phoneHead",phoneHead);
				core.ajax.sendPacket(getdataPacket, checkPhoneHead);
				getdataPacket = null;
				if(!v_phoneCheck) {
					return false;	
				}
			}
		}
		//wuxy add 20110525 �ƶ��绰������������У��
		if(undefined!=document.getElementById("List9105010001")) {
			if (document.getElementById("List9105010001").checked) {
				var theEmail = document.getElementById("texCharacterVal9105010001");
				if(!forMail(theEmail)) return false;
				
			}
		}
      	
	
		
	  	saveTo();
	  }
	
	/* yuanqs add 2011/5/20 15:30:08 ���Ӳ�ѯ�ֻ�����ŶεĻص����� */
	function checkPhoneHead(packet){
			var retCode = packet.data.findValueByName("retcode");
			var retMsg = packet.data.findValueByName("retmsg");
			var phoneHeadFlag = packet.data.findValueByName("phoneHeadFlag");
			if(retCode == "000000"){
				if (phoneHeadFlag == 0) {
					v_phoneCheck = false;
					rdShowMessageDialog("����д�ƶ����룡");
					return false;
				}
			}else{
				rdShowMessageDialog("������룺" + retCode + "��������Ϣ��" + retMsg,0);
				return false;
			}
		}
	
    function saveTo()
    {	
        var obj4115067011 = document.getElementsByName("texCharacterVal4115067011")[0];
        if(obj4115067011!=undefined){
        	var obj4115061009 = document.getElementsByName("texCharacterVal4115061009")[0];
        	var obj4115062009 = document.getElementsByName("texCharacterVal4115062009")[0];
        	if(obj4115061009!=undefined&&obj4115062009!=undefined){
        		obj4115061009.value = '10657'+obj4115067011.value;
        		obj4115062009.value = obj4115061009.value;
        	}       	
        }

        //add by wangleic 2011-3-31 04:52PM
        var obj4115097011 = document.getElementsByName("texCharacterVal4115097011")[0];
        if(obj4115097011!=undefined){
        	var obj4115091009 = document.getElementsByName("texCharacterVal4115091009")[0];
        	var obj4115092009 = document.getElementsByName("texCharacterVal4115092009")[0];
        	if(obj4115091009!=undefined&&obj4115092009!=undefined){
        		obj4115091009.value = '10657'+obj4115097011.value;
        		obj4115092009.value = obj4115091009.value;
        	}       	
        }

       	var unique_flags = document.getElementsByName("unique");
       	var sss='';
       	for(i = 0; i < unique_flags.length ;i++){ 
        	var ss =  unique_flags[i].id.substring(6,unique_flags[i].id.length);   
        	var l = document.getElementById('List'+ss);  
        	if(unique_flags[i].value!='Y'&&l.checked==true){
        		sss = '"'+unique_flags[i].cname+'"'; 		
        		break;
        	}
        	
        }

        var rIndex;        //ѡ�������
        var retValue = ""; //����ֵ
        var chPos;         //�ַ�λ��
        var obj;
        var fieldNo;        //���������к�
        var retFieldNum = document.fPubSimpSel.retFieldNum.value;
        var retQuence = document.fPubSimpSel.retQuence.value;  //�����ֶ��������
        var retNum = retQuence.substring(0, retQuence.indexOf("|"));
	    	var flag = "1";
	    	var position = "";
	    	var charaNumValue="";//���Ա��봮�����ｫ����ѡ�е����Ա���ƴ�ɴ˴���������ļ��
       
        retQuence = retQuence.substring(retQuence.indexOf("|") + 1);
        var tempQuence;
        if (retFieldNum == "")
        {
            return false;
        }
       //���ص�����¼
        for (i = 0; i < document.fPubSimpSel.elements.length; i++)
        {
        	
            if (document.fPubSimpSel.elements[i].name == "List")
            {    //�ж��Ƿ��ǵ�ѡ��ѡ��
                if (document.fPubSimpSel.elements[i].checked == true)
                {     //�ж��Ƿ�ѡ��
                    rIndex = document.fPubSimpSel.elements[i].RIndex;
                    tempQuence = retQuence;
                    for (n = 0; n < retNum; n++)
                    {
                        chPos = tempQuence.indexOf("|");
                        fieldNo = tempQuence.substring(0, chPos);
        			            
                        obj = "Rinput" + rIndex + fieldNo;
                        //alert(document.all(obj).value);
        			    
                        retValue = retValue + document.all(obj).value + "|";
                        tempQuence = tempQuence.substring(chPos + 1);
                        if(document.all("Rinput"+rIndex+"3").value==""){
                        	// alert(document.all("Rinput"+rIndex+"0").mustUploadFlag+"----"+document.all("Rinput"+rIndex+"0").value);
                        	if(/*document.all("Rinput"+rIndex+"1").value!="ҵ����չ��"&&*/document.all("Rinput"+rIndex+"0").mustUploadFlag!="2"){
	                        	flag="0";
	                        	position="Rinput"+rIndex+"3";
	                       	}
                        }
                        if(fieldNo==0)
                        	charaNumValue = charaNumValue + document.all(obj).value + "^";
                    }
                    retValue = retValue + "^";
                    window.returnValue = retValue;
                }
            }
        }
        //alert("sss"+document.fPubSimpSel.elements.length);
        for (i = 0; i < document.fPubSimpSel.elements.length; i++)
        {
        	var rIndex = document.fPubSimpSel.elements[i].RIndex;
        	var obj11 = "Rinput" + rIndex + "4";
        	var obj112 = "Rinput" + rIndex + "5";
        	 //alert(document.all(obj112).value);
        	if (document.fPubSimpSel.elements[i].name == "List")
            {
            	//alert("ss"+document.all.product_OperType.value.trim());
            	if(document.all.product_OperType.value.trim()!="9|")
            	{
            		//wuxy add 20090908 ������������������⣬�ٴ���ӣ������ж����Ա���
            	  //alert(document.all.maxGroup11.value);
            	  
            	if( document.all.maxGroup11.value<=0)
             {
            	if((document.fPubSimpSel.elements[i].checked == false)&&(document.all(obj112).value=="����"))
            	{
	                rdShowMessageDialog("��ѡ����������", 0);
					        return false;              		
            	}
             }
                
              }
	            if((document.fPubSimpSel.elements[i].checked == true)&&(document.all(obj11).value!="0"))
	            {
					    for (j = 0; j < document.fPubSimpSel.elements.length; j++)
	        			{
	        				if (document.fPubSimpSel.elements[j].name == "List")
            				{
            					var rIndex = document.fPubSimpSel.elements[j].RIndex;
		        				var obj1 = "Rinput" + rIndex + "4";
		            			if ((document.fPubSimpSel.elements[j].checked == false)&&(document.all(obj11).value==document.all(obj1).value))
		            			{
					            	group_flag=document.all(obj1).value;
					                rdShowMessageDialog("��ѡ�����Թ�����Ϊ"+group_flag+"������", 0);
           							return false;   
					            	break;            				
		            			}
		            		}
	            		}
	
	            }
	           	
        	}
        }
        //alert(charaNumValue);
        //���ú�������������Գ��ֵ�����
        if (retValue == "")
        {
            rdShowMessageDialog("��ѡ����Ϣ�", 0);
            return false;
        }
        if (flag=="0"){
        	rdShowMessageDialog("����д��Ʒ����ֵ["+document.all(position).name.substring(15)+"]������", 0);
        	//document.all(position).focus();
        	return false;
        }
        //opener.document.all.cust_name.className = "InputGrey";
        
    	 //liujian 2012-8-22 11:08:25 ��Ӷ����ڵ�У�飬���result[i][11]=1����ֻ����yyyy-MM-dd��yyyy/MM/dd begin 
    	 var typeFlagHidd = $("#typeFlagHidd").val();
  	 	 var _allDateOk = true;
  	 	 if(typeFlagHidd=="two"){
        $('.judge_data_type').each(function() {
          var _this = $(this);
          if(_this.parent().parent().find('input[@type=checkbox]:checked').attr("id")) {
            var myregex = new RegExp(/^\d{4}[\/\-]\d{2}[\/\-]\d{2}$/);   // ����������ʽ
            if ($.trim(_this.val()).length !=0 && !myregex.test(_this.val())){	
            	rdShowMessageDialog("���ڸ�ʽ����ֻ����yyyy-MM-dd��yyyy/MM/dd��");
            	_this.focus();
            	_allDateOk = false;
            	return false;
            }
          }
        });
        if(!_allDateOk) {
          return false;	
        }
  	 	 }
	  	 //liujian 2012-8-22 11:08:25 ��Ӷ����ڵ�У�飬���result[i][11]=1����ֻ����yyyy-MM-dd��yyyy/MM/dd end 
        
        
     		var ecLongServiceCode = document.getElementsByName('texCharacterVal1102222009')[0];
     		var ecShortBaseCode = document.getElementsByName('texCharacterVal1102221009')[0];
     		
     		if(ecLongServiceCode!=null&&ecShortBaseCode!=null){
     			
     			//alert(ecLongServiceCode.value.substring(0,11));
     			if(!(ecLongServiceCode.value==ecShortBaseCode.value&&ecLongServiceCode.value.substring(0,11)=='12582999928')){
     				rdShowMessageDialog("EC����������EC���Ż�������ű�����ͬ��������12582999928��ͷ��", 0);
     				return false;
     			}
     			
     		}
     		
		var ecLongServiceCode2 = document.getElementsByName('texCharacterVal4115061009')[0];
		var ecShortBaseCode2 = document.getElementsByName('texCharacterVal4115062009')[0];
		
		if(ecLongServiceCode2!=null&&ecShortBaseCode2!=null)
		{
			//wangzn add 2010-8-19 11:21:34
			var ecLongServiceCode2L = document.getElementsByName('List4115061009')[0];
			var ecShortBaseCode2L = document.getElementsByName('List4115062009')[0]; 
			if(ecLongServiceCode2L.checked||ecShortBaseCode2L.checked)
			{
				if(!(ecLongServiceCode2.value==ecShortBaseCode2.value
				&&ecLongServiceCode2.value.substring(0,9)=='106574001'
				&&ecLongServiceCode2.value.length>=15))
				{
					rdShowMessageDialog("EC����������EC���Ż�������ű�����ͬ��������106574001��ͷ,����Ϊ15λ��", 0);
					return false;
				}	
			}
		}
     		
		//add by wangleic 2011-3-31 04:55PM
		var ecLongServiceCode2 = document.getElementsByName('texCharacterVal4115091009')[0];
		var ecShortBaseCode2 = document.getElementsByName('texCharacterVal4115092009')[0];
		
		if(ecLongServiceCode2!=null&&ecShortBaseCode2!=null)
		{
			var ecLongServiceCode2L = document.getElementsByName('List4115091009')[0];
			var ecShortBaseCode2L = document.getElementsByName('List4115092009')[0]; 
			if(ecLongServiceCode2L.checked||ecShortBaseCode2L.checked)
			{
				if(!(ecLongServiceCode2.value==ecShortBaseCode2.value
					&&ecLongServiceCode2.value.substring(0,9)=='106574001'
					&&ecLongServiceCode2.value.length>=15))
				{
					rdShowMessageDialog("EC����������EC���Ż�������ű�����ͬ��������106574001��ͷ,��������Ϊ15λ��", 0);
					return false;
				}	
			} 			
		}
		
		/*һ��ͨҵ����ͨ����	247011009	EC���Ż��������	106572000*/
		if ( document.getElementsByName('texCharacterVal247011009')[0]!=null )
		{
			if ( document.getElementsByName('List247011009')[0]!=null )
			{
				if (!( document.getElementsByName('texCharacterVal247011009')[0].value.substring(0,9)=='106572000' 
					&& document.getElementsByName('texCharacterVal247011009')[0].value.length >=16 ))
				{
					rdShowMessageDialog("EC���Ż�������ű����� 106572000 ��ͷ,��������Ϊ16λ��", 0);
					return false;
				}
			}
		}
		
		
		/*һ��ͨҵ����ͨ����	247012009	EC���������	106572000*/
		if ( document.getElementsByName('texCharacterVal247012009')[0]!=null )
		{
			if ( document.getElementsByName('List247012009')[0]!=null )
			{
				if (!( document.getElementsByName('texCharacterVal247012009')[0].value.substring(0,9)=='106572000' 
					&& document.getElementsByName('texCharacterVal247012009')[0].value.length >=16 ))
				{
					rdShowMessageDialog("EC��������� ������ 106572000 ��ͷ,��������Ϊ16λ��", 0);
					return false;
				}
			}
		}		
		
		
		/*һ��ͨҵ����ͨ����	247021009	EC���Ż��������	106572000	16       */
		if ( document.getElementsByName('texCharacterVal247021009')[0]!=null )
		{
			if ( document.getElementsByName('List247021009')[0]!=null )
			{
				if (!( document.getElementsByName('texCharacterVal247021009')[0].value.substring(0,9)=='106572000' 
					&& document.getElementsByName('texCharacterVal247021009')[0].value.length >=16 ))
				{
					rdShowMessageDialog("EC���Ż�������� ������ 106572000 ��ͷ,��������Ϊ16λ��", 0);
					return false;
				}
			}
		}	
				
		/*һ��ͨҵ����ͨ����	247021019	EC���Ż��������	106572000	16       */
		if ( document.getElementsByName('texCharacterVal247021019')[0]!=null )
		{
			if ( document.getElementsByName('List247021019')[0]!=null )
			{
				if (!( document.getElementsByName('texCharacterVal247021019')[0].value.substring(0,9)=='106572000' 
					&& document.getElementsByName('texCharacterVal247021019')[0].value.length >=16 ))
				{
					rdShowMessageDialog("EC���Ż�������� ������ 106572000 ��ͷ,��������Ϊ16λ��", 0);
					return false;
				}
			}
		}			
		
		/*һ��ͨҵ����ͨ����	247022019	EC���������	106572000	16           */
		if ( document.getElementsByName('texCharacterVal247022019')[0]!=null )
		{
			if ( document.getElementsByName('List247022019')[0]!=null )
			{
				if (!( document.getElementsByName('texCharacterVal247022019')[0].value.substring(0,9)=='106572000' 
					&& document.getElementsByName('texCharacterVal247022019')[0].value.length >=16 ))
				{
					rdShowMessageDialog("EC��������� ������ 106572000 ��ͷ,��������Ϊ16λ��", 0);
					return false;
				}
			}
		}	

		/*��ҵ�ֻ���	1102241009	EC���Ż��������	1065022	14                   */
		if ( document.getElementsByName('texCharacterVal1102241009')[0]!=null )
		{
			if ( document.getElementsByName('List1102241009')[0]!=null )
			{
				if ( ""!=document.getElementsByName('texCharacterVal1102241009')[0].value.trim() )
				{
					if (!( document.getElementsByName('texCharacterVal1102241009')[0].value.substring(0,7)=='1065022' 
						&& document.getElementsByName('texCharacterVal1102241009')[0].value.length >=14 ))
					{
						rdShowMessageDialog("EC���Ż�������� ������ 1065022 ��ͷ,��������Ϊ14λ��", 0);
						return false;
					}							
				}

			}
		}			

		/*��ҵ�ֻ���	1102241019	EC���Ż��������	1065022	14                   */
		if ( document.getElementsByName('texCharacterVal1102241019')[0]!=null )
		{
			if ( document.getElementsByName('List1102241019')[0]!=null )
			{
				if (""!=document.getElementsByName('texCharacterVal1102241019')[0].value.trim())
				{
					if (!( document.getElementsByName('texCharacterVal1102241019')[0].value.substring(0,7)=='1065022' 
						&& document.getElementsByName('texCharacterVal1102241019')[0].value.length >=14 ))
					{
						rdShowMessageDialog("EC���Ż�������� ������ 1065022 ��ͷ,��������Ϊ14λ��", 0);
						return false;
					}					
				}

			}
		}	

		/*��ҵ�ֻ���	1102242019	EC���������	1065022	14                       */
		if ( document.getElementsByName('texCharacterVal1102242019')[0]!=null )
		{
			if ( document.getElementsByName('List1102242019')[0]!=null )
			{
				if ( ""!=document.getElementsByName('texCharacterVal1102242019')[0].value )
				{
					if (!( document.getElementsByName('texCharacterVal1102242019')[0].value.substring(0,7)=='1065022' 
						&& document.getElementsByName('texCharacterVal1102242019')[0].value.length >=14 ))
					{
						rdShowMessageDialog("EC��������� ������ 1065022 ��ͷ,��������Ϊ14λ��", 0);
						return false;
					}					
				}

			}
		}			

 		var ecEnglishSign = document.getElementsByName('texCharacterVal4115090050')[0];
 		if(ecEnglishSign!=null){
 			if(ecEnglishSign.value!=''){
     			var patrn = /^[A-Za-z]+$/;
     			var patrn1 = /^[A-Za-z0-9]+$/;
     			if(ecEnglishSign.value.length<17)
     			{
     				if(ecEnglishSign.value.search(patrn)==-1
     					&&ecEnglishSign.value.search(patrn1)==-1){
	     				rdShowMessageDialog("Ӣ�Ķ���/��������ǩ��֧�ִ�Ӣ�Ļ�Ӣ�ġ����ֻ��ʹ�ã�", 0);
	     				return false;
     				}
     			}else{
     				rdShowMessageDialog("Ӣ�Ķ���/��������ǩ�����Ȳ�����16λ��", 0);
	     			return false;
     			}
 			}
 		}

     		var ecECCode = document.getElementsByName('texCharacterVal4115091028')[0];
     		if(ecECCode!=null){
     			if(ecECCode.value!=''){
	     			var patrn2 = /^-?\d+$/;
	     			if(ecECCode.value.length<7){
	     				if(ecECCode.value.search(patrn2)==-1){
		     				rdShowMessageDialog("EC��ҵ��ֻ����д���֣�", 0);
		     				return false;
	     				}
	     			}else{
	     				rdShowMessageDialog("EC��ҵ�볤�Ȳ�����6λ��", 0);
		     			return false;
	     			}
     			}	
     		}

     		var ecChineseSign = document.getElementsByName('texCharacterVal4115091031')[0];
     		if(ecChineseSign!=null){
     			if(ecChineseSign.value!=''){
	     			var patrn3 = /^[A-Za-z]+$/;
	     			var patrn4 = /^[\u4e00-\u9fa5]+$/;
	     			var patrn5 = /^[A-Za-z\u4e00-\u9fa5]+$/;
	     			if(ecChineseSign.value.length<9){
	     				if(ecChineseSign.value.search(patrn3)==-1&&ecChineseSign.value.search(patrn4)==-1&&ecChineseSign.value.search(patrn5)==-1){
		     				rdShowMessageDialog("���Ķ���/��������ǩ��֧�����Ļ�Ӣ���ַ���", 0);
		     				return false;
	     				}
	     			}else{
	     				rdShowMessageDialog("���Ķ���/��������ǩ�����Ȳ�����8λ��", 0);
		     			return false;
	     			}
     			}
     		}

        //��֤��ʽwangzn 2010-4-12 16:21:50
    	  if(!check(fPubSimpSel)) return false;

    	  var begTime = '';
    	  var endTime = '';
    	  var Rinput331011009 = '';
    	  var Rinput331012009 = '';
    	 
    	  for(var i=0;i<fPubSimpSel.elements.length;i++){
	      	var flag = false;
	      	var obj = fPubSimpSel.elements[i];
	      	if((obj.type=="text"||obj.type=="textarea")&&obj.disabled!=true&&obj.readOnly!=true){
	      		//�һ�����ʱ����֤ wangleic add 2011-4-7 02:23PM
	      		if(obj.name=='texCharacterVal4115091034'){
	      			begTime = obj.value;
	      		}
	      		if(obj.name=='texCharacterVal4115091035'){
	      			endTime = obj.value;
	      		}
	      		if(obj.name=='texCharacterVal331011009'){
	      			Rinput331011009 = obj.value;
	      		}
	      		if(obj.name=='texCharacterVal331012009'){
	      			Rinput331012009 = obj.value;
	      		}
	      		
	      	}
	      }

	      //var dBegin=getDateFromFormat(begTime,"HHmm");
	      //var dEnd=getDateFromFormat(endTime,"HHmm");
	      if(begTime>endTime){
	      	rdShowMessageDialog("��ʼʱ��ʱ�䲻�����ڽ���ʱ�䣡", 0);
	      	return false;
	      }
	      if(Rinput331011009!=''&&Rinput331012009!=''){
     			if(!(Rinput331011009==Rinput331012009&&Rinput331011009.substring(0,11)=='12582999928'&&Rinput331011009.length==16)){
     				rdShowMessageDialog("EC���Ż�������ź�EC��������������ͬ�����Ҹ�ʽ12582999928ABCDE��", 0);
     				return false;
     			}
     			
     		}

    	//  alert(unique_flags.length);
        if(sss!=''){
        	rdShowMessageDialog(sss+"δУ�飡", 0);
        	return false;
        }

        opener.getProductOrderCharacterRtn(retValue);
        window.close();
    }

    function allChoose()
    {   //��ѡ��ȫ��ѡ��
        for (i = 0; i < document.fPubSimpSel.elements.length; i++)
        {
            if (document.fPubSimpSel.elements[i].type == "checkbox")
            {    //�ж��Ƿ��ǵ�ѡ��ѡ��
                document.fPubSimpSel.elements[i].checked = true;
            }
        }
    }

    function cancelChoose()
    {   //ȡ����ѡ��ȫ��ѡ��
        for (i = 0; i < document.fPubSimpSel.elements.length; i++)
        {
            if (document.fPubSimpSel.elements[i].type == "checkbox")
            {    //�ж��Ƿ��ǵ�ѡ��ѡ��
                document.fPubSimpSel.elements[i].checked = false;
            }
        }
    }
	function chegroup(){
		//var product_id = event.srcElement.parentNode.innerText);
		//var chebox = event.srcElement;
		//if(chebox.checked)
	}
	function checkUnique(uniqueProCharacterNum){
		
		
		var character_value = document.getElementsByName("texCharacterVal"+uniqueProCharacterNum)[0].value;
		var vsPOSpecNumber= document.fPubSimpSel.sPOSpecNumber.value;
	//	alert(uniqueProCharacterNum + "----"+character_value);
		
	//wuxy alter 20091217 �����Ʒ������
		
		var myPacket = new AJAXPacket("f2029_checkUniqueCharacter.jsp","����У����......");	
		myPacket.data.add("character_number",uniqueProCharacterNum);
		myPacket.data.add("character_value",character_value);
		myPacket.data.add("sPOSpecNumber",vsPOSpecNumber);
	  myPacket.data.add("verifyType","checkUnique");
	  core.ajax.sendPacket(myPacket);	
	  myPacket=null;				  

	}
	/*begin diling add for У��EC���Ż�������� @2012/5/31*/
	function checkSiMMSInfo(vSiMMSInfo){
	  var myPacket = new AJAXPacket("f2029_ajax_checkSiMMSInfo.jsp","����У����......");	
		myPacket.data.add("vSiMMSInfo",vSiMMSInfo);
	  core.ajax.sendPacket(myPacket,doCheckSiMMSInfo);	
	  myPacket=null;		
	}
	
	var v_siMMSCheckFlag = "N";
	function doCheckSiMMSInfo(packet){
	  var retCode = packet.data.findValueByName("retcode");
		var retMsg  = packet.data.findValueByName("retmsg");
		//var siMMSCheckFlag  = packet.data.findValueByName("siMMSCheckFlag");
		if(retCode!="000000"){
      rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
      v_siMMSCheckFlag = "N";
      return;
    }else{
      rdShowMessageDialog("У��ɹ���",2);
      v_siMMSCheckFlag = "Y";
      return;
    }
	}
	/*end diling add @2012/5/31*/
	
	function doProcess(packet){
		
		error_code = packet.data.findValueByName("errorCode");
		error_msg  = packet.data.findValueByName("errorMsg");
		verifyType = packet.data.findValueByName("verifyType");
		var backArrMsg = packet.data.findValueByName("backArrMsg");
		var uniqueProCharacterNum = packet.data.findValueByName("inputCharacter_number");
		self.status="";
		if(verifyType=="checkUnique"){
			if(backArrMsg=="0"){
					document.getElementById("unique"+uniqueProCharacterNum).value='Y';
			}else{
					rdShowMessageDialog("��ֵ�Ѿ����ڣ�", 0);
			}
			//alert("["+backArrMsg+"]["+error_code+"]["+error_msg+"]");
		}
	}
	function changeUniqueFlag(ProCharacterNum){
		var cUniqueFlag = document.getElementById('unique'+ProCharacterNum);
		//alert(cUniqueFlag);
		if(cUniqueFlag!=null){
			cUniqueFlag.value='N'  ;
		}
		//document.getElementById('unique'+ProCharacterNum).value='N' 
		
	}
	//wangzn 090927
	function showConsult(){
		//window.open("f2029_showConsultPage.jsp?dataConsult=<%=dataConsult%>","","toolbar = 0");
		opener.showConsult('<%=dataConsult%>');
	}
	//wangzn 2010-4-15 16:59:20
	function getRinput(obj,characterNo){
	  var val = obj.options[obj.selectedIndex].value;   
	  var ipt = 'Rinput'+obj.id.substring(9); 
	  document.getElementById(ipt).value=val;
	  if('4115057026'==characterNo){
	    document.getElementById('List4115057017').disabled=true;
	    document.getElementById('List4115057018').disabled=true;
	    document.getElementById('List4115057019').disabled=true;
	                                             
	    document.getElementById('List4115057021').disabled=true;
	    document.getElementById('List4115057022').disabled=true;
	    document.getElementById('List4115057023').disabled=true;
	                                             
	    document.getElementById('List4115057024').disabled=true;
	    document.getElementById('List4115057025').disabled=true;
	  
	  
	    if(val=='1'){
	        document.getElementById('List4115057017').checked=true;
	        document.getElementById('List4115057018').checked=true;
	        document.getElementById('List4115057019').checked=true;
	        
	        document.getElementById('List4115057021').checked=false;
	        document.getElementById('List4115057022').checked=false;
	        document.getElementById('List4115057023').checked=false;
	        
	        document.getElementById('List4115057024').checked=false;
	        document.getElementById('List4115057025').checked=false;
	        	        
	    }else if(val=='2'){
	        document.getElementById('List4115057017').checked=false;
	        document.getElementById('List4115057018').checked=false;
	        document.getElementById('List4115057019').checked=false;
	        
	        document.getElementById('List4115057021').checked=true;
	        document.getElementById('List4115057022').checked=true;
	        document.getElementById('List4115057023').checked=true;
	        
	        document.getElementById('List4115057024').checked=false;
	        document.getElementById('List4115057025').checked=false;
	    
	    }else if(val=='3'){
	        document.getElementById('List4115057017').checked=false;
	        document.getElementById('List4115057018').checked=false;
	        document.getElementById('List4115057019').checked=false;
	        
	        document.getElementById('List4115057021').checked=false;
	        document.getElementById('List4115057022').checked=false;
	        document.getElementById('List4115057023').checked=false;
	        
	        document.getElementById('List4115057024').checked=true;
	        document.getElementById('List4115057025').checked=true;
	    
	    }
	  }
	}
	
	/*���������������ſͻ���Ϣ����Ŀ(��Ʒ)Ͷ�ʺ������Զ���ƥ�䱨��ĺ�
	* liangyl 2016-08-22
	* 10985
	*/
	var F10985_flag=0;
	function ajax_check_F10985(){
		F10985_flag=0;
		if(document.getElementsByName("texCharacterVal10985")[0].value==""){
			F10985_flag=1;
		}
		else{
			var packet = new AJAXPacket("../se743/ajax_check_F10985.jsp","���Ժ�...");
	        packet.data.add("F10985_val",document.getElementsByName("texCharacterVal10985")[0].value);//
	    	core.ajax.sendPacket(packet,do_ajax_check_F10985);
	   	 	packet =null;	
		}
	}

	function do_ajax_check_F10985(packet){
	    var error_code = packet.data.findValueByName("code");//���ش���
	    var error_msg =  packet.data.findValueByName("msg");//������Ϣ
	    if(error_code=="000000"){//�����ɹ�
	    	var result_count =  packet.data.findValueByName("result_count");
	    	if(result_count=="0"){
	    		rdShowMessageDialog("�������Ŀ��Ŵ�����˶Ժ���������!");
	    	}
	    	else{
	    		F10985_flag=1;
	    	}
	    }else{//���÷���ʧ��
		    rdShowMessageDialog(error_code+":"+error_msg);
	    }
	}
</SCRIPT>
<FORM method=post name="fPubSimpSel">
	<input name="sPOSpecNumber" id="sPOSpecNumber" type="hidden" value='<%=sPOSpecNumber%>'>
<div id="Main">
<DIV id="Operation_Table"> 
	<div class="title"><div id="title_zi">��Ʒ����ѡ��</div></div>	

<table cellspacing="0" style="table-layout:fix">
    <tr align="center">
        <th>��Ʒ���Դ���</th>
        <th>��Ʒ������</th>      
        <th>ö��ֵ</th>
        <th>��Ʒ����ֵ</th>   
        <th>���Թ�����</th>
        <th>�Ƿ����</th>   
    </TR>
    <% //���ƽ����ͷ
        chPos = fieldName.indexOf("|");
        out.print("");
        String titleStr = "";
        int tempNum = 0;
        while (chPos != -1) {
            valueStr = fieldName.substring(0, chPos);
            titleStr = "";
            out.print(titleStr);
            fieldName = fieldName.substring(chPos + 1);
            tempNum = tempNum + 1;
            chPos = fieldName.indexOf("|");
        }
        out.print("");
    %>
    

<wtc:service name="s9100DetQry" outnum="14" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=sProductSpecNumber%>"/>
	<wtc:param value="9"/>
		<wtc:param value="<%=sPOSpecNumber%>"/>
</wtc:service>
<wtc:array id="result" start="2" length="12" scope="end" />
<!-- yuanqs add 2010/8/27 23:47:01 400�������� begin -->
<input type="hidden" id="prpValue" name="prpValue" />
<!-- yuanqs add 2010/8/27 23:47:01 400�������� end -->

    <%
            String tbclass="";
            String v_maxlength = "maxlength=\"256\"";//wuxy alter 20110527�ӿڹ淶����������󳤶�256
            for (int i = 0; i < result.length; i++) {
            	System.out.println("zhouby>>>>result["+i+"][0]=="+result[i][0]+"---");
		        System.out.println("zhouby>>>>result["+i+"][1]=="+result[i][1]+"---");
		        System.out.println("zhouby>>>>result["+i+"][2]=="+result[i][2]+"---");
		        System.out.println("zhouby>>>>result["+i+"][3]=="+result[i][3]+"---");
		        System.out.println("zhouby>>>>result["+i+"][4]=="+result[i][4]+"---");
		        System.out.println("zhouby>>>>result["+i+"][5]=="+result[i][5]+"---");
		        System.out.println("zhouby>>>>result["+i+"][6]=="+result[i][6]+"---");
		        System.out.println("zhouby>>>>result["+i+"][7]=="+result[i][7]+"---");
		        System.out.println("zhouby>>>>result["+i+"][8]=="+result[i][8]+"---");
		        System.out.println("zhouby>>>>result["+i+"][9]=="+result[i][9]+"---");
		        System.out.println("zhouby>>>>result["+i+"][10]=="+result[i][10]+"---");
		        System.out.println("zhouby>>>>result["+i+"][11]=="+result[i][11]+"<br>");
            	String dis_flag="";
            	//wuxy alter 20090923 �������ù���
            	//if((product_OperType.indexOf("9")!=-1)&&(result[i][1].equals("4115057017")||result[i][1].equals("4115011201")||result[i][1].equals("4115061201")||result[i][1].equals("4115057023")||result[i][1].equals("4115057021")))
            	if((product_OperType.indexOf("9")!=-1)&&"1".equals(result[i][6]))	
            		dis_flag="disabled";
            		
            	//wangzn 090913
            	if("4".equals(p_OperType)&&"1".equals(result[i][6])){
            		dis_flag="disabled";
            	}
            	tbclass = (i%2==0)?"Grey":"";
                typeStr = "";
                inputStr = "";
                out.print("<TR align='center'>");
                for (int j = 0; j < 6; j++) {
                String disflag="";
                String chkflag="";
                String isFile = "";
                //wuxy alter 20090911 ֧����Ʒ�޸���������Ʒ
                if(p_OperType.equals("0")||(product_OperType.trim().equals("")&&p_OperType.equals("4"))){
	                /* if(result[i][2].equals("ҵ����չ��")){
	                    	disflag="disabled";
	                    	chkflag="checked";
	                 }*/ //wangzn 090916
	                 if("2".equals(result[i][5])){
            		     disflag="disabled";
            		     chkflag="checked";
            	     }
                 }
                 
                 String checkBoxLabel = "";
                 if(irowlength==0&&(p_OperType.equals("0")||p_OperType.equals("4")&&product_add_flag.equals("1"))&&(result[i][5]).trim().equals("1")){
                    checkBoxLabel = " checked disabled ";
                 }
                
                 System.out.println("rendi test result["+i+"]["+j+"]="+result[i][j]);
                    if (j == 0) {
                    System.out.println("result["+i+"]["+j+"]="+result[i][j]);
                    //System.out.println("---------------diling-------------result["+i+"]["+j+"]="+result[i][j]);
                        typeStr = "<TD class='"+tbclass+"'>&nbsp;";
                        if (selType.compareTo("") != 0) {
                            typeStr = typeStr + "<input onclick='chegroup();'  id='List"+(result[i][1]).trim()+"'     type='" + selType +
                                    "' name='List' style='cursor:hand' RIndex='" + i + "'" +
                                    "onkeydown='if(event.keyCode==13)saveTo();'" +dis_flag+ "  "+chkflag+" "+disflag+" "+checkBoxLabel+">";
                        }
                        typeStr = typeStr +(result[i][1]).trim()+"<input type='hidden'  id='Rinput" + i + j + "' value='" +
                                (result[i][1]).trim() + "'  mustUploadFlag='"+(result[i][5]).trim()+"'           readonly></TD>";
                    }else if ( j == 1){  
                    	if("1102241019".equals(result[i][j])){
                        siMMSSumFlag = i ;                        
                      }
                      System.out.println("---------------2029-------------siMMSSumFlag="+siMMSSumFlag);   
                        inputStr = inputStr + "<TD class='"+tbclass+"'>" + (result[i][2]).trim() + "<input type='hidden' " +
                                " id='Rinput" + i + j + "' value='" + (result[i][2]).trim() + "'  readonly></TD>";
                    }else if ( j == 2){
                        inputStr = inputStr + "<TD class='"+tbclass+"'><div style='word-break:break-all;'>"+(result[i][3]).trim() +"</div><input type='hidden' " +" id='Rinput" + i + j + "' value='" + (result[i][3]).trim() + "'readonly>&nbsp;</TD>";
                    }else if ( j == 3){
                    	  // wangzn 2010-4-23 17:06:41
                    	  if("1".equals(result[i][10])){
                    	     inputStr = inputStr + "<TD class='"+tbclass+"' align=left>"
                    	     +"<input type='hidden'  id='Rinput" + i + j + "'  name='texCharacterVal"+result[i][1]+"'      value='"+result[i][9]+"'    onPropertyChange=changeUniqueFlag('"+result[i][1]+"') "+disflag+">"
                    	     +"    	<input type=\"file\" name=\"PosFile_"+result[i][1]+"\" id=\"PosFile\" class=\"button\" style='border-style:solid;border-color:#7F9DB9;border-width:1px;font-size:12px;' />";
                    	     inputStr = inputStr + "</TD>";
                    	     continue;
                    	  }
                    	
                    	  //wangzn 2010-4-15 10:11:51
                    	  String inputType = "text";
                    	  if(!"".equals((result[i][3]).trim())&&(result[i][3].trim().split(",").length>1)){
                    	     inputType = "hidden";
                    	  }
                    	  String defVal = result[i][9];
                    	  
                        if("331011010".equals(result[i][1])||"4115061010".equals(result[i][1])){
                           Date    date = new Date();
                           SimpleDateFormat df  = new SimpleDateFormat("yyyy/MM/dd");
                           GregorianCalendar gc = new GregorianCalendar();
                           gc.setTime(date); 
                           String  time=df.format(gc.getTime());
                           defVal = time;
                        }
                        
                        if("4115061031".equals(result[i][1])){
                            v_maxlength = "maxlength=\"8\"";
                        }
                    	
                    	//wangzn 2010-4-12 13:41:48
                    	  String v_type = "";
                    	  if("331011034".equals(result[i][1])||"4115061034".equals(result[i][1])||"4115091034".equals(result[i][1])||"4115091035".equals(result[i][1])){
                    	  	v_type = "v_type=time";//HHMISS
                    	  }
                    	  if("331010004".equals(result[i][1])||"331011010".equals(result[i][1])||"4115017020".equals(result[i][1])||"4115027020".equals(result[i][1])||"4115037020".equals(result[i][1])||"4115047020".equals(result[i][1])||"4115057020".equals(result[i][1])||"4115061038".equals(result[i][1])||"4115060004".equals(result[i][1])||"4115061010".equals(result[i][1])){
                    	  	v_type = "v_type=date2";//YYYY/MM/DD
                    	  }
                    	  if("4115057018".equals(result[i][1])){
                    	  	v_type = "v_type=time2";//HHMM
                    	  }
                    	  //System.out.println("---liujian---" + i + "-----result["+i+"][11]="+result[i][11]);
                    	  //liujian 2012-8-22 11:08:25 ��Ӷ����ڵ�У�飬���result[i][11]=1����ֻ����yyyy-MM-dd��yyyy/MM/dd
                    	  if(result[i][11] != null && result[i][11].equals("1")) {
                    	      //System.out.println("---liujian---" + i + "------result["+i+"][11]="+result[i][11]);
                    	      v_type = "";
                    	      typeFlag = "two";
                    	  		inputStr = inputStr + "<TD class='"+tbclass+"' align=left><input type='"+inputType+"' " +
                                " id='Rinput" + i + j + "'  name='texCharacterVal"+result[i][1]+"'    class='judge_data_type'  value='"+defVal+"'    onPropertyChange=changeUniqueFlag('"+result[i][1]+"') "+disflag+" "+v_type+" "+v_maxlength+" >";
	                           System.out.println("---liujian--11111-----v_type="+v_type);
	                           System.out.println("---liujian-d--11111-----typeFlag="+typeFlag );
	                      }else {
	                         typeFlag = "one";
	                         //System.out.println("---liujian---2222222-----v_type="+v_type);
	                    		inputStr = inputStr + "<TD class='"+tbclass+"' align=left><input type='"+inputType+"' " +
                                " id='Rinput" + i + j + "'  name='texCharacterVal"+result[i][1]+"'      value='"+defVal+"'    onPropertyChange=changeUniqueFlag('"+result[i][1]+"') "+disflag+" "+v_type+" "+v_maxlength+" >";
	                      }
                        
                        //wangzn 2010-4-15 10:11:42
                        if(!"".equals((result[i][3]).trim())&&(result[i][3].trim().split(",").length>1)){
                          String[] selDatas = result[i][3].trim().split(",");
                          inputStr = inputStr +"<select style='width:150px;' id='RinputSel"+i+j+"' name=texCharacterSel"+result[i][1]+" onchange='getRinput(this,\""+result[i][1]+"\")' >";
                          inputStr = inputStr + "<option value=''>...��ѡ��...</options>";
                          for(int ij = 0;ij<selDatas.length;ij++){
                           inputStr = inputStr + "<option value='"+selDatas[ij]+"'>"+selDatas[ij]+"</options>";
                          }
                          inputStr = inputStr + "</select>";
                        }
                        if("1".equals(result[i][7])){
                        	inputStr = inputStr + "&nbsp<input class=b_text type=button value=У�� onClick=checkUnique('"+result[i][1]+"');><input type=hidden id=unique"+result[i][1]+" name=unique value='N' cname="+result[i][2]+"  >";
                        }
                        /*begin diling add for ����EC���Ż�������ţ�������У�鰴ť*/
                        if(i==siMMSSumFlag){
                          inputStr = inputStr + "&nbsp<input class=b_text type=button value=У�� onClick=checkSiMMSInfo(document.getElementById('Rinput" + i + j + "').value);><input type=hidden id=siMMSInfo"+result[i][1]+" name='siMMSInfo' value='N' cname="+result[i][2]+"  >";
                        }
                        System.out.println("---------------2029-------------siMMSSumFlag="+siMMSSumFlag);
                         /*end diling add @2012/5/31*/
                        inputStr = inputStr + "</TD>";
                    }
                    else if ( j == 4){
                    	String charaterGroup = "";
                    	if((result[i][4]).trim().equals("0"))
                    	{
                    		charaterGroup="0";
                    		
                    	}else if(result[i][4].equals("")){
                    		charaterGroup = result[i][4];
                    	}else if((maxgroup.trim()).equals("")){
                    		charaterGroup = result[i][4];
                    	}
                    	else{
                    		charaterGroup =String.valueOf(Integer.parseInt(result[i][4].trim())+Integer.parseInt(maxgroup.trim()));
                    	}
                        inputStr = inputStr +"<TD class='"+tbclass+"'><input type='hidden' class='InputGrey' readonly  id='Rinput" + i + j + "' value='" + charaterGroup + "'>"+charaterGroup+"</TD>";
                    }else if ( j ==5){
                    	String tempResult = "";
                    	if((result[i][5]).trim().equals("0")){
                    		tempResult="�Ǳ���";
                    	}else if((result[i][5]).trim().equals("1")){
                    		tempResult="����";
                    	}else if((result[i][5]).trim().equals("2")){
                    		tempResult="�ؿ�";
                    	}else if((result[i][5]).trim().equals("3")){
                    		tempResult="����";
                    	}
                        inputStr = inputStr + "<TD class='"+tbclass+"'><input class='InputGrey' readonly  type='text' " +
                                " id='Rinput" + i + j + "' value='" + tempResult + "'></TD>";
                    }                    	
                    
                }
                out.print(typeStr + inputStr);
                out.print("</TR>");
            }
    %>
    </tr>
</table>

<!------------------------------------------------------>
<TABLE cellSpacing="0">
    <TBODY>
        <TR>
            <TD id="footer">
                <%
                    if (selType.compareTo("checkbox") == 0) {
                        out.print("<input name=allchoose onClick='allChoose()' style='cursor:hand' type=button value=ȫѡ class='b_foot'>&nbsp");
                        out.print("<input name=cancelAll onClick='cancelChoose()' style='cursor:hand' type=button value=ȡ��ȫѡ class='b_foot'>&nbsp");
                    }
                %>

                <%
                    if (selType.compareTo("") != 0) {
                %>
                <input class='b_foot' name=commit onClick="preSaveTo()" style="cursor:hand" type=button value=ȷ��>&nbsp;
                <%
                    }
                %>
                <input class='b_foot' name=back onClick="window.close()" style="cursor:hand" type=button value=����>&nbsp;
                <input class='b_foot' name=consult onClick="showConsult()" style="cursor:hand" type=button value=���� <%if(dataConsult==null||"".equals(dataConsult)||"null".equals(dataConsult)){%>style='display:none' <%}%> >&nbsp;<!-- wangzn 090928 -->
            </TD>
        </TR>
    </TBODY>
</TABLE>
<!------------------------>
<input type="hidden" name="retFieldNum" value=3>
<input type="hidden" name="retQuence" value="<%=retQuence%>" >
<input type="hidden" name="product_OperType" value="<%=product_OperType%>" >
<input type="hidden" name="maxGroup11" value="<%=irowlength%>" >
<input type="hidden" name="siMMSSumFlagHidd" id="siMMSSumFlagHidd" value="<%=siMMSSumFlag%>" >
<input type="hidden" name="typeFlagHidd" id="typeFlagHidd" value="<%=typeFlag%>" >

<!------------------------>

</div>
</div>
<iframe name='hidden_frame' id="hidden_frame" style='display:none'></iframe>
</FORM>
</BODY>
</HTML>    
