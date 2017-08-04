<%
  /*
   * ����: �ʷ����ն˷���Ŀ���û����� g982
   * �汾: 1.0
   * ����: 2013/9/17
   * ����: diling
   * ��Ȩ: si-tech
   * update:
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	response.setHeader("Pragma","No-Cache");
  response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0);

	String sale_type = "54";
	String loginNo = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = (String)session.getAttribute("regCode");
	String groupId = (String)session.getAttribute("groupId");
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String iPhoneNo = activePhone;
	//lj. �󶨲���
	String sql_select1 = "SELECT UNIQUE a.brand_code, TRIM (b.brand_name) FROM dphonesalecode a, schnresbrand b WHERE a.region_code = :region_code  AND a.brand_code = b.brand_code AND a.valid_flag = 'Y' AND a.sale_type = :sale_type";
	String srv_params1 = "region_code=" + regionCode + ",sale_type=" + sale_type;

	//��ȡƷ������
%>
	<wtc:service name="TlsPubSelCrm" outnum="2">
		<wtc:param value="<%=sql_select1%>"/>
		<wtc:param value="<%=srv_params1%>"/>
	</wtc:service>
	<wtc:array id="result_brand" scope="end"/>
<%
	StringBuffer brandSb = new StringBuffer("");
	brandSb.append("<option value ='-1'>��ѡ��</option>");
	brandSb.append("<option value ='all'>����Ʒ��</option>");
	for(int i=0; i<result_brand.length; i++) {
		  brandSb.append("<option value ='").append(result_brand[i][0]).append("'>")
						 .append(result_brand[i][1])
						 .append("</option>");
	}
	
	//��ȡ���еĵ�ǰ����
	//lj. �󶨲���
	String sql_select2 = "select a.region_name from sregioncode a where a.region_code=:regioncode";
	String srv_params2 = "regioncode=" + regionCode;
	
	String regionCodeStr = "";
%>
	<wtc:service name="TlsPubSelCrm" outnum="3" retcode="retCode_region" retmsg="retMsg_region">
		<wtc:param value="<%=sql_select2%>"/>
		<wtc:param value="<%=srv_params2%>"/>
	</wtc:service>
	<wtc:array id="result_regioncode" scope="end"/>
<%
  if("000000".equals(retCode_region)){
    if(result_regioncode.length>0){
      regionCodeStr = result_regioncode[0][0];
    }
  }
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=opName%></title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
<script>
	var bankInstalArr = new Array();
	$(function() {		
		//�����ֻ�Ʒ�Ƶ������б�
		$('#phone_brand').append("<%=brandSb.toString()%>");
	    //չʾ��Ӧ����
	    $('#region_code').val("<%=regionCodeStr%>");
	});
	/*************************�л��ֻ�Ʒ��*****************************/
  function changeBrand(){
  	//����ֻ�Ʒ��
  	var brand = $('#phone_brand').val();
  	//���������óɿ�
  	$("#phone_type").empty();
  	
  	if(brand=="all"){ //��ѡ������Ʒ�ƣ����ֻ�������ֻ��չʾ��������
  	  var txt = '<option value="-1" >--��ѡ��--</option>';
  	  txt = txt + '<option value="all" >���л���</option>';
  	  $('#phone_type').append(txt);
  	}else{
  	  var packet = new AJAXPacket("srv.jsp","���ڻ�������Ϣ�����Ժ�......");
      var _data = packet.data;
      _data.add("sale_type","<%=sale_type%>");
      _data.add("brand_code",$('#phone_brand').val());
      _data.add("method","apply_getPhoneTypes");
      core.ajax.sendPacket(packet,getPhoneType);
      packet = null;
  	}
  }
			
	function getPhoneType(package){
	  var retCode = package.data.findValueByName("retcode");
		var retMsg = package.data.findValueByName("retmsg");
		var result = package.data.findValueByName("result");
		if(retCode == "000000") {
			//����ֻ�����
			var txt = '<option value="-1" >--��ѡ��--</option>';
			for(var i=0,len=result.length;i<len;i++) {
				txt += '<option value="' + result[i].value + '">';
				txt +=     result[i].name;
				txt += '</option>'
			}
			$('#phone_type').append(txt);
		}else {
			rdShowMessageDialog("������룺" + retCode + "��������Ϣ��" + retMsg,0);
			return false;
		}
	}
		/*************************�ύ��ťע���¼�****************************/
		function nextStep() {
		  var slecopFlag =$("input[@name=opFlag][@checked]").val();
		  if(slecopFlag=="one"){ //����
		    printCommit();	
		  }else if(slecopFlag=="two"){ //ɾ��
		    queryInfo();
		  } else if(slecopFlag=="search"){ //������ѯ
		    if (!validateCommonSearch()){
		      return;
		    }
		    commonSearch();
		  }  else { //��ˮ��ѯ
		    if (!forPosInt($('input[name="loginAccept"]')[0])){
		        return;
		    }
		    loginAcceptSearch();
		  }
		}
		
		function validateCommonSearch(){
		    var phone_brand = $('#phone_brand').val();//Ʒ��
            var phone_type = $('#phone_type').val();//�ͺ�
            
		    if (phone_brand == '-1'){
		        rdShowMessageDialog('��ѡ��Ʒ�ƣ�', 0);
		        return false;
		    }
		    
		    if (phone_type == '-1'){
		        rdShowMessageDialog('��ѡ���ͺţ�', 0);
		        return false;
		    }
		    
		    return true;
		}
		
		function commonSearch(){
		    var phone_brand = $('#phone_brand').val();//Ʒ��
            var phone_type = $('#phone_type').val();//�ͺ�
            var packet = new AJAXPacket("fg982_ajax_search.jsp","���ڻ�����ݣ����Ժ�......");
        	packet.data.add("phone_brand",phone_brand);
        	packet.data.add("phone_type",phone_type);
        	packet.data.add("region_code","<%=regionCode%>");
        	core.ajax.sendPacketHtml(packet,doQuery);
        	packet = null;
		}
		
		function loginAcceptSearch(){
            var packet = new AJAXPacket("fg982_ajax_loginAcceptSearch.jsp","���ڻ�����ݣ����Ժ�......");
        	packet.data.add("loginAccept",$('input[name="loginAccept"]').val());
        	packet.data.add("region_code",'<%=regionCode%>');
        	core.ajax.sendPacketHtml(packet,doQuery);
        	packet = null;
		}
		
		function queryInfo(){
		  var phone_brand = $('#phone_brand').val();//Ʒ��
      var phone_type = $('#phone_type').val();//�ͺ�
      var packet = new AJAXPacket("fg982_ajax_queryDel.jsp","���ڻ�����ݣ����Ժ�......");
    	packet.data.add("phone_brand",phone_brand);
    	packet.data.add("phone_type",phone_type);
    	packet.data.add("regionCode","<%=regionCode%>");
    	core.ajax.sendPacketHtml(packet,doQuery);
    	packet = null;
		}
		
    function doQuery(data){
      //�ҵ���ӱ���div
			var markDiv=$("#intablediv"); 
			markDiv.empty().append(data);
      var retCode = $("#retCode").val();
      var retMsg = $("#retMsg").val();
      if(retCode!="000000"){
        rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
        return false;
      }
    }
    
    /*************************ɾ���ύ��ť�¼�****************************/
    function subDelInfo(){
      var slecdelQryRadio =$("input[@name=delQryRadio][@checked]");
      if(typeof(slecdelQryRadio)=="undefined"){
        rdShowMessageDialog("��ѡ��һ�����ݽ��в�����",1);
        return false;
      }
  		var regionCode = $("input[@name=delQryRadio][@checked]").attr("v_regionCode");
  		var phone_brand = $("input[@name=delQryRadio][@checked]").attr("v_phoneBrand");
      var phone_type = $("input[@name=delQryRadio][@checked]").attr("v_phoneType");
      var begin_time = $("input[@name=delQryRadio][@checked]").attr("v_beginTime");
      var end_time = $("input[@name=delQryRadio][@checked]").attr("v_endTime");
      document.frm.action="fg982_del_cfm.jsp?regionCode="+regionCode+"&phone_brand="+phone_brand+"&phone_type="+phone_type+"&begin_time="+begin_time+"&end_time="+end_time;
      document.frm.submit();
      return true;
		}
	/*************************�����ťע���¼�****************************/
	function clearInfo(){
			$('#phone_brand').val("-1");
			//$('#phone_brand').change();
			changeBrand();
			$('#begin_time').val("");
			$('#end_time').val("");
	}
		
		
	function printCommit() {
	  //getAfterPrompt();
	  var begin_time = $("#begin_time").val();
	  var end_time = $("#end_time").val();
	  if($('#phone_brand').val()=="-1"){
		  rdShowMessageDialog("��ѡ���ֻ�Ʒ��!");
			$('#phone_brand').focus();
			return false;
		}
		if($('#phone_type').val()=="-1"){
		  rdShowMessageDialog("��ѡ���ֻ�����!");
			$('#phone_type').focus();
			return false;
		}
		if(!check(document.frm)){
			return false;
		}else{
		  hiddenTip(document.frm.begin_time);
		  hiddenTip(document.frm.end_time);
		}
		if(begin_time.substr(0,8)>end_time.substr(0,8))
    {
      rdShowMessageDialog("��ʼʱ��ӦС�ڽ���ʱ�䣬���������룡");
      return false;
    }
		
		if(frm.feefile.value.length<1){
			rdShowMessageDialog("�����ļ�����������ѡ�������ļ���");
			document.frm.feefile.focus();
			return false;
		}
		setOpNote();
		frmCfm();
	}
	
  function setOpNote(){
    if(document.all.remark.value==""){
      document.all.remark.value = "����Ա��<%=loginNo%>�������ʷ����ն˷���Ŀ���û�����"; 
    }
    return true;
  }
  
  function frmCfm(){
    var phone_brand = $('#phone_brand').val();
    var phone_type = $('#phone_type').val();
    var begin_time = $('#begin_time').val();
    var end_time = $('#end_time').val();
    var remark = $('#remark').val();
    document.frm.action="fg982_upFile.jsp?phone_brand="+phone_brand+"&phone_type="+phone_type+"&begin_time="+begin_time+"&end_time="+end_time+"&remark="+remark;
    document.frm.submit();
    return true;
  }
  
  function operFlags(obj){
    if(obj.value=="one"){ //����
      $("#regionTr").css("display","none");
      $("#timeTr").css("display","");
      $("#fileTr1").css("display","");
      $("#fileTr2,#brand").css("display","");
      //$('#reset_btn').click();
      clearInfo();
      $('#next_step').val("ȷ��");
      $("#intablediv").empty();
      $('#loginAccept').hide();
    }else if(obj.value=="two"){
      $("#regionTr,#brand").css("display","");
      $("#timeTr").css("display","none");
      $("#fileTr1").css("display","none");
      $("#fileTr2").css("display","none");
      //$('#reset_btn').click();
      clearInfo();
      $('#next_step').val("��ѯ");
      $("#intablediv").empty();
      $('#loginAccept').hide();
    } else if(obj.value=="search"){
      $("#regionTr,#brand").css("display","");
      $("#timeTr").hide();
      $("#fileTr1").css("display","none");
      $("#fileTr2").css("display","none");
      clearInfo();
      $('#next_step').val("��ѯ");
      $("#intablediv").empty();
      $('#loginAccept').hide();
    } else {
      $("#regionTr,#fileTr2").hide();
      $("#timeTr,#fileTr1,#brand").hide();
      clearInfo();
      $('#next_step').val("��ѯ");
      $("#intablediv").empty();
      $('#loginAccept').show();
    }
  }

//-->
</script>
</head>
<body>
  <form name="frm" method="post" action="fg982_upFile.jsp" ENCTYPE="multipart/form-data">
		<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
			<div id="title_zi"><span id="sale_name_span"></span><%=opName%></div>
		</div>
		<table cellspacing="0">
    	<tr> 
    		<td class="blue" width="20%">��������</td>
    		<td colspan="3">
    			<input type="radio" name="opFlag" value="one" checked onclick="operFlags(this)">����&nbsp;&nbsp;
    			<input type="radio" name="opFlag" value="two" onclick="operFlags(this)">ɾ��&nbsp;&nbsp;
    			<input type="radio" name="opFlag" value="search" onclick="operFlags(this)">������ѯ&nbsp;&nbsp;
    			<input type="radio" name="opFlag" value="loginAcceptSearch" onclick="operFlags(this)">��ˮ��ѯ&nbsp;&nbsp;
    		</td>
    	</tr>
    	
    	<tr id="regionTr" style="display:none"> 
    		<td class="blue" width="20%">����</td>
    		<td colspan="3">
    			<input type="text" name="region_code" id="region_code" value="" class="InputGrey" readonly />
    		</td>
    	</tr>
    	
		<tr id="brand"> 
			<td class="blue">�ֻ�Ʒ��</td>
			<td> 
				<select id="phone_brand" name="phone_brand" onchange="changeBrand()">
				</select>
				<font color="orange">*</font>
			</td>
			<td class="blue">�ֻ����� </td>
			<td> 
				<select id="phone_type" name="phone_type">
				</select>
				<font color="orange">*</font>
			</td>
		</tr>  
		
		<tr id="timeTr">
		  <td class="blue">��ʼʱ��</td>
			<td width="39%">
				<input type="text" name="begin_time" id="begin_time" size="20" maxlength="8" v_must="1" value=""  onClick="WdatePicker({startDate:'%y%M%d',dateFmt:'yyyyMMdd 00:00:00',readOnly:true,alwaysUseStartDate:true})">
				<font color="orange">*</font>
			</td>
			<td class="blue">����ʱ��</td>
			<td>
				<input type="text" name="end_time" id="end_time" size="20" maxlength="8" v_must="1" value="" onClick="WdatePicker({startDate:'%y%M%d',dateFmt:'yyyyMMdd 23:59:59',readOnly:true,alwaysUseStartDate:true})">
				<font color="orange">*</font>
			</td>
		</tr>
	
      <tr id="fileTr1"> 
        <td class="blue">�����ļ�</td>
        <td width="30%" colspan="3"> 
          <input type="file" name="feefile">
          <font color="orange">*</font>
        </td>
      </tr>
      <tr id="fileTr2"> 
        <td colspan="4">˵����<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">�����ļ�ΪTXT�ļ�</font>��<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">ע��������ȷ�ԣ��������ɴ����Ŀ���û�¼��</font>:<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�ֻ�����  �س�<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�磺 <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;13604511234 <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;13704511234 <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;13804511234 <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;13904511234 
        </td>
      </tr>
      
      <tr id="loginAccept" style="display: none;">
        <td class="blue">��ˮ</td>  
        <td colspan="3"><input type="text" value="" name="loginAccept"/></td>  
      </tr>
      
    	<tr> 
    		<td colspan="4" align="center" id="footer"> 
    			<input class="b_foot" type=button name="next_step" id="next_step" value="ȷ��" index="2" onclick="nextStep()">    
    			<input class="b_foot" type=button name="reset_btn" id="reset_btn" value="���" onclick="clearInfo()"/>
    			<input class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab();">
    		</td>
    	</tr>
    	
		 </table>
			<input type="hidden" name="opName" value="<%=opName%>">
			<input type="hidden" name="opCode" value="<%=opCode%>">
			<input type="hidden" name="remark" id="remark" value="">
			<div id="intablediv"></div>
		  <%@ include file="/npage/include/footer.jsp" %>
	</form>
</body>
</html>
