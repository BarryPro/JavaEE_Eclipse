<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	/*
	 * ����: �ۺ�V����Ա��ѯ
	 * �汾: v1.0
	 * ����: 2009��08��11��
	 * ����: wangzn
	 * ��Ȩ: sitech
	 */
%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="java.util.*"%>
<%@ page contentType="text/html; charset=GBK"%>
<%
	response.setHeader("Pragma", "No-Cache");
	response.setHeader("Cache-Control", "No-Cache");
	response.setDateHeader("Expires", 0);
	String workName = (String) session.getAttribute("workName");
	String ipAddr = (String) session.getAttribute("ipAddr");
	String orgCode = (String) session.getAttribute("orgCode");
	
	//orgCode = "0206001xp";
	
	String regionCode = orgCode.substring(0,2);
	String districtCode = orgCode.substring(2,4);
	String opCode = "4084";
	String opName = "�ۺ�V�����Ų�ѯ";
	String sqlStr = "";
%>
<wtc:pubselect name="sPubSelect" routerKey="region"
	routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg"
	outnum="3">
	<wtc:sql>select region_code,district_code,district_name from sdiscode order by district_code</wtc:sql>
</wtc:pubselect>
<wtc:array id="disCodes" scope="end" />
<wtc:pubselect name="sPubSelect" routerKey="region"
	routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg"
	outnum="2">
	<wtc:sql>select region_code,region_name from sregioncode order by region_code</wtc:sql>
</wtc:pubselect>
<wtc:array id="regionCodes" scope="end" />

<HTML xmlns="http://www.w3.org/1999/xhtml">
	<script language="JavaScript">
	var allDisCodes
	var allDisCodeArr;
	function initDisCode(){
		 allDisCodes = '<%for (int i = 0; i < disCodes.length; i++) {%><%=disCodes[i][0]%>~<%=disCodes[i][1]%>~<%=disCodes[i][2]%>|<%}%>';
		 allDisCodeArr = allDisCodes.split('|');
		 
		 form1.region_code.value = '<%=regionCode%>';
		 getDisCode();
		 form1.district_code.value = '<%=districtCode%>';
		// alert(form1.district_code);
		 
	}
	function test(){
		alert(form1.region_code.value+' '+form1.district_code.value+' '+form1.field_value.value);
	}
	function getDisCode(){
		document.all.district_code.options.length = 0;  
		for(var i = 0; i<allDisCodeArr.length;i++){
			var disCodeRow = allDisCodeArr[i].split('~');
			if(disCodeRow[0]==form1.region_code.value){
				jsAddItemToSelect(form1.district_code,disCodeRow[2],disCodeRow[1]);
			}
		}
	}
	function jsAddItemToSelect(objSelect, objItemText, objItemValue) {    

		var varItem = new Option(objItemText, objItemValue);    
		objSelect.options.add(varItem);    
    
	}    
	
	</script>
<html>

	<body onload="initDisCode()">
		<form name="form1" method="post" action="s4084_1.jsp">
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
					<td class="blue" width="10%">
						����
					</td>

					<td class="blue" width="20%">

						<span onmousemove="this.setCapture();" onmouseout="this.releaseCapture();" onfocus="this.blur();"><select id="region_code" name="region_code" onchange="getDisCode();" onfocus="this.blur();"> 
							<%
								for (int i = 0; i < regionCodes.length; i++) {
									out.print("<option value='" + regionCodes[i][0] + "'>"
											+ regionCodes[i][1] + "</option>");
								}
							%>
						</select></span>
					</td>
					<td class="blue" width="10%">
						����
					</td>

					<td class="blue" width="20%">
						<select id="district_code" name="district_code" onfocus="this.blur();" >
						</select>
					</td>

					<td class="blue" width="20%">
						�ۺ�V������
					</td>
					<td class="blue" width="20%">
						<select  id="field_value" name="field_value">
							<option value="vm">
								��׼
							</option>
							<option value="vt">
								����
							</option>
						</select>
					</td>
				</tr>
			<!-- <button onclick="test();"></button> -->	



				<tr>
					<td align="center" id="footer" colspan="6">
						<input class="b_foot" name=next id=nextoper type=submit
							value="��һ��"></input>
						<input class="b_foot" name=res id=res type="reset" value="����"
							onclick="setTimeout('getDisCode()',200)"></input>
						<input class="b_foot" name=reset type=button value="�ر�"
							onClick="removeCurrentTab()" />
					</td>
				</tr>

			</table>
			<%@ include file="/npage/include/footer.jsp"%>
		</form>
	</body>
</html>
