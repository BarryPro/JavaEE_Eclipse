 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-01-20 页面改造,修改样式
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>

<%
   	String opCode = request.getParameter("opCode");	
	String opName = request.getParameter("opName");	//header.jsp需要的参数     
   
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
	String printAccept = getMaxAccept();//打印流水
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

		//关于页面刷新的处理问题
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
					system_note = all_no+" 集团号码 [删除].";
					opr_code = "3203";
				}
				else if( chg_type == "4"){
					system_note = all_no+" 集团号码 [激活].";
					opr_code = "3204";
				}
				else if( chg_type == "5"){
					system_note = all_no+" 集团号码 [去激活].";
					opr_code = "3205";
				}
				else if( chg_type == "2"){
					system_note = all_no+" 集团号码 [修改].";
					opr_code = "3202";
				}
				sysnote.value = system_note;
				op_code.value = opr_code;
		        	op_type.value = chg_type;
				
				//0.检测grp_name
			    if(  document.frm.grp_name.value == "" ){
			    	rdShowMessageDialog("集团名称:"+document.frm.grp_name.value+",必须输入!!");
			    	document.frm.grp_name.select();
			    	return false;
			    }
			    if(  document.frm.grp_userno.value == "" ){
			    	rdShowMessageDialog("集团代码必须输入!!");
			    	document.frm.grp_userno.select();
			    	return false;
			    }
			    if(  document.frm.serv_area.value == "" ){
			    	rdShowMessageDialog("集团所在业务区号必须输入!!");
			    	document.frm.serv_area.select();
			    	return false;
			    }	
			    if(  document.frm.inter_fee.value == "" ){
			    	rdShowMessageDialog("网内费率索引必须输入!!");
			    	document.frm.inter_fee.select();
			    	return false;
			    }
			    if(  document.frm.out_grpfee.value == "" ){
			    	rdShowMessageDialog("网外号码费率索引必须输入!!");
			    	document.frm.out_grpfee.select();
			    	return false;
			    }
			    if(  document.frm.adm_no.value == "" ){
			    	rdShowMessageDialog("集团管理接入码必须输入!!");
			    	document.frm.adm_no.select();
			    	return false;
			    }
			    if(  document.frm.out_fee.value == "" ){
			    	rdShowMessageDialog("网外费率索引必须输入!!");
			    	document.frm.out_fee.select();
			    	return false;
			    }
			    if(  document.frm.normal_fee.value == "" ){
			    	rdShowMessageDialog("非优惠费率索引必须输入!!");
			    	document.frm.normal_fee.select();
			    	return false;
			    }
			    if(  document.frm.trans_no.value == "" ){
			    	rdShowMessageDialog("呼叫话务员转接号必须输入!!");
			    	document.frm.trans_no.select();
			    	return false;
			    } 		
			    //2.转换业务起始日期和业务结束日期的YYYYMMDD---->YYYY-MM-DD
			    checkFlag = isValidYYYYMMDD(document.frm.srv_start.value);
			    if(checkFlag < 0){
			    	rdShowMessageDialog("业务起始日期:"+document.frm.srv_start.value+",日期不合法!!");
			    	document.frm.srv_start.select();
			    	return false;
			    }
			    checkFlag = isValidYYYYMMDD(document.frm.srv_stop.value);
			    if(checkFlag < 0){
			    	rdShowMessageDialog("业务结束日期:"+document.frm.srv_stop.value+",日期不合法!!");
			    	document.frm.srv_stop.select();
			    	return false;
			    }
			    //业务起始日期和业务结束日期的时间比较
			    checkFlag = dateCompare(document.frm.srv_start.value,document.frm.srv_stop.value);
			    if( checkFlag == 1 ){
			    	rdShowMessageDialog("业务结束日期应该大于业务起始日期!!");
			    	document.frm.srv_stop.select();
			    	return false;
			    }
			    //由于参数太多，需要通过form的post传输,因此,需要将传输的内容复制到隐含域中. yl.
			    document.frm.chgSrvStart.value = changeDateFormat(document.frm.srv_start.value);
			    document.frm.chgSrvStop.value  = changeDateFormat(document.frm.srv_stop.value);
				
			    if( parseInt(document.frm.pmax_close.value) > 5){
			    	rdShowMessageDialog("单个用户最大可加入的闭合群数:"+document.frm.pmax_close.value+",范围[0,5]!!");
			    	document.frm.pmax_close.select();
			    	return false;
			    }
			    checkFlag = parseInt(document.frm.max_users.value);
//          wangzn 20090729 取消对最大用户数的限制
//			    if(checkFlag < 20 || checkFlag > 1000){
//			    	rdShowMessageDialog("集团可拥有的最大用户数:"+document.frm.max_users.value+",范围[20,1000]!!");
//			    	document.frm.max_users.select();
//			    	return false;
//			    } 
			    checkFlag = isValidYYYYMMDD(document.frm.pkg_day.value);
			    if(checkFlag < 0 ){
			    	rdShowMessageDialog("资费套餐生效日期:"+document.frm.pkg_day.value+",日期不合法!!");
			    	document.frm.pkg_day.select();
			    	return false;
			    }
			    //必须晚于当前日期
			    checkFlag = dateCompare(document.frm.srv_start.value,document.frm.pkg_day.value);
			    if( (checkFlag == 1) || (checkFlag == 0) ){
			    	rdShowMessageDialog("必须晚于当前日期!!");
			    	document.frm.pkg_day.select();
			    	return false;
			    }
			    //由于参数太多，需要通过form的post传输,因此,需要将传输的内容复制到隐含域中. yl.
			    document.frm.chgPkgDay.value = changeDateFormat(document.frm.pkg_day.value);
			    
			    
			    var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes"); 
			    if(typeof(ret)!="undefined")
			     {
			        if((ret=="confirm"))
			        {
			          if(rdShowConfirmDialog('确认电子免填单吗？如确认,将提交本次业务!')==1)
			          {
			             document.frm.submit();
			          }
				      }
				      if(ret=="continueSub")
				      {
			          if(rdShowConfirmDialog('确认要提交信息吗？')==1)
			          {
			            document.frm.submit();
			          }
				      }
				    }
				    else
			      {
			        if(rdShowConfirmDialog('确认要提交信息吗？')==1)
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
		 		rdShowMessageDialog("请输入集团代码！");
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
					rdShowMessageDialog("没有找到有效的集团信息！");
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
					//document.frm.max_users.disabled = false; //luxc20061123 这个命令不好使,不让修改了
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
					 	document.frm.sub_state.value = "未激活";
					 	
					 }
					 else if ( tmpstr == "1" ){
					 	document.frm.sub_state.value = "激活";
					 }
					 else{
					 	document.frm.sub_state.value = "集团不可用";
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
		    
		    retInfo+="集团名称：				"+document.all.grp_name.value+"|";
		    retInfo+="集团代码：				"+document.all.grp_userno.value+"|";
		    retInfo+="联系人姓名：			"+document.all.contact.value+"|";
		    retInfo+="集团联系地址：		"+document.all.address.value +"|";
		    retInfo+="集团联系电话: 		"+document.all.telephone.value+"|";
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
				
		    
		    retInfo+="办理业务：				"+"智能网VPMN集团信息变更"+"|";
		    retInfo+="原网内费率：			"+inter_fee2+"  新网内费率：			"+inter_fee+"|";  
		    retInfo+="原网外费率：			"+out_grpfee2+"  新网外费率：			"+out_grpfee+"|";  
		    retInfo+="原显示方式：			"+display2+"  新显示方式：			"+display+"|";     
		    retInfo+="原集团类型：			"+grp_type2+"  新集团类型：			"+grp_type+"|";
		    retInfo+="业务开始时间：		"+document.all.srv_start.value+"|";
		    retInfo+="业务结束时间：		"+document.all.srv_stop.value+"|";
		    retInfo+=" "+"|";
		    
		    retInfo+=document.all.sysnote.value+"|";
		    retInfo+=" "+"|";
		    retInfo+=" "+"|";
		    retInfo+=" "+"|";
		
			  return retInfo;
		}

		 function showPrtDlg(printType,DlgMessage,submitCfm)
		{  //显示打印对话框 
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
			if(sDate1>sDate2)	//sDate1 早于 sDate2
				return 1;
			if(sDate1==sDate2)	//sDate1、sDate2 为同一天
				return 0;
			return -1;		//sDate1 晚于 sDate2
		}


</script>
 
	<title>黑龙江移动通信-VPMN集团信息变更</title>
</head>
	<BODY>
	<FORM action="s3202Cfm.jsp" method="post" name="frm" >
		<%@ include file="/npage/include/header.jsp" %>  
			<div class="title">
				<div id="title_zi">VPMN集团信息变更</div>
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
			            <td width="23%" nowrap class="blue">集团编号</td>
			            <td  nowrap> 
			              <input type="text" name="grp_userno"  size="20" maxlength="10" onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) showSelWindow();">
			              <input type="button" name="check" value="查询" class="b_text" onClick="showSelWindow()">
			            </td>
		          </tr>
	        </table>		  
		 
        	<table cellspacing=0>
		          <tr> 
			            <td width="20%" nowrap class="blue">集团名称</td>
			            <td width="30%"> 
			              	<input name="grp_name" type="text"  id="grp_name" readOnly class="InputGrey">
			            </td>
			            <td width="20%" class="blue">集团所在业务区号</td>
			            <td width="30%"> 
			              <input name="serv_area" type="text"  id="serv_area" onKeyPress="return isKeyNumberdot(0)" disabled>
			            </td>
		          </tr>
		          <tr> 
		            	<td width="20%" nowrap class="blue">集团类型</td>
		            	<td width="30%"> 
			              <select name="grp_type" id="grp_type" >
			              	<%
			              		if(work_no.equals("aavg21")){
					%>
					<option value="0"selected >0->本地集团</option>
			                <option value="1">1->全省集团</option>
			                <option value="2">2->全国集团</option>
			                <option value="3">3->本地化省级集团</option>
					<%
						}else{
					%>
			                <option value="0"selected >0->本地集团</option>
			              <%}%>
			              </select>
			              <select name="grp_type2" id="grp_type2" style="display:none">			              	
					<%
						if(power_code.equals("010101")){
					%>
					<option value="0"selected >0->本地集团</option>
			                <option value="1">1->全省集团</option>
			                <option value="2">2->全国集团</option>
			                <option value="3">3->本地化省级集团</option>
					<%
						}else{
					%>
			                <option value="0"selected >0->本地集团</option>
			              <%}%>
			              </select>
		            	</td>
		            	<td width="20%" nowrap class="blue">集团所在省区号</td>
		            	<td width="30%"> 
		              		<input  name="province" type="text" id="province" readonly class="InputGrey">
		            	</td>
		          </tr>
		          <tr> 
		            	   <td width="20%" nowrap class="blue">SCP号码</td>
			            <td width="30%"> 
			              	<input  name="scp_id" type="text" id="scp_id" onKeyPress="return isKeyNumberdot(0)" disabled>
			            </td>
			            <td width="20%" nowrap>&nbsp;</td>
			            <td width="30%">&nbsp; </td>
		          </tr>
		          <tr> 
			            <td width="20%" nowrap class="blue">联系人姓名</td>
			            <td width="30%"> 
			              	<input name="contact" type="text" id="contact" maxlength = 18 value="">
			            </td>
			            <td width="20%" nowrap class="blue">集团联系电话</td>
			            <td width="30%"> 
			              	<input name="telephone" type="text" id="telephone" onKeyPress="return isKeyNumberdot(0)" disabled>
			            </td>
		          </tr>
		          <tr> 
		            <td width="20%" nowrap class="blue">集团联系地址</td>
		            <td  colspan="3"> 
		              <input name="address" type="text" id="address" disabled size=60>
		            </td>		         
		          </tr>
		          <tr> 
		            <td width="20%" nowrap class="blue">业务起始日期</td>
		            <td width="30%"> 
		              <input name="srv_start" type="text" id="srv_start" onKeyPress="return isKeyNumberdot(0)" disabled>
		            </td>
		            <td width="20%" nowrap class="blue">业务终止日期</td>
		            <td width="30%"> 
		            	<!--update by wangzn -->
		              <input name="srv_stop" type="text"id="srv_stop" onKeyPress="return isKeyNumberdot(0)" disabled readonly >
		            </td>
		          </tr>
		          <tr> 
		            <td width="20%" nowrap class="blue">业务激活标志</td>
		            <td width="30%"> 
		               <input name="sub_state" type="text" id="sub_state" disabled value="">
		            </td>
		            <td width="20%" nowrap>&nbsp;</td>
		            <td width="30%">&nbsp; </td>
		          </tr>
		          <tr> 
			     <td width="20%"  class="blue">集团功能集</td>
			            <td nowrap> 
			              <input name="flags" type="text" id="flags" size="33" readonly class="InputGrey" ><input type="button" name="updateFlag" class="b_text" value="修改" onclick="call_flags()" disabled>
			            </td>
			            <TD class="blue">是否为综合v网</TD>
			           <td class="formTd">
					<select name=flags_no_2> 
			   		  <option value="0">否</option>	
					  <option value="1">标准综合v网</option>	
					   <option value="2">特殊综合v网</option>
					</select>	
			          </td>    	 		
		          </tr>
		          <tr> 
		            <td width="20%" class="blue">网内费率索引</td>
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
		            <td width="20%" class="blue">网外费率索引</td>
		            <td width="30%"> 
		              <input name="out_fee" type="text" id="out_fee" onKeyPress="return isKeyNumberdot(0)" readonly class="InputGrey">
		            </td>
		          </tr>
		          <tr> 
		            <td width="20%" class="blue">网外号码组费率索引</td>
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
		            <td width="20%" class="blue" >非优惠费率索引</td>
		            <td width="30%"> 
		              <input name="normal_fee" type="text" id="normal_fee" onKeyPress="return isKeyNumberdot(0)" readonly class="InputGrey">
		            </td>
		          </tr>
		          <tr> 
		            <td width="20%" class="blue">集团管理流程接入码</td>
		            <td width="30%"> 
		              <input  name="adm_no" type="text"id="adm_no" onKeyPress="return isKeyNumberdot(0)" disabled>
		            </td>
		            <td width="20%" class="blue">呼叫话务员转接号码</td>
		            <td width="30%"> 
		              <input name="trans_no" type="text" id="trans_no" onKeyPress="return isKeyNumberdot(0)" disabled>
		            </td>
		          </tr>
		          <tr> 
		            <td width="20%" class="blue">主叫号码显示方式</td>
		            <td width="30%"> 
			              <select name="display" style="WIDTH: 130px">
			                <option value="0"
							 selected >0->使用个人标志</option>
			                <option value="1"
							>1->显示短号</option>
			                <option value="2"
							>2->显示真实号码</option>
			                <option value="3"
							>3->PBX主叫显示真实号码</option>
			              </select>
			              <select name="display2" style="WIDTH: 130px" style="display:none">
			                <option value="0"
							 selected >0->使用个人标志</option>
			                <option value="1"
							>1->显示短号</option>
			                <option value="2"
							>2->显示真实号码</option>
			                <option value="3"
							>3->PBX主叫显示真实号码</option>
			              </select>
		            </td>
		            <td width="20%" class="blue" >集团可以创建的最大闭合用户群数</td>
		            <td width="30%"> 
		              <input  name="max_clnum" type="text" id="max_clnum" disabled onKeyPress="return isKeyNumberdot(0)">
		            </td>
		          </tr>
		          <tr> 
		            <td width="23%" class="blue">单个闭合用户群能包含的最大用户数</td>
		            <td width="27%"> 
		              <input name="max_numcl" type="text" id="max_numcl" disabled onKeyPress="return isKeyNumberdot(0)">
		            </td>
		            <td width="20%" class="blue">集团可以创建的最大闭合用户群数</td>
		            <td width="30%"> 
		              <input name="pmax_close" type="text" id="pmax_close" disabled onKeyPress="return isKeyNumberdot(0)">
		            </td>
		          </tr>		          
		          <tr> 
		            <td width="20%" class="blue">集团可以拥有的最大网外号码总数</td>
		            <td width="30%"> 
		              <input name="max_outnum" type="text" id="max_outnum" disabled onKeyPress="return isKeyNumberdot(0)">
		            </td>
		            <td width="20%" class="blue">集团可拥有的最大用户数:</td>
		            <td width="30%"> <!-- wangzn 20090729 当工号为aavg21时，可以对最大用户数进行更改操作 -->
		              <input name="max_users" type="text" id="max_users"  <%if(!work_no.trim().equals("aavg21")){%>readOnly class="InputGrey"<%}%> onKeyPress="return isKeyNumberdot(0)">
		            </td>
		          </tr>		          
		          <tr> 
		            <td width="20%" class="blue">集团使用的资费套餐类型</td>
		            <td width="30%"> 
		              <input name="pkg_type" type="text" id="pkg_type" disabled onKeyPress="return isKeyNumberdot(0)">
		            </td>
		            <td width="20%" class="blue">资费套餐生效日期</td>
		            <td width="30%"> 
		              <input name="pkg_day" type="text" id="pkg_day" disabled onKeyPress="return isKeyNumberdot(0)">
		            </td>
		          </tr>
		          <tr> 
		            <td width="20%" class="blue">总折扣</td>
		            <td width="30%"> 
		              <input name="discount" type="text" id="discount" disabled onKeyPress="return isKeyNumberdot(1)">
		            </td>
		            <td width="20%" class="blue">集团月费用限额</td>
		            <td width="30%"> 
		              <input name="lmt_fee" type="text" id="lmt_fee" disabled onKeyPress="return isKeyNumberdot(1)">
		            </td>
		          </tr>
        	</table>		 
	        <TABLE  cellSpacing="0" >
	          <tr> 
	            <td width="23%" nowrap class="blue">用户备注</td>
	            <td colspan="3"> 
	              <input type="text" name="sysnote" size="60" maxlength="60" readonly class="InputGrey" >
	            </td>
	          </tr>
	        </table>		        
         	<TABLE  cellSpacing="0" >
          	<TR> 
		            <TD id="footer"> 
		            			<input type="button" name="delete1" class="b_foot" value="删除" onclick="refMain(0)" disabled>
						<input type="button" name="update1" class="b_foot" value="修改" onclick="refMain(2)" disabled>
						<input type="button" name="enable1" class="b_foot" value="激活" onclick="refMain(4)" disabled>
						<input type="button" name="disable1" class="b_foot" value="去激活" onclick="refMain(5)" disabled>
		                		<input type="reset" name="reset"     class="b_foot" value="清除"  >
		                		<input type="button" name="return"   class="b_foot" value="关闭" onClick="removeCurrentTab()">
		              
		            </TD>
          	</TR>	
      <%@ include file="/npage/include/footer.jsp" %>	
</FORM>
</body>
</html>
