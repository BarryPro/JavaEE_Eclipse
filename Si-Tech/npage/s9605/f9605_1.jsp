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
    
 		String opCode = "9605";
 		String opName = "ע�����������";
 		
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
		String dateStr1 = new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss").format(new java.util.Date());
		
		/***���������жϹ�����������ע�������Ȩ�޵�:
		�����Ӫҵ��������,��û��Ȩ��***/
		String sReleaseGroupName = "";
		String getGroupNameSql = "select group_name ,root_distance from dChnGroupMsg where group_id  = '"+groupId+"'";		
%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
		<wtc:sql><%=getGroupNameSql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="sVerifyTypeArr" scope="end" />
<%
	int root_distance_int = 0;
	/*zhangyan add ��������,���������˹��ͷ�*/
	String accountType=(String)session.getAttribute("accountType");
	System.out.println("zhangyan~~~~accoutType~~~~"+accountType);
	if(retCode1.equals("000000")){
		/*zhangyan ��¼����������֯������root_distance*/
		String root_distance = sVerifyTypeArr[0][1];
		root_distance_int = Integer.parseInt(root_distance);
		
		/*zhangyan �޸�ֻ�з��˹��ͷ����Ų��ж�*/
		if ( !(accountType.equals("2")) )
		{
			if(root_distance_int>3 )
			{
			%>
				<script>
				rdShowMessageDialog("�ù���������Ȩ��!");
				window.close();
				</script>
			<%
			return ;
			}
		}
		if(sVerifyTypeArr!=null&&sVerifyTypeArr.length>0){
			sReleaseGroupName = sVerifyTypeArr[0][0];
		}
	}
	

	String sqlChn="select Channels_Code,Channels_Name "
		+"	from sChannelsCode "
		+"	where root_distance >="+root_distance_int;
		
	if (accountType.equals("2"))
	{
		sqlChn+=" and Channels_Code='08' ";
	}		
	else
	{
		sqlChn+=" and Channels_Code<>'08' ";
	}
	sqlChn+="	order by Channels_Code  ";
	

		
%>
<html>
	<head>
	<title>������BOSS-ע�����������</title>
	<script language="javascript">
		<!--
			/**
				*��Ϊ�����û�����Ĵ�������,,���Ժ���д�Ĵ���û��rdShowMessageDialog(),����alert(),,�Լӿ�ҳ����Ӧ�ٶ�
				*��ģ����ʹ�õ�jtrim(),�����Ϸ���jtrim(),����ģ������д�ķ���,�����������
				*ҳ���߼�����,ʹ��Ƕ��iframe,Ҳ��Ӧ�û���Ҫ��
				*���ٴ��޸ĵ�ʱ��,,һ��Ҫ������߼�,,
				*/
			
			
			onload=function(){
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
					//���ݽ�������
					showOprInfo();
				}else if(flag==2){
					//����ҵ������
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
        var path = "f9605_getFucntionInfo.jsp?sFunctionCode="+sFunctionCode+"&sFunctionName="+sFunctionName;
        var ret = window.showModalDialog(path, impFrm, prop);				
			}
			
			/**�������Ĳ���ģ����Ϣ,����yyy��ѯ**/
			function doClearFunctionInput(){
				document.all.sFunctionCode.value = "";
				document.all.sFunctionName.value = "";
				document.all.sFunctionCode.focus();
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
        var path = "f9605_getFucntionInfo.jsp?sFunctionCode="+sFunctionCode+"&sFunctionName="+sFunctionName;
        var ret = window.showModalDialog(path, impFrm, prop);				
			}	
	
			/**�������Ĳ���ģ����Ϣ,����yyy��ѯ**/
			function doClearFunctionInput2(){
				document.all.sFunctionCode2.value = "";
				document.all.sFunctionName2.value = "";
				document.all.sFunctionCode2.focus();
			}
							
			/**
			����ӡ����Ϊ"1,��ʾ"��ʱ��,��ʾ����:11-��ǰ��13-�º�
			����ӡ����Ϊ"2,��ӡ"��ʱ��,��ʾ����:13-�º�  @20081024 ѡС������ʱ����ӡѡ��ֻ�С���ӡ������ʾ����ֻ�С��ʷ�˵����
			����ӡ����Ϊ"3,��ӡ����ʾ"��ʱ��,��ʾ����:11-��ǰ��13-�º�
			**/
			function doChangeIsPrintSelect(obj){
				
				var iPromptType = document.getElementById("iPromptType");
				var ln=iPromptType.length;
				while(ln--)
        {
          iPromptType.options[ln] = null;
        }
        
				if(obj.value=="1"){
						var option =new Option("11-��ǰ","11");  
           iPromptType.add(option); 
           
					 var option =new Option("13-�º�","13");  
           iPromptType.add(option); 
				}else if(obj.value=="2"){
				
           var option =new Option("13-�º�","13");  
           iPromptType.add(option); 
				
				}else if(obj.value=="3"){
				
					 var option =new Option("11-��ǰ","11");  
           iPromptType.add(option); 
           
           var option =new Option("13-�º�","13");  
           iPromptType.add(option); 
				
				}
			}
			
							
			/**
			����ӡ����Ϊ"1,��ʾ"��ʱ��,��ʾ����:12-����
			����ӡ����Ϊ"2,��ӡ"��ʱ��,��ʾ����:13-�º�2-�ʷ�˵��
			����ӡ����Ϊ"3,��ӡ����ʾ"��ʱ��,��ʾ����:12-����
			**/
			function doChangeIsPrint2Select(obj){
				
				var iPromptType = document.getElementById("iPromptType2");
				var ln=iPromptType.length;
				while(ln--)
        {
          iPromptType.options[ln] = null;
        }
        
				if(obj.value=="1"){
					
					 var option =new Option("12-����","12");  
           iPromptType.add(option); 
				
				}else if(obj.value=="2"){
				
           var option =new Option("13-�º�","13");  
           iPromptType.add(option); 
           
           if(document.getElementById("iClassCode").value=="10442"||document.getElementById("iClassCode").value=="10702")
           {
           	//var option =new Option("2-�ʷ�˵��","2");  
           	//iPromptType.add(option);
           	
           	if(document.getElementById("iClassCode").value=="10702"){
           		iPromptType.value="2";
           		iPromptType.disabled = true;
           	}else{
           		iPromptType.disabled = false;	
           	}
           }
				
				}else if(obj.value=="3"){
				
					 var option =new Option("12-����","12");  
           iPromptType.add(option); 
				}
				
			}
			
			/**�ı䷢���ڵ����ʹ������¼�**/
			function doChangePromNodeType(){
				
				var confirmFlag = document.all.confirmFlag.value;
				document.all.townByRegionTr.style.display = "none";
				var promulgateNodeType = document.all.promulgateNodeType;
				
				if(promulgateNodeType.value=="none"){
					document.getElementById("promulgateNodeFrame").style.display="none";
					return false;
				}
				document.getElementById("promulgateNodeFrame").style.display = "block";
				
				if(promulgateNodeType.value=="0"){
					
					document.promulgateNodeFrame.location = "f9605_getPromNodeByProvince.jsp?prom_group_id="+document.all.townByRegionSelect.value+"&root_distance_int=<%=root_distance_int%>";
				}
				else if(promulgateNodeType.value=="1"){
					if("<%=groupId%>"=="10014"&&
							confirmFlag=="fieldPromptConfirm"&&
							document.getElementById("iPromptType2").value=="2"&&
							(document.getElementById("iClassCode").value=="10442"||document.getElementById("iClassCode").value=="10702"))
					{
							document.promulgateNodeFrame.location = "f9605_getPromNodeByRegion_all.jsp?root_distance_int=<%=root_distance_int%>";
					}
					else
					{
							document.promulgateNodeFrame.location = "f9605_getPromNodeByRegion.jsp?root_distance_int=<%=root_distance_int%>";
					}
				}else if(promulgateNodeType.value=="2"){
					document.all.townByRegionTr.style.display = "block";
					document.promulgateNodeFrame.location = "f9605_getPromNodeByTown.jsp?prom_group_id="+document.all.townByRegionSelect.value+"&root_distance_int=<%=root_distance_int%>";
				}
			}
			
			/**�����ڵ�������"����"ʱ,ѡ��"����"���õĺ���**/
			function doChangeTownByRegion(){
				document.promulgateNodeFrame.location = "f9605_getPromNodeByTown.jsp?prom_group_id="+document.all.townByRegionSelect.value+"&root_distance_int=<%=root_distance_int%>";
			}
			
			/**ѡ�����**/
			function getFieldClassCode(){
				document.getElementById("iClassCodeFrame").style.display = "block";
				document.iClassCodeFrame.location = "f9605_getFieldClassCode.jsp?iClassCode="+jtrim(document.all.iClassCode.value)+"&iClassName="+jtrim(document.all.iClassName.value);
			}
			
			/**�����ַ����ҵĿո�**/
			function jtrim(str){
				if(str==null){
					return "";	
				}
				return str.replace( /^\s*/, "" ).replace( /\s*$/, "" );	
			}
			
			/**�ύҳ��**/
			function doConfirm(){
				if(document.all.confirmFlag.value=="oprPromptConfirm"){
					
					if(jtrim(document.all.sFunctionCode.value)==""){
						rdShowMessageDialog("����д��������!");
						document.all.sFunctionCode.focus();
						return false;
					}
					
					if(document.getElementById("iBillType").value=="none")
					{
						rdShowMessageDialog("��ѡ��Ʊ������");
						return false
					}
					
					if(document.getElementById("sIsPrint").value=="none")
					{
						rdShowMessageDialog("��ѡ���ӡѡ��");
						return false
					}
					
					if(document.getElementById("iPromptType").value=="none")
					{
						rdShowMessageDialog("��ѡ����ʾ����");
						return false
					}
					
				  if(document.getElementById("Channels_Code").value=="none")
					{
						rdShowMessageDialog("��ѡ����������");
						return false
					}
					
					//��֤��Чʱ����ʧЧʱ��
					if(jtrim(document.all.sValidTime.value)==""){
						rdShowMessageDialog("��Чʱ�䲻��Ϊ��!");
						return false;
					}
					
					if(parseInt(jtrim(document.all.sValidTime.value))<<%=dateStr%>){
						rdShowMessageDialog("��Чʱ�䲻��С�ڵ�ǰʱ��!");
						return false;						
					}

					if(jtrim(document.all.sInvalidTime.value)==""){
						rdShowMessageDialog("ʧЧʱ�䲻��Ϊ��!");
						return false;
					}
					
					if(parseInt(jtrim(document.all.sInvalidTime.value))<<%=dateStr%>){
						rdShowMessageDialog("ʧЧʱ�䲻��С�ڵ�ǰʱ��!");
						return false;						
					}
					
					chkTime(parseInt(jtrim(document.all.sInvalidTime.value)),parseInt(jtrim(document.all.sValidTime.value)));				
										
					if(document.getElementById("sPromptContent").value=="")
					{
						rdShowMessageDialog("��������ʾ����");
						document.getElementById("sPromptContent").focus();
						return false;
					}
					
					if(document.getElementById("sPromptContent").value.length>512)
					{
						rdShowMessageDialog("��ʾ���ݳ�������,���ܴ���512�֣�");
						return false;
					}					
					
					if(document.all.sGroupId.value==""){
							rdShowMessageDialog("��ѡ�񷢲�����!");
							return false;
					}
					
					if(document.all.sAuditLogins.value == ""){
							rdShowMessageDialog("��ѡ��������,������������Ҫһ��!");
							return false;							
					}
				}
				
				
				if(document.all.confirmFlag.value=="fieldPromptConfirm"){
					
					if(jtrim(document.all.iClassCode.value)==""){
						rdShowMessageDialog("����д����!");
						document.all.iClassCode.focus();
						return false						
					}
					
					if(document.getElementById("sClassValue").value=="")
					{
						rdShowMessageDialog("�������ֶ���ֵ");
						document.getElementById("sClassValue").focus();
						return false
					}
					
					//�ͻ�:�������ҵ�����ӽ�������ѹ��ܣ���ѡ���ʷ�ģ������������ʱ��
					//���ʷѴ����Ϊ��λ�����ֶ���ֵ�������ڣ�λʱ���������ѣ�
					/*��Ʒ����yanpxע�� 
					if(document.all.iClassCode.value=="10442"){
						if(jtrim(document.all.sClassValue.value).length!=8){
							rdShowMessageDialog("��ѡ���ʷ�ģ������������ʱ,�ֶ���ֵ����ӦΪ8λ!");
							document.all.sClassValue.focus();
							document.all.sClassValue.select();
							return false;
						}
					}
					*/
					if(document.getElementById("iClassSeq").value=="")
					{
						rdShowMessageDialog("���������˳��");
						document.getElementById("iClassSeq").focus();
						return false
					}
					
						if(document.getElementById("iBillType2").value=="none")
					{
						rdShowMessageDialog("��ѡ��Ʊ������");
						return false
					}
					
					if(document.getElementById("sIsPrint2").value=="none")
					{
						rdShowMessageDialog("��ѡ���ӡѡ��");
						return false
					}
					
					if(document.getElementById("iPromptType2").value=="none")
					{
						rdShowMessageDialog("��ѡ����ʾ����");
						return false
					}
										
					if(document.getElementById("Channels_Code2").value=="none")
					{
						rdShowMessageDialog("��ѡ����������");
						return false
					}
					
					if(jtrim(document.all.sFunctionCode2.value)==""){
						rdShowMessageDialog("����д��������!");
						document.all.sFunctionCode2.focus();
						return false;
					}
					
					/**����ҵ�����ӵ�,ģ��������Ϊ"ALL"**/
					if(jtrim(document.all.sFunctionCode2.value).toUpperCase()=="ALL"){
						/**����Ҫ����ı����Ǵ�д��"ALL",��ֹҳ�洫��Ĳ��Ǵ�д**/
						document.all.sFunctionCode2.value = jtrim(document.all.sFunctionCode2.value).toUpperCase();
					}
					
					//��֤��Чʱ����ʧЧʱ��
					if(jtrim(document.all.sValidTime2.value)==""){
						rdShowMessageDialog("��Чʱ�䲻��Ϊ��!");
						return false;
					}
					
					if(parseInt(jtrim(document.all.sValidTime2.value))<<%=dateStr%>){
						rdShowMessageDialog("��Чʱ�䲻��С�ڵ�ǰʱ��!");
						return false;						
					}

					if(jtrim(document.all.sInvalidTime2.value)==""){
						rdShowMessageDialog("ʧЧʱ�䲻��Ϊ��!");
						return false;
					}
					
					if(parseInt(jtrim(document.all.sInvalidTime2.value))<<%=dateStr%>){
						rdShowMessageDialog("ʧЧʱ�䲻��С�ڵ�ǰʱ��!");
						return false;						
					}
					
					chkTime(parseInt(jtrim(document.all.sInvalidTime2.value)),parseInt(jtrim(document.all.sValidTime2.value)));				
					
					if(jtrim(document.all.sPromptContent2.value)=="")
					{
						rdShowMessageDialog("��������ʾ����");
						document.all.sPromptContent2.focus();
						return false;
					}
					
					if(document.all.sPromptContent2.value.length>512)
					{
						rdShowMessageDialog("��ʾ���ݳ�������,���ܴ���512�֣�");
						return false;
					}
					
					if(document.all.sGroupId.value==""){
							rdShowMessageDialog("��ѡ�񷢲�����!");
							return false;
					}
					
					if(document.all.sAuditLogins.value == ""){
							rdShowMessageDialog("��ѡ��������,������������Ҫһ��!");
							return false;							
					}
				}
				
				var confirmFlag = rdShowConfirmDialog("ȷ��Ҫ�ύ������?");
				if(confirmFlag!=1){
					return false;
				}
				
				if(document.all.confirmFlag.value=="oprPromptConfirm"){
					/**�������²���,�������disabled���ܴ�ֵ����**/
					var iPromptType = document.all.iPromptType.value;
					var sValidFlag = document.all.sValidFlag.value;
					var sCreateLogin = document.all.sCreateLogin.value;
					var sCreateTime = document.all.sCreateTime.value;

					document.frm.action = "f9605_oprCfm.jsp?iPromptType="+iPromptType+"&sValidFlag="+sValidFlag+"&sCreateLogin="+sCreateLogin+"&sCreateTime="+sCreateTime;
					document.frm.submit();					
				} 
				
				if(document.all.confirmFlag.value=="fieldPromptConfirm"){
					/**�������²���,�������disabled���ܴ�ֵ����**/
					var iPromptType2 = document.all.iPromptType2.value;
					var sValidFlag2 = document.all.sValidFlag2.value;
					var sCreateLogin2 = document.all.sCreateLogin2.value;
					var sCreateTime2 = document.all.sCreateTime2.value;
					var sIsByValue = document.all.sIsByValue.value;
					var sIsPrint2 = document.all.sIsPrint2.value;
					
					document.frm.action = "f9605_fieldCfm.jsp?iPromptType2="+iPromptType2+"&sValidFlag2="+sValidFlag2+"&sCreateLogin2="+sCreateLogin2+"&sCreateTime2="+sCreateTime2+"&sIsByValue="+sIsByValue+"&sIsPrint2="+sIsPrint2;
					document.frm.submit();
				}
			}
			
			/**����ҳ��**/
			function doReset(){
				//��"����"ҳ��ʱ,����confirmFlag�����־�Զ���ת������ǰ���Ǹ�ҳ��
				window.location.href = "f9605_1.jsp?confirmFlag="+document.all.confirmFlag.value;
			}
			
			/**�ر�ҳ��**/
			function doClose(){
				parent.removeTab("<%=opCode%>");
			}
			
			function chkTime(time1,time2)
			{
				if(parseInt(time2.value)<=parseInt(time1.value))
				{
					time2.select();
					rdShowMessageDialog("ʧЧʱ��Ӧ������Чʱ��");
					return;
				}
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
	   <table cellSpacing="0">
			<tr height=20 background="../../images/jl_background_4.gif" style="height=100%">
				<td  style="height=100%" width="5%" nowrap>
					<a id="tabhead1" style="CURSOR: hand; TEXT-DECORATION: none" class="tabnodisp" href="javascript:onclick=showOprInfo()" value="1">&nbsp;&nbsp;<font id="font1" color="3366cc">���ݽ�������&nbsp;&nbsp;</font></a>
				</td>            
	 			<td  width="5%" nowrap>
					<a id="tabhead2" style="CURSOR: hand; TEXT-DECORATION: none" class="tabdisp" href="javascript:onclick=showFieldInfo()" value="1">&nbsp;&nbsp;<font id="font2" color="">����ҵ������&nbsp;&nbsp;</font></a>
				</td> 
				<td width="90%">&nbsp;</td>
			</tr>
		</table>
		-->
	
		<!--
		/*@service information
			 *@name						s9605Cfm1
			 *@description				ע����������
			 *@author					lugz
			 *@created	2008-10-07 17:13:21
			 *@version %I%, %G%
			 *@since 1.00
			 *@input parameter information
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
			 *@inparam	sReleaseGroup ������Դ
			 *@inparam	iReleaseAction ������������
			 *@inparam	sPromptContent	��ʾ����
			 *@inparam	sIsPrint	�Ƿ��ӡ
			 *@inparam	sValidFlag	��Ч��־
			 *@inparam	sCreateLogin	��������
			 *@inparam	sCreateTime	����ʱ��
			 *@inparam	sGroupId		�����ڵ�
			 *@inparam	sValidTime ��Чʱ��
			 *@inparam	sInvalidTime ʧЧʱ��
			 *@output parameter information
			 *@outparam	loginAccept		��ˮ	�����ڷ��������ɵ���ˮ����ԭ�������ˮ
			 *@return SVR_ERR_NO 
			 */
		-->
		<div id="oprDiv" style="display:block">
			<!--������������,1,����,2,�ջ�,3,����-->
			<input type="hidden" name="iReleaseAction" value="1">
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
					<td width="15%" class="blue" nowrap>Ʊ������</td>
					<td>
						<select name="iBillType">
							<option value="none" selected>��ѡ��</option>
							<wtc:qoption name="sPubSelect" outnum="2">
							<wtc:sql>select bill_type,bill_type||'->'||bill_name from sPrintBillType where bill_type = '1'</wtc:sql>
							</wtc:qoption>
						</select>						
					</td>
					<td class="blue">��ӡѡ��</td>
					<td>
						<select name="sIsPrint" onchange="doChangeIsPrintSelect(this)">
							<option value="none" selected>��ѡ��</option>
							<option value="1">��ʾ</option>
							<option value="2">��ӡ</option>
							<option value="3">��ӡ����ʾ</option>
						</select>
					</td>	
				</tr>
				<tr>
					<td width="15%" class="blue" nowrap>��ʾ����</td>
					<td>
						<select name="iPromptType">
							<option value="none" selected>��ѡ��</option>
							<wtc:qoption name="sPubSelect" outnum="2">
							<wtc:sql>select prompt_type,prompt_type||'->'||prompt_name from sFuncPromptType where prompt_type = '11' or prompt_type = '10' or prompt_type = '13'order by prompt_type desc</wtc:sql>
							</wtc:qoption>
						</select>						
					</td>
					<td class="blue">��Ч��־</td>
					<td>
						<select name="sValidFlag" disabled>
							<option value="Y" selected>��Ч</option>
							<option value="N">��Ч</option>
						</select>
					</td>	
				</tr>
				<tr>
					<td class="blue">��������</td>
					<td >
						<input type="text" name="sReleaseGroupName" value="<%=sReleaseGroupName%>" disabled>
						<input type="hidden" name="sReleaseGroup" value="<%=groupId%>">
					</td>
					<td  class="blue" nowrap>��������</td>
					<td >
						<select name="Channels_Code">
							<option value="none" selected>��ѡ��</option>
							<wtc:qoption name="sPubSelect" outnum="2">
							<wtc:sql><%=sqlChn%></wtc:sql>
							</wtc:qoption>
						</select>						
					</td>			
				</tr>
				<tr>
					<td class="blue">��������</td>
					<td><input type="text" name="sCreateLogin" value="<%=workNo%>" disabled></td>
					<td class="blue">����ʱ��</td>
					<td><input type="text" name="sCreateTime" value="<%=dateStr1%>" disabled></td>
				</tr>
				<tr>
					<td class="blue">��Чʱ��</td>
					<td><input type="text" name="sValidTime" value="<%=dateStr%>" maxlength="8" onkeypress="if (event.keyCode<45 || event.keyCode>57) event.returnValue=false;"></td>
					<td class="blue">ʧЧʱ��</td>
					<td><input type="text" onblur="chkTime(document.getElementById('sValidTime'),document.getElementById('sInvalidTime'))" name="sInvalidTime" value="20500101" maxlength="8" onkeypress="if (event.keyCode<45 || event.keyCode>57) event.returnValue=false;"></td>
				</tr>
				<tr>
					<td class="blue">��ʾ����</td>
					<td colspan="3">
						<textarea name="sPromptContent" rows="8" cols="75"></textarea>&nbsp;(���512��)
					</td>
				</tr>	
			</table>
		</div>
		
		<!--
			/*@service information
			 *@name						s9605Cfm2
			 *@description				ע����������
			 *@author					lugz
			 *@created	2008-10-8 13:01:58
			 *@version %I%, %G%
			 *@since 1.00
			 *@input parameter information
			 *@inparam	loginAccept		��ˮ	�������룬������������ڷ�����ȡ��ˮ
			 *@inparam	opCode			���ܴ���	
			 *@inparam	loginNo			��������
			 *@inparam	loginPasswd		�������ܵĹ�������
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
			 *@inparam	sReleaseGroup ������Դ
			 *@inparam	iReleaseAction ������������
			 *@inparam	sGroupId		�����ڵ�
			 *@inparam	sPromptContent	��ʾ����
			 *@inparam	sIsPrint	�Ƿ��ӡ
			 *@inparam	sValidFlag	��Ч��־
			 *@inparam	sCreateLogin	��������
			 *@inparam	sCreateTime	����ʱ��
			 *@inparam	sValidTime ��Чʱ��
			 *@inparam	sInvalidTime ʧЧʱ��
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
						<input type="text" name="iClassCode" value="" onKeyDown="if(event.keyCode==13){getFieldClassCode();}">&nbsp;&nbsp;
						<input name="" type="button" class="b_text" style="cursor:hand" onClick="getFieldClassCode()" value="��ѯ">
					</td>
					<td width="15%" class="blue" nowrap>�ֶ�������</td>
					<td width="35%">
						<input type="text" name="iClassName" value="" onKeyDown="if(event.keyCode==13){getFieldClassCode();}">&nbsp;<font class="orange">(ƥ��ģ����ѯ)</font>
					</td>			
				</tr>
				<tr>
					<td colspan="4" style="height:0;">
						<iframe frameBorder="0" id="iClassCodeFrame" align="center" name="iClassCodeFrame" scrolling="no" style="height:100%; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('iClassCodeFrame').style.height=iClassCodeFrame.document.body.scrollHeight+'px'"></iframe>
					</td>
				</tr>
				<tr>
					<td class="blue">�ֶ���ֵ</td>
					<td>
						<input type="text" name="sClassValue" value="">
					</td>
					<td width="15%" class="blue">���˳��</td>
					<td>
						<input type="text" name="iClassSeq" value="" readonly >
					</td>
				</tr>
				<tr>		
					<td class="blue">Ʊ������</td>
					<td>
						<select name="iBillType2">
							<!--<option value="none" selected>��ѡ��</option>-->
							<wtc:qoption name="sPubSelect" outnum="2">
							<wtc:sql>select bill_type,bill_type||'->'||bill_name from sPrintBillType where bill_type = '1'</wtc:sql>
							</wtc:qoption>
						</select>						
					</td>
					<td class="blue">��ӡѡ��</td>
					<td>
						<select name="sIsPrint2" onchange="doChangeIsPrint2Select(this)">
							<option value="none" selected>��ѡ��</option>
							<option value="1">��ʾ</option>
							<option value="2">��ӡ</option>
							<option value="3">��ӡ����ʾ</option>
						</select>
					</td>
				</tr>
				<tr>
					<td width="15%" class="blue" nowrap>��ʾ����</td>
					<td >
						<select name="iPromptType2">
							<option value="none" selected>��ѡ��</option>
							<wtc:qoption name="sPubSelect" outnum="2">
							<wtc:sql>select prompt_type,prompt_type||'->'||prompt_name from sFuncPromptType where prompt_type = '12' or prompt_type = '10' order by prompt_type desc</wtc:sql>
							</wtc:qoption>
						</select>						
					</td>
						<td width="15%" class="blue" nowrap>��������</td>
					<td >
						<select name="Channels_Code2">
							<option value="none" selected>��ѡ��</option>
							<wtc:qoption name="sPubSelect" outnum="2">
							<wtc:sql><%=sqlChn%></wtc:sql>
							</wtc:qoption>
						</select>						
					</td>			
				</tr>
				<tr>
					<td width="15%" class="blue" nowrap>��������</td>
					<td>
						<input type="text" name="sFunctionCode2" value="">&nbsp;&nbsp;
						<input name="" type="button" class="b_text" style="cursor:hand" onClick="getFucntionInfo2()" value="��ȡ">&nbsp;
						<input name="clearBtn" id="clearBtn"  type="button" class="b_text" style="cursor:hand" onClick="doClearFunctionInput2()" value="���">
					</td>
					<td width="15%" class="blue" nowrap>��������</td>
					<td>
						<input type="text" name="sFunctionName2" value="">&nbsp;<font class="orange">(ƥ��ģ����ѯ)</font>
					</td>	
				</tr>
				<tr>
					<td class="blue">��Чʱ��</td>
					<td><input type="text" name="sValidTime2" value="<%=dateStr%>" maxlength="8" onkeypress="if (event.keyCode<45 || event.keyCode>57) event.returnValue=false;"></td>
					<td class="blue">ʧЧʱ��</td>
					<td><input type="text"  onblur="chkTime(document.getElementById('sValidTime2'),document.getElementById('sInvalidTime2'))" name="sInvalidTime2" value="20500101" maxlength="8" onkeypress="if (event.keyCode<45 || event.keyCode>57) event.returnValue=false;"></td>
				</tr>
				<tr>					
					<td class="blue">�Ƿ��մ�����ʾ</td>
					<td>
						<select name="sIsByValue" disabled>
							<option value="Y" selected>��</option>
							<option value="N">��</option>
						</select>							
					</td>		
					<td class="blue">��Ч��־</td>
					<td>
						<select name="sValidFlag2" disabled>
							<option value="Y" selected>��Ч</option>
							<option value="N">��Ч</option>
						</select>
					</td>	
				</tr>
				<tr>
					<td width="15%" class="blue" nowrap>������������</td>
					<td>
						<select name="iReleaseAction2" disabled>
							<option value="1" selected>����</option>
							<option value="2">�ջ�</option>
							<option value="3">����</option>
						</select>	
					</td>					
					<td class="blue">��������</td>
					<td>
						<input type="text" name="sReleaseGroupName2" value="<%=sReleaseGroupName%>" disabled>
						<input type="hidden" name="sReleaseGroup2" value="<%=groupId%>">
					</td>
				</tr>
				<tr>
					<td class="blue">��������</td>
					<td><input type="text" name="sCreateLogin2" value="<%=workNo%>" disabled></td>
					<td class="blue">����ʱ��</td>
					<td><input type="text" name="sCreateTime2" value="<%=dateStr1%>" disabled></td>
				</tr>
				<tr>
					<td class="blue">��ʾ����</td>
					<td colspan="3">
						<textarea name="sPromptContent2" rows="8" cols="75"></textarea>&nbsp;<font class="orange">(���512��)</font>
					</td>
				</tr>	
			</table>
		</div>
		
		<!--����Ϊ"���ݽ�������"��"����ҵ������"�Ĺ�������-->
		<table cellspacing="0">
				<tr>
					<td width="15%" class="blue" nowrap>������������</td>
					<td>
						<select name="promulgateNodeType" onchange="doChangePromNodeType()">
							<option value="none" selected>��ѡ��</option>
							<%
							if(root_distance_int==1)
							{
							%>
							<option value="0">ʡ</option>
							<option value="1">����</option>
							<%}
							if(root_distance_int==2)
							{
							%>
							<option value="1">����</option>
							<option value="2">����</option>
							<%}
							if(root_distance_int>2)
							{
							%>
							<option value="2">����</option>
						</select>		
							<%}%>
					</td>
				</tr>
				<tr id="townByRegionTr" style="display:none">
					<td width="15%" class="blue">��ѡ�����</td>
					<td>
						<select name="townByRegionSelect" onchange="doChangeTownByRegion()">
						<wtc:qoption name="sPubSelect" outnum="2">
						<wtc:sql>select group_id,group_id||'->'||group_name from dChnGroupMsg where group_id in (select parent_group_id from dChnGroupInfo  where group_id = '<%=groupId%>' ) and ROOT_DISTANCE = 2</wtc:sql>
						</wtc:qoption>
						</select> 
					</td>
				</tr>
				<tr>
					<td colspan="2" style="height:0;">
						<iframe frameBorder="0" id="promulgateNodeFrame" align="center" name="promulgateNodeFrame" scrolling="no" style="height:100%; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('promulgateNodeFrame').style.height=promulgateNodeFrame.document.body.scrollHeight+'px'"></iframe>
					</td>
				</tr>
				<tr>
					<td width="15%" class="blue" nowrap>��ѡ�ķ�������</td>
					<td>
						<textarea name="sGroupInfo" rows="5" cols="75" readonly></textarea>
						<input type="hidden" name="sGroupId" value="">
					</td>
				</tr>
				<tr>
					<td width="15%" class="blue" nowrap>��ѡ��������</td>
					<td>
						<iframe frameBorder="0" src="f9605_getAuditLoginInfo.jsp?createLoginNo=<%=workNo%>" id="sAuditLoginInfoFrame" align="center" name="sAuditLoginInfoFrame" scrolling="no" style="height:100%; visibility:inherit; width:100%; z-index:1;"  onload="document.getElementById('sAuditLoginInfoFrame').style.height=sAuditLoginInfoFrame.document.body.scrollHeight+'px'"></iframe>
						<input type="hidden" name="sAuditLogins" value="">
					</td>
				</tr>
				<tr>
					<td class="blue" nowrap>������ע</td>
					<td><input type="text" name="opNote" value="" size="90" maxlength="60"></td>
				</tr>
		</table>
		
		<!--����Ϊ��������-->
		<table cellspacing="0">
      <tr> 
        <td id="footer"> 
           <input type="button" name="resetButton"  class="b_foot" value="����" style="cursor:hand;" onclick="doReset()" >&nbsp;
           <input type="button" name="confirmButton" class="b_foot" value="ȷ��" style="cursor:hand;" onClick="doConfirm()" >&nbsp;
           <input type="button" name="closeButton" class="b_foot" value="�ر�" style="cursor:hand;" onClick="doClose()" >&nbsp;
        </td>
      </tr>
    </table>
    <%@ include file="/npage/include/footer.jsp" %> 
	</form>
</body>
</html>
