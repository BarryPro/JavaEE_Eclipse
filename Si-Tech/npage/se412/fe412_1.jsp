<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<head>
	<%
   response.setHeader("Pragma","No-cache");
   response.setHeader("Cache-Control","no-cache");
   response.setDateHeader("Expires", 0);
		String opCode = request.getParameter("opCode");
		String opName = request.getParameter("opName");
		String regionCode= (String)session.getAttribute("regCode");
		String workNo = (String)session.getAttribute("workNo");
		String sqlsl ="select id_type,id_name from sidtype";
		
		%>
				<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="RetCode3" retmsg="RetMsg3" outnum="2">
			<wtc:sql><%=sqlsl%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="rets1" scope="end" />
		<script language="javascript">
			function srenzhe() {
								var si =document.frm.renzhengtype.value;
							if(si=="0") {
              document.all.zjcar.style.display = "block";
              document.all.zjcarqt.style.display = "none";
	  	        }else {
	  	        hiddenTip(document.all.idcardqt);
							document.all.zjcar.style.display = "none";
							document.all.zjcarqt.style.display = "block";
	  	      	}
			}
		function quechoosee() {
				var phones = document.frm.phoneNo.value;
				var phoneNames = document.frm.bp_name.value;
				var renzhengtypes = document.frm.renzhengtype.value;
				var idcards = document.frm.idcard.value;
				var idcardqts = document.frm.idcardqt.value;
				var lxrphoneNos = document.frm.lxrphoneNo.value;
				var lianxiren_names = document.frm.lianxiren_name.value;
				var yucunmoneys = document.frm.yucunmoney.value;
				var ykh_workNos = document.frm.ykh_workNo.value;
				var khdayss = document.frm.khdays.value;
				var spr_workNos = document.frm.spr_workNo.value;
				var do_notes = document.frm.do_note.value;				
			
				if(phones.trim()=="") {
					rdShowMessageDialog("Ԥ�����ֻ����벻��Ϊ��!");
					return false;
				}
				if(phoneNames.trim()=="") {
					rdShowMessageDialog("�ͻ���������Ϊ��!");
					return false;
				}
				if(renzhengtypes.trim()=="0") {
					if(idcards.trim()=="") {
						rdShowMessageDialog("���֤�Ų���Ϊ��!");
						return false;
					}
				}
			  if(renzhengtypes.trim()!="0") {
					if(idcardqts.trim()=="") {
						rdShowMessageDialog("֤���Ų���Ϊ��!");
						return false;
					}
				}
				if(lxrphoneNos.trim()=="") {
						rdShowMessageDialog("��ϵ�˺��벻��Ϊ��!");
						return false;
				}
				if(lianxiren_names.trim()=="") {
						rdShowMessageDialog("��ϵ����������Ϊ��!");
						return false;
				}
				if(yucunmoneys.trim()=="") {
						rdShowMessageDialog("Ԥ����Ϊ��!");
						return false;
				}
				if(ykh_workNos.trim()=="") {
						rdShowMessageDialog("Ԥ�������Ų���Ϊ��!");
						return false;
				}
				if(khdayss.trim()=="") {
						rdShowMessageDialog("������Ч�ڣ�����������Ϊ��!");
						return false;
				}
				if(spr_workNos.trim()=="") {
						rdShowMessageDialog("�����˹��Ų���Ϊ��!");
						return false;
				}
				if(do_notes.trim()=="") {
						document.frm.do_note.value="���������������������Ϊ<%=workNo%>��";
						return false;
				}
			var oButton = document.getElementById("quchoose"); 
			oButton.disabled = true;
			
			var getdataPacket = new AJAXPacket("fe412_confirm.jsp","���ڻ�ò�������·�������Ժ�......");
			getdataPacket.data.add("phoneNo",phones);
			getdataPacket.data.add("bp_name",phoneNames);
			getdataPacket.data.add("renzhengtype",renzhengtypes);
			getdataPacket.data.add("idcard",idcards);
			getdataPacket.data.add("idcardqt",idcardqts);
			getdataPacket.data.add("lxrphoneNo",lxrphoneNos);
			getdataPacket.data.add("lianxiren_name",lianxiren_names);
			getdataPacket.data.add("yucunmoney",yucunmoneys);
			getdataPacket.data.add("ykh_workNo",ykh_workNos);
			getdataPacket.data.add("khdays",khdayss);
			getdataPacket.data.add("spr_workNo",spr_workNos);
			getdataPacket.data.add("do_note",do_notes);
			getdataPacket.data.add("opCode","<%=opCode%>");
			core.ajax.sendPacket(getdataPacket);
			getdataPacket = null;	
		}
			function doProcess(packet){
			var retCode = packet.data.findValueByName("retcode");
			var retMsg = packet.data.findValueByName("retmsg");
			var oButton = document.getElementById("quchoose"); 
			if(retCode == "000000"){
			rdShowMessageDialog("�����ɹ���",2);
			oButton.disabled = false;
			doReset();
			}else{
				rdShowMessageDialog("����ʧ�ܣ� ������룺" + retCode + "��������Ϣ��" + retMsg,0);
				oButton.disabled = false;
				return false;
			}
		}
				function doReset(){
				document.frm.phoneNo.value="";
				document.frm.bp_name.value="";
				
				document.frm.idcard.value="";
				document.frm.idcardqt.value="";
				document.frm.lxrphoneNo.value="";
				document.frm.lianxiren_name.value="";
			 document.frm.yucunmoney.value=""
				document.frm.ykh_workNo.value=""
				document.frm.khdays.value=""
				document.frm.spr_workNo.value=""
				document.frm.do_note.value=""
		} 
		</script>
		<body>
		<form name="frm" method="POST" action="">
	<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	      <table cellspacing="0" >
		  <tr>
		    <td class="blue" width="15%">Ԥ�����ֻ�����</td>
		    <td width="35%">
		  <input name="phoneNo" type="text"   id="phoneNo" value=""  v_type="mobphone" onblur="checkElement(this)" maxlength="11">
		  <font class="orange">*</font>
		</td>
				    <td class="blue" width="15%">�ͻ�����</td>
            <td>
			  <input name="bp_name" type="text"   id="bp_name" value=""  >
			   <font class="orange">*</font>
			</td>
	</tr>
			  <tr>
		    <td class="blue" width="15%">֤������</td>
		    <td>
		 				<select id="renzhengtype" name="renzhengtype" style="width:130px;" onChange="srenzhe()">
           <%
           String selectse="";
        	for(int i=0;i<rets1.length; i++){
        	if(rets1[i][0].equals("0")) {
        		selectse=" selected";
        	}
          else {
          	selectse="";
        	}
			    out.println("<option class='button' value='"+rets1[i][0]+"' "+selectse+">"+rets1[i][1]+"</option>");
			    }
		      %>
						</select>
						

		</td>
		<td class="blue" width="15%">֤������</td>
		<td id="zjcar" style="display:block">
			<input name="idcard" type="text"   id="idcard" value=""  v_type="idcard" onblur="checkElement(this)">
			<font class="orange">*</font>
		</td>
				<td id="zjcarqt" style="display:none">
			<input name="idcardqt" type="text"   id="idcardqt" value=""  >
			<font class="orange">*</font>
		</td>
	</tr>
		  <tr>
		    <td class="blue" width="15%">��ϵ�˵绰</td>
		    <td width="35%">
		  <input name="lxrphoneNo" type="text"   id="lxrphoneNo" value=""  v_type="phone" onblur="checkElement(this)">
		  <font class="orange">*</font>
		</td>
				    <td class="blue" width="15%">��ϵ������</td>
            <td>
			  <input name="lianxiren_name" type="text"   id="lianxiren_name" value=""  >
			   <font class="orange">*</font>
			</td>

	</tr>
			  <tr>
		    <td class="blue" width="15%">Ԥ���</td>
		    <td width="35%">
		  <input name="yucunmoney" type="text"   id="yucunmoney" value=""  v_type="money" onblur="checkElement(this)">
		  <font class="orange">*</font>
		</td>
						    <td class="blue" width="15%">Ԥ��������</td>
            <td>
			  <input name="ykh_workNo" type="text"   id="ykh_workNo" value=""  maxlength="6">
			   <font class="orange">*</font>
			</td>

	</tr>
				  <tr>
		    <td class="blue" width="15%">������Ч�ڣ�������</td>
		    <td  >
		  <input name="khdays" type="text"   id="khdays" value=""  v_type="0_9" onblur="checkElement(this)">
		  <font class="orange">*</font>
		</td>
						    <td class="blue" width="15%">�����˹���</td>
            <td>
			  <input name="spr_workNo" type="text"   id="spr_workNo" value=""  maxlength="20">
			   <font class="orange">*</font>
			</td>
	</tr>
					 
	         <tr> 
				   <td class="blue"  width="20%">������ע</td>
				    <td colspan="3"> 
				   <input name="do_note" type="text" class="button" id="do_note" value="" size="60" maxlength="30" >
				     </td>
			   
	
	</tr>
</table>
 
	 	<table cellspacing="0">
		<tr>
			<td noWrap id="footer">
			<div align="center">
					<input type="button"  name="quchoose" class="b_foot" value="ȷ��" onclick="quechoosee()" />		
				&nbsp;
				<input name="back" onClick="history.go(-1)" type="button" class="b_foot"  value="����">
				&nbsp;
				<input type="button" name="close" class="b_foot" value="�ر�" onClick="removeCurrentTab();"/>
			</div>
			</td>
		</tr>
	</table>
		    
 <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>