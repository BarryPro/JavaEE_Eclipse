 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-01-16 页面改造,修改样式
	********************/
%> 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>

<html>

<head>
	<title>包年付奖</title>
<%
   
	 String opCode = "5100";	
	 String opName = "包年付奖";	//header.jsp需要的参数   
	 String regionCode = (String)session.getAttribute("regCode");
	 String loginName =(String)session.getAttribute("workName");//工号名称                   
   	 String[][]  temfavStr = (String[][])session.getAttribute("favInfo");	//优惠权限信息
   	 String[] favStr=new String[temfavStr.length];
	 for(int i=0;i<favStr.length;i++)
		favStr[i]=temfavStr[i][0].trim();
	 boolean pwrf=false;
	 if(WtcUtil.haveStr(favStr,"a272"))
		pwrf=true;
   	String printAccept="";
   	printAccept = getMaxAccept();  
%>
	<script language=javascript>
 
	//----------------验证及提交函数-----------------
	 function verifyCust(){
	  
	    if (document.frm.srv_no.value.length == 0) {
	      rdShowMessageDialog("手机号码不能为空，请重新输入 !!",0);
	      document.frm.srv_no.focus();
	      return false;
	     } 
		
 
		var myPacket = new AJAXPacket("custmsg.jsp","正在查询客户信息，请稍候......");
		myPacket.data.add("phoneNo",document.frm.srv_no.value.trim());
		myPacket.data.add("type","0");
		core.ajax.sendPacket(myPacket);
		myPacket=null;
		//delete(myPacket);  
	    
		
	 }	 
	function doProcess(packet)
	{
	    var retCode = packet.data.findValueByName("retCode");
	    var retMsg = packet.data.findValueByName("retMsg");
		var retResult = packet.data.findValueByName("retResult");
	    var type = packet.data.findValueByName("type");
	    var custName = packet.data.findValueByName("cust_name");
		var iccid = packet.data.findValueByName("id_iccid");
		var custAddress = packet.data.findValueByName("id_address");	    
	    if (type == "0"){
			if(custName!=""){
				document.frm.cust_name.value = custName;
				document.frm.iccid.value = iccid;
				document.frm.custAddress.value = custAddress;
			}else{
				rdShowMessageDialog("无此号码！",0);
				document.frm.srv_no.focus();
				return false;
			}
			if(retResult!="0")
			{
				rdShowMessageDialog("此号码领过奖品！",0);
			}
	
		}else{
			if(retResult == "000000"){
				rdShowMessageDialog("密码输入准确！",2);
				document.frm.confirm.disabled = false;
				document.frm.infor.disabled= false;
				return true; 
			 }else{
				rdShowMessageDialog("密码输入错误，请重新输入！",0);
				document.frm.confirm.disabled = true;
				return false;
			 
			 }
		}
			
	}	
	function printCommit()
	{          
		getAfterPrompt();
		if (document.frm.srv_no.value.length == 0) {
	      rdShowMessageDialog("手机号码不能为空，请重新输入 !!",0);
	      document.frm.srv_no.focus();
	      return false;
	     } 
		
		if(document.frm.cust_name.value!="")
	  {
		var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
	
	     if((ret=="confirm"))
	      {
	        if(rdShowConfirmDialog('确认电子免填单吗？')==1)
	        {  
		      frm.submit();
	        }
	
	
		    if(ret=="remark")
		    {
	         if(rdShowConfirmDialog('确认要提交信息吗？')==1)
	         {
		       frm.submit();
	         }
		   }
		}
	    else
	    {
	       if(rdShowConfirmDialog('确认要提交信息吗？')==1)
	       {
		     frm.submit();
	       }
	    }
	  }
	
	    return true;  	 
	}

	function showPrtDlg(printType,DlgMessage,submitCfm)
	{ 
	 	var pType="subprint";                     // 打印类型print 打印 subprint 合并打印
     		var billType="1";                      //  票价类型1电子免填单、2发票、3收据
		var sysAccept ="<%=printAccept%>";                       // 流水号
		var printStr = printInfo(printType);   //调用printinfo()返回的打印内容
		var mode_code=null;                        //资费代码
		var fav_code=null;                         //特服代码
		var area_code=null;                    //小区代码
		var opCode =   "<%=opCode%>";                         //操作代码
		var phoneNo = <%=activePhone%>;                           //客户电话	
		
		 //显示打印对话框 
		var h=180;
		var w=350;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
	
	   	var printStr = printInfo(printType);	   	
	    	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
	    
	      var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);   
	}


	function printInfo(printType)
	{
	   
	  if(document.frm.op_note.value==""){ 				
	  	document.frm.op_note.value="<%=loginName%>"+"对用户"+document.frm.cust_name.value+"进行付奖，奖品类型为"+document.frm.award_type.value;
	  }
	  
	      var cust_info=""; //客户信息
	      var opr_info=""; //操作信息
	      var retInfo = "";  //打印内容
	      var note_info1=""; //备注1
	      var note_info2=""; //备注2
	      var note_info3=""; //备注3
	      var note_info4=""; //备注4
	      
	      cust_info+="手机号码："+document.frm.srv_no.value+"|";	    
	      cust_info+="客户姓名："+document.frm.cust_name.value+"|";	    
	      cust_info+="证件号码："+document.frm.iccid.value+"|";	   
	      cust_info+="客户地址："+document.frm.custAddress.value+"|";
	      
	      opr_info+="业务类型："+"包年付奖"+"|";
	      opr_info+="操作流水："+"<%=printAccept%>"+"|";	
	      note_info1+="备注:"+document.frm.op_note.value+"|";
	      
	      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
  	      retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //把“#"替换为url格式
    	      return retInfo;	
	}	
	</script>
</head>
<body>
	<form name="frm" method="POST" action="s5100Cfm.jsp" >			
			<%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">
				<div id="title_zi">包年付奖</div>
			</div>   
			<input type="hidden" name="iccid" value="">
			<input type="hidden" name="custAddress" value="">
			<table  cellspacing="0">   
				<TBODY>  
			            <tr> 
				           	<td  nowrap class="blue"> 手机号码</td>
					        <td nowrap  class="blue colspan="5">            
					                <input  type="text"  name="srv_no"size="12" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1  v_name="服务号码" maxlength="11" index="0" value =<%=activePhone%>  readonly class="InputGrey" >    
					                <font class="orange">*</font>           
													<input class="b_text" type="button" name="infor" value="查询" onClick="verifyCust()">				
					        </td>		 
					        <td colspan="2">&nbsp;</td>			          
			            </tr>
			          <tr>
			          		<td nowrap  class="blue"> 
			              		用户名称
			            	</td>
			            	<TD>
						<input type="text" class="InputGrey" name="cust_name"  maxlength="8" readOnly /> 		    
										</TD>
										<td  nowrap  class="blue">付奖类型</td>
			             	<td class=Input nowrap  >
						              <select name="award_type" index="15" >
							                <option value="月租包年" selected >月租包年</option>
							                <option value="其他1">其他1</option>
							                <option value="其他2">其他2</option>
							                <option value="其他3">其他3</option>
															<option value="动感地带久明运动水壶">动感地带久明运动水壶</option>
							                <option value="动感地带邦方运动水壶">动感地带邦方运动水壶</option>
						              </select>
			            	</td>			
			         </tr>
				<tr>
					<td  class="blue" nowrap> 备注信息</td>
					<td colspan="3"> 
						<INPUT class="InputGrey" TYPE=text NAME="op_note" size="60" readOnly />
					</td>			
				</tr>
			</TBODY>
      	</table>
    	<table cellspacing="0">
    		<TBODY>
				<tr> 
					<td id="footer"> 				
					    	<input class="b_foot" type=button name="confirm" value="确认" onClick="printCommit()" index="2">
					    	&nbsp;
					    	<input class="b_foot" type=button name=back value="清除" onClick="frm.reset()">
					    	&nbsp; 
					    	<input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab()">		               
					</td>
				</tr>
		</TBODY>
  	</table>
  	<input type="hidden" value="<%=printAccept%>" name="printAccept"/>
  	<%@ include file="/npage/include/footer.jsp" %>	 
   </form>
</body>
</html>