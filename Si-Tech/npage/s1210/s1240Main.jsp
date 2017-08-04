<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *update:zhanghonga@2008-09-09 页面改造,修改样式
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

	<%@ page contentType="text/html; charset=GB2312" %>
	<%@ include file="/npage/include/public_title_name.jsp" %>

 	 <%
	 	 String opCode = "1240";
		 String opName = "呼转设置";
		 
 		 String work_no = (String)session.getAttribute("workNo");
 		 String loginName = (String)session.getAttribute("workName");
 		 String loginPwd    = (String)session.getAttribute("password");
		 String[][] temfavStr=(String[][])session.getAttribute("favInfo");
		 String[] favStr=new String[temfavStr.length];
		 for(int i=0;i<favStr.length;i++)
		  favStr[i]=temfavStr[i][0].trim();
		 boolean hfrf=false;
 		 String OPflag =  (String)session.getAttribute("accountType")==null?"":(String)session.getAttribute("accountType");//OPflag == "2"时为客服工号进入
		 String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
 		 String op_code = "1240";          
 		 String srv_no=activePhone;//WtcUtil.repNull(request.getParameter("srv_no"));
 		 		
	   String loginAccept = "";	   
%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone"  routerValue="<%=srv_no%>" id="sLoginAccept"/>
<%
		loginAccept = sLoginAccept;

 	 //---------------根据提交页面决定处理流程-----------------------------
 		String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));
  	//------------------填充数据------------------------------------------
		//S1210Impl im=new S1210Impl();
		//ArrayList custDoc=im.sPubUsrBaseInfo(srv_no,op_code,"phone",srv_no,work_no);
%>
		<wtc:service name="sPubUsrBaseInfo" routerKey="phone" routerValue="<%=srv_no%>" retcode="retCode1" retmsg="retMsg1" outnum="30" >
		
		<wtc:param value=" "/>
		<wtc:param value="01"/>
		<wtc:param value="<%=op_code%>"/>
		<wtc:param value="<%=work_no%>"/>	
		<wtc:param value="<%=loginPwd%>"/>		
		<wtc:param value="<%=srv_no%>"/>	
		<wtc:param value=" "/>
			
		</wtc:service>
		<wtc:array id="sPubUsrBaseInfoArr" scope="end"/>
<%
		ArrayList baseInfoList = new ArrayList();
		if(sPubUsrBaseInfoArr!=null&&sPubUsrBaseInfoArr.length>0){
			for(int i=0;i<sPubUsrBaseInfoArr.length;i++){
				for(int j=0;j<sPubUsrBaseInfoArr[i].length;j++){
					baseInfoList.add(sPubUsrBaseInfoArr[i][j]);
				}
			}
		}else{
%>
<script>
			rdShowMessageDialog("未取到数据1，请核查数据或咨询系统管理员！",0);
			removeCurrentTab();
</script>
<%			
		}
		String userRegionCode = ((String)baseInfoList.get(2)).length()>=2?((String)baseInfoList.get(2)).substring(0,2):"";
		String handFeeSqlStr = "select hand_fee ,trim(favour_code) from snewFunctionFee where region_code='"+userRegionCode+"' and function_code='"+opCode+"'";
%>
		<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=srv_no%>" outnum="2">
    <wtc:sql><%=handFeeSqlStr%>
    </wtc:sql>
		</wtc:pubselect>
		<wtc:array id="handFeeSqlArr" scope="end"/>
<%
		if(handFeeSqlArr!=null&&handFeeSqlArr.length>0){
			for(int i=0;i<handFeeSqlArr[0].length;i++){
				baseInfoList.add(handFeeSqlArr[0][i]);
			}
		}else{
				baseInfoList.add("");
				baseInfoList.add("");
		}
		
		//服务返回参数可能不规范,比如返回四位等等.所以这样转化下,避免因为服务参数不规范带来的错误
		int returnCode = retCode1==""?999999:Integer.parseInt(retCode1);
		String returnMsg = retMsg1;
		baseInfoList.add(String.valueOf(returnCode));
		baseInfoList.add(returnMsg);
		
		//在这里进行链表转换一下
		ArrayList custDoc = baseInfoList;
		if(custDoc.size()<34){ //如果长度不够34,就表明出错了
%>
<script>
			rdShowMessageDialog("未能取得用户完整的基本信息!",0);
			removeCurrentTab();
</script>
<%		
		}
		if(Double.parseDouble(((String)custDoc.get(19)))>Double.parseDouble(((String)custDoc.get(20)))){
				String SqlBuffer = "select count(b.pay_code) from dConUserMsg a, dConMsg b , dCustMsg c where a.id_no = c.id_no and c.id_no =" + (String)custDoc.get(0)+ " and  a.contract_no = b.contract_no and a.bill_order!=99999999 and b.pay_code = '4' and a.rate_flag='N'";		
				System.out.println("SqlBuffer=[" + SqlBuffer);
				//retArray = co.spubqry32("1",SqlBuffer);
%>
				<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=srv_no%>" outnum="1">
		    <wtc:sql><%=SqlBuffer%>
		    </wtc:sql>
				</wtc:pubselect>
				<wtc:array id="result" scope="end"/>
<%
				if(result.length>0){
				  if(Integer.parseInt(result[0][0]) == 0){
%>
<script>
			rdShowMessageDialog("已欠费，不能办理业务！",0);
			removeCurrentTab();
</script>
<%				  
					}
				}
	  }
	  
	  
 		if(((String)custDoc.get(30)).trim().equals("") || ((String)custDoc.get(30)).trim().equals("0") || Double.parseDouble(((String)(custDoc.get(30))))==0)
		{
 			hfrf=true; 
		}else{
          if(!WtcUtil.haveStr(favStr,((String)custDoc.get(31)).trim())){
 						hfrf=true;
		  		}
		}
		
		
 		if(Integer.parseInt(((String)custDoc.get(32)).trim())!=0)
		{
		  if(Integer.parseInt(((String)custDoc.get(32)).trim())==1007 || Integer.parseInt(((String)custDoc.get(32)).trim())==1008)
		  {
		   }else{
%>
<script>
			rdShowMessageDialog("<%=new String(((String)custDoc.get(33)).trim().getBytes("GBK"),"ISO8859_1")%>",0);
			removeCurrentTab();
</script>
<%			   	
		  }
		}
		String Sql = "select a.CALL_PHONE from sCallPhone a,dcustmsg b where region_code='"+userRegionCode+"' and  phone_no='"+srv_no+"' and a.sm_code=b.sm_code and function_type='M'";	
%>
		<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=srv_no%>" outnum="1">
    <wtc:sql><%=Sql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="resultPhone" scope="end"/>
<%
		String callPhoneNo = resultPhone.length>0?resultPhone[0][0]:"";
%>
	<html xmlns="http://www.w3.org/1999/xhtml">
	 <head>
 	 <title>呼转设置</title>
 	 <META content="MSHTML 5.00.3315.2870" name=GENERATOR>
	 <script language=javascript>	  
	   onload=function()
	   {
	   	if("2"=="<%=OPflag%>"){
	   			$("#userInfo").css("display","none");
	   			$("#Fee").css("display","none");
	   	}
	 		 self.status="";
			 document.all.s_optype.focus();
			 chgtypechg();
	   }	   

	  //--------4---------显示打印对话框----------------
	 function chgtypechg()
	 {
	 	var myEle ;
  		var x ;
  		//for (var q=document.all.s_optype.options.length;q>=0;q--) document.all.s_optype.options[q]=null;
	 	if(document.all.chgtype.value=="01")
	 	{
	 	  /*
	 		myEle = document.createElement("option") ;
        	myEle.value = "0";
        	myEle.text = "取消";
        	document.all.s_optype.add(myEle) ;
        	myEle = document.createElement("option") ;
        	myEle.value = "1";
        	myEle.text = "申请";
        	document.all.s_optype.add(myEle) ;
       */
        	if($("#s_optype").find("option:selected").text()=="取消"){
        	  $("#s_optype").find("option:selected").val("0");
        	}else{
        	   $("#s_optype").find("option:selected").val("1");
        	}
	 	}
	 	else if (document.all.chgtype.value=="02")
	 	{
	 	  /*
	 		myEle = document.createElement("option") ;
        	myEle.value = "2";
        	myEle.text = "取消";
        	document.all.s_optype.add(myEle) ;
        	myEle = document.createElement("option") ;
        	myEle.value = "3";
        	myEle.text = "申请";
        	document.all.s_optype.add(myEle) ;
       */
      if($("#s_optype").find("option:selected").text()=="取消"){
        $("#s_optype").find("option:selected").val("2");
      }else{
        $("#s_optype").find("option:selected").val("3");
      }
        	
	 	}
	 	else if (document.all.chgtype.value=="03")
	 	{
	 	  /*
	 		myEle = document.createElement("option") ;
        	myEle.value = "4";
        	myEle.text = "取消";
        	document.all.s_optype.add(myEle) ;
        	myEle = document.createElement("option") ;
        	myEle.value = "5";
        	myEle.text = "申请";
        	document.all.s_optype.add(myEle) ;
       */
      if($("#s_optype").find("option:selected").text()=="取消"){
        $("#s_optype").find("option:selected").val("4");
      }else{
        $("#s_optype").find("option:selected").val("5");
      }
	 	}
	 }
	 function printCommit()
	 {
	    	//客服工号不展示
	 		if("2"!="<%=OPflag%>"){
	    	getAfterPrompt();//add by qidp
	  	}
	  	
	  	/* begin 当操作类型为“申请”时，界面中的“呼转号码”为必填项 @2013/8/22 */
	  	if($("#s_optype").find("option:selected").text()=="申请"){
	  	  if(document.all.next_no.value.trim().len()==0)
				{
					 rdShowMessageDialog("呼转号码不能为空！");
					 document.all.next_no.value=document.all.next_no.value.trim();
					 document.all.next_no.focus();
					 return false;
				}
	  	  if(!forNotNegReal(document.all.next_no)){
					return false;
				}
	  	}
	  	/* end  @2013/8/22 */
			if(document.all.s_optype.options[document.all.s_optype.selectedIndex].value == "1")
			{
			  if(document.all.next_no.value.trim().len()==0)
				{
					 rdShowMessageDialog("呼转号码不能为空！");
					 document.all.next_no.value=document.all.next_no.value.trim();
					 document.all.next_no.focus();
					 return false;
				}
				if(!forNotNegReal(document.all.next_no)){
					return false;
				}
			}
			if(document.all.s_optype_new.value=="0" ){
				if(document.all.next_no.value !="<%=callPhoneNo%>"){
					rdShowMessageDialog("来电提醒呼转号码应是"+"<%=callPhoneNo%>");
					return;
				}
			}
		showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
	 }

	 function showPrtDlg(printType,DlgMessage,submitCfm)
	 {
		if(check(frm))
		{
			document.all.t_sys_remark.value="用户"+document.all.srv_no.value.trim()+document.all.s_optype.options[document.all.s_optype.selectedIndex].text+document.all.callType.options[document.all.callType.selectedIndex].text+"  到"+document.all.next_no.value;
		  if(document.all.t_op_remark.value.trim().len()==0){
				  document.all.t_op_remark.value="操作员<%=work_no%>"+"对用户手机"+document.all.srv_no.value.trim()+"呼转设置"
		  }

		 //显示打印对话框

			var h=210;
			var w=400;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var pType="subprint";   
			var billType="1";  
			var sysAccept = document.all.loginAccept.value;
			var printStr = printInfo(printType);
			
			var mode_code=null;
			var fav_code=null;
			var area_code=null;
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no;	scrollbars:yes; resizable:no;location:no;status:no;help:no"
			var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage;
			var path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo=<%=srv_no%>&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
			var ret=window.showModalDialog(path,printStr,prop);
		 
		  if(typeof(ret)!="undefined")
		  {
			if((ret=="confirm")&&(submitCfm == "Yes"))
			{
				  if(rdShowConfirmDialog('确认要提交呼转设置信息吗？')==1)
				  {
				   conf();
				  }
				  
		    }
		    if(ret=="continueSub")
		    {
			  if(rdShowConfirmDialog('确认要提交呼转设置信息吗？')==1)
			  {
			   conf();
			  }
    		}
		  }
		  else
		  {
			  if(rdShowConfirmDialog('确认要提交呼转设置信息吗？')==1)
			  {
			   conf();
			  }
		  }
		}
	 }

	 function printInfo(printType)
	 {
 		  var retInfo = "";
 		  var cust_info="";
		  var opr_info="";
		  var note_info1="";
		  var note_info2="";
		  var note_info3="";
		  var note_info4="";
    	cust_info+="客户姓名："+'<%=(String)custDoc.get(5)%>'+"|";
    	cust_info+="手机号码："+'<%=srv_no%>'+"|";  
    	cust_info+="证件号码："+'<%=(String)custDoc.get(16)%>'+"|";
    	cust_info+="客户地址："+'<%=(String)custDoc.get(13)%>'+"|";

    	opr_info+="业务类型："+document.all.chgtype.options[document.all.chgtype.selectedIndex].text+"|";
    	opr_info+="呼转类型："+document.all.callType.options[document.all.callType.selectedIndex].text+"/"+document.all.s_optype.options[document.all.s_optype.selectedIndex].text+"呼转设置"+"|";
    	opr_info+="流水："+document.all.loginAccept.value+"|";


 		note_info1+="备注："+"|";
 		note_info1+=document.all.t_sys_remark.value+"|";
    	note_info1+=document.all.t_op_remark.value+"|";
		//retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
		return retInfo;
	 }

	 //--------5----------提交处理函数-------------------
	 function conf()
	 {
		document.all.b_print.disabled=true;
		document.all.b_clear.disabled=true;

		 frm.action="s1240_conf.jsp";
		 frm.submit();
	 }

	 function canc()
	 {
		frm.submit();
	 }

    //-------6--------实收栏专用函数----------------
     function ChkHandFee()
	 {
       if(document.all.oriHandFee.value.trim().len()>=1 && document.all.t_handFee.value.trim().len()>=1)
	   {
         if(parseFloat(document.all.oriHandFee.value)<parseFloat(document.all.t_handFee.value))
	     {
          rdShowMessageDialog("实收手续费不能大于原始手续费！");
				  document.all.t_handFee.value=document.all.oriHandFee.value;
				  document.all.t_handFee.select();
				  document.all.t_handFee.focus();
				  return;
	     }
	   }
	  
	   if(document.all.oriHandFee.value.trim().len()>=1 && document.all.t_handFee.value.trim().len()==0)
	   {
         document.all.t_handFee.value="0";
	   }
	 }

	 function getFew()
	 {
	   if(window.event.keyCode==13)
	   {
		 var fee=document.all.t_handFee;
		 var fact=document.all.t_factFee;
		 var few=document.all.t_fewFee;
		 if(fact.value.trim().len()==0)
		 {
		  rdShowMessageDialog("实收金额不能为空！");
		  fact.value="";
		  fact.focus();
		  return;
		 }
		 if(parseFloat(fact.value)<parseFloat(fee.value))
		 {
		  rdShowMessageDialog("实收金额不足！");
		  fact.value="";
		  fact.focus();
		  return;
		 }

		var tem1=((parseFloat(fact.value)-parseFloat(fee.value))*100+0.5).toString();
		var tem2=tem1;
		if(tem1.indexOf(".")!=-1) tem2=tem1.substring(0,tem1.indexOf("."));
	    few.value=(tem2/100).toString();
			few.focus();
	   }
	 }
	 
	 function callTypeChg(){
	 	if(document.all.callType.value=="52"){
	 		document.all.s_optype_id.style.display = "";
	 		document.all.s_optype_new.value = "1";
	 	}else{
	 		document.all.s_optype_id.style.display = "none";
	 		document.all.next_no.value="";
	 		document.all.s_optype_new.value = "1";
	 	}
	}
	function opTypeNewChg(){
		if(document.all.s_optype_new.value=="0"){
			document.all.next_no.value="<%=callPhoneNo%>";
		}else{
			document.all.next_no.value="";
		}
	}
	 </script>
	 </head>
	 <body>
 			<form name="frm" method="POST"  onKeyUp="chgFocus(frm)">
 	  		<input type="hidden" name="op_code" value="<%=op_code%>">
  			<input type="hidden" name="region_code" value="<%=regionCode%>">
				<%@ include file="../../include/remark.htm" %>
				<input type="hidden" name="srv_no" id="srv_no" value="<%=srv_no%>">
				<input type="hidden" name="cust_name" id="cust_name" value="<%=(String)custDoc.get(5)%>">
				<input type="hidden" name="cust_addr" id="cust_addr" value="<%=(String)custDoc.get(13)%>">
				<input type="hidden" name="ic_no" id="ic_no" value="<%=(String)custDoc.get(16)%>">
				<input type="hidden" name="ReqPageName" id="ReqPageName" value="s1240Main">
				<input type="hidden" name="user_id" id="user_id" value="<%=(String)custDoc.get(0)%>">
				<input type="hidden" name="oriHandFee" id="oriHandFee" value="<%=((String)custDoc.get(30)).trim()%>">
				<input type="hidden" name="oldPass" id="oldPass" value="<%=((String)custDoc.get(6)).trim()%>">
				
				<input type="hidden" name="assu_name" value="">
				<input type="hidden" name="assu_phone" value="">
				<input type="hidden" name="assu_idAddr" value="">
				<input type="hidden" name="assu_idIccid" value="">
				<input type="hidden" name="assu_conAddr" value="">
				<input type="hidden" name="assu_idType" value="">
				<input type="hidden" name="loginAccept" value="<%=loginAccept%>">
 			<%@ include file="/npage/include/header.jsp" %>
					<div id="userInfo">
						<div class="title">
						    <div id="title_zi">用户信息</div>
						</div> 				   
              <table cellspacing="0">
                <tr> 
                  <td class="blue" width="13%"> 
                    <div align="left">客户名称</div>
                  </td>
                  <td width="20%"> 
                    <div align="left"><%=(String)custDoc.get(5)%></div>
                  </td>
                  <td class="blue" width="13%"> 
                    <div align="left">大客户标志</div>
                  </td>
                  <td width="20%"> 
                    <div align="left"><b><font class="orange"><%=(String)custDoc.get(17)%></font></b></div>
                  </td>
                  <td class="blue" width="13%"> 
                    <div align="left">集团标志</div>
                  </td>
                  <td width="20%"> 
                    <div align="left"><%=(String)custDoc.get(18)%></div>
                  </td>
                </tr>
                <tr> 
                  <td class="blue"> 
                    <div align="left">客户状态</div>
                  </td>
                  <td> 
                    <div align="left"><%=(String)custDoc.get(8)%> </div>
                  </td>
                  <td class="blue"> 
                    <div align="left">客户级别</div>
                  </td>
                  <td> 
                    <div align="left"><%=(String)custDoc.get(10)%> </div>
                  </td>
                  <td class="blue"> 
                    <div align="left">客户类别</div>
                  </td>
                  <td> 
                    <div align="left"><%=(String)custDoc.get(12)%> </div>
                  </td>
                </tr>
                <tr> 
                  <td class="blue"> 
                    <div align="left">客户地址</div>
                  </td>
                  <td> 
                    <div align="left"><%=(String)custDoc.get(13)%></div>
                  </td>
                  <td class="blue"> 
                    <div align="left">证件类型</div>
                  </td>
                  <td> 
                    <div align="left"><%=(String)custDoc.get(15)%> </div>
                  </td>
                  <td class="blue"> 
                    <div align="left">证件号码</div>
                  </td>
                  <td> 
                    <div align="left"><%=(String)custDoc.get(16)%></div>
                  </td>
                </tr>
                <tr> 
                  <td class="blue"> 
                    <div align="left">业务类型</div>
                  </td>
                  <td> 
                    <div align="left"><%=(String)custDoc.get(4)%></div>
                  </td>
                  <td class="blue"> 
                    <div align="left">当前预存</div>
                  </td>
                  <td> 
                    <div align="left"><%=(String)custDoc.get(20)%></div>
                  </td>
                  <td class="blue"> 
                    <div align="left">当前欠费</div>
                  </td>
                  <td> 
                    <div align="left"><%=(String)custDoc.get(19)%></div>
                  </td>
                </tr>
              </table>
           </div>
          </div>
          
					 <div id="Operation_Table"> 
						<div class="title">
							<div id="title_zi">业务办理</div>
						</div> 
						<table cellspacing="0">              
                <tr> 
                  <td class="blue" width="13%"> 
                    <div align="left">用户号码</div>
                  </td>
                  <td width="20%"><%=srv_no%></td>
                  <td class="blue" width="13%"> 
                    <div align="left">业务类型</div>
                  </td>
                  <td nowrap >
                    <select name="chgtype" onChange="chgtypechg()">
					    				<option value="01" selected>语音及可视</option>
					    				<option value="02">普通语音业务</option>
					    				<option value="03">可视电话业务</option>
					  				</select>
                  </td>
                 <td class="blue" width="13%"> 
                    <div align="left">呼转类型</div>
                  </td>
                  <td nowrap >
                    <select name="callType" onChange="callTypeChg()">
					    				<option value="51" selected>无条件呼转</option>
					    				<option value="52">不可及呼转</option>
					    				<option value="53">无应答呼转</option>
					    				<option value="54">遇忙呼转  </option>
					  				</select>
                  </td>
                </tr>
                <tr id="s_optype_id" style="display:none"> 
                	<td class="blue"> 
                    <div align="left">呼转方式</div>
                  </td>
                 	<td nowrap colspan="5"> 
                    <select name="s_optype_new"  index="1" onChange="opTypeNewChg()">
                      <option value="1" selected>普通</option>
                      <option value="0">来电提醒</option>
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td class="blue"> 
                    <div align="left">操作类型</div>
                  </td>
                  <td> 
                    <select name="s_optype" id="s_optype" index="0">
                      <option value="1" selected>申请</option>
                      <option value="0">取消</option>
                    </select>
                  </td>
                  <td class="blue"> 
                    <div align="left">呼转号码</div>
                  </td>
                  <td nowrap colspan="3"> 
                    <input type="text" name="next_no" id="next_no" maxlength="15" style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)">
                  </td>
                </tr>
                 
                <tr> 
                  <tr id="Fee"> 
                  	<td  class="blue"> 
                    <div align="left">手续费</div>
                  </td>
                  <td> 
                    <div align="left"> 
                      <input type="text" name="t_handFee" id="t_handFee" size="16" value="<%=(((String)custDoc.get(30)).trim().equals(""))?("0"):(((String)custDoc.get(30)).trim()) %>" v_type=float v_name="手续费" <%if(hfrf){%>readonly<%}%> onblur="ChkHandFee()"  index="2">
                    </div>
                  </td>
                  <td class="blue"> 
                    <div align="left">实收</div>
                  </td>
                  <td nowrap width="20%"> 
                    <div align="left"> 
                      <input type="text" name="t_factFee" id="t_factFee" size="16" index="3" onKeyUp="getFew()" v_type=float v_name="实收" 
                      <%
                      	if(hfrf){
													 if(((String)custDoc.get(30)).trim().equals("") || ((String)custDoc.get(30)).trim().equals("0")  || Double.parseDouble(((String)(custDoc.get(30))))==0)
													 {
							   			%>
								   						readonly
							  			<%
													 }
												 }
							   			%>
							   			>
                    </div>
                  </td>
                  <td class="blue" width="13%"> 
                    <div align="left">找零</div>
                  </td>
                  <td> 
                    <div align="left"> 
                      <input type="text" name="t_fewFee" id="t_fewFee" size="16" readonly>
                    </div>
                  </td>
                </tr>
                <tr> 
                  <td class="blue"> 
                    <div align="left">系统备注</div>
                  </td>
                  <td nowrap colspan="5"> 
                    <div align="left"> 
                      <input type="text" name="t_sys_remark" id="t_sys_remark" size="60" readonly maxlength=30>
                    </div>
                  </td>
                </tr>
                <tr style="display:none"> 
                  <td class="blue"> 
                    <div align="left">用户备注</div>
                  </td>
                  <td nowrap colspan="5"> 
                    <div align="left"> 
                      <input type="text" name="t_op_remark" id="t_op_remark" size="60" v_maxlength=60  v_type=string  v_name="用户备注" maxlength=60 index="4">
                    </div>
                  </td>
                </tr>
                <tr> 
                  <td nowrap colspan="6" id="footer"> 
                    <div align="center"> 
                      <input class="b_foot" name=back2 type=button onmouseup="assuWin();" onkeyup="if(event.keyCode==13)assuWin()" value="担保人录入" index="5" style="display:none">
                      <input class="b_foot" type="button" name="b_print" value="确认&打印" onmouseup="printCommit()" onkeyup="if(event.keyCode==13)printCommit()" index="6">
                      <input class="b_foot" type="button" name="b_clear" value="清除" onClick="frm.reset();" index="7">
                      <input class="b_foot" type="button" name="b_close" value="关闭" onclick="parent.removeTab('<%=opCode%>')">
                    </div>
                  </td>
                </tr>
              </table>
		    		<%@ include file="/npage/include/footer.jsp" %>
 	 </form>
 	 </body>

 	 	
 	 	
 	 </html>
