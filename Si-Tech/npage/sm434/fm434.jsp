<%
/********************

�������������������������ι�˾һ֤���������������ʾ liyang
 
 
 -------------------------��̨��Ա��liyang--------------------------------------------
 
********************/
%>
              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%
	String opCode    = WtcUtil.repNull(request.getParameter("opCode"));
  String opName    = WtcUtil.repNull(request.getParameter("opName"));
  
  String workNo     = (String)session.getAttribute("workNo");
  String password   = (String)session.getAttribute("password");
  String regionCode = (String)session.getAttribute("regCode");
  
	String currentDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
%> 
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="loginAccept" /> 

<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<SCRIPT language=JavaScript>



//����ˢ��ҳ��
function reSetThis(){
	  location = location;	
}



/*-------------------------------------------m414-----------------��ʼ------------------------------*/

var public_opCode = "";

function sm434_go_getAddr(bt){
		if($(bt).val().trim()=="") return;

	  var packet = new AJAXPacket("fm434_2.jsp","���Ժ�...");
        packet.data.add("idIccid",$(bt).val().trim());//
    core.ajax.sendPacket(packet,sm434_do_getAddr);
    packet =null;		
}
function sm434_do_getAddr(packet){
    var error_code = packet.data.findValueByName("code");//���ش���
    var error_msg =  packet.data.findValueByName("msg");//������Ϣ

    if(error_code!="000000"){//���÷���ʧ��
      rdShowMessageDialog(error_code+":"+error_msg);
	    return;
    }else{//�����ɹ�
    	var retArray =  packet.data.findValueByName("retArray");
    	if(retArray.length!=0){
    		if(retArray[0][0]!=""){
    			$("#custName").val(retArray[0][0]);
    		}
    	}
    }
}



//�ύ����
function sm434_go_Cfm(){

		if(!checkElement(document.msgFORM.idIccid)) return;
		if(!checkElement(document.msgFORM.custName)) return;
		 		
		if(!checkIccIdFunc16New(document.msgFORM.idIccid)) return;
		if(!checkCustNameFunc16New(document.msgFORM.custName)) return;
	
		if(rdShowConfirmDialog("ȷ��Ҫ�ύ��Ϣ��")!=1) return;
		

    var packet = new AJAXPacket("fm434_Cfm.jsp","���Ժ�...");
    		packet.data.add("iCustType",$("#idType").val());//
        packet.data.add("iCustId",$("#idIccid").val());//
        packet.data.add("iCustName",$("#custName").val());//
        packet.data.add("loginAccept","<%=loginAccept%>");//
        
        
    core.ajax.sendPacket(packet,sm434_do_Cfm);
    packet =null;		
}
function sm434_do_Cfm(packet){
    var error_code = packet.data.findValueByName("code");//���ش���
    var error_msg =  packet.data.findValueByName("msg");//������Ϣ

    if(error_code!="000000"){//���÷���ʧ��
      rdShowMessageDialog(error_code+":"+error_msg);
	    return;
    }else{//�����ɹ�
	    rdShowMessageDialog("�����ɹ�",2);
    	reSetThis();
    }
}
 
function rpc_chkX(x_type,x_no,chk_kind)
{
  var obj_type=document.all(x_type);
  var obj_no=document.all(x_no);
  var idname="";

  if(obj_type.type=="text")
  {
    idname=(obj_type.value).trim();
  }
  else if(obj_type.type=="select-one")
  {
    idname=(obj_type.options[obj_type.selectedIndex].text).trim();  
  }

  if((obj_no.value).trim().length>0)
  {
  	
   
      if(idname=="���֤")
    {
        if(checkElement(obj_no)==false) return false;
    }
  
  }
  else 
  return;
  var myPacket = new AJAXPacket("/npage/innet/chkX.jsp","������֤��������Ϣ�����Ժ�......");
    myPacket.data.add("retType","chkX");
    myPacket.data.add("retObj",x_no);
    myPacket.data.add("x_idType",getX_idno(idname));
    myPacket.data.add("x_idNo",obj_no.value);
    myPacket.data.add("x_chkKind",chk_kind);
    core.ajax.sendPacket(myPacket);
    myPacket=null;
  
}
function getX_idno(xx)
{
  if(xx==null) return "0";
  
  if(xx=="���֤") return "0";
  else if(xx=="����֤") return "1";
  else if(xx=="��ʻ֤") return "2";
  else if(xx=="����֤") return "4";
  else if(xx=="ѧ��֤") return "5";
  else if(xx=="��λ") return "6";
  else if(xx=="У԰") return "7";
  else if(xx=="Ӫҵִ��") return "8";
  else return "0";
}
function doProcess(packet)
{
    //RPC������findValueByName
    var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode"); 
    var retMessage = packet.data.findValueByName("retMessage"); 
    self.status="";
  if((retCode).trim()=="")
  {
       rdShowMessageDialog("����"+retType+"����ʱʧ�ܣ�");
       return false;
  }
    
   if(retType=="chkX")
   {
    var retObj = packet.data.findValueByName("retObj");
    if(retCode == "000000"){
        //rdShowMessageDialog("У��ɹ�111!",2);     
      }else if(retCode=="100001"){
        retMessage = retCode + "��"+retMessage;  
        rdShowMessageDialog(retMessage);     
        return true;
      }else{
        retMessage = "����" + retCode + "��"+retMessage;      
        rdShowMessageDialog(retMessage,0);
        return false;
       
    }
   }
    
  
}

function set_custInfo(){
	$("#idIccid").val("");
	$("#custName").val("");
}
</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi"><%=opName%><%=opCode%></div></div>

<table cellSpacing="0">
	<tr>
		  <td class="blue" width="15%">֤������</td>
		  <td width="35%">
			    	<input type = "hidden" name = "cust_type" id = "cust_type" value = "">
			    	<select id="idType" name = "idType" onchange="set_custInfo(this)">
						<option value = "8"> Ӫҵִ�� </option>
						<option value = "A"> ��֯�������� </option>
						<option value = "B"> ��λ����֤�� </option>
						<option value = "C"> ��λ֤�� </option>
						</select>
			    </select>
		  </td>
	</tr>
 
	<tr>
		  <td class="blue" width="15%">֤������</td>
		  <td width="35%"colspan="3" >
			   <input type="text"  value="" name="idIccid" id="idIccid" v_must="1" v_type="string"   onblur="if(checkIccIdFunc16New(this,0,0)){rpc_chkX('idType','idIccid','A');sm434_go_getAddr(this)}"   maxlength="20" />
		  </td>
	</tr>	  
	<tr>
		  <td class="blue" width="15%">�����ϱ��ͻ�����</td>
		  <td width="35%"colspan="3" >
			    <input type="text"  value="" name="custName" id="custName" v_must="1" v_type="string"   onblur="if(checkElement(this)){checkCustNameFunc16New(this,0,0)}" maxlength="256" size="80"/>
		  </td>
	</tr>
 
 	
</table>


<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="ȷ��" onclick="sm434_go_Cfm()"            />
	 		<input type="button" class="b_foot" value="����" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="�ر�" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>


			
<%@ include file="/npage/include/footer.jsp" %>
<%@ include file="/npage/include/public_smz_check.jsp" %>
</FORM>
</BODY>
</HTML>