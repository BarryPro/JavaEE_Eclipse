<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
/********************
 version v3.0
������: si-tech
********************/
%>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    
 		String opCode = "9608";
 		String opName = "ע�������ɾ��";

		String workNo = (String)session.getAttribute("workNo");
		String workName = (String)session.getAttribute("workName");
		String orgCode = (String)session.getAttribute("orgCode");
		String regionCode  = (String)session.getAttribute("regCode");
		String belongName = (String)session.getAttribute("orgCode");
		String groupId = (String)session.getAttribute("groupId");
		String pass = (String)session.getAttribute("password");
				
		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		String dateStr1 = new java.text.SimpleDateFormat("yyyyMMdd hh:mm:ss").format(new java.util.Date());

		String getGroupNameSql = "select group_name ,root_distance from dChnGroupMsg where group_id  = '"+groupId+"'";		
%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
		<wtc:sql><%=getGroupNameSql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="sVerifyTypeArr" scope="end" />
<%
	/*zhangyan add �ͷ����Ų�У�����*/
	String accountType=(String)session.getAttribute("accountType");
	int root_distance_int = 0;
	if (  ! accountType.equals("2") )
	{
		if(retCode1.equals("000000")){
			String root_distance = sVerifyTypeArr[0][1];
			root_distance_int = Integer.parseInt(root_distance);
			if(root_distance_int>3)
			{
			%>
			<script>
				rdShowMessageDialog("�ù�����ɾ��Ȩ��!");
				window.close();
			</script>
			<%
				return ;
			}
	
		}
	}
%>
<html>
	<head>
	<meta http-equiv="content-Type" content="text/html;charset=gb2312">
	<title>������BOSS-ע�������ɾ��</title>
	<script language="javascript">
		<!--
			/**��ʾ"���ݽ���ɾ��"**/
			function showOprInfo(){
				//doReset();
				oprDiv.style.display="block";
				fieldDiv.style.display="none";
				document.all.confirmFlag.value="oprPromptConfirm";
				//document.all("sAuditLoginInfoFrame").height=sAuditLoginInfoFrame.document.body.scrollHeight;
			}

			/**��ʾ"����ҵ��ɾ��"**/
			function showFieldInfo(){
				//doReset();
				oprDiv.style.display="none";
				fieldDiv.style.display="block";
				document.all.confirmFlag.value="fieldPromptConfirm";
			}
			
			/**����л���ǩ�����¼�**/
			function showMessage(flag){
				var guidanceUl=document.getElementById("guidanceUl");
				for(var i=0;i<guidanceUl.childNodes.length;i++){
					guidanceUl.childNodes[i].className="";
				}
				eval("document.getElementById('li"+flag+"')").className="current";	
				if(flag==1){
					//���ݽ���ɾ��
					showOprInfo();
				}else if(flag==2){
					//����ҵ��ɾ��
					showFieldInfo();
				}
			}	
			
			/**ѡ�����**/
			function getFieldClassCode(){
				document.getElementById("iClassCodeFrame").style.display = "block";
				document.iClassCodeFrame.location = "f9608_getFieldClassCode.jsp?iClassCode="+jtrim(document.all.iClassCode.value)+"&iClassName="+jtrim(document.all.iClassName.value);
			}
			
			/**�����ƶ�������,��ѯ��Ҫɾ������Ϣ**/
			function doQuery(){
				if(document.all.confirmFlag.value=="oprPromptConfirm"){
					var sFunctionCode = jtrim(document.all.sFunctionCode.value);
					var iBillType = document.all.iBillType.value;
					var iPromptType = document.all.iPromptType.value;
					var iPromptSeq = jtrim(document.all.iPromptSeq.value);	

					document.getElementById("qryOprInfoFrame").style.display="block";
					document.qryOprInfoFrame.location.href = "f9608_getOprInfoByFunctionCode.jsp?sFunctionCode="+sFunctionCode+"&iBillType="+iBillType+"&iPromptType="+iPromptType+"&iPromptSeq="+iPromptSeq;
				}
				
				if(document.all.confirmFlag.value=="fieldPromptConfirm"){
					var iClassCode = jtrim(document.all.iClassCode.value);
					var sClassValue = jtrim(document.all.sClassValue.value);
					var iBillType = document.all.iBillType2.value;
					var iPromptType = document.all.iPromptType2.value;
					var iPromptSeq = jtrim(document.all.iPromptSeq2.value);
					var sFunctionCode = jtrim(document.all.sFunctionCode2.value);	
					
					document.getElementById("qryFieldInfoFrame").style.display = "block";
					document.qryFieldInfoFrame.location.href = "f9608_getFieldInfoByClassCode.jsp?iClassCode="+iClassCode+"&sClassValue="+sClassValue+"&iPromptSeq2="+iPromptSeq+"&iPromptType2="+iPromptType+"&iBillType2="+iBillType+"&sFunctionCode2="+sFunctionCode;						
				}
			}
			
			/**�ύҳ��**/
			function doConfirm(){
				
				var sAuditLoginsValue = "";
					if(document.all.confirmFlag.value=="oprPromptConfirm"){
						var sFunctionCode = jtrim(document.all.sFunctionCode.value);
						var iBillType = document.all.iBillType.value;
						var iPromptType = document.all.iPromptType.value;
						var iPromptSeq = jtrim(document.all.iPromptSeq.value);
						
						if(sFunctionCode==""||sFunctionCode.length==0){
							rdShowMessageDialog("��ʾ�������벻��Ϊ��!");
							document.all.iClassCode.focus();
							return false;
						}	
						if(iPromptSeq==""||iPromptSeq.length==0){
							rdShowMessageDialog("��ʾ��Ų���Ϊ��!");
							document.all.iPromptSeq.focus();
							return false;
						}	
						if(iPromptType==""||iPromptType=="none"){
							rdShowMessageDialog("��ѡ����ʾ����!");
							document.all.iPromptType.focus();
							return false;
						}					
						if(iBillType==""||iBillType=="none"){
							rdShowMessageDialog("��ѡ��Ʊ������!");
							document.all.iBillType.focus();
							return false;
						}	
						
					if(document.getElementById("qryOprInfoFrame").contentWindow.document.getElementById ('sAuditLogins').value == ""){
							rdShowMessageDialog("��ѡ��������,������������Ҫһ��!");
							return false;							
					}
					
					sAuditLoginsValue = document.getElementById("qryOprInfoFrame").contentWindow.document.getElementById ('sAuditLogins').value;
						
				}
				
				if(document.all.confirmFlag.value=="fieldPromptConfirm"){
					var iClassCode = jtrim(document.all.iClassCode.value);
					var sClassValue = jtrim(document.all.sClassValue.value);
					var iBillType = document.all.iBillType2.value;
					var iPromptType = document.all.iPromptType2.value;
					var iPromptSeq = jtrim(document.all.iPromptSeq2.value);	
						
					if(iClassCode==""||iClassCode.length==0){
						rdShowMessageDialog("���벻��Ϊ��!");
						document.all.iClassCode.focus();
						return false;
					}	
					
					if(sClassValue==""||sClassValue.length==0){
						rdShowMessageDialog("�ֶ���ֵ����Ϊ��!");
						document.all.sClassValue.focus();
						return false;
					}						
					
					if(iPromptSeq==""||iPromptSeq.length==0){
						rdShowMessageDialog("��ʾ��Ų���Ϊ��!");
						document.all.iPromptSeq2.focus();
						return false;
					}	
					if(iPromptType==""||iPromptType=="none"){
						rdShowMessageDialog("��ѡ����ʾ����!");
						document.all.iPromptType2.focus();
						return false;
					}					
					if(iBillType==""||iBillType=="none"){
						rdShowMessageDialog("��ѡ��Ʊ������!");
						document.all.iBillType2.focus();
						return false;
					}			
					
					if(document.getElementById("qryFieldInfoFrame").contentWindow.document.getElementById ('sAuditLogins').value == ""){
							rdShowMessageDialog("��ѡ��������,������������Ҫһ��!");
							return false;							
					}
					
					sAuditLoginsValue = document.getElementById("qryFieldInfoFrame").contentWindow.document.getElementById ('sAuditLogins').value;
				}
				
				var confirmFlag = rdShowConfirmDialog("ȷ��Ҫ�ύ������?");
				if(confirmFlag!=1){
					return false;
				}
				
				if(document.all.confirmFlag.value=="oprPromptConfirm"){
					
					//�����Ϊdisabled�����ܴ�ֵ������
					var sFunctionCode = replaceSpacialCharacter(jtrim(document.all.sFunctionCode.value));
					var iBillType = replaceSpacialCharacter(document.all.iBillType.value);
					var iPromptType = replaceSpacialCharacter(document.all.iPromptType.value);
					var iPromptSeq = replaceSpacialCharacter(jtrim(document.all.iPromptSeq.value));
					//rdShowMessageDialog(sAuditLoginsValue);	
					document.frm.action = "f9608_oprCfm.jsp?sFunctionCode="+sFunctionCode+"&iBillType="+iBillType+"&iPromptType="+iPromptType+"&iPromptSeq="+iPromptSeq+"&sAuditLogins="+sAuditLoginsValue;
					document.frm.submit();					
				}else if(document.all.confirmFlag.value=="fieldPromptConfirm"){
					//�����Ϊdisabled�����ܴ�ֵ������
					var iClassCode = replaceSpacialCharacter(jtrim(document.all.iClassCode.value));
					var sClassValue =replaceSpacialCharacter(jtrim(document.all.sClassValue.value));
					var iBillType = replaceSpacialCharacter(document.all.iBillType2.value);
					var iPromptType = replaceSpacialCharacter(document.all.iPromptType2.value);
					var iPromptSeq = replaceSpacialCharacter(jtrim(document.all.iPromptSeq2.value));
					var sFunctionCode = replaceSpacialCharacter(jtrim(document.all.sFunctionCode2.value));
									
					//rdShowMessageDialog(sAuditLoginsValue);	
					document.frm.action = "f9608_fieldCfm.jsp?sFunctionCode2="+sFunctionCode+"&iBillType2="+iBillType+"&iPromptType2="+iPromptType+"&iPromptSeq2="+iPromptSeq+"&iClassCode="+iClassCode+"&sClassValue="+sClassValue+"&sAuditLogins="+sAuditLoginsValue;
					
					document.frm.submit();
				}
			}

			function replaceSpacialCharacter(source)
			{
				source = source.replace("#","%23");
				source = source.replace("&","%26");
				source = source.replace("+","%2b");
				source = source.replace("?","%3f");
				source = source.replace("_","%5f");
				source = source.replace('"',"%22");
				source = source.replace("'","%27");
				return source;
			}
			
			/**����ҳ��**/
			function doReset(){
				window.location.reload();
				/*
				//��Ϊdocument.all.confirmFlag.value�����л�ӵ�в�ͬ��ֵ
				//���frm.reset(),�����״���.
				//�ɷ������µĴ���,�޸ĳ�:window.location.reload()����window.location.href="xxxx"
				var e = document.forms[0].elements;
				for(var i=0;i<e.length;i++){
				  if(e[i].type=="select-one"){
				  	e[i].value="none";
				  }
				  if(e[i].type=="text"&&e[i].name!="confirmFlag"){
				  	e[i].value="";
				  }
				}
				
				//�������е���ʾ��iframe
				var iframes = document.getElementsByTagName("iframe");
				for(var i=0;i<iframes.length;i++){
					if(iframes[i].id!="sAuditLoginInfoFrame"||iframes[i].id!="sAuditLoginInfoFrame2")
					iframes[i].style.display = "none";	
				}
				*/
			}
			
			/**�ر�ҳ��**/
			function doClose(){
				parent.removeTab("<%=opCode%>");
			}
			
			/**�����ַ����ҵĿո�**/
			function jtrim(str){
				if(str==null)return;
				return str.replace( /^\s*/, "" ).replace( /\s*$/, "" );	
			}
			//-->
	</script>
	
	<!--���css��ʽ�����������л���ǩ����ʽ,,,����и��õ��л���ǩ���滻,,,��ɾ�������ʽ,��Ӱ��ҳ����������-->
	<style type="text/css">
	<!--
    body {
      margin:0;
      padding:0;
      font:  12px/1.5em Verdana;
    }
		
    #tabsJ {
      float:left;
      width:100%;
      background:#f6f6f6;
      font-size:93%;
      line-height:normal;
    }
    #tabsJ ul {
      margin:0;
      padding:10px 10px 0 5px;
      list-style:none;
    }
    #tabsJ li {
      display:inline;
      margin:0;
      padding:0;
    }
    #tabsJ a {
      float:left;
      background:url("/nresources/default/images/tableftJ.gif") no-repeat left top;
      margin:0;
      padding:0 0 0 5px;
      text-decoration:none;
      cursor:hand;
    }
    #tabsJ a span {
      float:left;
      display:block;
      background:url("/nresources/default/images/tabrightJ.gif") no-repeat right top;
      padding:5px 15px 4px 6px;
      color:#24618E;
    }
    /* Commented Backslash Hack hides rule from IE5-Mac \*/
    #tabsJ a span {
    	float:none;
    }
    /* End IE5-Mac hack */
    #tabsJ a:hover span {
      color:#FFF;
    }
    #tabsJ a:hover {
      background-position:0% -42px;
    }
    #tabsJ a:hover span {
      background-position:100% -42px;
    }

    #tabsJ .current a {
      background-position:0% -42px;
    }
    #tabsJ .current a span {
			font: bold;
      background-position:100% -42px;
      color:#FFF;
    }
	-->
	</style>
</head>

<body>
	<form action="" method="post" name="frm">
		
		<%@ include file="/npage/include/header.jsp" %>
		
		<input type="hidden" name="confirmFlag" value="oprPromptConfirm">
    
    <div class="title">
			<div id="title_zi">��ѡ���������</div>
		</div>
		
		<!--�л���ǩ,����и����ʵı�ǩ,,�����滻-->
		 <table cellSpacing="0">
		 	<tr>
		 		<td>
					<div id="tabsJ">
						<ul id="guidanceUl">
							<li id="li1" class="current"><a onclick="showMessage(1)"><span>���ݽ���ɾ��</span></a></li>
							<li id="li2"><a onclick="showMessage(2)"><span>����ҵ��ɾ��</span></a></li>
						</ul>
					</div>
				</td>
			</tr>
		</table>
		
		<!--
			/*@service information
			 *@inparam	loginAccept		��ˮ	�������룬������������ڷ�����ȡ��ˮ
			 *@inparam	opCode			���ܴ���	
			 *@inparam	loginNo			��������
			 *@inparam	loginPasswd		�������ܵĹ�������
			 *@inparam	opNote			������ע
			 *@inparam	ipAddr			IP��ַ
			 
			 
			 *@inparam	sFunctionCode	��ʾ��������
			 *@inparam	iBillType	Ʊ������
			 *@inparam	iPromptType	��ʾ����
			 *@inparam	iPromptSeq	��ʾ���
			 *@output parameter information
			 *@outparam	loginAccept		��ˮ	�����ڷ��������ɵ���ˮ����ԭ�������ˮ
			 *@return SVR_ERR_NO 
			 */
		-->
		<div id="oprDiv" style="display:block">
			<table cellspacing="0">
				<tr>
					<td width="15%" class="blue" nowrap>��������</td>
					<td width="35%">
						<input type="text" name="sFunctionCode" value="" onKeyDown="if(event.keyCode==13)doQuery()">&nbsp;<font class="orange">(ƥ��ģ����ѯ)</font>
					</td>
					<td width="15%" class="blue">��ʾ���</td>
					<td width="35%">
						<input type="text" name="iPromptSeq" value="">
					</td>
				</tr>
				<tr>
					<td width="15%" class="blue" nowrap>��ʾ����</td>
					<td>
						<select name="iPromptType">
							<option value="none" selected>��ѡ��</option>
							<option value="2">2->�ʷ�����</option> <!--add by diling for ��棺ע��������޸ĺ�ɾ�����ɹ�@2011/11/3-->
							<option value="11">11->��ǰ��ʾ</option>
							<option value="13">13->�º���ʾ</option>
						</select>						
					</td>
					<td class="blue">Ʊ������</td>
					<td>
						<select name="iBillType">
							<option value="none" selected>��ѡ��</option>
							<wtc:qoption name="sPubSelect" outnum="2">
							<wtc:sql>select bill_type,bill_type||'->'||bill_name from sPrintBillType</wtc:sql>
							</wtc:qoption>
						</select>						
					</td>
				</tr>
				<tr> 
		        <td noWrap align="center" colspan="4" > 
		        	 <input type="button" name="queryButton"  class="b_text" value="��ѯ" style="cursor:hand;" onclick="doQuery()">
						<td>
				</tr>				
				<tr>
					<td colspan="4" style="height:0;">
						<iframe frameBorder="0" id="qryOprInfoFrame" align="center" name="qryOprInfoFrame" scrolling="no" style="height:100%; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('qryOprInfoFrame').style.height=qryOprInfoFrame.document.body.scrollHeight+'px'"></iframe>
					</td>
				</tr>
			</table>
			<table cellspacing="0">
				<tr>
					<td width="15%" class="blue" nowrap>������ע</td>
					<td colspan="3"><input type="text" name="opNote" value="" size="100" maxlength="60"></td>
				</tr>		
			</table>		
		</div>
		<!--
			/*@service information
			 *@name						s9608Cfm2
			 *@author					lugz
			 *@created	2008-10-10 14:54:23
			 *@version %I%, %G%
			 *@since 1.00
			 *@input parameter information
			 *@inparam	loginAccept		��ˮ	�������룬������������ڷ�����ȡ��ˮ
			 *@inparam	opCode			���ܴ���	
			 *@inparam	loginNo			��������
			 *@inparam	loginPasswd		�������ܵĹ�������
			 *@inparam	opNote			������ע
			 *@inparam	ipAddr			IP��ַ
			 
			 *@inparam	iBillType	Ʊ������
			 *@inparam	iClassCode	����
			 *@inparam	sClassValue	�ֶ���ֵ
			 *@inparam	iPromptType	��ʾ����
			 *@inparam	iPromptSeq	��ʾ���
			 *@output parameter information
			 *@outparam	loginAccept		��ˮ	�����ڷ��������ɵ���ˮ����ԭ�������ˮ
			 *@return SVR_ERR_NO 
			 */
		-->
		<div id="fieldDiv" style="display:none">
			<table cellspacing="0">
				<tr>
					<td width="15%" class="blue" nowrap>����</td>
					<td width="35%">
						<input type="text" name="iClassCode" value="" onKeyDown="if(event.keyCode==13){getFieldClassCode();}">&nbsp;&nbsp;
						<input name="" type="button" class="b_text" style="cursor:hand" onClick="getFieldClassCode()" value="��ѯ">
					</td>
					<td width="15%" class="blue" nowrap>�ֶ�������</td>
					<td width="35%">
						<input type="text" name="iClassName" value="" onKeyDown="if(event.keyCode==13){getFieldClassCode();}">&nbsp;<font class="orange">(ƥ��ģ����ѯ)</font>
					</td>	
				</tr>
				<tr>
					<td colspan="4" style='height:0;'>
						<iframe frameBorder="0" id="iClassCodeFrame" align="center" name="iClassCodeFrame" scrolling="no" style="height:100%; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('iClassCodeFrame').style.height=iClassCodeFrame.document.body.scrollHeight+'px'"></iframe>
					</td>
				</tr>
				<tr>
					<td width="15%" class="blue" nowrap>��������</td>
					<td colspan="3">
						<input type="text" name="sFunctionCode2" value="" onKeyDown="if(event.keyCode==13)doQuery()">
					</td>
				</tr>				
				<tr>
					<td width="15%" class="blue">�ֶ���ֵ</td>
					<td>
						<input type="text" name="sClassValue" value="">
					</td>	
					<td width="15%" class="blue">��ʾ���</td>
					<td><input type="text" name="iPromptSeq2" value=""></td>
				</tr>
				<tr>		
					<td width="15%" class="blue" nowrap>��ʾ����</td>
					<td>
						<select name="iPromptType2">
							<option value="none" selected>��ѡ��</option>
							<option value="2">2->�ʷ�����</option> <!--add by diling for ��棺ע��������޸ĺ�ɾ�����ɹ�@2011/11/3-->
							<option value="12">12->������ʾ</option>
							<option value="13">13->�º���ʾ</option>
						</select>						
					</td>
					<td class="blue">Ʊ������</td>
					<td>
						<select name="iBillType2">
							<option value="none" selected>��ѡ��</option>
							<wtc:qoption name="sPubSelect" outnum="2">
							<wtc:sql>select bill_type,bill_type||'->'||bill_name from sPrintBillType where bill_type = '1'</wtc:sql>
							</wtc:qoption>
						</select>						
					</td>
				</tr>
		      <tr> 
		        <td noWrap align="center" colspan="4" > 
		        	 <input type="button" name="queryButton"  class="b_text" value="��ѯ" style="cursor:hand;" onclick="doQuery()">&nbsp;
						<td>
					</tr>
				<tr>
					<td colspan="4" style="height:0;">
						<iframe frameBorder="0" id="qryFieldInfoFrame" align="center" name="qryFieldInfoFrame" scrolling="no" style="height:100%; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('qryFieldInfoFrame').style.height=qryFieldInfoFrame.document.body.scrollHeight+'px'"></iframe>
					</td>
				</tr>
			</table>
			<table cellspacing="0">
				<tr>
					<td class="blue" width="15%" nowrap>������ע</td>
					<td colspan="3"><input type="text" name="opNote2" value="" size="100" maxlength="60"></td>
				</tr>	
			</table>
		</div>
		
		<!--����Ϊ��������-->
		<table cellSpacing="0">
      <tr> 
        <td id="footer"> 
           <input type="button" name="resetButton"  class="b_foot" value="����" style="cursor:hand;" onclick="doReset()">&nbsp;
           <input type="button" name="confirmButton" class="b_foot" value="ȷ��ɾ��" style="cursor:hand;" onClick="doConfirm()" disabled>&nbsp;
           <input type="button" name="closeButton" class="b_foot" value="�ر�" style="cursor:hand;" onClick="doClose()">&nbsp;
        </td>
      </tr>
     </table>
     <%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>
