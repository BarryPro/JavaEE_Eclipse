<%
  /*
   *	IMS�̻�������Centrex��
   *	ningtn
   *	����: 2013-12-16 13:29:14
   */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<head>
	<title>IMS�̻�������Centrex��</title>
	<%
		request.setCharacterEncoding("GBK");
	  response.setHeader("Pragma","No-Cache"); 
	  response.setHeader("Cache-Control","No-Cache");
	  response.setDateHeader("Expires", 0);
	%>
	<%
		String opCode = (String)request.getParameter("opCode");
  	String opName = (String)request.getParameter("opName");
  	String checkIdNo = (String)request.getParameter("checkIdNo");
  	String phoneNoList = (String)request.getParameter("phoneNoList");
		String workNo = (String)session.getAttribute("workNo");
		String password = (String)session.getAttribute("password");
		String regionCode= (String)session.getAttribute("regCode");
		String cccTime=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date());
	%>
	<!--�����ˮ��-->
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAcceptl" /> 	
	<script language="javascript">
				//���ù������棬���м��ſͻ�ѡ��
		function getInfo_Cust(){
			var pageTitle = "���ſͻ�ѡ��";
			var fieldName = "֤������|�ͻ�ID|�ͻ�����|����ID|��������|������|������֯|";
			var sqlStr = "";
			var selType = "S";    //'S'��ѡ��'M'��ѡ
			var retQuence = "7|0|1|2|3|4|5|6|";
			var retToField = "iccid|cust_id|cust_name|unit_id|unit_name|belong_code|group_id|";
			/**add by liwd 20081127,group_id����dcustDoc��group_id end **/
			var cust_id = document.frm.cust_id.value;
			if(document.frm.iccid.value == "" &&
			document.frm.cust_id.value == "" &&
			document.frm.unit_id.value == "")
			{
				rdShowMessageDialog("������֤�����롢�ͻ�ID����ID���в�ѯ��");
				document.frm.iccid.focus();
				return false;
			}
			
			if(document.frm.cust_id.value != "" && forNonNegInt(frm.cust_id) == false)
			{
				frm.cust_id.value = "";
				rdShowMessageDialog("���������֣�");
				return false;
			}
			
			if(document.frm.unit_id.value != "" && forNonNegInt(frm.unit_id) == false)
			{
				frm.unit_id.value = "";
				rdShowMessageDialog("���������֣�");
				return false;
			}
			
			if(PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
		}
		
		function PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
		{
			var path = "<%=request.getContextPath()%>/npage/s3690/fpubcust_sel.jsp";
			path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
			path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
			path = path + "&selType=" + selType+"&iccid=" + document.all.iccid.value;
			path = path + "&cust_id=" + document.all.cust_id.value;
			path = path + "&unit_id=" + document.all.unit_id.value;
			path = path + "&regionCode=" + "<%=regionCode%>";
			
			retInfo = window.open(path,"newwindow","height=450, width=800,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
			
			return true;
		}
		
		function getvaluecust(retInfo){
			/*add by liwd 20081127,group_id����dcustDoc��group_id
			**var retToField = "iccid|cust_id|cust_name|unit_id|unit_name|belong_code|";;
			**/
			var retToField = "iccid|cust_id|cust_name|unit_id|unit_name|belong_code|group_id|";
			/**add by liwd 20081127,group_id����dcustDoc��group_id end **/
			if(retInfo ==undefined)      
			{   return false;   }
			
			var chPos_field = retToField.indexOf("|");
			var chPos_retStr;
			var valueStr;
			var obj;
			while(chPos_field > -1)
			{
				obj = retToField.substring(0,chPos_field);
				chPos_retInfo = retInfo.indexOf("|");
				valueStr = retInfo.substring(0,chPos_retInfo);
				document.all(obj).value = valueStr;
				retToField = retToField.substring(chPos_field + 1);
				retInfo = retInfo.substring(chPos_retInfo + 1);
				chPos_field = retToField.indexOf("|");
			}
			document.all.grp_name.value = document.all.unit_name.value;
		}
		function check_HidPwd()
		{
			var cust_id = document.all.cust_id.value;
			var Pwd1 = document.all.custPwd.value;
			if(cust_id.trim() == "" || Pwd1.trim() == ""){
				return false;
			}
			var checkPwd_Packet = new AJAXPacket("<%=request.getContextPath()%>/npage/s3690/pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
			checkPwd_Packet.data.add("retType","checkPwd");
			checkPwd_Packet.data.add("cust_id",cust_id);
			checkPwd_Packet.data.add("Pwd1",Pwd1);
			core.ajax.sendPacket(checkPwd_Packet,doCheckPwdBack);
			checkPwd_Packet = null;
		}
		function doCheckPwdBack(packet){
			var retType = packet.data.findValueByName("retType");
	    var retCode = packet.data.findValueByName("retCode");
	    var retMessage=packet.data.findValueByName("retMessage");
			if(retCode == "000000"){
				var retResult = packet.data.findValueByName("retResult");
				if (retResult == "false") {//Ϊ�˲��ԣ��޸����ж�����
					rdShowMessageDialog("�ͻ�����У��ʧ�ܣ����������룡",0);
					frm.custPwd.value = "";
					frm.custPwd.focus();
					return false;
				} else {
					rdShowMessageDialog("�ͻ�����У��ɹ���",2);
					$("#new_cus_id").val(document.all.cust_id.value);
					document.frm.next.disabled = false;
				}
			}
			else{
				rdShowMessageDialog("�ͻ�����У�����������У�飡",0);
				return false;
			}
		}
		
		function cfm(){
			
			if(rdShowConfirmDialog("��ȷ���Ƿ���в�Ʒ��װ��")==1){
				$("#frm").attr("action","fm014MainCfm.jsp");
				$("#frm").submit();
			}else{
				return false;
			}
		}
		
	
	</script>
<body>
<form name="frm" id="frm" method="POST" >
	<%@ include file="/npage/include/header.jsp" %>
	<input type="hidden" name="grp_name" id="grp_name" />
	<input type="hidden" name="unit_name" id="unit_name" />
	<input type="hidden" name="belong_code" id="belong_code" />
	<input type="hidden" name="group_id" id="group_id" />
	<input type="hidden" name="offerId" id="offerId" />
	<input type="hidden" name="offerType" id="offerType" />
	<input type="hidden" name="servBusiId" id="servBusiId" />
	<input type="hidden" name="offerInfoCode" id="offerInfoCode" />
	<input type="hidden" name="offerInfoValue" id="offerInfoValue" />
	<input type="hidden" name="checkIdNo" value="<%=checkIdNo%>" />
	<input type="hidden" name="phoneNoList" value="<%=phoneNoList%>" />
	<input type="hidden" name="new_cus_id" id="new_cus_id" />
	<input type="hidden" name="opCode" value="<%=opCode%>" />
	<input type="hidden" name="opName" value="<%=opName%>" />
	<input type="hidden" name="sysAcceptl" id="sysAcceptl" value="<%=sysAcceptl%>" /> <!--��ˮ-->
	<div class="title">
		<div id="title_zi">��ѡ�̻�</div>
	</div>
	<table cellspacing="0">
    <tr>
    	<td class="blue" width="20%">��ѡ�̻�</td>
    	<td><%=phoneNoList.substring(0,phoneNoList.length()-1)%></td>
    </tr>
  </table>
	<div class="title">
		<div id="title_zi">������֤</div>
	</div>
	<table cellspacing="0">
    <tr>
      <td class=blue>֤������</td>
      <td>
        <input name="iccid" id="iccid" size="24" maxlength="20" v_type="string" v_must=1>
        <input name="custQuery" type="button" id="custQuery" 
         class="b_text" onClick="getInfo_Cust();" 
          onKeyUp="if(event.keyCode==13)getInfo_Cust();" style="cursor:hand" value=��ѯ />
        <font class="orange">*</font>
      </td>
      <td class=blue>���ſͻ�ID</TD>
      <td>
        <input type="text" name="cust_id" id="cust_id" size="20" maxlength="12" v_type="0_9" v_must=1 index="2">
        <font class="orange">*</font>
      </td>
    </tr>
    <tr>
      <td class=blue>���ű��</td>
      <td>
          <input name="unit_id" id="unit_id" size="24" maxlength="11" v_type="0_9" v_must=1 index="3">
          <font class="orange">*</font>
      </td>
      <td class=blue>���ſͻ�����</td>
      <td>
          <input name="cust_name" id="cust_name" size="20" readonly v_must=1 v_type=string index="4">
          <font class="orange">*</font>
      </td>
    </tr>
    <tr>
      <td class=blue>���ſͻ�����</td>
      <td colspan="3">
        <jsp:include page="/npage/common/pwd_1.jsp">
        <jsp:param name="width1" value="16%"  />
        <jsp:param name="width2" value="34%"  />
        <jsp:param name="pname" value="custPwd"  />
        <jsp:param name="pwd" value="<%=123%>"  />
        </jsp:include>
        <input name=chkPass type=button onClick="check_HidPwd();" class="b_text" style="cursor:hand" id="chkPass2" value=У��>
        <font class="orange">*</font>
      </td>
    </tr>
	</table>
	<table cellspacing="0">
		<tr>
			<td noWrap id="footer">
			<div align="center">
				<input type="button" name="next" class="b_foot" value="�ύ" onclick="cfm()" disabled />
				&nbsp;
				<input type="button" name="close" class="b_foot" value="�ر�" onClick="removeCurrentTab();">
			</div>
			</td>
		</tr>
	</table>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>