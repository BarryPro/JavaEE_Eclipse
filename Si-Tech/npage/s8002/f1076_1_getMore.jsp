<%
/********************
version v2.0
������: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.util.page.*"%>
<head>
	<title>����ҵ�����������Ʋ���</title>
<%
	String opCode = "1076";
	String opName = "����ҵ�����������Ʋ�������ѯ";
	String regionCode = (String)session.getAttribute("regCode");
	String loginNo = request.getParameter("loginNo");
	String groupId = request.getParameter("groupId");
	String searchNo = request.getParameter("searchNo");
	String timePoint = request.getParameter("timePoint");
	//���ڷ�ҳ
	int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	int iPageSize = 20;
	int iStartPos = (iPageNumber-1)*iPageSize;
	int iEndPos = iPageNumber*iPageSize;
	//��ѯ�ܹ�����
	String allNumSql = "SELECT COUNT (1) FROM sextransaction WHERE time_flag = '" + timePoint + "' AND login_no LIKE '%" + searchNo + "%'";
	//��ѯ������Ϣsql
	String searchSql = "SELECT * FROM (SELECT my_table.*, ROWNUM AS my_rownum FROM " + 
						"(SELECT login_no,op_code,limit_value,time_flag FROM sextransaction WHERE time_flag = '" + timePoint + 
						"' AND lower(login_no) LIKE lower('%" + searchNo + "%') ORDER BY login_no) my_table " +
         				"WHERE ROWNUM < " + iEndPos + ") WHERE my_rownum > " + iStartPos;
	System.out.println("searchSql : " + searchSql);
	String login_no = "";
	String op_code = "";
	String limit_value = "";
	String time_flag = "";
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="4">
		<wtc:sql><%=searchSql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="resultArr" scope="end" />
		
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="1">
		<wtc:sql><%=allNumSql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="allNum" scope="end" />
<%
	String[][] allNumStr = allNum;
	if(retCode1.equals("000000") && retCode1.equals("000000")){
		System.out.println("f1076_1_getMore.jsp ���� sPubSelect �ɹ�");
	}else{
	}
%>
<script language="javascript" type="text/javascript">
	var limitValueTemp = "";
	var serviceTemp = 0;
	function modifyInfo(i){
		var iloginNoStr = "#inputLoginNo" + i;
		var inputLoginNoObj = $(iloginNoStr);
		var iopCodeStr = "#inputOpCode" + i;
		var iopCodeObj = $(iopCodeStr);
		var ilimitValueStr = "#inputLimitValue" + i;
		var ilimitValueObj = $(ilimitValueStr);
		var itimeFlagStr = "#inputTimeFlag" + i;
		var itimeFlagObj = $(itimeFlagStr);
		
		var modifyBtnStr = "#modify" + i;
		var modifyBtnObj = $(modifyBtnStr);

		//�޸���ʽ
		
		if(modifyBtnObj.attr("var") == "update"){
			if($("input[var='commit']").length > 0){
				rdShowMessageDialog("���д����޸�״̬����");
				return false;
			}
			
			ilimitValueObj.removeClass("InputGrey");
			ilimitValueObj.removeAttr("readOnly");
			modifyBtnObj.attr("var","commit");
			modifyBtnObj.val("ȷ��");
			
			limitValueTemp = ilimitValueObj.val();
		}else{
			if(limitValueTemp == ilimitValueObj.val()){
				//û���������޸�
				rdShowMessageDialog("û�����޸�");
				limitValueTemp = "";
				serviceTemp = 1;
			}else{
				if(!checkElement(ilimitValueObj[0])){
					return false;
				}
				//��ʼ���÷����޸�
				var updatePacket = new AJAXPacket("f1076_1_modify.jsp","�����޸����ݣ����Ժ�......");
				updatePacket.data.add("timeFlagHid",itimeFlagObj.val());
				updatePacket.data.add("loginNoHid",inputLoginNoObj.val());
				updatePacket.data.add("opCodeHid",iopCodeObj.val());
				updatePacket.data.add("limitValueHid",ilimitValueObj.val());
				updatePacket.data.add("optypeHid","U");
				core.ajax.sendPacket(updatePacket);
				getdataPacket = null;
			}
				//���ȷ���޸���ʽ
				if(serviceTemp == 1){
					ilimitValueObj.addClass("InputGrey");
					ilimitValueObj.attr("readOnly","readOnly");
					modifyBtnObj.attr("var","update");
					modifyBtnObj.val("�޸�");
				}else{
					ilimitValueObj.val(limitValueTemp);
				}
		}
		
	}
	
	function deleteInfo(i){
		var iloginNoStr = "#inputLoginNo" + i;
		var inputLoginNoObj = $(iloginNoStr);
		var iopCodeStr = "#inputOpCode" + i;
		var iopCodeObj = $(iopCodeStr);
		var itimeFlagStr = "#inputTimeFlag" + i;
		var itimeFlagObj = $(itimeFlagStr);
		var ilimitValueStr = "#inputLimitValue" + i;
		var ilimitValueObj = $(ilimitValueStr);
		var showMsg = inputLoginNoObj.val() + " " + iopCodeObj.val() + " " + itimeFlagObj.val();
		if(rdShowConfirmDialog('ȷ��Ҫɾ��' + showMsg + '��')==1){
			//��ʼ���÷���ɾ��
			var updatePacket = new AJAXPacket("f1076_1_modify.jsp","�����޸����ݣ����Ժ�......");
			updatePacket.data.add("timeFlagHid",itimeFlagObj.val());
			updatePacket.data.add("loginNoHid",inputLoginNoObj.val());
			updatePacket.data.add("opCodeHid",iopCodeObj.val());
			updatePacket.data.add("limitValueHid",ilimitValueObj.val());
			updatePacket.data.add("optypeHid","D");
			core.ajax.sendPacket(updatePacket);
			getdataPacket = null;
			window.location.href=window.location.href; 
		}else{
			return false;
		}
	}
	
	function doProcess(packet){
		var retCode = packet.data.findValueByName("retcode");
		var retMsg = packet.data.findValueByName("retmsg");
		var result = packet.data.findValueByName("result");
		if(result == 1){
			//�޸ĳɹ�
			serviceTemp = 1;
			return true;
		}else{
			//�޸�ʧ��
			rdShowMessageDialog("����ʧ�ܣ�������룺" + retCode + "����ԭ��" + retMsg);
			serviceTemp = 0;
			return false;
		}
	}

</script>
</head>
<body>
<form name="getMoreFrm" method="POST" action="">
<div id="Operation_Table">
	<div class="title">
		<div id="title_zi">����ҵ�����������Ʋ�������ѯ</div>
	</div>
	<table cellspacing="0">
		<tr>
			<th>����</th>
			<th>��������</th>
			<th>��ֵ</th>
			<th>ʱ���</th>
			<th>����</th>
		</tr>
		<%
		for(int i = 0; i < resultArr.length; i++){
		%>
		<tr>
			<td>
				<input type="text" id="inputLoginNo<%=i%>" value="<%=resultArr[i][0]%>" 
						class="InputGrey" readOnly="readOnly" />
			</td>
			<td>
				<input type="text" id="inputOpCode<%=i%>" value="<%=resultArr[i][1]%>" 
						class="InputGrey" readOnly="readOnly" />
			</td>
			<td>
				<input type="text" name="lmt" id="inputLimitValue<%=i%>" value="<%=resultArr[i][2]%>" 
				class="InputGrey" readOnly="readOnly" v_type="0_9" v_must="1" v_maxvalue="9999" onblur="checkElement(this)" />
			</td>
			<td>
				<input type="text" id="inputTimeFlag<%=i%>" value="<%=resultArr[i][3]%>" 
						class="InputGrey" readOnly="readOnly" />
			</td>
			<td>
				<input type="button" id="modify<%=i%>" var="update" value="�޸�" 
						class="b_text" onclick="modifyInfo(<%=i%>)" />
				<input type="button" id="delete<%=i%>" value="ɾ��" class="b_text" onclick="deleteInfo(<%=i%>)" />
			</td>
		</tr>
		<%
		}
		%>
	</table>
	
	<%
	    int iQuantity = Integer.parseInt(allNumStr[0][0].trim());
	    Page pg = new Page(iPageNumber,iPageSize,iQuantity);
	    PageView view = new PageView(request,out,pg);
	%>
	
	<div style="position:relative;font-size:12px;" align="center">
	<%
	   	view.setVisible(true,true,0,0);
	%>
	</div>
</div>
</form>
</body>
</html>
