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
    
 		String opCode = "9614";
 		String opName = "ע�����������";
 		
		String workNo = (String)session.getAttribute("workNo");
		String workName = (String)session.getAttribute("workName");
		String orgCode = (String)session.getAttribute("orgCode");
		String regionCode  = (String)session.getAttribute("regCode");
		String belongName = (String)session.getAttribute("orgCode");
		String groupId = (String)session.getAttribute("groupId");
		String pass = (String)session.getAttribute("password");
		
		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		String dateStr1 = new java.text.SimpleDateFormat("yyyyMMdd hh:mm:ss").format(new java.util.Date());
%>
<html>
	<head>
	<title>������BOSS-ע�����������</title>
	<script language="javascript">
		<!--
			/**��ʾ"���ݽ�������"**/
			function showOprInfo(){
				oprDiv.style.display="block";
				fieldDiv.style.display="none";
				document.all.confirmFlag.value="oprPromptConfirm";
				document.all.confirmButton.disabled = true;
			}

			/**��ʾ"����ҵ������"**/
			function showFieldInfo(){
				oprDiv.style.display="none";
				fieldDiv.style.display="block";
				document.all.confirmFlag.value="fieldPromptConfirm";
				document.all.confirmButton.disabled = true;
				
				document.getElementById("showFieldAccInfoFrame2").style.display = "block";
				document.showFieldAccInfoFrame2.location.href = "f9614_getFieldCreateAcceptInfo.jsp";
			}
	
				/**����л���ǩ�����¼�**/
			function showMessage(flag){
				var guidanceUl=document.getElementById("guidanceUl");
				for(var i=0;i<guidanceUl.childNodes.length;i++){
					guidanceUl.childNodes[i].className="";
				}
				eval("document.getElementById('li"+flag+"')").className="current";	
				if(flag==1){
					//���ݽ�������
					showOprInfo();
				}else if(flag==2){
					//����ҵ������
					showFieldInfo();
				}
			}		

			window.onload=function(){
				if(document.all.confirmFlag.value=="oprPromptConfirm"){
					document.getElementById("showOprAccInfoFrame").style.display = "block";
					document.showOprAccInfoFrame.location.href = "f9614_getOprCreateAcceptInfo.jsp";
				}	
				if(document.all.confirmFlag.value=="fieldPromptConfirm"){
					document.getElementById("showFieldAccInfoFrame2").style.display = "block";
					document.showFieldAccInfoFrame2.location.href = "f9614_getFieldCreateAcceptInfo.jsp";
				}	
			}
			
			/**ѡ��"����Ƿ�ͨ��"selectʱ�������¼�**/
			function doCheckAcc(){
				if(document.all.confirmFlag.value=="oprPromptConfirm"){
					if(document.all.sAuditAccept.value==""){
						rdShowMessageDialog("����������ˮ����Ϊ��!");
						document.all.sIsAuditPass.value="none";
						return false;
					}	
					if(document.all.sIsAuditPass.value!="none"){
						document.all.confirmButton.disabled = false;
					}else{
						document.all.confirmButton.disabled = true;	
					}
				}
				
				if(document.all.confirmFlag.value=="fieldPromptConfirm"){
					if(document.all.sAuditAccept2.value==""){
						rdShowMessageDialog("����������ˮ����Ϊ��!");
						document.all.sIsAuditPass2.value="none";
						return false;
					}	
					if(document.all.sIsAuditPass2.value!="none"){
						document.all.confirmButton.disabled = false;
					}else{
						document.all.confirmButton.disabled = true;	
					}
				}				
			}
			
			
			/**�ύҳ��**/
			function doConfirm(){
				if(document.all.confirmFlag.value=="oprPromptConfirm"){
				}
				if(document.all.confirmFlag.value=="fieldPromptConfirm"){
				}
				
				var confirmFlag = rdShowConfirmDialog("ȷ��Ҫ�ύ������?");
				if(confirmFlag!=1){
					return false;
				}
				
				if(document.all.confirmFlag.value=="oprPromptConfirm"){
					
					if(document.getElementById("sAuditSuggestion").value=="")
					{
							rdShowMessageDialog("�������������");
							document.getElementById("sAuditSuggestion").focus();
							return false;
					}
					
					document.frm.action = "f9614_oprCfm.jsp";
					document.frm.submit();					
				}else if(document.all.confirmFlag.value=="fieldPromptConfirm"){
					if(document.getElementById("sAuditSuggestion2").value=="")
					{
							rdShowMessageDialog("�������������");
							document.getElementById("sAuditSuggestion2").focus();
							return false;
					}
					
					document.frm.action = "f9614_fieldCfm.jsp";
					document.frm.submit();
				}
			}
						
			/**����ҳ��**/
			function doReset(){
				document.frm.reset();
			}
			
			/**�ر�ҳ��**/
			function doClose(){
				parent.removeTab("<%=opCode%>");
			}
			
			/**�����ַ����ҵĿո�**/
			function jtrim(str){
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
							<li id="li1" class="current"><a onclick="showMessage(1)"><span>���ݽ�������</span></a></li>
							<li id="li2"><a onclick="showMessage(2)"><span>����ҵ������</span></a></li>
						</ul>
					</div>
				</td>
			</tr>
		</table>
		    
		<!--	
		/*@service information
		 *@name						s9614Cfm1
		 *@description				��˵��ǲ������� 
		 *@author					lugz
		 *@created	2008-10-8 13:01:58
		 *@version %I%, %G%
		 *@since 1.00
		 *@input parameter information
		 *@inparam	loginAccept		��ˮ	�������룬������������ڷ�����ȡ��ˮ
		 *@inparam	opCode			���ܴ���	
		 *@inparam	loginNo			��������
		 *@inparam	loginPasswd		�������ܵĹ�������
		 *@inparam	systemNote		ϵͳ��ע
		 *@inparam	opNote			������ע
		 *@inparam	ipAddr			IP��ַ
		 
		 *@inparam	sAuditAccept	������ˮ
		 *@inparam	sIsAuditPass 	Y/N
		 *@inparam	sAuditSuggestion �������
		 *@inparam	sIsAudit	�Ƿ��Ѿ���� Y/N
		 
		 *@output parameter information
		 *@outparam	loginAccept		��ˮ	�����ڷ��������ɵ���ˮ����ԭ�������ˮ
		 *@return SVR_ERR_NO 
		 */
		-->
		<div id="oprDiv" style="display:block">
			<table cellspacing="0">
				<tr>
					<td colspan="4">
						<iframe frameBorder="0" id="showOprAccInfoFrame" align="center" name="showOprAccInfoFrame" scrolling="no" style="height:100%; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('showOprAccInfoFrame').style.height=showOprAccInfoFrame.document.body.scrollHeight+'px'"></iframe>
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<iframe frameBorder="0" id="showMainOprInfoFrame" align="center" name="showMainOprInfoFrame" scrolling="no" style="height:100%; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('showMainOprInfoFrame').style.height=showMainOprInfoFrame.document.body.scrollHeight+'px'"></iframe>
					</td>
				</tr>
			</table>
			<table id="oprAuditTable" style="display:none" cellspacing="0">
				 <tr>
					<td width="15%" class="blue" nowrap>&nbsp;&nbsp;ѡ���������ˮ</td>
					<td>
						<input type="text" name="sAuditAccept" value="" readonly>						
					</td>
				</tr>
				<tr>
					<td width="15%" class="blue" nowrap>&nbsp;&nbsp;����Ƿ�ͨ��</td>
					<td>
						<select name="sIsAuditPass" onchange="doCheckAcc()">
							<option value="none">��ѡ��</option>
							<option value="Y">��</option>
							<option value="N">��</option>
						</select>						
					</td>
				</tr>
				<tr>
					<td width="15%" class="blue" nowrap>&nbsp;&nbsp;�������</td>
					<td>
						<input type="text" name="sAuditSuggestion" value="" size="80" maxlength="60">					
					</td>
				</tr>
					<input type="hidden" name="systemNote" value="" size="80" maxlength="60" readonly>
				<tr>
					<td class="blue" nowrap>&nbsp;&nbsp;������ע</td>
					<td><input type="text" name="opNote" value="" size="80" maxlength="60"></td>
				</tr>
			</table>	
		</div>
		
		<!--
			/*@service information
			 *@name						s9614Cfm2
			 *@description				ע��ʵ�ֿ����
			 *@author					lugz
			 *@created	2008-10-8 13:01:58
			 *@version %I%, %G%
			 *@since 1.00
			 *@input parameter information
			 *@inparam	loginAccept		��ˮ	�������룬������������ڷ�����ȡ��ˮ
			 *@inparam	opCode			���ܴ���	
			 *@inparam	loginNo			��������
			 *@inparam	loginPasswd		�������ܵĹ�������
			 *@inparam	systemNote		ϵͳ��ע
			 *@inparam	opNote			������ע
			 *@inparam	ipAddr			IP��ַ
			 
			 *@inparam	sAuditAccept	������ˮ
			 *@inparam	sIsAuditPass 	Y/N
			 
			 *@output parameter information
			 *@outparam	loginAccept		��ˮ	�����ڷ��������ɵ���ˮ����ԭ�������ˮ
			 *@return SVR_ERR_NO 
 */
		-->
		<div id="fieldDiv" style="display:none">
			<table cellspacing="0">
				<tr>
					<td colspan="2">
						<iframe frameBorder="0" id="showFieldAccInfoFrame2" align="center" name="showFieldAccInfoFrame2" scrolling="no" style="height:100%; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('showFieldAccInfoFrame2').style.height=showFieldAccInfoFrame2.document.body.scrollHeight+'px'"></iframe>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<iframe frameBorder="0" id="showMainOprInfoFrame2" align="center" name="showMainOprInfoFrame2" scrolling="no" style="height:100%; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('showMainOprInfoFrame2').style.height=showMainOprInfoFrame2.document.body.scrollHeight+'px'"></iframe>
					</td>
				</tr>
			</table>

			<table id="oprAuditTable2" style="display:none" cellspacing="0">
				 <tr>
					<td width="15%" class="blue" nowrap>&nbsp;&nbsp;ѡ���������ˮ</td>
					<td>
						<input type="text" name="sAuditAccept2" value="" readonly>						
					</td>
				</tr>
				<tr>
					<td width="15%" class="blue" nowrap>&nbsp;&nbsp;����Ƿ�ͨ��</td>
					<td>
						<select name="sIsAuditPass2" onchange="doCheckAcc()">
							<option value="none">��ѡ��</option>
							<option value="Y">��</option>
							<option value="N">��</option>
						</select>						
					</td>
				</tr>
				<tr>
					<td width="15%" class="blue" nowrap>&nbsp;&nbsp;�������</td>
					<td>
						<input type="text" name="sAuditSuggestion2" value="" size="80" maxlength="60">					
					</td>
				</tr>
				<tr>
					<td class="blue" nowrap>&nbsp;&nbsp;������ע</td>
					<td><input type="text" name="opNote2" value="" size="80" maxlength="60"></td>
				</tr>
			</table>
		</div>
		
		<!--����Ϊ��������-->
		<table cellSpacing="0">
      <tr> 
        <td id="footer"> 
           <input type="button" name="resetButton"  class="b_foot" value="����" style="cursor:hand;" onclick="doReset()" >&nbsp;
           <input type="button" name="confirmButton" class="b_foot" value="ȷ��" style="cursor:hand;" onClick="doConfirm()" disabled>&nbsp;
           <input type="button" name="closeButton" class="b_foot" value="�ر�" style="cursor:hand;" onClick="doClose()" >&nbsp;
        </td>
      </tr>
     </table>
    <%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>

