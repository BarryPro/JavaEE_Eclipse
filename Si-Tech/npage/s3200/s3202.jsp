 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-01-20 ҳ�����,�޸���ʽ
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>

<%
   	String opCode = request.getParameter("opCode");	
	String opName = request.getParameter("opName");	//header.jsp��Ҫ�Ĳ���     
   
	String ip_Addr = (String)session.getAttribute("ipAddr");
	String work_no  = (String)session.getAttribute("workNo");
	String workname = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode=(String)session.getAttribute("regCode");
	String GroupId = (String)session.getAttribute("groupId");     
   	String OrgId = (String)session.getAttribute("orgId");   
  	String nopass   =(String)session.getAttribute("password");
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="seq"/>
<%
	String printAccept = getMaxAccept();//��ӡ��ˮ
	String power_code = (String)session.getAttribute("powerCode");
	String powerRight= (String)session.getAttribute("powerRight");
		
	//ArrayList retArray = new ArrayList();			
	String[][] result = new String[][]{};
	String sqlStr="";
    	//SPubCallSvrImpl callView = new SPubCallSvrImpl();
    
    	System.out.println("--------power_code---------:"+power_code);
    	System.out.println("--------power_right---------:"+powerRight);
%>

<HTML>

	<HEAD>
		<script language="JavaScript" src="<%=request.getContextPath()%>/npage/s1400/pub.js"></script>
		<script language="JavaScript">

		//����ҳ��ˢ�µĴ�������
		function refMain(chg_type){
			getAfterPrompt();
			with ( document.frm )
			{
		
				var paraStr;
				var all_no;
				all_no=grp_userno.value;
				var cmdtext = all_no;
				var system_note ="";
		        	var opr_code = ""
				
				if( chg_type == "0"){
					system_note = all_no+" ���ź��� [ɾ��].";
					opr_code = "3203";
				}
				else if( chg_type == "4"){
					system_note = all_no+" ���ź��� [����].";
					opr_code = "3204";
				}
				else if( chg_type == "5"){
					system_note = all_no+" ���ź��� [ȥ����].";
					opr_code = "3205";
				}
				else if( chg_type == "2"){
					system_note = all_no+" ���ź��� [�޸�].";
					opr_code = "3202";
				}
				sysnote.value = system_note;
				op_code.value = opr_code;
		        	op_type.value = chg_type;
				
				//0.���grp_name
			    if(  document.frm.grp_name.value == "" ){
			    	rdShowMessageDialog("��������:"+document.frm.grp_name.value+",��������!!");
			    	document.frm.grp_name.select();
			    	return false;
			    }
			    if(  document.frm.grp_userno.value == "" ){
			    	rdShowMessageDialog("���Ŵ����������!!");
			    	document.frm.grp_userno.select();
			    	return false;
			    }
			    if(  document.frm.serv_area.value == "" ){
			    	rdShowMessageDialog("��������ҵ�����ű�������!!");
			    	document.frm.serv_area.select();
			    	return false;
			    }	
			    if(  document.frm.inter_fee.value == "" ){
			    	rdShowMessageDialog("���ڷ���������������!!");
			    	document.frm.inter_fee.select();
			    	return false;
			    }
			    if(  document.frm.out_grpfee.value == "" ){
			    	rdShowMessageDialog("����������������������!!");
			    	document.frm.out_grpfee.select();
			    	return false;
			    }
			    if(  document.frm.adm_no.value == "" ){
			    	rdShowMessageDialog("���Ź���������������!!");
			    	document.frm.adm_no.select();
			    	return false;
			    }
			    if(  document.frm.out_fee.value == "" ){
			    	rdShowMessageDialog("�������������������!!");
			    	document.frm.out_fee.select();
			    	return false;
			    }
			    if(  document.frm.normal_fee.value == "" ){
			    	rdShowMessageDialog("���Żݷ���������������!!");
			    	document.frm.normal_fee.select();
			    	return false;
			    }
			    if(  document.frm.trans_no.value == "" ){
			    	rdShowMessageDialog("���л���Աת�Ӻű�������!!");
			    	document.frm.trans_no.select();
			    	return false;
			    } 		
			    //2.ת��ҵ����ʼ���ں�ҵ��������ڵ�YYYYMMDD---->YYYY-MM-DD
			    checkFlag = isValidYYYYMMDD(document.frm.srv_start.value);
			    if(checkFlag < 0){
			    	rdShowMessageDialog("ҵ����ʼ����:"+document.frm.srv_start.value+",���ڲ��Ϸ�!!");
			    	document.frm.srv_start.select();
			    	return false;
			    }
			    checkFlag = isValidYYYYMMDD(document.frm.srv_stop.value);
			    if(checkFlag < 0){
			    	rdShowMessageDialog("ҵ���������:"+document.frm.srv_stop.value+",���ڲ��Ϸ�!!");
			    	document.frm.srv_stop.select();
			    	return false;
			    }
			    //ҵ����ʼ���ں�ҵ��������ڵ�ʱ��Ƚ�
			    checkFlag = dateCompare(document.frm.srv_start.value,document.frm.srv_stop.value);
			    if( checkFlag == 1 ){
			    	rdShowMessageDialog("ҵ���������Ӧ�ô���ҵ����ʼ����!!");
			    	document.frm.srv_stop.select();
			    	return false;
			    }
			    //���ڲ���̫�࣬��Ҫͨ��form��post����,���,��Ҫ����������ݸ��Ƶ���������. yl.
			    document.frm.chgSrvStart.value = changeDateFormat(document.frm.srv_start.value);
			    document.frm.chgSrvStop.value  = changeDateFormat(document.frm.srv_stop.value);
				
			    if( parseInt(document.frm.pmax_close.value) > 5){
			    	rdShowMessageDialog("�����û����ɼ���ıպ�Ⱥ��:"+document.frm.pmax_close.value+",��Χ[0,5]!!");
			    	document.frm.pmax_close.select();
			    	return false;
			    }
			    checkFlag = parseInt(document.frm.max_users.value);
//          wangzn 20090729 ȡ��������û���������
//			    if(checkFlag < 20 || checkFlag > 1000){
//			    	rdShowMessageDialog("���ſ�ӵ�е�����û���:"+document.frm.max_users.value+",��Χ[20,1000]!!");
//			    	document.frm.max_users.select();
//			    	return false;
//			    } 
			    checkFlag = isValidYYYYMMDD(document.frm.pkg_day.value);
			    if(checkFlag < 0 ){
			    	rdShowMessageDialog("�ʷ��ײ���Ч����:"+document.frm.pkg_day.value+",���ڲ��Ϸ�!!");
			    	document.frm.pkg_day.select();
			    	return false;
			    }
			    //�������ڵ�ǰ����
			    checkFlag = dateCompare(document.frm.srv_start.value,document.frm.pkg_day.value);
			    if( (checkFlag == 1) || (checkFlag == 0) ){
			    	rdShowMessageDialog("�������ڵ�ǰ����!!");
			    	document.frm.pkg_day.select();
			    	return false;
			    }
			    //���ڲ���̫�࣬��Ҫͨ��form��post����,���,��Ҫ����������ݸ��Ƶ���������. yl.
			    document.frm.chgPkgDay.value = changeDateFormat(document.frm.pkg_day.value);
			    
			    
			    var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
			    if(typeof(ret)!="undefined")
			     {
			        if((ret=="confirm"))
			        {
			          if(rdShowConfirmDialog('ȷ�ϵ����������ȷ��,���ύ����ҵ��!')==1)
			          {
			             document.frm.submit();
			          }
				      }
				      if(ret=="continueSub")
				      {
			          if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
			          {
			            document.frm.submit();
			          }
				      }
				    }
				    else
			      {
			        if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
			        {
			            document.frm.submit();
			        }
			      }
			      
			      //document.frm.submit();
			  }
		}
		
		 function showSelWindow()
		 {
		 
		 	if ( document.frm.grp_userno.value == "" )
		 	{
		 		rdShowMessageDialog("�����뼯�Ŵ��룡");
		 		document.frm.grp_userno.focus();
		 		return false;
		 	}
		 	var strArr = new Array();
		 	var i   = 0;
		 	var num = 0;
		 	var j = 0;
		 	var tmpstr;
		 	var flag = 0;
		 	
			var h=480;
			var w=650;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var prop="dialogHeight:"+300+"px; dialogWidth:"+500+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
			var str=window.showModalDialog('get_s3200Data.jsp?grpId='+document.frm.grp_userno.value,"",prop);
			if( typeof(str) != "undefined" ){
				if ( str == "0" ){
					rdShowMessageDialog("û���ҵ���Ч�ļ�����Ϣ��");
					document.frm.grp_userno.focus();
		 			return false;			
				}
				else{
					//document.frm.province.disabled = false;
					document.frm.serv_area.disabled = false;
					document.frm.scp_id.disabled = false; 
					//document.frm.contact.disabled = false;
					document.frm.address.disabled = false;
					document.frm.telephone.disabled = false;
					document.frm.srv_start.disabled = false;
					document.frm.srv_stop.disabled = false; 
					document.frm.flags.disabled = false; 
					document.frm.inter_fee.disabled = false;
		
					document.frm.out_grpfee .disabled = false;
					document.frm.adm_no.disabled = false; 
					document.frm.trans_no.disabled = false; 
					document.frm.max_clnum.disabled = false; 
					document.frm.max_numcl.disabled = false; 
					document.frm.pmax_close.disabled = false;
					document.frm.max_outnum.disabled = false;
					//document.frm.max_users.disabled = false; //luxc20061123 ��������ʹ,�����޸���
					document.frm.pkg_type.disabled = false; 
					document.frm.pkg_day.disabled = false; 
					document.frm.discount.disabled = false; 
					document.frm.lmt_fee.disabled = false; 
		           
					num =  getTokNums(str,",");
					for ( i=0; i < num ; i++ ){
						j = i + 1;
						strArr[i] = oneTok(str,",",j);
					}
					
					
				    document.frm.grp_name.value = strArr[1];
				    document.frm.province.value = strArr[2];
				    document.frm.serv_area.value = strArr[3];
				    document.frm.scp_id.value = strArr[4];
				    tmpstr = strArr[5];
				     
				    for(i=0; i<document.frm.grp_type.length; i++){
					 	if( document.frm.grp_type.options[i].value == tmpstr ){
					 		document.frm.grp_type.options.selectedIndex = i;
					 		break;
					 	}
					 }
					 
					 for(i=0; i<document.frm.grp_type2.length; i++){
					 	if( document.frm.grp_type2.options[i].value == tmpstr ){
					 		document.frm.grp_type2.options.selectedIndex = i;
					 		break;
					 	}
					 }
					 
				    document.frm.contact.value = strArr[6];
				    document.frm.address.value = strArr[7];
				    document.frm.telephone.value = strArr[8];
				    document.frm.srv_start.value = strArr[9];
				    document.frm.srv_stop.value = strArr[10];
				    		    
				    tmpstr = strArr[11];
				   
					if( tmpstr == "0" ){
					 	document.frm.sub_state.value = "δ����";
					 	
					 }
					 else if ( tmpstr == "1" ){
					 	document.frm.sub_state.value = "����";
					 }
					 else{
					 	document.frm.sub_state.value = "���Ų�����";
					 }
					 document.frm.SUBSTATE.value = tmpstr;
					 		
				    document.frm.flags.value = strArr[12];
		          
		       tmpStr = strArr[13];
		       for(i=0; i<document.frm.inter_fee.length; i++){
						if( document.frm.inter_fee.options[i].value == strArr[13] ){
					 		document.frm.inter_fee.options.selectedIndex = i;
					 		break;
					 	}
					 }
					 
					 for(i=0; i<document.frm.inter_fee2.length; i++){
						if( document.frm.inter_fee2.options[i].value == strArr[13] ){
					 		document.frm.inter_fee2.options.selectedIndex = i;
					 		break;
					 	}
					 }
		            document.frm.out_fee.value = "1";
		            
		            tmpStr = strArr[15];
		            for(i=0; i<document.frm.out_grpfee.length; i++){
						if( document.frm.out_grpfee.options[i].value == strArr[15] ){
					 		document.frm.out_grpfee.options.selectedIndex = i;
					 		break;
					 	}
					 }
					 
					 for(i=0; i<document.frm.out_grpfee2.length; i++){
						if( document.frm.out_grpfee2.options[i].value == strArr[15] ){
					 		document.frm.out_grpfee2.options.selectedIndex = i;
					 		break;
					 	}
					 }
					 
					 
					 
		            document.frm.normal_fee.value = "1";
		            document.frm.adm_no.value = strArr[17];
		            document.frm.trans_no.value = strArr[18];
		             
		             tmpstr =  strArr[19];
		             for(i=0; i<document.frm.display.length; i++){
		             	
					 	if( document.frm.display.options[i].value == tmpstr ){
					 		document.frm.display.options.selectedIndex = i;
					 		break;
					 	}
					 }
					 for(i=0; i<document.frm.display2.length; i++){
					 if( document.frm.display2.options[i].value == tmpstr ){
					 		document.frm.display2.options.selectedIndex = i;
					 		break;
					 	}
					 }
		            document.frm.max_clnum.value = strArr[20];
		            document.frm.max_numcl.value = strArr[21];
		            document.frm.pmax_close.value = strArr[22];
		            document.frm.max_outnum.value = strArr[23];
		            document.frm.max_users.value = strArr[24];
		            document.frm.pkg_type.value = strArr[25];
		            document.frm.pkg_day.value = strArr[26];
		            document.frm.discount.value = strArr[27];
		            document.frm.lmt_fee.value = strArr[28];
		            document.frm.max_outnumcl.value = strArr[29];
		            document.frm.fee_rate.value = strArr[30];
		            document.frm.busi_type.value = strArr[31];
		            document.frm.use_status.value = strArr[32];
		            document.frm.cover_region.value = strArr[33];
		            document.frm.chg_flag.value = strArr[34];
		            document.frm.grp_id.value = strArr[35];
		           
		             
		  
		          tmpstr =  strArr[36];
		          for(i=0; i<document.frm.flags_no_2.length; i++){
					    if( document.frm.flags_no_2.options[i].value == tmpstr ){
					    		document.frm.flags_no_2.options.selectedIndex = i;
					    		break;
					    	}
					    }   
		        
		
					//document.frm.delete1.disabled = false;
					document.frm.update1.disabled = false;
					document.frm.enable1.disabled = false;
					document.frm.disable1.disabled = false;
					document.frm.updateFlag.disabled = false;
				}
			}
		 }
		function call_flags(){
		
		   var h=480;
		   var w=1000;
		   var t=screen.availHeight/2-h/2;
		   var l=screen.availWidth/2-w/2;
		   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
		   
		   var str=window.showModalDialog('group_flags.jsp?flags='+document.frm.flags.value,"",prop);
		   
		   if( str != undefined ){
				document.frm.flags.value = str;
			}
			return true;
		}

		function printInfo(printType)
		{		
			var grp_type=document.all.grp_type.options[document.all.grp_type.selectedIndex].text;
			var grp_type2=document.all.grp_type2.options[document.all.grp_type2.selectedIndex].text;
			var inter_fee=document.all.inter_fee.options[document.all.inter_fee.selectedIndex].text;
			var inter_fee2=document.all.inter_fee2.options[document.all.inter_fee2.selectedIndex].text;
			var out_grpfee=document.all.out_grpfee.options[document.all.out_grpfee.selectedIndex].text;
			var out_grpfee2=document.all.out_grpfee2.options[document.all.out_grpfee2.selectedIndex].text;
			var display=document.all.display.options[document.all.display.selectedIndex].text;
			var display2=document.all.display2.options[document.all.display2.selectedIndex].text;
				
				
			var retInfo = "";
		    retInfo+='<%=work_no%>  <%=workname%>'+"|";
		    retInfo+='<%=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime())%>'+"|";
		    
		    retInfo+="�������ƣ�				"+document.all.grp_name.value+"|";
		    retInfo+="���Ŵ��룺				"+document.all.grp_userno.value+"|";
		    retInfo+="��ϵ��������			"+document.all.contact.value+"|";
		    retInfo+="������ϵ��ַ��		"+document.all.address.value +"|";
		    retInfo+="������ϵ�绰: 		"+document.all.telephone.value+"|";
		    retInfo+=" "+"|";
		    retInfo+=" "+"|";
		    retInfo+=" "+"|";
		    retInfo+=" "+"|";
		    retInfo+=" "+"|";
		    retInfo+=" "+"|";
		    retInfo+=" "+"|";
		    retInfo+=" "+"|";
		    retInfo+=" "+"|";
		    retInfo+=" "+"|";
		    retInfo+=" "+"|";
		    retInfo+=" "+"|";
		    retInfo+=" "+"|";
				
		    
		    retInfo+="����ҵ��				"+"������VPMN������Ϣ���"+"|";
		    retInfo+="ԭ���ڷ��ʣ�			"+inter_fee2+"  �����ڷ��ʣ�			"+inter_fee+"|";  
		    retInfo+="ԭ������ʣ�			"+out_grpfee2+"  ��������ʣ�			"+out_grpfee+"|";  
		    retInfo+="ԭ��ʾ��ʽ��			"+display2+"  ����ʾ��ʽ��			"+display+"|";     
		    retInfo+="ԭ�������ͣ�			"+grp_type2+"  �¼������ͣ�			"+grp_type+"|";
		    retInfo+="ҵ��ʼʱ�䣺		"+document.all.srv_start.value+"|";
		    retInfo+="ҵ�����ʱ�䣺		"+document.all.srv_stop.value+"|";
		    retInfo+=" "+"|";
		    
		    retInfo+=document.all.sysnote.value+"|";
		    retInfo+=" "+"|";
		    retInfo+=" "+"|";
		    retInfo+=" "+"|";
		
			  return retInfo;
		}

		 function showPrtDlg(printType,DlgMessage,submitCfm)
		{  //��ʾ��ӡ�Ի��� 
		     var h=180;
		     var w=350;
		     var t=screen.availHeight/2-h/2;
		     var l=screen.availWidth/2-w/2;
		   
		     var printStr = printInfo(printType);
		   
		     var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
		     var path = "<%=request.getContextPath()%>/npage/innet/hljGdPrint.jsp?DlgMsg=" + DlgMessage;
		     var path = path + "&printInfo=" + printStr + "&submitCfm=" + submitCfm;
		     var ret=window.showModalDialog(path,"",prop);
		     return ret;     
		}
		function dateCompare(sDate1,sDate2){	
			if(sDate1>sDate2)	//sDate1 ���� sDate2
				return 1;
			if(sDate1==sDate2)	//sDate1��sDate2 Ϊͬһ��
				return 0;
			return -1;		//sDate1 ���� sDate2
		}


</script>
 
	<title>�������ƶ�ͨ��-VPMN������Ϣ���</title>
</head>
	<BODY>
	<FORM action="s3202Cfm.jsp" method="post" name="frm" >
		<%@ include file="/npage/include/header.jsp" %>  
			<div class="title">
				<div id="title_zi">VPMN������Ϣ���</div>
			</div>	
		<input type="hidden" name="op_code"  value="3201">
		<input type="hidden" name="WorkNo"  value="<%=work_no%>">
		<input type="hidden" name="chgSrvStart" value="">
		<input type="hidden" name="chgSrvStop" value="">
		<input type="hidden" name="chgPkgDay" value="">
		<input type="hidden" name="NoPass" value="<%=nopass%>">
		<input type="hidden" name="OrgCode" value="<%=org_code%>">
		<input type="hidden" name="SUBSTATE" value="">
		<input type="hidden" name="login_accept" value="<%=seq%>">
		<input type="hidden" name="opName" value="<%=opName%>">
		<input type="hidden" name="op_type" value="">
		<input type="hidden" name="ip_Addr"  value="<%=ip_Addr%>">
		<input type="hidden" name="max_outnumcl"  value="100">
		<input type="hidden" name="fee_rate"  value="1">
		<input type="hidden" name="lock_flag"  value="0">
		<input type="hidden" name="busi_type"  value="01">
		<input type="hidden" name="bill_type"  value="0">
		<input type="hidden" name="use_status"  value="Y">
		<input type="hidden" name="cover_region"  value="01">
		<input type="hidden" name="chg_flag"  value="Y">
		<input type="hidden" name="org_id"  value="<%=OrgId%>">
		<input type="hidden" name="group_id"  value="<%=GroupId%>">
		<input type="hidden" name="pay_code"  value="0">
		<input type="hidden" name="grp_id"  value="">

	        <table cellspacing=0>
		          <tr> 
			            <td width="23%" nowrap class="blue">���ű��</td>
			            <td  nowrap> 
			              <input type="text" name="grp_userno"  size="20" maxlength="10" onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) showSelWindow();">
			              <input type="button" name="check" value="��ѯ" class="b_text" onClick="showSelWindow()">
			            </td>
		          </tr>
	        </table>		  
		 
        	<table cellspacing=0>
		          <tr> 
			            <td width="20%" nowrap class="blue">��������</td>
			            <td width="30%"> 
			              	<input name="grp_name" type="text"  id="grp_name" readOnly class="InputGrey">
			            </td>
			            <td width="20%" class="blue">��������ҵ������</td>
			            <td width="30%"> 
			              <input name="serv_area" type="text"  id="serv_area" onKeyPress="return isKeyNumberdot(0)" disabled>
			            </td>
		          </tr>
		          <tr> 
		            	<td width="20%" nowrap class="blue">��������</td>
		            	<td width="30%"> 
			              <select name="grp_type" id="grp_type" >
			              	<%
			              		if(work_no.equals("aavg21")){
					%>
					<option value="0"selected >0->���ؼ���</option>
			                <option value="1">1->ȫʡ����</option>
			                <option value="2">2->ȫ������</option>
			                <option value="3">3->���ػ�ʡ������</option>
					<%
						}else{
					%>
			                <option value="0"selected >0->���ؼ���</option>
			              <%}%>
			              </select>
			              <select name="grp_type2" id="grp_type2" style="display:none">			              	
					<%
						if(power_code.equals("010101")){
					%>
					<option value="0"selected >0->���ؼ���</option>
			                <option value="1">1->ȫʡ����</option>
			                <option value="2">2->ȫ������</option>
			                <option value="3">3->���ػ�ʡ������</option>
					<%
						}else{
					%>
			                <option value="0"selected >0->���ؼ���</option>
			              <%}%>
			              </select>
		            	</td>
		            	<td width="20%" nowrap class="blue">��������ʡ����</td>
		            	<td width="30%"> 
		              		<input  name="province" type="text" id="province" readonly class="InputGrey">
		            	</td>
		          </tr>
		          <tr> 
		            	   <td width="20%" nowrap class="blue">SCP����</td>
			            <td width="30%"> 
			              	<input  name="scp_id" type="text" id="scp_id" onKeyPress="return isKeyNumberdot(0)" disabled>
			            </td>
			            <td width="20%" nowrap>&nbsp;</td>
			            <td width="30%">&nbsp; </td>
		          </tr>
		          <tr> 
			            <td width="20%" nowrap class="blue">��ϵ������</td>
			            <td width="30%"> 
			              	<input name="contact" type="text" id="contact" maxlength = 18 value="">
			            </td>
			            <td width="20%" nowrap class="blue">������ϵ�绰</td>
			            <td width="30%"> 
			              	<input name="telephone" type="text" id="telephone" onKeyPress="return isKeyNumberdot(0)" disabled>
			            </td>
		          </tr>
		          <tr> 
		            <td width="20%" nowrap class="blue">������ϵ��ַ</td>
		            <td  colspan="3"> 
		              <input name="address" type="text" id="address" disabled size=60>
		            </td>		         
		          </tr>
		          <tr> 
		            <td width="20%" nowrap class="blue">ҵ����ʼ����</td>
		            <td width="30%"> 
		              <input name="srv_start" type="text" id="srv_start" onKeyPress="return isKeyNumberdot(0)" disabled>
		            </td>
		            <td width="20%" nowrap class="blue">ҵ����ֹ����</td>
		            <td width="30%"> 
		            	<!--update by wangzn -->
		              <input name="srv_stop" type="text"id="srv_stop" onKeyPress="return isKeyNumberdot(0)" disabled readonly >
		            </td>
		          </tr>
		          <tr> 
		            <td width="20%" nowrap class="blue">ҵ�񼤻��־</td>
		            <td width="30%"> 
		               <input name="sub_state" type="text" id="sub_state" disabled value="">
		            </td>
		            <td width="20%" nowrap>&nbsp;</td>
		            <td width="30%">&nbsp; </td>
		          </tr>
		          <tr> 
			     <td width="20%"  class="blue">���Ź��ܼ�</td>
			            <td nowrap> 
			              <input name="flags" type="text" id="flags" size="33" readonly class="InputGrey" ><input type="button" name="updateFlag" class="b_text" value="�޸�" onclick="call_flags()" disabled>
			            </td>
			            <TD class="blue">�Ƿ�Ϊ�ۺ�v��</TD>
			           <td class="formTd">
					<select name=flags_no_2> 
			   		  <option value="0">��</option>	
					  <option value="1">��׼�ۺ�v��</option>	
					   <option value="2">�����ۺ�v��</option>
					</select>	
			          </td>    	 		
		          </tr>
		          <tr> 
		            <td width="20%" class="blue">���ڷ�������</td>
		            <td width="30%"> 
		            	<select name="inter_fee" style="WIDTH: 240px">
					<%
					        try
					        {					               
					                sqlStr ="select FEEINDEX,FEEINDEX||'-->'||FEEINDEX_NAME from  svpmnfeeindex  where feeindex > 0 and region_code='"
					                	+regionCode+"' and stop_time>=sysdate and power_right<="+powerRight
					                	+" order by feeindex";
					                System.out.println("luxc"+sqlStr);
					                //retArray = callView.sPubSelect("2", sqlStr);				                
					                
					  %>
					  	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
							<wtc:sql><%=sqlStr%></wtc:sql>
						</wtc:pubselect>
						<wtc:array id="retArray" scope="end" />
					  
					  <%					  		
					                //result = (String[][])retArray.get(0);
					                //int recordNum = result.length;
					                int recordNum=0;
					                result=retArray;
					                if(result!=null&&result.length>0){
					                	recordNum = result.length;
					                }
					                for(int i=0;i<recordNum;i++){
					                        out.println("<option class='button' value='" + result[i][0] + "'>" + result[i][1] + "</option>");
					                }
					        }catch(Exception e){
					                
					        }
					%>
								</select>
								<select name="inter_fee2" style="WIDTH: 240px" style="display:none">
					<%
					        try
					        {
					                sqlStr ="select FEEINDEX,FEEINDEX||'-->'||FEEINDEX_NAME from  svpmnfeeindex  where feeindex > 0 and region_code='"+regionCode+"' order by feeindex";
					                //retArray = callView.sPubSelect("2", sqlStr);
					                //result = (String[][])retArray.get(0);
					 %>
					 	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="2">
							<wtc:sql><%=sqlStr%></wtc:sql>
						</wtc:pubselect>
						<wtc:array id="retArray2" scope="end" />
					 <%
					 	result=retArray2;
					        //int recordNum = result.length;
					       int  recordNum = 0;
					        if(result!=null&&result.length>0){
					                recordNum = result.length;
					        }
					                for(int i=0;i<recordNum;i++){
					                        out.println("<option class='button' value='" + result[i][0] + "'>" + result[i][1] + "</option>");
					                }
					        }catch(Exception e){
					                
					        }
					%>
				</select>
		            </td>
		            <td width="20%" class="blue">�����������</td>
		            <td width="30%"> 
		              <input name="out_fee" type="text" id="out_fee" onKeyPress="return isKeyNumberdot(0)" readonly class="InputGrey">
		            </td>
		          </tr>
		          <tr> 
		            <td width="20%" class="blue">����������������</td>
		            <td width="30%"> 
		             	<select name="out_grpfee" style="WIDTH: 240px">
			            <%
			            	for(int i=0;i<result.length;i++){
							out.print("<option class=button value=" + result[i][0] + ">" + result[i][1] + "</option>");
					}
						%>
				</select>
				<select name="out_grpfee2" style="WIDTH: 240px" style="display:none">
			            <%
			            	for(int i=0;i<result.length;i++){
						out.print("<option class=button value=" + result[i][0] + ">" + result[i][1] + "</option>");
					}
				   %>
				</select>
		            </td>
		            <td width="20%" class="blue" >���Żݷ�������</td>
		            <td width="30%"> 
		              <input name="normal_fee" type="text" id="normal_fee" onKeyPress="return isKeyNumberdot(0)" readonly class="InputGrey">
		            </td>
		          </tr>
		          <tr> 
		            <td width="20%" class="blue">���Ź������̽�����</td>
		            <td width="30%"> 
		              <input  name="adm_no" type="text"id="adm_no" onKeyPress="return isKeyNumberdot(0)" disabled>
		            </td>
		            <td width="20%" class="blue">���л���Աת�Ӻ���</td>
		            <td width="30%"> 
		              <input name="trans_no" type="text" id="trans_no" onKeyPress="return isKeyNumberdot(0)" disabled>
		            </td>
		          </tr>
		          <tr> 
		            <td width="20%" class="blue">���к�����ʾ��ʽ</td>
		            <td width="30%"> 
			              <select name="display" style="WIDTH: 130px">
			                <option value="0"
							 selected >0->ʹ�ø��˱�־</option>
			                <option value="1"
							>1->��ʾ�̺�</option>
			                <option value="2"
							>2->��ʾ��ʵ����</option>
			                <option value="3"
							>3->PBX������ʾ��ʵ����</option>
			              </select>
			              <select name="display2" style="WIDTH: 130px" style="display:none">
			                <option value="0"
							 selected >0->ʹ�ø��˱�־</option>
			                <option value="1"
							>1->��ʾ�̺�</option>
			                <option value="2"
							>2->��ʾ��ʵ����</option>
			                <option value="3"
							>3->PBX������ʾ��ʵ����</option>
			              </select>
		            </td>
		            <td width="20%" class="blue" >���ſ��Դ��������պ��û�Ⱥ��</td>
		            <td width="30%"> 
		              <input  name="max_clnum" type="text" id="max_clnum" disabled onKeyPress="return isKeyNumberdot(0)">
		            </td>
		          </tr>
		          <tr> 
		            <td width="23%" class="blue">�����պ��û�Ⱥ�ܰ���������û���</td>
		            <td width="27%"> 
		              <input name="max_numcl" type="text" id="max_numcl" disabled onKeyPress="return isKeyNumberdot(0)">
		            </td>
		            <td width="20%" class="blue">���ſ��Դ��������պ��û�Ⱥ��</td>
		            <td width="30%"> 
		              <input name="pmax_close" type="text" id="pmax_close" disabled onKeyPress="return isKeyNumberdot(0)">
		            </td>
		          </tr>		          
		          <tr> 
		            <td width="20%" class="blue">���ſ���ӵ�е���������������</td>
		            <td width="30%"> 
		              <input name="max_outnum" type="text" id="max_outnum" disabled onKeyPress="return isKeyNumberdot(0)">
		            </td>
		            <td width="20%" class="blue">���ſ�ӵ�е�����û���:</td>
		            <td width="30%"> <!-- wangzn 20090729 ������Ϊaavg21ʱ�����Զ�����û������и��Ĳ��� -->
		              <input name="max_users" type="text" id="max_users"  <%if(!work_no.trim().equals("aavg21")){%>readOnly class="InputGrey"<%}%> onKeyPress="return isKeyNumberdot(0)">
		            </td>
		          </tr>		          
		          <tr> 
		            <td width="20%" class="blue">����ʹ�õ��ʷ��ײ�����</td>
		            <td width="30%"> 
		              <input name="pkg_type" type="text" id="pkg_type" disabled onKeyPress="return isKeyNumberdot(0)">
		            </td>
		            <td width="20%" class="blue">�ʷ��ײ���Ч����</td>
		            <td width="30%"> 
		              <input name="pkg_day" type="text" id="pkg_day" disabled onKeyPress="return isKeyNumberdot(0)">
		            </td>
		          </tr>
		          <tr> 
		            <td width="20%" class="blue">���ۿ�</td>
		            <td width="30%"> 
		              <input name="discount" type="text" id="discount" disabled onKeyPress="return isKeyNumberdot(1)">
		            </td>
		            <td width="20%" class="blue">�����·����޶�</td>
		            <td width="30%"> 
		              <input name="lmt_fee" type="text" id="lmt_fee" disabled onKeyPress="return isKeyNumberdot(1)">
		            </td>
		          </tr>
        	</table>		 
	        <TABLE  cellSpacing="0" >
	          <tr> 
	            <td width="23%" nowrap class="blue">�û���ע</td>
	            <td colspan="3"> 
	              <input type="text" name="sysnote" size="60" maxlength="60" readonly class="InputGrey" >
	            </td>
	          </tr>
	        </table>		        
         	<TABLE  cellSpacing="0" >
          	<TR> 
		            <TD id="footer"> 
		            			<input type="button" name="delete1" class="b_foot" value="ɾ��" onclick="refMain(0)" disabled>
						<input type="button" name="update1" class="b_foot" value="�޸�" onclick="refMain(2)" disabled>
						<input type="button" name="enable1" class="b_foot" value="����" onclick="refMain(4)" disabled>
						<input type="button" name="disable1" class="b_foot" value="ȥ����" onclick="refMain(5)" disabled>
		                		<input type="reset" name="reset"     class="b_foot" value="���"  >
		                		<input type="button" name="return"   class="b_foot" value="�ر�" onClick="removeCurrentTab()">
		              
		            </TD>
          	</TR>	
      <%@ include file="/npage/include/footer.jsp" %>	
</FORM>
</body>
</html>
