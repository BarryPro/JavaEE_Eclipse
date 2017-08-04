<%
	/********************
	 version v2.0
	开发商: si-tech
	********************/
%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>


<%		
 	//String opCode = "9911";	
	//String opName = "手机邮箱5元版商用申请";	//header.jsp需要的参数
  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
	String loginNo = (String)session.getAttribute("workNo");    //工号
	String regionCode = (String)session.getAttribute("regCode"); 
 	String loginName = (String)session.getAttribute("workName");  
 	String password = (String)session.getAttribute("password");   
%>
<%
	String retFlag="",retMsg="";
 	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
  	//ArrayList retList = new ArrayList();
  	String[] paraAray1 = new String[3];
	String phoneNo = request.getParameter("srv_no");
	String opcode = request.getParameter("opcode");
  	String passwordFromSer="";
  
  	paraAray1[0] = phoneNo;		/* 手机号码   */ 
  	paraAray1[1] = "9911"; 	    /* 操作代码   */
  	paraAray1[2] = loginNo;	    /* 操作工号   */

	  for(int i=0; i<paraAray1.length; i++)
	  {		
		if( paraAray1[i] == null )
		{
		  paraAray1[i] = "";
		  
		}
	  }
 /* 输出参数： 返回码，返回信息，客户姓名，客户地址，证件类型，证件号码，业务品牌，
 			归属地，当前状态，VIP级别，当前积分,可用预存
 */

  	//retList = impl.callFXService("s9911Qry", paraAray1, "20","phone",phoneNo);
  %>
  <wtc:service name="s9911Qry" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="19" >
		<wtc:param value=" " />
		<wtc:param value="01" />
		<wtc:param value="<%=paraAray1[1]%>"/>
		<wtc:param value="<%=paraAray1[2]%>"/>
		<wtc:param value="<%=password%>" />
		<wtc:param value="<%=paraAray1[0]%>"/>
	  <wtc:param value=" " />
	</wtc:service>
	<wtc:array id="retList" scope="end"/>
 <%	  	
  	String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="",run_name="",vip="",posint="",prepay_fee="";
  	String curlevel="",nextlevel="",text_curlevel="",text_nextlevel="",qxlevel="KTYX5";
  	String spcode="",opercode="";
  	String orderFlag = "0"; //默认为0，全球通全网统一资费(包含预约)为1  liujian add
  	String[][] tempArr= new String[][]{};
  	//int errCode = impl.getErrCode();
  	//String errMsg = impl.getErrMsg();
  	String errCode = retCode1;
  	String errMsg= retMsg1;
  if(retList == null)
  {
	if(!retFlag.equals("1"))
	{
		System.out.println("retFlag="+retFlag);
	   retFlag = "1";
	   retMsg = "s9911Qry查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }    
  }
  else
  {
  	System.out.println("errCode=========999999========="+errCode);
  	System.out.println("errMsg=========999======="+errMsg);
	if(!errCode.equals("000000")){%>
		<script language="JavaScript">
			rdShowMessageDialog("错误代码：<%=errCode%>，错误信息：<%=errMsg%>",0);
			//history.go(-1);
			window.location.href="f9912_a.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
		</script>
	<%}
	else{
	  if(retList.length>0){
		 // tempArr = (String[][])retList.get(2);
		    tempArr=retList;
		  if(!(tempArr==null)){
		    bp_name = tempArr[0][2];//机主姓名
		    System.out.println(bp_name);
		  }
		  //tempArr = (String[][])retList.get(3);
		  if(!(tempArr==null)){
		    bp_add = tempArr[0][3];//客户地址
		  }
		  //tempArr = (String[][])retList.get(4);
		  if(!(tempArr==null)){
		    cardId_type = tempArr[0][4];//证件类型
		  }
		  //tempArr = (String[][])retList.get(5);
		  if(!(tempArr==null)){
		    cardId_no = tempArr[0][5];//证件号码
		  }
		  //tempArr = (String[][])retList.get(6);
		  if(!(tempArr==null)){
		    sm_code = tempArr[0][6];//业务品牌
		  }
		  //tempArr = (String[][])retList.get(7);
		  if(!(tempArr==null)){
		    region_name = tempArr[0][7];//归属地
		  }
		  //tempArr = (String[][])retList.get(8);
		  if(!(tempArr==null)){
		    run_name = tempArr[0][8];//当前状态
		  }
		  //tempArr = (String[][])retList.get(9);
		  if(!(tempArr==null)){
		    vip = tempArr[0][9];//ＶＩＰ级别
		  }
		  //tempArr = (String[][])retList.get(10);
		  if(!(tempArr==null)){
		    posint = tempArr[0][10];//当前积分
		  }
		  //tempArr = (String[][])retList.get(11);
		  if(!(tempArr==null)){
		    prepay_fee = tempArr[0][11];//可用预存
		  }
		  //tempArr = (String[][])retList.get(13);
		  if(!(tempArr==null)){
		    passwordFromSer = tempArr[0][13];  //密码
		  }
		  //tempArr = (String[][])retList.get(14);
		  if(!(tempArr==null)){
		    curlevel = tempArr[0][14];  //当前级别编码
		  }
		  	  	
		  //tempArr = (String[][])retList.get(15);
		  if(!(tempArr==null)){
			  nextlevel = tempArr[0][15];  //预约级别编码
		  }
		  //tempArr = (String[][])retList.get(16);
		  if(!(tempArr==null)){
			  text_curlevel = tempArr[0][16];  //当前级别名称
		  }
		  //tempArr = (String[][])retList.get(17);
		  if(!(tempArr==null)){
			  text_nextlevel = tempArr[0][17];  //预约级别名称
			/*liujian add 资费判断 1为全球通全网统一资费(包含预约) begin*/
			  orderFlag = tempArr[0][18];
			/*liujian add 资费判断 1为全球通全网统一资费(包含预约) end*/
		  }
	  }
	}
  }

%>

<%
	//******************得到下拉框数据***************************//
	String printAccept="";
	printAccept = getMaxAccept();
	System.out.println("=============================="+printAccept);
	String exeDate="";
	exeDate = getExeDate("1","1141");

%>

<html>
<head>
	<title><%=opName%></title>
	<script type="text/javascript" src="../../npage/s3000/js/S3000.js"></script>
	<script language="JavaScript" src="../../npage/s1400/pub.js"></script> 
	<script language="JavaScript">
		<!--
		  //定义应用全局的变量
		  var SUCC_CODE	= "0";   		//自己应用程序定义
		  var ERROR_CODE  = "1";			//自己应用程序定义
		  var YE_SUCC_CODE = "0000";		//根据营业系统定义而修改
		
		  //***
		  function frmCfm(){
  		 	frm.submit();
  			return true;
		  }
		 //***IMEI 号码校验

		 function printCommit()
		 { 
		 	/*liujian add 添加订购方式字段 begin*/
		 	/*
		 	liujian 2012-8-20 15:25:05 orderFlag不再起作用
		 	var order_flag = '<%=orderFlag%>'; 
		 	if(order_flag == "1") {
		 		 var selectValue = $('#orderWaySelect').val();
		 		 $('#orderWayStatus').val(selectValue);
		 	}
		 	*/
		 	/*liujian add 添加订购方式字段 end*/
		 	
		  getAfterPrompt();
		  var updateLevel = $("#updateLevel").val();
		  $("#updateLevel_hidden").val("KTYX"+updateLevel);
		 //打印工单并提交表单
		  var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes"); 
		  if(typeof(ret)!="undefined")
		  {
		    if((ret=="confirm"))
		    {
		      if(rdShowConfirmDialog('确认电子免填单吗？')==1)
		      {
			    frmCfm();
		      }
			}
			if(ret=="continueSub")
			{
		      if(rdShowConfirmDialog('确认要提交信息吗？')==1)
		      {
			    frmCfm();
		      }
			}
		  }
		  else
		  {
		     if(rdShowConfirmDialog('确认要提交信息吗？')==1)
		     {
			   frmCfm();
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
			var phoneNo = <%=phoneNo%>;                           //客户电话
			
			//显示打印对话框 
			var h=180;
			var w=352;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 	   
		   	var path= "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
			var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
			var ret=window.showModalDialog(path,printStr,prop); 	   
			   
		}

		function printInfo(printType)
		{
      var cust_info=""; //客户信息
      var opr_info=""; //操作信息
      var retInfo = "";  //打印内容
      var note_info1=""; //备注1
      var note_info2=""; //备注2
      var note_info3=""; //备注3
      var note_info4=""; //备注4 
					 
			cust_info+="客户姓名：   "+document.all.cust_name.value+"|";
      cust_info+="手机号码：   "+document.all.phone_no.value+"|";
      cust_info+="客户地址：   "+document.all.cust_addr.value+"|";
      cust_info+="证件号码：   "+document.all.cardId_no.value+"|";
      		        
      opr_info+="业务类型：<%=opName%>"+"|";
      opr_info+="操作类型：申请"+$("#updateLevel").find("option:selected").text()+"|";
      
      var updateLevelVal = $("#updateLevel").val();//变更级别
      //var updateLevelName = $("#updateLevel").find("option:selected").text(); //变更级别名称
      if("<%=nextlevel%>"!="xx"){ //预约级别有值，预约级别和更改级别比较
        if(parseInt("<%=nextlevel%>") < updateLevelVal){
          opr_info+="尊敬的客户，您的139邮箱功能已变更为139邮箱"+updateLevelVal+"元版，立即生效，资费"+updateLevelVal+"元/月。详询10086 "+"|";
        }else if("<%=nextlevel%>" > updateLevelVal){
          opr_info+="尊敬的客户，您的139邮箱功能已变更为139邮箱"+updateLevelVal+"元版，次月生效，资费"+updateLevelVal+"元/月。详询10086 "+"|";
        }
      }else{ //无值，则当前级别和更改级别比较
        if(parseInt("<%=curlevel%>") < updateLevelVal){
          opr_info+="尊敬的客户，您的139邮箱功能已变更为139邮箱"+updateLevelVal+"元版，立即生效，资费"+updateLevelVal+"元/月。详询10086 "+"|";
        }else if(parseInt("<%=curlevel%>") > updateLevelVal){
          opr_info+="尊敬的客户，您的139邮箱功能已变更为139邮箱"+updateLevelVal+"元版，次月生效，资费"+updateLevelVal+"元/月。详询10086 "+"|";
        }
      }
			retInfo= strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //把“#"替换为url格式
      return retInfo;	
		}

		//-->
		
		/*liujian 设置预定方式，只有是全球通全网统一资费(包含预约)，才可以选择此按钮！ begin*/
		$(function() {
			/*
				var order_flag = '<%=orderFlag%>'; 
				if(order_flag == "1") {
					$('#orderWayTagName').css('display','block');
					$('#orderWayTagValue').css('display','block');
				}else {
					$('#orderWayStatus').val("0");	
				}
				*/
				$('#orderWaySelect').change(function() {
					var selectValue = $('#orderWaySelect').val();
					if(selectValue == "0") {
						 rdShowMessageDialog("尊敬的客户您好，请你通过短信营业厅订购。具体办理方法为：139邮箱5元版，发送KTYX5到10086；139邮箱20元版，发送KTYX20到10086，详询10086。",0);
						 $('#orderWaySelect').val("1");
					}else {
						$('#orderWayStatus').val(selectValue);
					}
				});
		});
		/*liujian 设置预定方式，只有是全球通全网统一资费(包含预约)，才可以选择此按钮！ end*/
    
    function goBack(){
      window.location.href="f9912_a.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
    }
	</script>
</head>
<body>
	<form name="frm" method="post" action="f9912_c.jsp" onKeyUp="chgFocus(frm)">	
		<%@ include file="/npage/include/header.jsp" %>  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
        	<table cellspacing="0">
			  <tr> 
			            <td class="blue">操作类型</td>
			            <td colspan="1"><%=opName%></td>
			            <td class="blue">用户号码</td>
			            <td>
					<input name="phoneNo" value="<%=phoneNo%>" type="text"  v_must=1 readonly class="InputGrey" id="phoneNo" maxlength="20" > 
					<font class="orange">*</font>
			            </td>
		          </tr>
		          <tr> 
			            <td class="blue">客户姓名</td>
			            <td>
					<input name="cust_name" value="<%=bp_name%>" type="text"  v_must=1 readonly class="InputGrey" id="cust_name" maxlength="20" > 
					<font class="orange">*</font>
			            </td>
		            	    <td class="blue">证件类型</td>
			            <td>
					<input name="cardId_type" value="<%=cardId_type%>" type="text"  v_must=1 readonly class="InputGrey" id="cardId_type" maxlength="20" > 
					<font class="orange">*</font>
			            </td>
			</tr>
		        <tr style="display:none"> 
			            <td class="blue">&nbsp;</td>
			            <td>
					<input name="cust_addr" value="<%=bp_add%>" type="hidden"  v_must=1 readonly class="InputGrey" id="cust_addr" maxlength="20" > 
			            </td>
			            <td class="blue">&nbsp;</td>
			            <td>
					<input name="cardId_no" value="<%=cardId_no%>" type="hidden"  v_must=1 readonly class="InputGrey" id="cardId_no" maxlength="20" > 
			            </td>
		      </tr>
		      <tr> 
		            <td class="blue">业务品牌</td>
		            <td>
				<input name="sm_code" value="<%=sm_code%>" type="text"  v_must=1 readonly  class="InputGrey" id="sm_code" maxlength="20" > 
				<font class="orange">*</font>
		            </td>
		            <td class="blue">运行状态</td>
		            <td>
				<input name="run_type" value="<%=run_name%>" type="text"  v_must=1 readonly class="InputGrey" id="run_type" maxlength="20" > 
				<font class="orange">*</font>
		            </td>
		     </tr>
		     <tr> 
		            <td class="blue">VIP级别</td>
		            <td>
				<input name="vip" value="<%=vip%>" type="text"  v_must=1 readonly class="InputGrey" id="vip" maxlength="20" > 
				<font class="orange">*</font>
		            </td>
		            <td class="blue">可用预存</td>
		            <td>
				<input name="prepay_fee" value="<%=prepay_fee%>" type="text"  v_must=1 readonly class="InputGrey" id="prepay_fee" maxlength="20" > 
				<font class="orange">*</font>
		            </td>  
		    <tr> 
		            <td class="blue">当前级别</td>
		            <td>
				<input name="cur_level" value="<%=text_curlevel%>"  type="text"  id="cur_level"   readonly class="InputGrey" >
				<font class="orange">*</font>	
			     </td>
		            <td class="blue">预约级别</td>
		            <td>
				<input name="next_level" value="<%=text_nextlevel%>"  type="text"   id="next_level"    readonly class="InputGrey">
				<font class="orange">*</font>
			    </td>
          	     </tr>
	          <tr> 
		            <td class="blue">变更级别</td>
		            <td>
									<select id="updateLevel" name="textqxlevel">
								    <%
								      if(!"xx".equals(nextlevel)){
              			    if("5".equals(nextlevel)){
              			%>
              			      <option value="20" >VIP版</option>
              			<%
                			  }else if("20".equals(nextlevel)){
                		%>
              			      <option value="5" >标准版</option>
              			<%
                			  }else{ //都显示
                		%>
                		      <option value="5" >标准版</option>
								          <option value="20" >VIP版</option>
                		<%    
                			  }
              			  }else{//判断当前级别 
              			    if("xx".equals(curlevel)){ //当前级别为xx，或0 ，报错 “用户无此业务，不允许变更！”
              			%>
              			      <script language="JavaScript">
                  		      rdShowMessageDialog("用户无此业务，不允许变更！",1);
                    	      window.location.href="f9912_a.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
                  		    </script>
              			<%
              			    }else if("5".equals(curlevel)){
              			%>
              			      <option value="20" >VIP版</option>
              			<%
                			  }else if("20".equals(curlevel)){
                		%>
              			      <option value="5" >标准版</option>
              			<%
                			  }else{
                		%>
                		      <option value="5" >标准版</option>
								          <option value="20" >VIP版</option>
                		<%    
                			  }
              			  }
								    %>
								  </select>
									<font class="orange">*</font>	
			    			</td>
	            	<td class="blue"><span id="orderWayTagName" style="display:none">订购方式</td>
	            	<td>
	            		<div id="orderWayTagValue" style="display:none">
	            			<select id="orderWaySelect" name="orderWay">
											<option value="1" selected>全网资费订购</option>
											<option value="0" >正常订购</option>
										</select>	
						<!-- liujian 2012-8-20 15:26:35 -->
	            		  <input type="hidden" id="orderWayStatus" name="orderWayStatus" value="0" />
	            		 <div>
	            	</td>	            
	          </tr>
	</table>
	<table cellspacing="0">
	          <tr> 
		            <td id="footer"> 
		                <input name="confirm"  class="b_foot_long"  type="button"  index="2" value="确认&打印" onClick="printCommit()"  >
		                &nbsp; 
		                <input name="back"  class="b_foot"  onClick="goBack()" type="button"  value="返回">
		                &nbsp; 
		           </td>
	          </tr>
        </table>
        
    	<input type="hidden" name="phone_no" value="<%=phoneNo%>">
    	<input type="hidden" name="work_no" value="<%=loginName%>">
	<input type="hidden" name="opcode" value="<%=opcode%>">
    	<input type="hidden" name="login_accept" value="<%=printAccept%>">
    	<input type="hidden" name="card_dz" value="0" >
	<input type="hidden" name="sale_type" value="1" >
    	<input type="hidden" name="used_point" value="0" >  
	<input type="hidden" name="point_money" value="0" > 
	<input type="hidden" name="phone_typename" value="" >
	<input type="hidden" name="qx_level" value="<%=qxlevel%>" >
	<input type="hidden" name="opCode" value="<%=opCode%>" />
	<input type="hidden" name="opName" value="<%=opName%>" />
	<input type="hidden" name="updateLevel_hidden" id="updateLevel_hidden" value="" />
	<%@ include file="/npage/include/footer.jsp" %>		
</form>
</body>
</html>
