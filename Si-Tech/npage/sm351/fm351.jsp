<%
/********************
 version v2.0
������: si-tech
create by wanglm 20110321
********************/
%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
  request.setCharacterEncoding("GBK");
  String opCode = (String)request.getParameter("opCode");
  String opName = (String)request.getParameter("opName");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=opName%></title>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String current_timeNAME=new SimpleDateFormat("yyyyMMdd HH:mm:ss", Locale.getDefault()).format(new java.util.Date());
%>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
	
	  onload=function()
  {
		checkadd();
		document.all.querysss.disabled=true;
	  document.all.quchoose.disabled=false;	
  
  }
  

	function getFileName(obj){
		var pos = obj.lastIndexOf("\\");
		return obj.substring(pos+1);
	}
	function getFileExt(obj)
	{
	    var pos = obj.lastIndexOf(".");
	    return obj.substring(pos+1);
	}
 function doCfm(){	     

 			 	if(form1.feefile.value.length<1){
					rdShowMessageDialog("���ϴ��ļ�!");
					document.form1.feefile.focus();
					return false;
				}
		 		//var fileVal = getFileName($("#feefile").val());
		 		var fileVal = getFileExt($("#feefile").val());
				if("txt" == fileVal){
					//��չ����txt
				}else{
					rdShowMessageDialog("�ϴ��ļ�����չ������ȷ,ֻ���Ǻ�׺Ϊtxt�����ļ���",0);
					return false;
				}
				document.all.querysss.disabled=true;
				document.form1.action = "fm351Cfm.jsp";
   			document.form1.submit();
 }

 	function resetPage(){
 		window.location.href = "f<%=opCode%>.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	}
	function checkadd(){
			
		 $("#phoneNo").val("");
	   $("#qPhoneNogh").val("");
     $("#qPhoneNo").val("");
     $("#qCustName").val("");
		
	     var obj = document.getElementsByName("radio") ;
	     for(var t=0;t<obj.length;t++){
		 if(obj[t].checked){
				if(obj[t].value=="0") {
					$("#zengjia").show();
					$("#showTab").hide();
					$("#fileUpLoad").hide();
		document.all.querysss.disabled=true;
	  document.all.quchoose.disabled=false;						
				}else {
					$("#zengjia").hide();
					$("#showTab").hide();
					$("#fileUpLoad").show();
		document.all.querysss.disabled=false;
	  document.all.quchoose.disabled=true;						
				}
		   }
	     }
	}
	
	
	 function chk_Phone() {
 
 				var phoneNo = $("#phoneNo").val();
				if(phoneNo.trim()=="") {
						rdShowMessageDialog("������̻�������в�ѯ��");
						return false;
				}

     $("#qPhoneNogh").val("");
     $("#qPhoneNo").val("");
     $("#qCustName").val("");
     
 
 	var myPacket = new AJAXPacket("ajax_phoneNomsg.jsp","���ڲ�ѯ��Ϣ�����Ժ�......");
	myPacket.data.add("phoneNo",phoneNo);

	core.ajax.sendPacket(myPacket,querinfo,true);
	myPacket = null;
	
 }
 
 function querinfo(packet){
	var errorCode = packet.data.findValueByName("retCode");
	var returnMsg = packet.data.findValueByName("retMsg");
	if(errorCode != "000000"){
		rdShowMessageDialog("��ѯ��Ϣʧ�ܣ�"+errorCode + ":"+returnMsg,0);
		return false;
	}else{
	var phoneNo = packet.data.findValueByName("phoneNo");
	var qPhoneNo = packet.data.findValueByName("qPhoneNo");
	var qCustName = packet.data.findValueByName("qCustName");
		//rdShowMessageDialog("У��ɹ�",2);
		$("#showTab").show();
     $("#qPhoneNogh").val(phoneNo);
     $("#qPhoneNo").val(qPhoneNo);
     $("#qCustName").val(qCustName);
	}
}


	
		
		//�޸�����
function updInfo(){

			if($("#qPhoneNogh").val()==""){
					rdShowMessageDialog("���Ȳ�ѯ���ٽ����޸Ĳ�����");
					return false;
			}

			if(!checkElement(document.all.qPhoneNo)){
		  return false;
	    }	
	    if(!checkElement(document.all.qCustName)){
		  return false;
	    }			
		
		
		if(rdShowConfirmDialog('ȷ��Ҫ�޸���Ϣ��')==1){
					   var qPhoneNoghs =  $("#qPhoneNogh").val();
					   var qPhoneNos =  $("#qPhoneNo").val();
					   var qCustNames =  $("#qCustName").val();
					   
									var packet = new AJAXPacket("fm351_ajax_subInfo.jsp","���ڻ�����ݣ����Ժ�......");
                	packet.data.add("qPhoneNoghs",qPhoneNoghs);
                	packet.data.add("qPhoneNos",qPhoneNos);
                	packet.data.add("qCustNames",qCustNames);
                	core.ajax.sendPacket(packet,doSubInfo);
                	packet = null;
     }
		
	}
	
	            function doSubInfo(packet)
            {
                var retCode = packet.data.findValueByName("retCode");
                var retMsg = packet.data.findValueByName("retMsg");
                if(retCode=="000000"){
                  rdShowMessageDialog("�޸ĳɹ���",2);
                  window.location.href = "f<%=opCode%>.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
                }else{
                	rdShowMessageDialog("�޸�ʧ�ܣ�������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
                }
            }

 
</script>
</head>
<body>
<form name="form1" id="form1" method="POST" ENCTYPE="multipart/form-data">
<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
      <table cellspacing="0">

		<tr>
			<td class="blue" width="13%">��������</td>
			<td ><input type="radio" name="radio" value="0" checked  onclick="checkadd()" />������ѯ�����
			    <input type="radio" name="radio" value="1" onclick="checkadd()" />�������	
			</td>
		</tr>
		<tr id="zengjia">
			    <td class="blue" width="13%"> �̻�����</td>
						<td >
							<input type="text" id="phoneNo" name="phoneNo"  maxlength="11"/>
							<font class="orange">*</font> 
							<input type="button" name="chkPhone" id="chkPhone" value="��ѯ" 
							 class="b_text"  onClick="chk_Phone()" >  
						</td>
		</tr>
		<tr colspan="2"></tr>
		
	</table>
	
				<table cellspacing="0" id="showTab">           
		    <tr>
		    	<td class="blue" width="13%">�̻�����</td>
		    	<td width="13%">
			    	<input type="text" id="qPhoneNogh" name="qPhoneNogh" class="InputGrey" readonly/>		    		
		    	</td>		    	
		    	<td class="blue" width="13%">��ϵ�绰</td>
		    	<td width="15%">
			    	<input type="text" id="qPhoneNo" name="qPhoneNo" value="" v_must="1" v_type="mobphone"  maxlength="11" onblur="if(checkElement(this)){}"/>		    		
			    	<font class=orange>*</font>
		    	</td>
		    	<td class="blue" width="13%">��ϵ��</td>
		    	<td width="33%">
			    	
			    	<input name=qCustName id=qCustName class="button" value="" v_type="string"  maxlength="60" size=40  v_must=1 v_maxlength=60 onblur="if(checkElement(this)){}"/>
			    	<font class=orange>*</font>
		    	</td>
		    </tr>
			</table>


	
	<table id="fileUpLoad">
		<tr >
			<td class="blue" width="13%">
				�ļ��ϴ�
			</td>
			<td width="30%">
				<input type="file" name="feefile" id="feefile">
			</td>
			<td class="blue" width="13%">
				�ļ��ϴ�˵��
			</td>
			<td>
				<span>
					�����ļ�����Ϊ<font color="red">txt</font>��ʽ��ÿ�м�¼ΪIMS�̻�����|��ϵ�绰|��ϵ������<br />
					һ��������100����¼,������֮�䲻������ڿ��С�<br />
					&nbsp;�磺<br />
					&nbsp;&nbsp;&nbsp;456852562|13800388300|��Ʒ�<br />
					&nbsp;&nbsp;&nbsp;456852563|13800388301|��Ʒ�<br />
			</span>
			</td>
		</tr>

      </table>
              <table cellspacing="0">
          <tr>
            <td noWrap id="footer">
              <div align="center">	
              <input type="button" name="updBtn" id="quchoose"  class="b_foot" value="�޸�" onclick="updInfo()">
              <input class="b_foot" type=button name="querysss" value="�����ύ" onClick="doCfm(this)" index="2">
              <input class="b_foot" type=button name=back value="���" onClick="resetPage()">
		      <input class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab()">
              </div>
            </td>
          </tr>
        </table>
      <input type="hidden" name="flag" id="flag" />
    <%@ include file="/npage/include/footer_simple.jsp"%>
   </form>
</body>
</html>