<%
  /*
   * ����: ������ò���ҳ��
�� * �汾: 1.0.0
�� * ����: 2008/10/14
�� * ����: mixh
�� * ��Ȩ: sitech
	 *update:
��*/
%>

<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
	<title>������ò���ҳ��</title>
	<link href="/nresources/default/css/main.css" rel="stylesheet" type="text/css" />
	<script>


	<%--------------------------------------------------------------------------%>
	/*�Է���ֵ���д���*/
	function doProcessInsert(packet)
	{
		alert("Begin call doProcessInsert()......");
		var retType = packet.data.findValueByName("retType");
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		alert(retType);
		alert(retCode);
		alert(retMsg);
		if(retType=="sK012insert"){
			if(retCode=="000000"){
				alert("���ʱ���¼�ɹ�!");
			}else{
				alert("���ʱ���¼ʧ��!");
				return false;
			}
		}
		alert("End call doProcessInsert()......");
	}
	
	/*�Է���ֵ���д���*/
	function doProcessUpd(packet)
	{
		alert("Begin call doProcessUpd()......");
		var retType = packet.data.findValueByName("retType");
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		alert(retType);
		alert(retCode);
		alert(retMsg);
		if(retType=="sK012upd"){
			if(retCode=="000000"){
				alert("���ʱ����³ɹ�!");
			}else{
				alert("���ʱ�����ʧ��!");
				return false;
			}
		}
		alert("End call doProcessUpd()......");
	}	

	/**/
	function sK012insert()
	{
		alert("Begin call sK012insert()....");
		setRestId();
		var restId = document.getElementById("restId").value;
		alert("--------> " + restId);
	    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/K012/K012_insert.jsp","...");
	    chkPacket.data.add("retType", "sK012insert");
	    chkPacket.data.add("id", restId);
	    chkPacket.data.add("rest_login_no", "106");
	    chkPacket.data.add("current_status", "8");
	    chkPacket.data.add("staffstatus", "8");
	    chkPacket.data.add("checkno", "106");
	    chkPacket.data.add("ccsworkno", "106");
	    chkPacket.data.add("kf_no", "106");
	    chkPacket.data.add("kf_name", "106");
	    chkPacket.data.add("class_id", "1");
	    chkPacket.data.add("org_id", "1");
	    chkPacket.data.add("duty", "1");
	    chkPacket.data.add("op_code", "K103"); 	    	    	    	    

	    core.ajax.sendPacket(chkPacket,doProcessInsert,true);
		chkPacket =null;
		alert("End call sK012insert()....");
	}
	
	/**/
	function sK012upd()
	{
		alert("Begin call sK012upd()....");
		var restId = document.getElementById("restId").value;
		alert("--------> " + restId);
	    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/K012/K012_upd.jsp","...");
	    chkPacket.data.add("retType", "sK012upd");
	    chkPacket.data.add("id", restId);
	    chkPacket.data.add("rest_login_no", "106");
	    chkPacket.data.add("current_status", "1");
	    chkPacket.data.add("staffstatus", "1");
	    chkPacket.data.add("checkno", "106");
	    chkPacket.data.add("ccsworkno", "106");
	    chkPacket.data.add("kf_no", "106");
	    chkPacket.data.add("kf_name", "106");
	    chkPacket.data.add("class_id", "1");
	    chkPacket.data.add("org_id", "1");
	    chkPacket.data.add("duty", "1");
	    chkPacket.data.add("op_code", "K103"); 	 
	    
	    core.ajax.sendPacket(chkPacket,doProcessUpd,true);
		chkPacket =null;
		alert("End call sK012upd()....");
	}
	
	/*�Է���ֵ���д���*/
	function doProcessSetRestId(packet)
	{
		//alert("Begin call doProcessGetRestId()......");
		var retType = packet.data.findValueByName("retType");
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		var restId = packet.data.findValueByName("restId");
		if(retType=="getRestId"){
			if(retCode=="000000"){
				document.getElementById("restId").value = restId;
				//alert("-------------> " + document.getElementById("restId").value);
			}else{
				return false;
			}
		}
		//alert("End call doProcessGetRestId()......");
	}		
	
	function setRestId(){
		//alert("Begin call setRestId()....");
	    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/K012/get_rest_id.jsp","���ڻ�ȡ����������Ϣ,���Ժ�...");
	    chkPacket.data.add("retType", "getRestId");
	    //core.ajax.sendPacket(chkPacket);
	    core.ajax.sendPacket(chkPacket,doProcessSetRestId,false);
		chkPacket =null;
		//alert("End call setRestId()....");		
	}
	<%--------------------------------------------------------------------------%>
	</script>
</head>

<body>
<form action="" method="post" id="passwordForm">
<input type="hidden" name="restId" id="restId" value=""/>
		<table width="400" border="0" align="center" cellpadding="0" cellspacing="0">
			<tr>
				<td height="25" class="basicinfo_bg">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td class="title_boldtext">
								������ò���
							</td>
							<td width="100%">
								&nbsp;
							</td>
							<td class="basic_arrow">
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>

		<table cellpadding="0" cellspacing="0" border="0" width="100%">
		    <tr>
		        <td height="2"></td>
		    </tr>
		</table>
			<table width="400" align="center" border="0" cellpadding="5" cellspacing="5" class="table_listoutline" style="display: black;">
				<tr>
					<td colspan="2" align="center">
						<input type="button" value="���"   onClick="sK012insert()" />
						<input type="button" value="���ʱ�䵽" onClick="sK012upd()"/>
						<input type="button" value="��������ˮ" onClick="setRestId()"/>
					</td>
				</tr>
			</table>
		</form>

</html>
