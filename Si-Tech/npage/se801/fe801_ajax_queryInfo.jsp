<%
    /*************************************
    * ��  ��: ���ſͻ������� e801
    * ��  ��: version v1.0
    * ������: si-tech
    * ������: diling @ 2012-4-26
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.conn.*" %>
<%@ page import="com.sitech.boss.pub.exception.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%@ page import="java.util.ArrayList" %>
<%

	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
  String opCode = "e801";
	String opName = "���ſͻ�������";
	
	String unitId = request.getParameter("unitId");//��ѯ����
	 System.out.println("--------------e801-----unitId="+unitId);
%>

	<wtc:service name="sGrpInfoQry"  outnum="16" retcode="errcode" retmsg="errmsg" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="0" />
	<wtc:param value="01" />
	<wtc:param value="e801" />
	<wtc:param value="<%=workNo%>" />
	<wtc:param value="" />
	<wtc:param value="" />
	<wtc:param value="" />
	<wtc:param value="<%=unitId%>" />
	</wtc:service>
	<wtc:array id="result1" scope="end"/>
		

	<wtc:service name="s5082ListEXC"  outnum="20" retcode="errcode1" retmsg="errmsg1" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="0" />
	<wtc:param value="01" />
	<wtc:param value="e801" />
	<wtc:param value="<%=workNo%>" />
	<wtc:param value="" />
	<wtc:param value="" />
	<wtc:param value="" />
	<wtc:param value="<%=unitId%>" />
	</wtc:service>
	<wtc:array id="result3" start="0" length="20" scope="end"/>
<%
	System.out.println("result3.length: "+result3.length);
	System.out.println("errcode: "+errcode);
	
%>
<HEAD>
  <TITLE>������Ϣ��ѯ</TITLE>
</HEAD>
<script>
	function goBack(){
	  window.location.href="fe801_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	}
</script>
<% if (!"000000".equals(errcode) || result1[0][0].trim().equals("")) {%>
    <script language="javascript">
    	rdShowMessageDialog("û���ҵ��κ�����");
    	window.location.href="fe801_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
    </script>
<%}else{%>
<body>
<FORM method=post name="frme801_query">
<%@ include file="/npage/include/header.jsp" %>
<div id="Operation_Table">
  <div class="title">
  	<div id="title_zi">������Ϣ��ѯ</div>
  </div>
  <table cellspacing="0">
    <tr>
      <th></th>
      <th>�ͻ�����</th>
	    <th>��Ʒ����</th>
      <th>���ű�ţ�BOSS��unit_id��</th>
      <th>��Ʒ�˺�</th>
      <th>��Ʒ����</th>
      <th>�ͻ�����</th>
      <th>��Ʒ�ʷ�����</th>
    </tr>
  <%
	for(int y=0;y<result3.length;y++){
    String tdClass = "";
    if (y%2==0){
        tdClass = "Grey";
    }
  %>
	  <tr>
	    <td class="<%=tdClass%>"><input type="radio" id="queryRadio" name="queryRadio" value=""  v_idNo="<%=result3[y][1]%>" onclick="seleQryInfo(this)"  /></td>
	    <td class="<%=tdClass%>"><%=result1[0][1].equals("")?"&nbsp;":result1[0][1]%></td>
	    <td class="<%=tdClass%>"><%=result3[y][3].equals("")?"&nbsp;":result3[y][3]%></td>
	    <td class="<%=tdClass%>"><%=result1[0][0].equals("")?"&nbsp;":result1[0][0]%></td>
	    <td class="<%=tdClass%>"><%=result3[y][1].equals("")?"&nbsp;":result3[y][1]%></td>
	    <td class="<%=tdClass%>"><%=result3[y][2].equals("")?"&nbsp;":result3[y][2]%></td>
	    <td class="<%=tdClass%>"><%=result1[0][3].equals("")?"&nbsp;":result1[0][3]%></td>
	    <td class="<%=tdClass%>"><%=result3[y][10].equals("")?"&nbsp;":result3[y][10]%></td>
	   </tr>
  <%
    }
  %>
  </table>
</div>
<div>
  <div class="title">
    <div id="title_zi">ѡ���������</div>
  </div>
  <TABLE cellSpacing=0>
    <TR> 
        <td class="blue">��������</td>
        <td colspan="3">
            <input type="radio" name="operType" id="operTypeUpt" index="0" value="0"  onclick="changeType('0');" checked />�޸�����
            <input type="radio" name="operType" id="operTypeCover" index="1" value="1"  onclick="changeType('1');" />��������
        </td>
    </TR>
    <TR> 
      <td class="blue">�����Χ</td>
      <td>
        <select name="identityType" id="identityType" index="15" style="width:285px" onchange="cleanPass()" >
          <option value="00" selected >*��ѡ��*</option>
          <option value="01">ֻ�޸ļ��ſͻ�����</option>
          <option value="02">ֻ�޸ļ����û�����</option>
          <option value="03">�޸ļ��ſͻ�����(�������źͼ��������в�Ʒ����)</option>
        </select>
        <font class="orange">*</font>
      </td>
      <td  class="blue">ԭ����</td>
      <td>
        <jsp:include page="/npage/common/pwd_8.jsp">
            <jsp:param name="width1" value="16%"  />
            <jsp:param name="width2" value="34%"  />
            <jsp:param name="pname" value="oldPassword"  />
            <jsp:param name="pwd" value=""  />
        </jsp:include>
        <input type='button' class='b_text' id='chkPass' name='chkPass' onClick='check_HidPwd()' value='У��' />
        <font class="orange">*</font>
      </td>
    </TR>
    <TR id="newPassTr"> 
      <td  class="blue">������</td>
      <td>
         <input name="newPassword1" type="password"  id="newPassword1" v_type="0_9"  value=""  />
      </td>
      <td  class="blue">������ȷ��</td>
      <td>
         <input name="newPassword2" type="password"  id="newPassword2" v_type="0_9"  value=""  />
      </td>
    </TR>
  </TABLE>
  <table cellspacing=0>
    <tr id="footer"> 
      <td>
        <input class="b_foot" name="subUptBtn" id="subUptBtn" onClick="subUptPass()" type="button" value="ȷ��" />
        <input class="b_foot" name="back" onClick="goBack()" type="button" value="����" />
        <input class="b_foot" name="back" onClick="removeCurrentTab()" type="button" value="�ر�" />
      </td>
    </tr>
  </table>
</div>
<jsp:include page="/npage/common/pwd_comm.jsp"/>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
<script language="javascript">
  window.onload=function(){
    $("#subUptBtn").attr("disabled","true");
  }
  
  /*У��ԭ����*/
  function check_HidPwd(){
    var cust_id = "<%=result1[0][10]%>";
    var oldPassword = $("input[name='oldPassword']").val();
    
    var identityTypes = document.getElementById("identityType");
    var identityTypeVal;
    for(i=0;i<identityTypes.length;i++){            
      if(identityTypes[i].selected==true){             
        identityTypeVal = identityTypes[i].value;               
      }   
    }
    
    if(oldPassword==""){
      rdShowMessageDialog("������ԭ���룡",1);
  	  return false;
    }
    if(identityTypeVal=="00"){
      rdShowMessageDialog("��ѡ������Χ��",1);
      return false;
    }
    
    /*У�鼯�ſͻ�����*/
    if((identityTypeVal=="01")||(identityTypeVal=="03")){ 
      var checkPwd_Packet = new AJAXPacket("/npage/public/pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
      checkPwd_Packet.data.add("custType","02");				//01:�ֻ����� 02 �ͻ�����У�� 03�ʻ�����У��
      checkPwd_Packet.data.add("phoneNo",cust_id);	    //�ƶ�����,�ͻ�id,�ʻ�id
      checkPwd_Packet.data.add("custPaswd",oldPassword);	      //�û�/�ͻ�/�ʻ�����
  		checkPwd_Packet.data.add("idType","un");					        //en ����Ϊ���ģ�������� ����Ϊ����
  		checkPwd_Packet.data.add("idNum","");						          //����
  		checkPwd_Packet.data.add("loginNo","<%=workNo%>");		    //����
  		core.ajax.sendPacket(checkPwd_Packet, doCheckPwd);
  		checkPwd_Packet=null;
    }
    /*У�鼯���û�����*/
    else if(identityTypeVal=="02"){     
      if(isSeleQryFlay=="N"){
        rdShowMessageDialog("��ѡ���б��еļ����û���",1);
			  return false;
      }              
      var v_idNo = $("input[@name=queryRadio][@checked]").attr("v_idNo"); 
      var checkPwd_Packet = new AJAXPacket("/npage/s3691/pubCheckPwdIDC.jsp","���ڽ�������У�飬���Ժ�......");
      checkPwd_Packet.data.add("retType","checkPwd");
      checkPwd_Packet.data.add("idNo",v_idNo);
      checkPwd_Packet.data.add("Pwd1",oldPassword);
      core.ajax.sendPacket(checkPwd_Packet,doCheckUserPwd);
    }
  }
  
  var passValidateFlag = "N";
  function doCheckPwd(packet) {
		var retResult = packet.data.findValueByName("retResult");
		var msg = packet.data.findValueByName("msg");
		if (retResult != "000000") {
			rdShowMessageDialog(msg);
			return false;
		}else{
		  rdShowMessageDialog("У��ɹ���",2);
		  passValidateFlag = "Y";
		  $("#subUptBtn").attr("disabled","");
		}
	}
	
	function doCheckUserPwd(packet){
	  var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode");
    if(retType == "checkPwd") //���ſͻ�����У��
    {
      if(retCode == "000000")
      {
        var retResult = packet.data.findValueByName("retResult");
        if(retResult == "false"){
        	rdShowMessageDialog("�û�����У��ʧ�ܣ����������룡",0);
        	return false;	        	
        }else{
          rdShowMessageDialog("�û�����У��ɹ���",2);
          passValidateFlag = "Y";
          $("#subUptBtn").attr("disabled","");
        }
      }
      else{
        rdShowMessageDialog("�û�����У�����������У�飡",0);
  	    return false;
      }
    }
	}
	
	/*���ԭ����*/
	function cleanPass(){
	  $("input[name='oldPassword']").val("");
	}
  
  function changeType(obj){
    if(obj=="0"){ //�޸�
      $("#newPassTr").css("display","");
       $("input[name='oldPassword']").val("");
       $("input[name='oldPassword']").attr("disabled","");
      $("#chkPass").attr("disabled","");
      $("#subUptBtn").attr("disabled","true");
    }else if(obj=="1"){ //����
      $("#newPassTr").css("display","none");
      $("input[name='oldPassword']").val("");
      $("input[name='oldPassword']").attr("disabled","true");
      $("#chkPass").attr("disabled","true");
      $("#subUptBtn").attr("disabled","");
    }
  }
  
  var isSeleQryFlay = "N";
  /*ѡ�����޸�����Ĳ�Ʒ*/
  function seleQryInfo(obj){
    isSeleQryFlay = "Y";
  }
  
  /*�ύ�޸�����*/
  function subUptPass(){
    var newPassword1 = $("#newPassword1").val();
    var newPassword2 = $("#newPassword2").val();
    var slecOperType = $("input[@name=operType][@checked]").val();  //��������
    var oldPassword;
    var idNo;//ѡ�в�Ʒid
    var updateType; //�޸����ͣ�01-�����޸ģ�02-�������ã�
    
    var identityTypes = document.getElementById("identityType");
    var identityTypeVal;
    for(i=0;i<identityTypes.length;i++){            
      if(identityTypes[i].selected==true){             
        identityTypeVal = identityTypes[i].value;               
      }   
    }
    if(identityTypeVal=="00"){
      rdShowMessageDialog("��ѡ������Χ��",1);
      return false;
    }
    if(slecOperType=="0"){ //�޸�����
      oldPassword = $("input[name='oldPassword']").val();
      updateType = "01";
      if(passValidateFlag=="Y"){//��������֤ͨ��
        if(!checkElement(document.getElementById("newPassword1"))) return false;
        if(!checkElement(document.getElementById("newPassword2"))) return false;
        
        if(newPassword1==""||newPassword2==""){
          rdShowMessageDialog("�����������룡",1);
          return false;
        }
        if(newPassword1!=newPassword2){
          rdShowMessageDialog("�������벻һ�£������������룡",1);
          return false;
        }
      }
    }else if(slecOperType=="1"){ //��������
      oldPassword = "";
      updateType = "02";
      newPassword1="123123";
    }
    
     
    /*У�鼯�ſͻ�����*/
    if((identityTypeVal=="01")||(identityTypeVal=="03")){ 
      idNo = "";
    }
    /*У�鼯���û�����*/
    else if(identityTypeVal=="02"){
      if(isSeleQryFlay=="N"){
        rdShowMessageDialog("��ѡ���б��еļ����û���",1);
			  return false;
      }
      idNo = $("input[@name=queryRadio][@checked]").attr("v_idNo"); 
    }
    var packet = new AJAXPacket("/npage/se801/fe801_ajax_subUptPass.jsp","���ڽ�������У�飬���Ժ�......");
    packet.data.add("opCode","<%=opCode%>");	
		packet.data.add("updateType",updateType);		  
		packet.data.add("identityTypeVal",identityTypeVal);	
		packet.data.add("custId","<%=result1[0][10]%>");	
		packet.data.add("idNo",idNo);	
		packet.data.add("oldPassword",oldPassword);	
		packet.data.add("newPassword1",newPassword1);
		packet.data.add("slecOperType",slecOperType);
		core.ajax.sendPacket(packet, doSubUptPass);
		checkPwd_Packet=null;
  }
  
  function doSubUptPass(packet){
    var retCode = packet.data.findValueByName("retcode");
    var retMsg = packet.data.findValueByName("retmsg");
    var slecOperType = packet.data.findValueByName("slecOperType");
    if(retCode!="000000"){
      rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
      window.location.href="fe801_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
    }else{
      if(slecOperType=="0"){ //�޸�����
        rdShowMessageDialog("�����޸ĳɹ���",2);
        window.location.href="fe801_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
      }else{  //��������
        rdShowMessageDialog("�������óɹ���<br>����Ϊ123123.",2);
        window.location.href="fe801_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
      }
    }
  }
</script>
</BODY>
</HTML>
<%}%>