 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-10 页面改造,修改样式
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%  
	   String ph_no = (String)request.getParameter("ph_no");
	
	  HashMap hm=new HashMap();
	  hm.put("1","没有客户ID！");
	  hm.put("3","密码错误！");
	  hm.put("4","手续费不确定，您不能进行任何操作！");
	  
	  hm.put("2","未取到数据1，请核查数据或咨询系统管理员！");
	  hm.put("10","未取到数据2，请核查数据或咨询系统管理员！");
	  hm.put("11","未取到数据3，请核查数据或咨询系统管理员！");
	  hm.put("12","未取到数据4，请核查数据或咨询系统管理员！");
	  hm.put("13","未取到数据5，请核查数据或咨询系统管理员！");
	  hm.put("14","未取到数据6，请核查数据或咨询系统管理员！");
	  String op_name="";
	  String op_code = request.getParameter("op_code");
	  //System.out.println("op_code === "+ op_code );
	  //op_code="1250";
	 
	  if(op_code.equals("1220"))
	    op_name="换卡变更";
	  else if(op_code.equals("1217"))
	    op_name="预销恢复";
	  else if(op_code.equals("1260"))
	    op_name="预拆恢复";
	  else if(op_code.equals("2419"))
	    op_name="积分转赠业务受理";
	  else if(op_code.equals("1296"))
	    op_name="动感地带积分转赠";
	  else if(op_code.equals("1250"))
	    op_name="积分兑奖";
	  else if(op_code.equals("1221"))
	    op_name="换卡冲正";
	  else if(op_code.equals("1353"))
	    op_name="工单补打";
	  else if(op_code.equals("1290"))
	    op_name="身份证挂失";
	  else if(op_code.equals("1291"))
	    op_name="手机证券申请";
	  else if(op_code.equals("1295"))
	    op_name="手续费";
	  else if(op_code.equals("1299"))
	    op_name="动感地带M值兑换";
	  else if(op_code.equals("2420"))
	    op_name="积分转赠业务冲正";
	  else if(op_code.equals("2421"))
	    op_name="改号通知业务";
	  else if(op_code.equals("1442"))
	    op_name="SIM卡营销";
	  else if(op_code.equals("1445"))
	    op_name="全球通签约计划";
	  else if(op_code.equals("1448"))
	    op_name="邮寄帐单";
	  else if(op_code.equals("7114"))
	    op_name="详单查询短信提醒";
	  else if(op_code.equals("1458"))
	    op_name="信息收集";
	  else if(op_code.equals("1469"))
	    op_name="全网sp业务退费";
	  else if(op_code.equals("7115"))
	    op_name="商务电话免费换机";
	  else if(op_code.equals("2299"))
	    op_name="二代身份证读卡器设置";
	  else if(op_code.equals("1499"))
	    op_name="数据业务付奖类型维护";
	  else if(op_code.equals("1451"))
	    op_name="电子帐单受理";
	  else if(op_code.equals("1452"))
	    op_name="二代身份证";
	  else if(op_code.equals("5036"))
	    op_name="客服系统套餐配制";
	  else if(op_code.equals("5037"))
	    op_name="卡类费用查询";
	  else if(op_code.equals("1577"))
	    op_name="彩信核检话单查询";
	  else if(op_code.equals("1446"))
	    op_name="改号通知";
	  else if(op_code.equals("1440"))
	    op_name="新业务兑奖";
	  else if(op_code.equals("5118"))
	    op_name="数据业务付奖";
	  else if(op_code.equals("1449"))
	    op_name="全球通签约计划冲正";
	  else if(op_code.equals("1450"))
	    op_name="积分兑换冲正";
	  else if(op_code.equals("1443"))
	    op_name="四季有礼";
	  else if(op_code.equals("2267"))
	    op_name="手机用户实名预登记查询/确认";
	  else if(op_code.equals("2266"))
	    op_name="促销品统一付奖";
	  else if(op_code.equals("2849"))
	    op_name="垃圾短信集团反馈结果信息查询";
	  else if(op_code.equals("5303"))
	    op_name="工号登陆短信提醒配置";
	  else if(op_code.equals("5309"))
	    op_name="工号登陆短信提醒配置历史查询";
%>
<%

	String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));
	String loginName = (String)session.getAttribute("workName");
	
	String opCode = "7115";		
	String opName = "商务电话免费换机充正";	//header.jsp需要的参数     
	String regionCode= (String)session.getAttribute("regCode");  
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAccept" /> 
<html>

<head>
	<title><%=op_name%></title>

	<script language="JavaScript">
		<!--
		  onload=function()
		  {
		  	document.all.phoneno.focus();		   	
		    	self.status="";
		  }
		 
		  //删除查询检查
		  function deleteSimChk(){		  	
		  	if(document.all.phoneno.value.trim().length<1){
		    	rdShowMessageDialog("手机号码不能为空！");
		 	  	return;
			} 
		   	var myPacket = new AJAXPacket("7115DelQry.jsp","正在查询客户，请稍候......");
		   	
				myPacket.data.add("phoneNo",document.all.phoneno.value.trim());
				core.ajax.sendPacket(myPacket);
				myPacket=null;
		  }
		
		
		
		 //--------4---------doProcess函数----------------
		function doProcess(packet)
		{
		  var vRetPage=packet.data.findValueByName("rpc_page");  
			var retCode = packet.data.findValueByName("retCode");
		  var retMsg = packet.data.findValueByName("retMsg");
			var cust_name = packet.data.findValueByName("cust_name");
			var strLoginAccept = packet.data.findValueByName("strLoginAccept");
			var strOldMachineType = packet.data.findValueByName("strOldMachineType");
			var strOldSimNo = packet.data.findValueByName("strOldSimNo");
			var strNewMachineType = packet.data.findValueByName("strNewMachineType");
			var strNewSimNo = packet.data.findValueByName("strNewSimNo");
		
			if(retCode == 0){
			
				document.all.cust_name.value = cust_name;
				document.all.oper_login_accept.value = strLoginAccept;
				document.all.old_machine_type.value = strOldMachineType;
				document.all.old_sim_no.value = strOldSimNo;
				document.all.new_machine_type.value = strNewMachineType;
				document.all.new_sim_no.value = strNewSimNo;
				document.all.confirm.disabled=false;
			}else
			{
				rdShowMessageDialog("错误:"+ retCode + "->" + retMsg);
				return;
			}    
		    
		}
		
		//-------2---------验证及提交函数-----------------
		
		function printCommit(){
			//校验
			getAfterPrompt();
		   if(!checkElement(document.s7115.phoneno)) return false;	
			if(!check(s7115)) return false;
			
		   //打印工单并提交表单
		   document.all.op_mark.value="用户"  + document.all.phoneno.value + "商务电话免费换机冲正";
		    var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
		
		     if((ret=="confirm"))
		      {
		        if(rdShowConfirmDialog('确认电子免填单吗？')==1)
		        {  
			      s7115.submit();
		        }
		
		
			    if(ret=="remark")
			    {
		         if(rdShowConfirmDialog('确认要提交信息吗？')==1)
		         {
			       s7115.submit();
		         }
			   }
			}
		    else
		    {
		       if(rdShowConfirmDialog('确认要提交信息吗？')==1)
		       {
			     s7115.submit();
		       }
		    }	
		    return true;
		  }
		  function showPrtDlg(printType,DlgMessage,submitCfm)
		  {  //显示打印对话框 		  	
		  	
		  	var pType="subprint";                     // 打印类型print 打印 subprint 合并打印
	     		var billType="1";                      //  票价类型1电子免填单、2发票、3收据
			var sysAccept ="<%=sysAccept%>";                       // 流水号
			var printStr = printInfo(printType);   //调用printinfo()返回的打印内容
			var mode_code=null;                        //资费代码
			var fav_code=null;                         //特服代码
			var area_code=null;                    //小区代码
			var opCode =   "<%=opCode%>";                         //操作代码
			var phoneNo = document.all.phoneno.value                          //客户电话	
			
		    	var h=180;
		     	var w=350;
		     	var t=screen.availHeight/2-h/2;
		     	var l=screen.availWidth/2-w/2;
		     	
		   	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 	   
		   	var path= "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
			var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
			var ret=window.showModalDialog(path,printStr,prop);   
		  }
		
		  function printInfo(printType){
		
		    
		    	var cust_info=""; //客户信息
	      	    	var opr_info=""; //操作信息
	      		var retInfo = "";  //打印内容
	      		var note_info1=""; //备注1
	      		var note_info2=""; //备注2
	      		var note_info3=""; //备注3
	      		var note_info4=""; //备注4 
	      		
	      		cust_info+="客户姓名：   "+document.all.cust_name.value+"|";
      			cust_info+="手机号码：   "+document.all.phoneno.value+"|";  
      			
      			if(document.all.TranType[0].checked){
				opr_info+="商务电话免费换机: 换机"+"|";
			}else{
				opr_info+="商务电话免费换机: 换机冲正"+"|";
			}
	      		note_info1+="原话机型号:"+document.all.old_machine_type.value+"|";
			note_info2+="旧SIM卡卡号:"+document.all.old_sim_no.value+"|";
		    	note_info3+="新话机型号:"+document.all.new_machine_type.value+"|";
		    	note_info4+="新SIM卡卡号:"+document.all.new_sim_no.value+"|";
		    	
		    	
			retInfo= strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
  	      		retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //把“#"替换为url格式
    	      		return retInfo;	
		  }
		
		 function sel_type1() {
		            window.location.href='s7115.jsp?op_code=7115&ph_no='+document.s7115.phoneno.value;
		 }
		
		 function sel_type2(){
		           window.location.href='s7115Del.jsp?op_code=7115&ph_no='+document.s7115.phoneno.value;
		 }		
		 //-->
	  </script> 

</head>
<body> 
	<form action="7115Cfm.jsp" method="POST" name="s7115"  onKeyUp="chgFocus(s7115)">
		<%@ include file="/npage/include/header.jsp" %>  
		<div class="title">
			<div id="title_zi">商务电话免费换机</div>
		</div>	
		<input type="hidden" name="op_code" id="op_code" value="<%=op_code%>">
		<input type="hidden" name="op_type" id="op_type" value="d">
		<input type="hidden" name="ReqPageName" id="ReqPageName" value="s1210Login">			
		<input type=hidden name=simBell value="   手机上网可选套餐优惠的GPRS流量仅指CMWAP节点产生的流量.  彩铃下载：1.购彩铃包年卡,送价值88元德赛电池。  2.登陆龙江风采（wap.hljmonternet.com）使用手机上网：体验图铃下载、新闻资讯、网络美文免费体验区下载铃音、时尚屏保,免收信息费！拨打1860开通GPRS 。">
		<input type=hidden name=worldSimBell value="    您办理此业务后，即成为我公司全球通签约客户，在签约期限内使用我公司业务及产品，同时执行月底限消费政策。您交纳的预存款需在消费期限内消费完毕，同时您获赠的积分在积分使用期限后方可使用。       在协议有效期内若遇国家资费标准调整，按国家新的资费政策执行。       做为全球通客户，您将享受我公司为您提供的尊贵服务。">
		<input type="hidden" name="opName" value="<%=opName%>">
		<input type="hidden" name="sysAccept" value="<%=sysAccept%>">
		
		<table  cellspacing="0">
			<tr> 
			    	<td  nowrap class="blue">操作类型1</td>
			    	<td  nowrap colspan="3" >
			    		<input name="TranType" type="radio" onClick="sel_type1()" value="a">换机 	
       					<input name="TranType" type="radio" onClick="sel_type2()" value="d"  checked>换机冲正 	
			    	</td>
		  	</tr>
		  	<tr> 
		    		<td  nowrap width="16%" class="blue">用户号码</td>
		      		<td nowrap  colspan="3" width="28%"> 
		      			<input   type="text" name="phoneno"  v_must=1  v_type="mobphone" value =<%=activePhone!=null?activePhone:ph_no%>  readonly class="InputGrey"  maxlength=11  index="6" >              
       					 <input  type="button" name="qryId_No" class="b_text" value="查询" onClick="deleteSimChk()" > 
		      		</td>
			</tr>  	
		 	<tr> 
		    		<td   nowrap width="16%" class="blue">用户名称</td>
		      		<td  nowrap  width="28%"> 
		      			<input name="cust_name" type="text"    index="6" readonly class="InputGrey">
		      		</td>
		      		<td  nowrap  width="16%" class="blue">操作流水</td>
		      		<td  nowrap  width="40%">
		      			<input  type="text" name="oper_login_accept" value="" readonly class="InputGrey"> 
		      		</td>
		    	</tr>
    			<tr> 
    				<td   nowrap width="16%" class="blue">原话机型号</td>
			      	<td  nowrap   width="28%"> 
			      		<input  type="text" name="old_machine_type" value="" readonly class="InputGrey">
			      	</td>
      				<td  nowrap class="blue"  width="16%">旧SIM卡卡号</td>
      				<td  nowrap  width="40%"> 
      					<input  type="text" name="old_sim_no" value="" readonly class="InputGrey">
      				</td>
  			</tr>
			<tr> 
			    	<td   nowrap width="16%" class="blue">新话机型号</td>
			      	<td  nowrap   width="28%"> 
			      		<input  type="text" name="new_machine_type" value="" readonly class="InputGrey">
			      </td>
			      <td  nowrap  width="16%" class="blue">新SIM卡卡号</td>
			      <td  nowrap  width="40%"> 
			      		<input  type="text" name="new_sim_no" value="" readonly class="InputGrey">
			      </td>
			</tr>
    			<tr>
    				<td valign="top" class="blue"> 
      					用户备注
      				</td>
      				<td colspan="4" valign="top" > 
      					<input type="text"  name="op_mark"   size="100" readonly class="InputGrey"> 
      				</td>
    			</tr>
         	</table>
         	
          	<table  cellspacing="0">
          		<tr>
            			<td id="footer" >              
                			<input  type="button" name="confirm" class="b_foot_long" value="打印&确认"  onClick="printCommit()" index="26" disabled >
                			<input  type=reset name=back value="清除" class="b_foot" onClick="document.all.confirm.disabled=true;" >
                			<input  type="button" name="b_back" class="b_foot" value="返回"  onClick="removeCurrentTab()" index="28">
             
            			</td>
                      	</tr>
        	</table>
		<%@ include file="/npage/include/footer.jsp" %>	
	</form>
</body>
</html>

