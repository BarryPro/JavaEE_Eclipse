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
    
 		String opCode = "9607";
 		String opName = "ע��������޸�";
 		
		String workNo = (String)session.getAttribute("workNo");
		String workName = (String)session.getAttribute("workName");
		String orgCode = (String)session.getAttribute("orgCode");
		String regionCode  = (String)session.getAttribute("regCode");
		String belongName = (String)session.getAttribute("orgCode");
		String groupId = (String)session.getAttribute("groupId");
		String pass = (String)session.getAttribute("password");
		
		/**�����������������"����"��ʱ��,ҳ����ʾ�Ĳ�������**/
		String confirmFlag = WtcUtil.repNull(request.getParameter("confirmFlag"));
		
		
		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		String dateStr1 = new java.text.SimpleDateFormat("yyyyMMdd hh:mm:ss").format(new java.util.Date());
		
		/**�鿴���ŵļ���,�����Ӫҵ���ļ�����С,��������޸�ҳ��**/
		String checkSql = "select root_distance from dChnGroupMsg where group_id = '"+groupId+"'";
		System.out.println("#######checkSql->"+checkSql);
%>
		<wtc:pubselect  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>" outnum="1"> 
		<wtc:sql><%=checkSql%></wtc:sql>
		</wtc:pubselect> 
		<wtc:array  id="sVerifyTypeArr"  scope="end"/>
<%
		/**����loginRootDistance���жϹ���Ȩ������**/
		int loginRootDistance = 999999;
		if(retCode.equals("000000")){
			if(sVerifyTypeArr!=null&&sVerifyTypeArr.length>0){
				loginRootDistance = sVerifyTypeArr[0][0].equals("")?loginRootDistance:Integer.parseInt(sVerifyTypeArr[0][0]);
			}
		}
		
		/*zhangyan add ��������,���������˹��ͷ�*/
		String accountType=(String)session.getAttribute("accountType");
		System.out.println("zhangyan~~~~loginRootDistance="+loginRootDistance);
		System.out.println("zhangyan~~~~accoutType~~~~"+accountType);
	
		String sqlChn="select Channels_Code,Channels_Name "
			+"	from sChannelsCode "
			+"	where root_distance >="+loginRootDistance;
			
		if (accountType.equals("2"))
		{
			sqlChn+=" and Channels_Code='08' ";
		}	
		else
		{
			sqlChn+=" and Channels_Code<>'08' ";
		}
		sqlChn+="	order by Channels_Code  ";		
		
		System.out.println("9607~~~~sqlChn="+sqlChn);
		/**������ŵļ�������ظ�С,���ܽ����޸Ĳ���;1.�жϹ��ŵļ���,���root_distance==1,ʡ��,==2,����,==3,����,>3,Ӫҵ�����С�ļ���**/
		/*zhangyan add �ǿͷ����Ų�У��root_distance*/
		if (  ! accountType.equals("2") )
		{
			if(loginRootDistance>3){
			%>
					<table cellspacing="0">
						<tr bgcolor='649ECC' height=25 align="center">
							<td>
								<font style="color:red">(�˹������޸�Ȩ��)</font>
							</td>
						</tr>
					</table>
					<script language="javascript">
						<!--
						rdShowMessageDialog("�˹������޸�Ȩ��");
						window.close();
						//-->
					</script>		
				<%
				return;
			}
		}
%>
<html>
	<head>
	<title>������BOSS-ע��������޸�</title>
	<!--����js��-->
	<script language="javascript">
		<!--
			/**
				*��Ϊ�����û�����Ĵ�������,,���Ժ���д�Ĵ���û��rdShowMessageDialog(),����alert(),,�Լӿ�ҳ����Ӧ�ٶ�
				*��ģ����ʹ�õ�jtrim(),�����Ϸ���jtrim(),����ģ������д�ķ���,�����������
				*ҳ���߼�����,ʹ��Ƕ��iframe,Ҳ��Ӧ�û���Ҫ��
				*���ٴ��޸ĵ�ʱ��,,һ��Ҫ������߼�,,
				*/
				
			onload = function(){
				
				/**������δ�������������"����"��,ҳ����ʾ�ǲ�������.����ɾ����δ���,���Ҳ�Ӱ��ҳ��**/
				var confirmFlag = "<%=confirmFlag%>";
				if(confirmFlag=="fieldPromptConfirm"){
					showMessage(2);
				}else{
					showMessage(1);
				}	
				/***������Ϊֹ***/
			}
			
			/**��ʾ"���ݽ�������"**/
			function showOprInfo(){
				oprDiv.style.display="block";
				fieldDiv.style.display="none";
				document.all.confirmFlag.value="oprPromptConfirm";
			}

			/**��ʾ"����ҵ������"**/
			function showFieldInfo(){
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
					//���ݽ����޸�
					showOprInfo();
				}else if(flag==2){
					//����ҵ���޸�
					showFieldInfo();
				}
			}	
			
			/**ģ����ѯ����ģ����Ϣ**/
			function getFucntionInfo(){
				var sFunctionCode = document.all.sFunctionCode.value;
				var sFunctionName = document.all.sFunctionName.value;
				if(jtrim(sFunctionCode)==""&&jtrim(sFunctionName)==""){
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
        var path = "f9607_getFucntionInfo.jsp?sFunctionCode="+sFunctionCode+"&sFunctionName="+sFunctionName;
        var ret = window.showModalDialog(path, impFrm, prop);				
			}
			
			/**�������Ĳ���ģ����Ϣ,���ڲ�ѯ**/
			function doClearFunctionInput(){
				document.all.sFunctionCode.value = "";
				document.all.sFunctionName.value = "";
			}
			
			/**ģ����ѯ����ģ����Ϣ**/
			function getFucntionInfo2(){
				var sFunctionCode = document.all.sFunctionCode2.value;
				var sFunctionName = document.all.sFunctionName2.value;
				if(jtrim(sFunctionCode)==""&&jtrim(sFunctionName)==""){
					rdShowMessageDialog("ģ�������ģ�����Ʊ�������һ��!<br>(֧��ģ����ѯ,ֻ�����벿����Ϣ)");
					document.all.sFunctionCode2.focus();
					return false;
				}
        var h = 500;
        var w = 350;
        var t = screen.availHeight / 2 - h / 2;
        var l = screen.availWidth / 2 - w / 2;
        var impFrm = document.frm;
        var prop = "dialogHeight:" + h + "px; dialogWidth:" + w + "px; dialogLeft:" + l + "px; dialogTop:" + t + "px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
        var path = "f9607_getFucntionInfo.jsp?sFunctionCode="+sFunctionCode+"&sFunctionName="+sFunctionName;
        var ret = window.showModalDialog(path, impFrm, prop);				
			}	
	
			/**�������Ĳ���ģ����Ϣ,����yyy��ѯ**/
			function doClearFunctionInput2(){
				document.all.sFunctionCode2.value = "";
				document.all.sFunctionName2.value = "";
			}
			
			/**ѡ�����**/
			function getFieldClassCode(){
				document.getElementById("iClassCodeFrame").style.display = "block";
				document.iClassCodeFrame.location = "f9607_getFieldClassCode.jsp?iClassCode="+jtrim(document.all.iClassCode.value)+"&iClassName="+jtrim(document.all.iClassName.value);
			}
			
			/**���"��ѯ"��ť�������¼�**/
			function doQuery(){
				if(document.all.confirmFlag.value=="oprPromptConfirm"){
					var sFunctionCode = jtrim(document.all.sFunctionCode.value);
					var iBillType = document.all.iBillType.value;
					var iPromptType = document.all.iPromptType.value;
					var iPromptSeq = (document.all.iPromptSeq.value).trim();	
					var Channels_Code = document.all.Channels_Code.value;
						
					/**
					if(sFunctionCode==""||sFunctionCode.length==0){
						rdShowMessageDialog("��ʾ�������벻��Ϊ��!");
						document.all.sFunctionCode.focus();
						return false;
					}	
					**/
							
					document.getElementById("qryOprInfoFrame").style.display="block";
					document.qryOprInfoFrame.location.href = "f9607_getOprInfoByFunctionCode.jsp?sFunctionCode="+sFunctionCode+"&iBillType="+iBillType+"&iPromptType="+iPromptType+"&iPromptSeq="+iPromptSeq+"&Channels_Code="+Channels_Code+"&rootDistance=<%=loginRootDistance%>";
				}
				
				if(document.all.confirmFlag.value=="fieldPromptConfirm"){
					var iClassCode = jtrim(document.all.iClassCode.value);
					var sClassValue = jtrim(document.all.sClassValue.value);
					var iBillType = document.all.iBillType2.value;
					var iPromptType = document.all.iPromptType2.value;
					var iPromptSeq = jtrim(document.all.iPromptSeq2.value);
					var sFunctionCode = jtrim(document.all.sFunctionCode2.value);
					var Channels_Code2 = document.all.Channels_Code2.value;
					document.getElementById("qryFieldInfoFrame").style.display = "block";
					document.qryFieldInfoFrame.location.href = "f9607_getFieldInfoByClassCode.jsp?iClassCode="+iClassCode+"&sClassValue="+sClassValue+"&iPromptSeq2="+iPromptSeq+"&iPromptType2="+iPromptType+"&iBillType2="+iBillType+"&sFunctionCode2="+sFunctionCode+"&Channels_Code="+Channels_Code2+"&rootDistance=<%=loginRootDistance%>";						
				}
			}
			
			/**�ύҳ��**/
			function doConfirm(){
					/**����ǰ�"��������"�޸�**/
					if(document.all.confirmFlag.value=="oprPromptConfirm"){
						/**
						if(typeof(document.all.)){
							
						}
						**/
						
						var sFunctionCode = jtrim(document.all.sFunctionCode.value);
						var iBillType = document.all.iBillType.value;
						var iPromptType = document.all.iPromptType.value;
						var Channels_Code = document.all.Channels_Code.value;
						var iPromptSeq = jtrim(document.all.iPromptSeq.value);
						
						if(sFunctionCode==""||sFunctionCode.length==0){
							rdShowMessageDialog("�������벻��Ϊ��!");
							return false;
						}	
						if(iPromptType==""||iPromptType=="none"){
							rdShowMessageDialog("��ѡ����ʾ����!");
							return false;
						}					
						if(iBillType==""||iBillType=="none"){
							rdShowMessageDialog("��ѡ��Ʊ������!");
							return false;
						}
						if(iPromptSeq==""||iPromptSeq.length==0){
							rdShowMessageDialog("��ʾ��Ų���Ϊ��!");
							return false;
						}	
						if(Channels_Code==""||Channels_Code=="none"){
							rdShowMessageDialog("��ѡ����������!");
							return false;
						}
				}
				
				if(document.all.confirmFlag.value=="fieldPromptConfirm"){
					var sFunctionCode = jtrim(document.all.sFunctionCode2.value);
					var iClassCode = jtrim(document.all.iClassCode.value);
					var sClassValue = jtrim(document.all.sClassValue.value);
					var iBillType = document.all.iBillType2.value;
					var iPromptType = document.all.iPromptType2.value;
					var iPromptSeq = jtrim(document.all.iPromptSeq2.value);	
					var Channels_Code = document.all.Channels_Code2.value;
					
					if(sFunctionCode==""||sFunctionCode.length==0){
						rdShowMessageDialog("�������벻��Ϊ��!");
						document.all.iClassCode2.focus();
						return false;
					}
						
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
					if(Channels_Code==""||Channels_Code=="none"){
							rdShowMessageDialog("��ѡ����������!");
							return false;
					}	
				}
				

				
				if(document.all.confirmFlag.value=="oprPromptConfirm"){
					var sPromptContent = document.showOprInfoFrame.document.all.sPromptContent.value;
					var sIsPrint = document.showOprInfoFrame.document.all.sIsPrint.value;
					var sValidFlag = document.showOprInfoFrame.document.all.sValidFlag.value;
					var sModifyGroupId = document.showOprInfoFrame.document.all.sModifyGroupId.value;
					var sIsCreaterStart = document.showOprInfoFrame.document.all.sIsCreaterStart.value;
					var sAuditLogins = document.showOprInfoFrame.document.all.sAuditLogins.value;
					var opNote = document.showOprInfoFrame.document.all.opNote.value;
					
					if(jtrim(sPromptContent)==""){
						rdShowMessageDialog("��ʾ���ݲ���Ϊ��!");
						return false;	
					}
					
					if(jtrim(sPromptContent).length>512){
						rdShowMessageDialog("��ʾ���ݳ�������,���ܴ���512�֣�");
						return false;						
					}
					
					if(jtrim(sAuditLogins)==""){
						rdShowMessageDialog("����ѡ��������,������Ҫѡ��һ��!");
						return false;							
					}	
										
					if(jtrim(opNote).length>30){
						rdShowMessageDialog("������ע����,��ɾ����");
						return false;							
					}
					
					var confirmFlag = rdShowConfirmDialog("ȷ��Ҫ�ύ������?");
					if(confirmFlag!=1){
						return false;
					}
					
					document.frm.action = "f9607_oprCfm.jsp?sPromptContent="+sPromptContent+"&sIsPrint="+sIsPrint+"&sValidFlag="+sValidFlag+"&sModifyGroupId="+sModifyGroupId+"&sIsCreaterStart="+sIsCreaterStart+"&sAuditLogins="+sAuditLogins+"&opNote="+opNote;
					document.frm.submit();					
				}else if(document.all.confirmFlag.value=="fieldPromptConfirm"){
					var iClassSeq = document.showFieldInfoFrame.document.all.iClassSeq.value;
					var sIsByValue = document.showFieldInfoFrame.document.all.sIsByValue.value;
					var sLimitRule = document.showFieldInfoFrame.document.all.sLimitRule.value;
					var sPromptContent2 = document.showFieldInfoFrame.document.all.sPromptContent2.value;
					var sIsPrint2 = document.showFieldInfoFrame.document.all.sIsPrint2.value;	
 					var sValidFlag2 = document.showFieldInfoFrame.document.all.sValidFlag2.value;
 					var sModifyGroupId2 = document.showFieldInfoFrame.document.all.sModifyGroupId2.value;
 					var sAuditLogins2 = document.showFieldInfoFrame.document.all.sAuditLogins.value;
 					var sIsCreaterStart2 = document.showFieldInfoFrame.document.all.sIsCreaterStart2.value;
 					var opNote2 = document.showFieldInfoFrame.document.all.opNote2.value;
 					
 					if(sValidFlag2==""||sValidFlag2=="none"){
 						rdShowMessageDialog("����ѡ��'��Ч��־'!");
 						return false;
 					}
 					
 					if(iClassSeq.search(/^[0-9]*[1-9][0-9]*$/)==-1){
 						rdShowMessageDialog("'���˳��'������������!");
 						return false;
 					}
 	
					if(jtrim(sPromptContent2)==""){
						rdShowMessageDialog("��ʾ���ݲ���Ϊ�գ�");
						return false;						
					}
									
					if(jtrim(sPromptContent2).length>512){
						rdShowMessageDialog("��ʾ���ݳ�������,���ܴ���512�֣�");
						return false;						
					}
					
					if(jtrim(sAuditLogins2)==""){
						rdShowMessageDialog("����ѡ��������,������Ҫѡ��һ��!");
						return false;							
					}
					
					if(jtrim(opNote2).length>30){
						rdShowMessageDialog("������ע����,��ɾ����");
						return false;							
					}
					
					var confirmFlag = rdShowConfirmDialog("ȷ��Ҫ�ύ������?");
					if(confirmFlag!=1){
						return false;
					}			
							 
					document.frm.action = "f9607_fieldCfm.jsp?iClassSeq="+iClassSeq+"&sIsByValue="+sIsByValue+"&sLimitRule="+sLimitRule+"&sPromptContent2="+sPromptContent2+"&sIsPrint2="+sIsPrint2+"&sValidFlag2="+sValidFlag2+"&sModifyGroupId2="+sModifyGroupId2+"&sAuditLogins2="+sAuditLogins2+"&sIsCreaterStart2="+sIsCreaterStart2+"&opNote2="+opNote2;
					document.frm.submit();
				}
			}
			/**�����ַ����ҵĿո�**/
			function jtrim(str){
				if(str==null){
					return "";	
				}
				return str.replace( /^\s*/, "" ).replace( /\s*$/, "" );	
			}		
				
			/**����ҳ��**/
			function doReset(){
				//window.location.reload();
				//��"����"ҳ��ʱ,���������־�Զ���ת������ǰ���Ǹ�ҳ��
				window.location.href = "f9607_1.jsp?confirmFlag="+document.all.confirmFlag.value;
			}
			
			/**�ر�ҳ��**/
			function doClose(){
				parent.removeTab("<%=opCode%>");
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

<!--
	������������,1,����,2,�ջ�,3,����
	/**
		����ӡ����Ϊ"1,��ʾ"��ʱ��,��ʾ����:12-����
		����ӡ����Ϊ"2,��ӡ"��ʱ��,��ʾ����:13-�º�2-�ʷ�˵��
		����ӡ����Ϊ"3,��ӡ����ʾ"��ʱ��,��ʾ����:12-����
	**/
-->
			
<body>
	<form action="" method="post" name="frm">
		<%@ include file="/npage/include/header.jsp" %>
		<!--���������ǳ���Ҫ.��Ҫ��ͨ������������"���ݽ����޸�"����"����ҵ���޸�"-->
		<input type="hidden" name="confirmFlag" value="oprPromptConfirm">
		<!--
			//�������createLogin������ҳ��,�����ж�:
			//�����������صļ���ʱ,������������Ÿ��޸��˹��űȶ�,
			//������,���޸ķ����;��Ϊ:�����˷�����޸�
			//��������,���޸ķ����;��Ϊ:�޸��߷�����޸�
		-->
		<input type="hidden" name="createLogin" value="">
		<!--����Ϊ��������-->
		
		<div class="title">
			<div id="title_zi">��ѡ���������</div>
		</div>
		
		<!--�л���ǩ,����и����ʵı�ǩ,,�����滻-->
		 <table cellSpacing="0">
		 	<tr>
		 		<td>
					<div id="tabsJ">
						<ul id="guidanceUl">
							<li id="li1" class="current"><a onclick="showMessage(1)"><span>���ݽ����޸�</span></a></li>
							<li id="li2"><a onclick="showMessage(2)"><span>����ҵ���޸�</span></a></li>
						</ul>
					</div>
				</td>
			</tr>
		</table>

		<!--
			/*@service information
			 *@name						s9607Cfm1
			 *@description				ע���������޸�
			 *@author					lugz
			 *@created	2008-10-10 9:05:18
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
			 
			 *@inparam	sFunctionCode	��ʾ��������
			 *@inparam	iBillType	Ʊ������
			 *@inparam	iPromptType	��ʾ����
			 *@inparam	iPromptSeq	��ʾ���
			 *@inparam	sReleaseGroup ������Դ
			 *@inparam	sPromptContent	��ʾ����
			 *@inparam	sIsPrint	�Ƿ��ӡ
			 *@inparam	sValidFlag	��Ч��־
			 *@inparam	sModifyGroupId �޸Ľڵ�
			 *@inparam	sIsCreaterStart Y/N
			 *@inparam	sAuditLogin	������
			 
			 *@output parameter information		
			 *@outparam	loginAccept		��ˮ	�����ڷ��������ɵ���ˮ����ԭ�������ˮ
			 *@return SVR_ERR_NO 
			 */
		-->
		<div id="oprDiv" style="display:block">
			<table cellspacing="0" align="center">
				<tr>
					<td width="15%" class="blue" nowrap>��������</td>
					<td width="35%">
						<input type="text" name="sFunctionCode" value="" onKeyDown="if(event.keyCode==13){doQuery();}">&nbsp;
						<input type="hidden" name="sFunctionCodeHidden" value="">
						<input name="queryfcbutton" type="button" class="b_text" style="cursor:hand" onClick="getFucntionInfo()" value="��ȡ">&nbsp;
						<input name="clearfcbutton"  type="button" class="b_text" style="cursor:hand" onClick="doClearFunctionInput()" value="���">
					</td>
					<td width="15%" class="blue" nowrap>��������</td>
					<td>
						<input type="text" name="sFunctionName" value="" onKeyDown="if(event.keyCode==13){getFucntionInfo();}">&nbsp;<font class="orange">(ƥ��ģ����ѯ)</font>
					</td>
				</tr>
				<tr>
					<td width="15%" class="blue" nowrap>��ʾ����</td>
					<td>
						<select name="iPromptType">
							<option value="none" selected>��ѡ��</option>
							<wtc:qoption name="sPubSelect" outnum="2">
							<wtc:sql>select prompt_type,prompt_type||'->'||prompt_name from sFuncPromptType where prompt_type = '11' or prompt_type = '10' or prompt_type='13' or prompt_type='2' order by prompt_type</wtc:sql><!--update by diling for ��棺ע��������޸ĺ�ɾ�����ɹ�@2011/11/3-->
							</wtc:qoption>
						</select>	
						<input type="hidden" name="iPromptTypeHidden" value="">					
					</td>
					<td class="blue">Ʊ������</td>
					<td>
						<select name="iBillType">
							<option value="none" selected>��ѡ��</option>
							<wtc:qoption name="sPubSelect" outnum="2">
							<wtc:sql>select bill_type,bill_type||'->'||bill_name from sPrintBillType where bill_type = '1'</wtc:sql>
							</wtc:qoption>
						</select>		
						<input type="hidden" name="iBillTypeHidden" value="">				
					</td>
				</tr>
				<tr>
					<td width="15%" class="blue" nowrap>��ʾ���</td>
					<td width="35%" >
						<input type="text" name="iPromptSeq" value="">
						<input type="hidden" name="iPromptSeqHidden" value="">		
					</td>
					<td  class="blue" nowrap>��������</td>
					<td >
						<select name="Channels_Code">
							<wtc:qoption name="sPubSelect" outnum="2">
							<wtc:sql><%=sqlChn%></wtc:sql>
							</wtc:qoption>
						</select>				
						  <input type="hidden" name="Channels_CodeHidden" value="">									
					</td>			
				</tr>
				<tr>
					<td colspan="4" style="height:0;">
						<iframe frameBorder="0" id="qryOprInfoFrame" align="center" name="qryOprInfoFrame" scrolling="no" style="height:100%; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('qryOprInfoFrame').style.height=qryOprInfoFrame.document.body.scrollHeight+'px'"></iframe>
					</td>
				</tr>
				<tr>
					<td colspan="4" style="height:0;">
						<iframe frameBorder="0" id="showOprInfoFrame" align="center" name="showOprInfoFrame" scrolling="no" style="height:100%; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('showOprInfoFrame').style.height=showOprInfoFrame.document.body.scrollHeight+'px'"></iframe>
					</td>
				</tr>
			</table>
		</div>
		<!--
			/*@service information
			 *@name						s9607Cfm2
			 *@description				ע�������޸�
			 *@author					lugz
			 *@created	2008-10-10 11:12:30
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
			 
			 
			 *@inparam	sFunctionCode	��ʾ��������
			 *@inparam	iBillType	Ʊ������
			 *@inparam	iClassSeq	���˳��
			 *@inparam	iClassCode	����
			 *@inparam	sClassValue	�ֶ���ֵ
			 *@inparam	sIsByValue	�Ƿ��մ�����ʾ
			 *@inparam	sLimitRule	ǰ������
			
			 *@inparam	iPromptType	��ʾ����
			 *@inparam	iPromptSeq	��ʾ���
			 *@inparam	sPromptContent	��ʾ����
			 *@inparam	sIsPrint	�Ƿ��ӡ
			 *@inparam	sValidFlag	��Ч��־
			 *@inparam	sModifyGroupId �޸Ľڵ�
			 *@inparam	sIsCreaterStart Y/N
			 *@inparam	sAuditLogin	������
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
						<input type="text" name="iClassCode" value="">&nbsp;&nbsp;
						<input name="queryccbutton" type="button" class="b_text" style="cursor:hand" onClick="getFieldClassCode()" value="��ѯ">
						<input type="hidden" name="iClassCodeHidden" value="">
					</td>
					<td width="15%" class="blue" nowrap>�ֶ�������</td>
					<td width="35%">
						<input type="text" name="iClassName" value="">&nbsp;<font class="orange">(֧��ģ����ѯ)</font>
					</td>	
				</tr>
				<tr>
					<td colspan="4" style="height:0;">
							<iframe frameBorder="0" id="iClassCodeFrame" align="center" name="iClassCodeFrame" scrolling="no" style="height:100%; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('iClassCodeFrame').style.height=iClassCodeFrame.document.body.scrollHeight+'px'"></iframe>
					</td>
				</tr>
				<tr>
					<td width="15%" class="blue" nowrap>��������</td>
					<td width="35%">
						<input type="text" name="sFunctionCode2" value="" onKeyDown="if(event.keyCode==13){doQuery();}">&nbsp;&nbsp;
						<input name="queryfcbutton2" type="button" class="b_text" style="cursor:hand" onClick="getFucntionInfo2()" value="��ȡ">&nbsp;
						<input name="clearfcbutton2"  type="button" class="b_text" style="cursor:hand" onClick="doClearFunctionInput2()" value="���">
						<input type="hidden" name="sFunctionCode2Hidden" value="">
					</td>
					<td width="15%" class="blue" nowrap>��������</td>
					<td>
						<input type="text" name="sFunctionName2" value="" onKeyDown="if(event.keyCode==13){getFucntionInfo2();}">&nbsp;<font class="orange">(ƥ��ģ����ѯ)</font>
					</td>
				</tr>
				<tr>
					<td width="15%" class="blue">�ֶ���ֵ</td>
					<td>
						<input type="text" name="sClassValue" value="">
						<input type="hidden" name="sClassValueHidden" value="">
					</td>	
					<td width="15%" class="blue">��ʾ���</td>
					<td>
						<input type="text" name="iPromptSeq2" value="">
						<input type="hidden" name="iPromptSeq2Hidden" value="">	
					</td>
				</tr>
				<tr>		
					<td width="15%" class="blue" nowrap>��ʾ����</td>
					<td>
						<select name="iPromptType2">
							<option value="none" selected>��ѡ��</option>
							<wtc:qoption name="sPubSelect" outnum="2">
							<wtc:sql>select prompt_type,prompt_type||'->'||prompt_name from sFuncPromptType where prompt_type = '12' or prompt_type = '10' or prompt_type='13' or prompt_type='2' order by prompt_type</wtc:sql><!--update by diling for ��棺ע��������޸ĺ�ɾ�����ɹ�@2011/11/3-->
							</wtc:qoption>
						</select>
						<input type="hidden" name="iPromptType2Hidden" value="">						
					</td>
					<td class="blue">Ʊ������</td>
					<td>
						<select name="iBillType2">
							<option value="none" selected>��ѡ��</option>
							<wtc:qoption name="sPubSelect" outnum="2">
							<wtc:sql>select bill_type,bill_type||'->'||bill_name from sPrintBillType where bill_type = '1'</wtc:sql>
							</wtc:qoption>
						</select>
						<input type="hidden" name="iBillType2Hidden" value="">						
					</td>
				</tr>
							<tr>
				<td  class="blue" nowrap>��������</td>
					<td colspan="3">
						<select name="Channels_Code2">
						  <wtc:qoption name="sPubSelect" outnum="2">
							<wtc:sql><%=sqlChn%></wtc:sql>
							</wtc:qoption>
						</select>						
						<input type="hidden" name="Channels_Code2Hidden" value="">	
					</td>			
				</tr>
				<tr>
					<td colspan="4" style="height:0;">
						<iframe frameBorder="0" id="qryFieldInfoFrame" align="center" name="qryFieldInfoFrame" scrolling="no" style="height:100%; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('qryFieldInfoFrame').style.height=qryFieldInfoFrame.document.body.scrollHeight+'px'"></iframe>
					</td>
				</tr>
				<tr>
					<td colspan="4" style="height:0;">
						<iframe frameBorder="0" id="showFieldInfoFrame" align="center" name="showFieldInfoFrame" scrolling="no" style="height:100%; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('showFieldInfoFrame').style.height=showFieldInfoFrame.document.body.scrollHeight+'px'"></iframe>
					</td>
				</tr>
			</table>
		</div>
		<!--����Ϊ��������-->
		<table cellSpacing="0">
      <tr> 
        <td id="footer"> 
        	 <input type="button" name="queryButton"  class="b_foot" value="��ѯ" style="cursor:hand;" onclick="doQuery()">&nbsp;
           <input type="button" name="resetButton"  class="b_foot" value="����" style="cursor:hand;" onclick="doReset()">&nbsp;
           <input type="button" name="confirmButton" class="b_foot" value="ȷ���޸�" style="cursor:hand;" onClick="doConfirm()" disabled>&nbsp;
           <input type="button" name="closeButton" class="b_foot" value="�ر�" style="cursor:hand;" onClick="doClose()">&nbsp;
        </td>
      </tr>
     </table>
    <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
