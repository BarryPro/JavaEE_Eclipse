<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	/*
	 * ����: �ۺ�V����Ա��ѯ
	 * �汾: v1.0
	 * ����: 2009��08��06��
	 * ����: wangzn
	 * ��Ȩ: sitech
	 */
%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page contentType="text/html; charset=GBK"%>
<%
	response.setHeader("Pragma", "No-Cache");
	response.setHeader("Cache-Control", "No-Cache");
	response.setDateHeader("Expires", 0);
	String workName = (String) session.getAttribute("workName");
	String ipAddr = (String) session.getAttribute("ipAddr");
	String orgCode = (String) session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0, 2);
	String districtCode = orgCode.substring(2,4);
	String opCode = "5891";
	String opName = "�ۺ�V����Ա��ѯ";
	String sqlStr = "";
%>

<HTML xmlns="http://www.w3.org/1999/xhtml">
<html>

	<link href="s2002.css" rel="stylesheet" type="text/css">
	<script language="JavaScript">

	function doProcess(packet){
		
		error_code = packet.data.findValueByName("errorCode");
		error_msg  = packet.data.findValueByName("errorMsg");
		verifyType = packet.data.findValueByName("verifyType");
		var backArrMsg = packet.data.findValueByName("backArrMsg");     
		self.status="";
		if(verifyType=="GroupNo"){
			if(backArrMsg==""){
				rdShowMessageDialog("���ۺ�V������",0);
				document.getElementById('nextoper').disabled = true;		
			}else{
				var temp = backArrMsg+"";
				
				var region_code = temp.split(",")[1];
				var district_code = temp.split(",")[2];
				if(region_code != '<%=regionCode%>' || district_code !='<%=districtCode%>' ){
					rdShowMessageDialog("��û��Ȩ�޲鿴�ü���!",0);
				  document.getElementById('nextoper').disabled = true;	
				  return;	
				}
				document.getElementById('nextoper').disabled = false;
				document.getElementById('group_no').readOnly="readOnly";
			}	
		}
	}

	function checkGroupNo()
	{
		var myPacket = new AJAXPacket("s5891_1.jsp","���ڼ���group_no�����Ժ�......");				      			    
		var groupNo = document.getElementById('group_no').value.trim();
		if(groupNo==""){
				     	rdShowMessageDialog("���ű�Ų���Ϊ��",0);
				     	document.getElementById('nextoper').disabled = true;
				     	return false;
		}
		myPacket.data.add("groupNo",groupNo);
		myPacket.data.add("verifyType","GroupNo");
		core.ajax.sendPacket(myPacket);	
		myPacket=null;	
	}
	function disInfo(){
		var but = document.getElementById('nextoper');
		if(but.disabled){
			//��֤Ϊͨ�����������һЩ��ʾ��Ϣ��˵������һ��������֤�ɹ�����Ч��
		}
	}
</script>
	</head>
	<body>
		<form name="form1" method="post" action="s5891_2.jsp">
			<input type="hidden" name="pageOpCode" value="<%=opCode%>">
			<input type="hidden" name="pageOpName" value="<%=opName%>">
			<input type="hidden" id="grpIdNo" name="grpIdNo" value="">
			<input type="hidden" name="productSpecNum" value=""><%@ include
				file="/npage/include/header.jsp"%>
			<div class="title">
				<div id="title_zi">
					��ѯ����
				</div>
			</div>
			<table cellSpacing=0>
				<tr>
					<td class="blue" width="15%">
						���ű��
					</td>
					<td width="35%">
						<input name="group_no" id="group_no" v_type="string" v_must="1"
							size="20" maxlength="20">
						<font class="orange">*</font>
						<input name="CustomerNumberQuery" type="button" class="b_text"
							onclick="checkGroupNo()" id="getCustomerNumberBtn" value="��֤">
					</td>
					<td class="blue" width="15%">
						��Ӫ������
					</td>
					<td width="35%">
						<select name=phone_type id=phone_type>
							<option value=0>
								�ƶ�
							</option>
							<option value=1>
								��ͨ
							</option>
						</select>
						<input type="hidden" value="" name="orderSourceName">
					</td>
				</tr>

				
				<tr style="display: none">
				<td class="blue" rowspan="4" colspan="2" align="center">�б�������ʾ</td>
				<td class="blue"><input type="checkbox" name="disProperty" value="region">����</td><td class="blue"><input type="checkbox" name="disProperty" value="district">����</td>
				</tr>
				<tr style="display: none">
				<td class="blue"><input type="checkbox" name="disProperty" value="service_no">�ͻ�����</td><td class="blue"><input type="checkbox" name="disProperty" value="group_id">���ű��</td>
				</tr>
				<tr style="display: none">
				<td class="blue"><input type="checkbox" name="disProperty" value="group_name">��������</td><td class="blue"><input type="checkbox" name="disProperty" value="field_value">�ۺ�V������</td>
				</tr>
				<tr style="display: none">
				<td class="blue"><input type="checkbox" name="disProperty" vaule="phone_no">�ֻ�����</td><td class="blue">&nbsp;</td>
				</tr>
				
				
				<tr>
					<td align="center" id="footer" colspan="4">
						<a onmouseover="disInfo();"><input class="b_foot" name=next id=nextoper type=submit
							value="��һ��" disabled></input></a>
						<input class="b_foot" name=res id=res type="reset"
							value="����"
							onclick="document.getElementById('group_no').readOnly=false;document.getElementById('nextoper').disabled = true;"></input>
						<input class="b_foot" name=reset type=button value="�ر�"
							onClick="removeCurrentTab()" />
					</td>
				</tr>
			</table>
			<%@ include file="/npage/include/footer.jsp"%>
		</form>
	</body>
</html>
