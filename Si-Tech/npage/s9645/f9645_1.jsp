<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
/********************
 version v3.0
������: si-tech
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
		
		String opCode = "9645";
 		String opName = "ע�������¼��";
 		
 		String workNo = (String)session.getAttribute("workNo");
		String workName = (String)session.getAttribute("workName");
		String orgCode = (String)session.getAttribute("orgCode");
		String regionCode  = (String)session.getAttribute("regCode");
		String belongName = (String)session.getAttribute("orgCode");
		String groupId = (String)session.getAttribute("groupId");
		String pass = (String)session.getAttribute("password");
		
		String dateStr1 = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		
%>
<html>
	<head>
	<title>������BOSS-ע�������¼��</title>
	<script language="javascript">	
	<!--
	onload=function(){
	
	}		
	
	function getFucntionInfo(){
				var sFunctionCode = document.all.sFunctionCode.value;
				var sFunctionName = document.all.sFunctionName.value;
				//alert(sFunctionCode+"|"+sFunctionName);
				if(document.all.sFunctionCode.value=="" && document.all.sFunctionName.value==""){
					rdShowMessageDialog("ģ�������ģ�����Ʊ�������һ��!<br>(֧��ģ����ѯ,ֻ�����벿����Ϣ)");
					document.all.sFunctionCode.focus();
					return false;
				}
        var h = 500;
        var w = 350;
        var t = screen.availHeight / 2 - h / 2;
        var l = screen.availWidth / 2 - w / 2;
        var impFrm = document.frm;
        var prop = "dialogHeight:" + h + "px; dialogWidth:" + w + "px; dialogLeft:" + l + "px; dialogTop:" + t + "px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
        var path = "f9645_getFucntionInfo.jsp?sFunctionCode="+sFunctionCode+"&sFunctionName="+sFunctionName;
        var ret = window.showModalDialog(path, impFrm, prop);				
			}
			
	function checkItem(e, allName)
	{	
			var all = document.getElementsByName(allName)[0];
			var iPromptTypeValue = "";
	  	if(!e.checked) all.checked = false;              
	  	else                                             
	  	{                                                
	  	  var aa = document.getElementsByName(e.name);   
	  	  for (var i=0; i<aa.length; i++)                
	  	  {                                              
	  	  	if(aa[i].checked)                    
	  	 		{  	  	                                                           
	  	  	  iPromptTypeValue += (aa[i].value+",");                                            
	  			}                                            
	  		}                                              
	  	} 
	  	document.all.iPromptTypes.value = iPromptTypeValue;                                               
	}	                                                   
	                                                     
	function doConfirm(){				                         
					if(document.all.sFunctionCode.value==""){    
						rdShowMessageDialog("����д��������!");    
						document.all.sFunctionCode.focus();        
						return false;                              
					}                                            					                                             
					/**����ҵ�����ӵ�,ģ��������Ϊ"ALL"**/     
					//if(jtrim(document.all.sFunctionCode2.value).toUpperCase()=="ALL"){
						/**����Ҫ����ı����Ǵ�д��"ALL",��ֹҳ�洫��Ĳ��Ǵ�д**/
						//document.all.sFunctionCode2.value = jtrim(document.all.sFunctionCode2.value).toUpperCase();
					//}
					if(document.getElementById("phoneNo").value=="")
					{
						rdShowMessageDialog("���������Ա�ֻ���");
						document.getElementById("phoneNo").focus();
						return false
					}
					if(document.getElementById("phoneNo").value.length < 11)
					{
						rdShowMessageDialog("�ֻ��ų�����������������");
						document.getElementById("phoneNo").value="";
						document.getElementById("phoneNo").focus();
						return false
					}
					if(document.getElementById("sAdviceContent").value=="")
					{
						rdShowMessageDialog("�����뽨����Ϣ");
						document.getElementById("sAdviceContent").focus();
						return false;
					}
					
					if(document.getElementById("sAdviceContent").value.length>512)
					{
						rdShowMessageDialog("������Ϣ��������,���ܴ���512�֣�");
						return false;
					}
					if(document.all.opNote.value.length==0)
					{
						document.all.opNote.value=="����Ա��<%=workNo%> ¼����ע���������Ϣ";
					}
				//setOpNote();//Ϊ��ע��ֵ															
				var confirmFlag = rdShowConfirmDialog("ȷ��Ҫ�ύ������?");
				if(confirmFlag!=1){
					return false;
				}
				//alert(document.all.opNote.value+"|"+document.all.sFunctionCode.value+"|"+document.all.sFunctionName.value+"|"+document.all.sAdviceContent.value);									
				
				var sCreateLogin = document.all.sCreateLogin.value;	
				var sCreateName = document.all.sCreateName.value;	
				var sCreateTime = document.all.sCreateTime.value;	
				var opNote = document.all.opNote.value;					
				document.frm.action = "f9645_oprCfm.jsp?sCreateLogin="+sCreateLogin+"&sCreateName="+sCreateName+"&sCreateTime="+sCreateTime+"&opNote="+opNote;
				document.frm.submit();					
			}
			
			/**����ҳ��**/
			function doReset(){
				document.frm.sFunctionCode.value="";
				document.frm.sFunctionName.value="";
				document.frm.phoneNo.value="";
				//document.getElementsByName(iPromptType).checked = false;
				document.frm.sAdviceContent.value="";
				//document.frm.iPromptTypes.value="";				
			}
			
			/**�ر�ҳ��**/
	function doClose(){
			parent.removeTab("<%=opCode%>");
	}
	function setOpNote(){
		if(document.all.opNote.value=="")
		{
			document.all.opNote.value=="����Ա��<%=workNo%> ¼����ע���������Ϣ";
		}
		return true;
	}	
	function doClearFunctionInput(){
		document.all.sFunctionCode.value = "";
		document.all.sFunctionName.value = "";
		document.all.sFunctionCode.focus();
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
		<div class="title">
			<div id="title_zi">ע�������¼��</div>
		</div>	
		
		<table cellspacing="0">
				<tr>
					<td width="15%" class="blue" nowrap>��������</td>
					<td width="35%">
						<input type="text" name="sFunctionCode" value="">&nbsp;&nbsp;
						<input name="" type="button" class="b_text" style="cursor:hand" onClick="getFucntionInfo()" value="��ȡ">&nbsp;
						<input name=""  type="button" class="b_text" style="cursor:hand" onClick="doClearFunctionInput()" value="���">
					</td>
					<td width="15%" class="blue" nowrap>��������</td>
					<td>
						<input type="text" name="sFunctionName" value="">&nbsp;<font class="orange">(ƥ��ģ����ѯ)</font>
					</td>
				</tr>
				<tr>
					<td width="15%" class="blue" nowrap>��������</td>
					<td ><input type="text" name="sCreateLogin" value="<%=workNo%>" disabled></td>
					<td class="blue" nowrap>����������</td>
					<td ><input type="text" name="sCreateName" value="<%=workName%>" disabled></td>
				</tr>
				<tr>
					<td width="15%" class="blue" nowrap>������Ա�ֻ���</td>
					<td><input type="text" name="phoneNo" v_must="1" v_minlength=1 v_maxlength=16 v_type="string" index="0" value=""></td>
					<td class="blue" nowrap>����ʱ��</td>
					<td><input type="text" name="sCreateTime" value="<%=dateStr1%>" disabled></td>
				</tr>				
				<tr style="display:none">
					<td width="15%" class="blue" nowrap>��ʾ����</td>
					<td colspan="3">
					<input type="radio" name=iPromptType value="1" onclick="checkItem(this, 'mmAll')">��ǰ &nbsp;&nbsp;&nbsp;
					<input type="radio" name=iPromptType value="2" onclick="checkItem(this, 'mmAll')">���� &nbsp;&nbsp;&nbsp;
					<input type="radio" name=iPromptType value="3" onclick="checkItem(this, 'mmAll')">�º� &nbsp;&nbsp;&nbsp;
					<input type="radio" name=iPromptType value="4" onclick="checkItem(this, 'mmAll')">�ʷ�˵�� &nbsp;
					<input type="hidden" name="iPromptTypes" value="">
					</td>			
				</tr>
				</table>
    </div>		
<div id="Operation_Table"> 
	<div class="title">
	<div id="title_zi">��������</div>
	</div>
		<TABLE cellSpacing="0">
          <TBODY> 						
				<tr>
					<td width="15%" class="blue" nowrap>������Ϣ</td>
					<td colspan="3">
						<textarea name="sAdviceContent" rows="7" cols="75"></textarea>&nbsp;<font class="orange">(���512��)</font>
					</td>
				</tr>
				<tr>
					<td class="blue" nowrap>������ע</td>
					<td><input type="text" name="opNote" value="����Ա��<%=workNo%> ¼����ע���������Ϣ" size="90" maxlength="60" disabled></td>
				</tr>	
				<table cellspacing="0">
    	  <tr> 
    	    <td id="footer"> 
    	       <input type="button" name="resetButton"  class="b_foot" value="����" style="cursor:hand;" onclick="doReset()" >&nbsp;
    	       <input type="button" name="confirmButton" class="b_foot" value="ȷ��" style="cursor:hand;" onClick="doConfirm()" >&nbsp;
    	       <input type="button" name="closeButton" class="b_foot" value="�ر�" style="cursor:hand;" onClick="doClose()" >&nbsp;
    	    </td>
    	  </tr>
    	</table>
    </div>
    	<input type="hidden" name="sGroupId" value="<%=groupId%>">
		<%@ include file="/npage/include/footer.jsp" %> 
	</form>
</body>
</html>