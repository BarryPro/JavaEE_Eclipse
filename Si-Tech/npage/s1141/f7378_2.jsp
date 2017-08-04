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
<%@ page import="java.text.*" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
 	String opCode = "7378";		
	//String opName = "短信类领奖";	//header.jsp需要的参数   
	String opName = "自有业务宣传名单管理--增加";
	
	String loginNo = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");  
  	String orgCode = (String)session.getAttribute("orgCode");
  	String regionCode= (String)session.getAttribute("regCode");
  	String loginPwd    = (String)session.getAttribute("password");
%>

<%
	String retFlag="",retMsg="";
 	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
  	//ArrayList retList = new ArrayList();
  	String[] paraAray1 = new String[3];
  	String phoneNo = request.getParameter("srv_no");
  	String opcode = request.getParameter("opcode");
  	String listtype=request.getParameter("listtype");
  	String passwordFromSer="";

  	paraAray1[0] = phoneNo;		/* 手机号码   */
  	paraAray1[1] = opCode; 	    /* 操作代码   */
  	paraAray1[2] = loginNo;	    /* 操作工号   */

	  for(int i=0; i<paraAray1.length; i++)
	  {
		if( paraAray1[i] == null ){
		  paraAray1[i] = "";
	
		}
	  }
 /* 输出参数： 返回码，返回信息，客户姓名，客户地址，证件类型，证件号码，业务品牌，
 			归属地，当前状态，VIP级别，当前积分,可用预存
 */

  	//retList = impl.callFXService("s1141Qry", paraAray1, "14","phone",phoneNo);
 %>
 	<wtc:service name="s1141Qry" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="14" >

		<wtc:param value=" "/>
		<wtc:param value="01"/>		
		<wtc:param value="<%=paraAray1[1]%>"/>
		<wtc:param value="<%=paraAray1[2]%>"/>
		<wtc:param value="<%=loginPwd%>"/>										
		<wtc:param value="<%=paraAray1[0]%>"/>
		<wtc:param value=""/>
	</wtc:service>	
	<wtc:array id="retList" scope="end"/>	
 <%
  	String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="",run_name="",vip="",posint="",prepay_fee="";
  	String[][] tempArr= new String[][]{};
  	//int errCode = impl.getErrCode();
  	//String errMsg = impl.getErrMsg();
  	String  errCode=retCode1;
  	String errMsg =retMsg1;
	if(retList == null){
		if(!retFlag.equals("1")){
			System.out.println("retFlag="+retFlag);
		   retFlag = "1";
		   retMsg = "s1141Qry查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
	    	}    
	  }else{
	  	System.out.println("errCode="+errCode);
	  	System.out.println("errMsg="+errMsg);
		if(!errCode.equals("000000")){%>
			<script language="JavaScript">
				rdShowMessageDialog("错误代码：<%=errCode%>，错误信息：<%=errMsg%>",0);
				history.go(-1);
			</script>
		<%
		}else{	 
		  
		  	tempArr=retList;
		  if(tempArr!=null&&tempArr.length>0){
		    bp_name = tempArr[0][2];//机主姓名
		    System.out.println(bp_name);
		    bp_add = tempArr[0][3];//客户地址	
		    cardId_type = tempArr[0][4];//证件类型	
		    cardId_no = tempArr[0][5];//证件号码
		    sm_code = tempArr[0][6];//业务品牌		
		    region_name = tempArr[0][7];//归属地
		    run_name = tempArr[0][8];//当前状态	
		    vip = tempArr[0][9];//ＶＩＰ级别		 
		    posint = tempArr[0][10];//当前积分	 
		    prepay_fee = tempArr[0][11];//可用预存	
		    passwordFromSer = tempArr[0][13];  //密码	
  		}
  	}
}
%>
<%
//******************得到下拉框数据***************************//
	String printAccept="";
	printAccept = getMaxAccept();
	System.out.println(printAccept);
  	//comImpl co=new comImpl();
  	//SPubCallSvrImpl callView1 = new SPubCallSvrImpl();
  	//宣传方式
  	String sqlAgentCode = " select op_code,total_date from sroleopcode where op_type='2' and region_code=:region ";
  	System.out.println("sqlAgentCode====="+sqlAgentCode);
 
  	//组织输入参数
    	String [] paraIn = new String[4];
    
    	paraIn[0] = "region";
    	paraIn[1] = orgCode.substring(0,2);
    	paraIn[2] = sqlAgentCode;
    	paraIn[3] = "region="+orgCode.substring(0,2);
  	//调用服务
    	//ArrayList agentCodeArr = callView1.callFXService("sPubSelectNew",paraIn,"2");
%>
	<wtc:service name="sPubSelectNew" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2" >
		<wtc:param value="<%=paraIn[0]%>"/>
		<wtc:param value="<%=paraIn[1]%>"/>
		<wtc:param value="<%=paraIn[2]%>"/>
		<wtc:param value="<%=paraIn[3]%>"/>
	</wtc:service>	
	<wtc:array id="opcodeArray" start="0" length="1" scope="end"/>
	<wtc:array id="totaldataArray" start="1" length="1" scope="end"/>
	
<%    
    	//String[][] opcodeArray    = null;
	//String[][] totaldataArray= null;
	String[][] offnodataArray=null;
	
	//获取查询结果     

 	//总开关方式
 	String sqloffon="select to_char(count(*)) from dBlakWhiteList a,dcustmsg b where a.id_no=b.id_no and b.phone_no=:phone "
 				+" and op_Type='0' and op_code='0' and list_type=:listtype ";
  	System.out.println("sqloffon====="+sqloffon);
  	//组织输入参数
    	String [] paraIn1 = new String[4];
    	paraIn1[0] = "region";
    	paraIn1[1] = orgCode.substring(0,2);
    	paraIn1[2] = sqloffon;
    	paraIn1[3] = "phone="+phoneNo+",listtype="+listtype;
  	//调用服务
    	//ArrayList offonArr = callView1.callFXService("sPubSelectNew",paraIn1,"1");
 %>
 	<wtc:service name="sPubSelectNew" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2" >
		<wtc:param value="<%=paraIn1[0]%>"/>
		<wtc:param value="<%=paraIn1[1]%>"/>
		<wtc:param value="<%=paraIn1[2]%>"/>
		<wtc:param value="<%=paraIn1[3]%>"/>
	</wtc:service>	
	<wtc:array id="offonArr"  scope="end"/>
	
 	
 <%
    	if(retCode1.equals("000000")){
    		//offnodataArray    =(String[][])offonArr.get(0);    
    		offnodataArray=	offonArr;
    	}     		
   	System.out.println("offnodataArray[0][0]="+offnodataArray[0][0]);

%>
<html>
<head>
	<title>自有业务宣传名单管理--增加</title>
	<script type="text/javascript" src="/npage/s3000/js/S3000.js"></script>
	<script language="JavaScript" src="/npage/s1400/pub.js"></script>
 	<script language=javascript>
  		onload=function(){
  	
  		}
		 function doProcess(packet){		
		 		var errorCode = packet.data.findValueByName("errorCode");
				var errorMsg = packet.data.findValueByName("errorMsg");
				if(errorCode != "0000"){
					rdShowMessageDialog("["+errorCode+"]:"+errorMsg,0);
					return;
				}
				
				var typecode = packet.data.findValueByName("typecode");
				if(typecode == "getopcode")
				{
						var values = packet.data.findValueByName("values");
						var names = packet.data.findValueByName("names");
						fillDropDown(document.all.op_code,values,names);
						//document.all.town_name.value="--请选择--";
						return;
				}
		    	
		 }
		 function viewConfirm(){
			if(document.frm.IMEINo.value=="")
			{
				document.frm.confirm.disabled=true;
			}
		
		}

 
 	</script>
	<script language="JavaScript">
	<!--
	  //定义应用全局的变量
	  var SUCC_CODE	= "0";   		//自己应用程序定义
	  var ERROR_CODE  = "1";			//自己应用程序定义
	  var YE_SUCC_CODE = "0000";		//根据营业系统定义而修改
	
	  //***
	  function frmCfm(){
	  	var optypelist="";
		var opcodelist="";
	
		document.frm.action="f7378_3.jsp";
		if("<%=offnodataArray[0][0]%>"!="0")
		{
			if(document.all.opFlag[0].checked==true){
				rdShowMessageDialog("没有改变业务信息！");
				return;
			}
		}
		if("<%=offnodataArray[0][0]%>"=="0" && document.all.opFlag[1].checked==true)
		{
			if(bind_values1.length==0){
				rdShowMessageDialog("请选择业务信息!",rdModeError);
				return;
			}
		}
		document.all.opCount.value=bind_values1.length;
		if(bind_values1.length>0) {
			for(i=0; i<bind_values1.length; i++) {
				optypelist=optypelist+bind_values1[i]+",";
				opcodelist=opcodelist+notes[i]+",";
			}	
		}
		if(document.all.opFlag[0].checked==true){
			document.all.offon.value="0";
		}else{
			document.all.offon.value="1";
		}
		document.all.optypestr.value=optypelist;
		//alert(document.all.optypestr.value);
		document.all.opcodestr.value=opcodelist;
		//alert(document.all.opcodestr.value);
		//alert(document.all.opCount.value);
		
	 	
	 	frm.submit();
		return true;
	  }
	 //***
	function printCommit(){
		getAfterPrompt();
		 if("<%=offnodataArray[0][0]%>"!="0")
			{
				if(document.all.opFlag[0].checked==true){
					rdShowMessageDialog("没有改变业务信息！");
					return;
				}
			}
			if("<%=offnodataArray[0][0]%>"=="0" && document.all.opFlag[1].checked==true)
			{
				if(bind_values1.length==0){
					rdShowMessageDialog("请选择业务信息!",rdModeError);
					return;
				}
			}
		if("<%=listtype%>"=='W')
		{
		 	//打印工单并提交表单
		  	var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
		  	if(typeof(ret)!="undefined")
		  	{
		    	if((ret=="confirm"))
		    	{
		      	if(rdShowConfirmDialog('确认电子免填单吗？')==1)
		      	{
		      		document.all.printcount.value="1";
			    	frmCfm();
		      	}
			}
			if(ret=="continueSub")
			{
		      if(rdShowConfirmDialog('确认要提交信息吗？')==1)
		      {
		      	document.all.printcount.value="0";
			    frmCfm();
		      }
			}
		  	}
		  	else
		  	{
		     if(rdShowConfirmDialog('确认要提交信息吗？')==1)
		     {
		     	document.all.printcount.value="0";
			   frmCfm();
		     }
		  	}
		  	return true;
		  }else{
		  	if(rdShowConfirmDialog('确认要提交信息吗？')==1)
		     {
		     	document.all.printcount.value="0";
			   frmCfm();
		     }
			}
	}
	function showPrtDlg(printType,DlgMessage,submitCfm)
	{  //显示打印对话框
		//显示打印对话框 		
		var pType="subprint";                     // 打印类型print 打印 subprint 合并打印
	     	var billType="1";                      //  票价类型1电子免填单、2发票、3收据
		var sysAccept ="<%=printAccept%>";                       // 流水号
		var printStr = printInfo(printType);   //调用printinfo()返回的打印内容
		var mode_code=null;                        //资费代码
		var fav_code=null;                         //特服代码
		var area_code=null;                    //小区代码
		var opCode =   "<%=opCode%>";                         //操作代码
		var phoneNo = <%=phoneNo%>;                           //客户电话		
	   	var h=180;
	   	var w=350;
	   	var t=screen.availHeight/2-h/2;
	   	var l=screen.availWidth/2-w/2;
	   	
	   	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 	   
		var path= "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
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
	      	
	      	cust_info+="客户姓名：   " +document.all.cust_name.value+"|";
		cust_info+="手机号码：   "+document.all.phone_no.value+"|";
		cust_info+="客户地址：   "+document.all.cust_addr.value+"|";
		cust_info+="证件号码：   "+document.all.cardId_no.value+"|";
		
		opr_info+="用户品牌:"+document.all.sm_code.value+"        办理业务：接收业务信息"+"|";
	  	opr_info+="操作流水："+document.all.login_accept.value+"|";
		
		note_info1+="说明：您办理此业务后，即为想获悉我公司开展的各项活动、新推出的优惠资费和新业务、新推出的服务项目等信息，我公司将及时的以短信、电话等方式免费通知您。"+"|";
		
		retInfo= strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
  	      	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //把“#"替换为url格式
    	      	return retInfo;	
	
	}
	function opcodechg()
	{
		document.all.opcode_name.value=document.all.op_code.options[document.all.op_code.selectedIndex].text;
		
	}

	//-->
</script>
<script language="JavaScript">
	<!--
	 	var plan_code ;
		bind_values1 = new Array() ;
		notes = new Array() 
	 	function optypeChange(){
	   // alert("qqqqqqqqqqqqq");
	   	document.all.optype_name.value=document.all.op_type.options[document.all.op_type.selectedIndex].text;
		var getNote_Packet = new AJAXPacket("f7378_rpc.jsp","正在获得业务信息，请稍候......");
	    	getNote_Packet.data.add("retType","getopcode");
		getNote_Packet.data.add("regionCode","<%=regionCode%>");
		getNote_Packet.data.add("optype",document.all.op_type.value);
		getNote_Packet.data.add("phone_no",document.all.phone_no.value);  
		getNote_Packet.data.add("listtype",document.all.listtype.value);
		core.ajax.sendPacket(getNote_Packet);
		getNote_Packet=null;
	 }
	 
	 function fillDropDown(obj,_value,_text){
	    obj.options.length = 0;
	    var option1 = new Option('--请选择--','');
	    obj.add(option1);
	    for(var i=0; i<_value.length;i++)
	    {
	      var option = new Option(_text[i],_value[i]);
	      obj.add(option);
	   }
	}
	function opchange()
	{
		if(document.all.opFlag[0].checked==true) 
		{
			
		  	for(i=1; i=bind_values1.length; i++) {
		  		//alert("i="+i);
		  		//alert(bind_values1.length);
		  		var tableobj = document.getElementById("table_1"); 
	    		tableobj.deleteRow(i); 
				var temp = bind_values1[i-1];
				for(j=i-1 ; j<bind_values1.length-1; j++) {
					bind_values1[j] = bind_values1[j+1] ;
				}
				bind_values1[bind_values1.length-1] = temp ;
				bind_values1.pop() ;
		
				var temp = notes[i-1];
				for(j=i-1 ; j<notes.length-1; j++) {
					notes[j] = notes[j+1] ;
				}
				notes[notes.length-1] = temp ;
				notes.pop() ;
				
			}
		
		}
		else
		{
			
		}
	}
	function addRow(){
		if(document.all.opFlag[0].checked==true){
			rdShowMessageDialog("业务总开关开，不能再选业务",rdModeError);
			return;
		}
		if(document.all.op_type.value.length<1) {
			rdShowMessageDialog("请选择宣传方式",rdModeError);
			return;
		}
		
		if(document.all.op_code.value.length<1) {
			rdShowMessageDialog("请选择业务分类",rdModeError);
			return;
		}
		
		
		if(bind_values1.length>0) {
			for(i=0; i<bind_values1.length; i++) {
				if(document.getElementById("op_type").value == bind_values1[i] && document.getElementById("op_code").value== notes[i]) {				
					rdShowMessageDialog("信息重复",rdModeError);
					return;
				}
			}
		}
		if(bind_values1.length>=50){
			rdShowMessageDialog("不能超过50行，请提交",rdModeError);
			return;
		}
		
			
	     var tableobj=document.getElementById("table_1"); 
	     var rowobj=tableobj.insertRow(tableobj.rows.length); 
	
		var cell1=rowobj.insertCell(rowobj.cells.length); 
		var cell2=rowobj.insertCell(rowobj.cells.length); 
		var cell3=rowobj.insertCell(rowobj.cells.length); 		
		
	    cell1.innerHTML = '<td><input type="hidden" name="bind_values" id="bind_values" value="'+document.getElementById("op_type").value+'" class="input-read"  readonly class="InputGrey"/>' ; 
	    cell1.innerHTML += '<input type="text" name="ssname" id="ssname" value="'+document.getElementById("optype_name").value+'"  readonly class="InputGrey"/></td>' ; 
	    cell2.innerHTML = '<td><input type="hidden" name="notes" id="notes" value="'+document.getElementById("op_code").value+'" class="input-read" readonly class="InputGrey"/>' ; 
	    cell2.innerHTML += '<input type="text" name="townname" id="townname"  value="'+document.getElementById("opcode_name").value+'"  readonly class="InputGrey"/></td>' ; 
	    cell3.innerHTML = '<img src="../../images/ico_delete.gif" alt="删除" onclick="deleteRow('+(tableobj.rows.length-1)+');leo()">' ;
	  
		bind_values1.push(document.getElementById("op_type").value) ;
		notes.push(document.getElementById("op_code").value) ;
		//alert(bind_values1.length);
		if(bind_values1.length>=50){
			rdShowMessageDialog("不能超过50行，请提交",rdModeError);
			return;
		}
		
	}
	
	function leo(){//当删除一行后，对各行重新建立索引！！！ 
		var tableobj=document.getElementById("table_1"); 
		for(i=1;i<tableobj.rows.length;i++) { 
			tableobj.rows[i].cells[2].innerHTML = '<img src="../../images/ico_delete.gif" alt="Delete" border="0" onclick="deleteRow('+i+');leo()">';
		} 
	} 
	function deleteRow(i){       
		//alert(i);                 
	    var tableobj = document.getElementById("table_1"); 
	    var returnValue = rdShowConfirmDialog("您确定要删除该条信息吗？");
	    if (returnValue == rdConstOK) {
			tableobj.deleteRow(i); 
		}
		
		var temp = bind_values1[i-1];
		for(j=i-1 ; j<bind_values1.length-1; j++) {
			bind_values1[j] = bind_values1[j+1] ;
		}
		bind_values1[bind_values1.length-1] = temp ;
		bind_values1.pop() ;
		
		var temp = notes[i-1];
		for(j=i-1 ; j<notes.length-1; j++) {
			notes[j] = notes[j+1] ;
		}
		notes[notes.length-1] = temp ;
		notes.pop() ;
	}
	//-->
	</script>
</head>
<body >
<form name="frm" method="post" action="f7378_3.jsp" onKeyUp="chgFocus(frm)">
	 <%@ include file="/npage/include/header.jsp" %>     	
	<div class="title">
		<div id="title_zi">自有业务宣传名单管理--增加 </div>
	</div>
        <table  cellspacing="0" >
		  <tr>
            		<td class="blue">操作类型</td>
            		<td colspan="3">自有业务宣传名单管理--增加</td>            		
          	</tr>
          	<tr>
            		<td class="blue">客户姓名</td>
            		<td>
			  	<input name="cust_name" value="<%=bp_name%>" type="text"  v_must=1 readonly  class="InputGrey" id="cust_name" maxlength="20" >
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
			  	<input name="sm_code" value="<%=sm_code%>" type="text"  v_must=1 readonly class="InputGrey" id="sm_code" maxlength="20" >
			 	<font class="orange">*</font>
            		</td>
            		<td class="blue">运行状态</td>
            		<td>
			  	<input name="run_type" value="<%=run_name%>" type="text"  v_must=1 readonly class="InputGrey" id="run_type" maxlength="20" >
			 	<font class="orange">*</font>
            		</td>
            	</tr>
            	<tr>
            		<td class="blue">当前积分</td>
            		<td>
			  	<input name="point" value="<%=posint%>" type="text"  v_must=1 readonly class="InputGrey" id="point" maxlength="20" >
			 	<font class="orange">*</font>
            		</td>
            		<td class="blue">可用预存</td>
            		<td>
			  	<input name="prepay_fee" value="<%=prepay_fee%>" type="text"  v_must=1 readonly class="InputGrey" id="prepay_fee" maxlength="20" >
			 	<font class="orange">*</font>
            		</td>
            	</tr>
            	<tr>
            		<td colspan="4"> 
            			<div align="center"> 业务总开关
	            			<% if(offnodataArray[0][0].equals("0")){%>
	           				<input type="radio" name="opFlag" value="one" onclick="opchange()"  >开&nbsp;&nbsp;
						<input type="radio" name="opFlag" value="two" checked>关
					<%}else{%>
				 		<input type="radio" name="opFlag" value="one" onclick="opchange()"  checked >开&nbsp;&nbsp;
						<input type="radio" name="opFlag" value="two"  >关
					<%}%>
				</div>
        		</td>
            	</tr>
             <tr>
            		<td class="blue">宣传方式分类</td>
            		<td colspan="3">
			  	<SELECT id="op_type" name="op_type" v_must=1  onchange="optypeChange();"  >
			    		<option value ="">--请选择--</option>
                			<%for(int i = 0 ; opcodeArray != null && i<opcodeArray.length;  i ++){%>
                				<option value="<%=opcodeArray[i][0]%>"><%=totaldataArray[i][0]%></option>
               	 			<%}%>
              			</select>
			  	<font class="orange">*</font>		   
			</td>
			
          </tr>
          <tr>
           	<td class="blue"> 业务分类</td>            
          	<td colspan="3">
			<SELECT id="op_code" name="op_code" v_must=1   onchange="opcodechg()" style="margin-left:0px;width:300px;">
			    	<option value ="">--请选择--</option>               
             		</select>
			<font class="orange">*</font>
			<input type="button" value="添加" class="b_text" onclick="addRow()">
		</td>
          </tr>
        </table>    
 		 
     	<table id="table_1" cellspacing="0">       
       		<tr>
       			<th>宣传方式</th>
       			<th>业务分类</th>
       			<th>操作</th>       			
       		</tr>
    	</table>
	
       			
	<table cellspacing="0">       
          	<tr>
            		<td id="footer"> 
                		<input name="confirm" type="button" class="b_foot_long"  index="2" value="确认&打印" onClick="printCommit()"  >
                		&nbsp;
                		<input name="reset" type="reset"  class="b_foot" value="清除" >
                		&nbsp;
                		<input name="back" onClick="javaScript:history.go(-1)" type="button" class="b_foot" value="返回">
                		&nbsp; 
                	</td>
          </tr>
        </table>
           
 	     <input type="hidden" name="opName" value="<%=opName%>">
 	     
 	     
	<input type="hidden" name="optype_name">
       	<input type="hidden" name="opcode_name">
 	     
	    <input type="hidden" name="phone_no" value="<%=phoneNo%>">
	    <input type="hidden" name="work_no" value="<%=loginName%>">
	    <input type="hidden" name="login_accept" value="<%=printAccept%>">
	    <input type="hidden" name="opCode" value="<%=opCode%>">
	    <input type="hidden" name="listtype" value="<%=listtype%>">
	    <input type="hidden" name="optypestr" >
	    <input type="hidden" name="opcodestr" >
	    <input type="hidden" name="opCount" >
	    <input type="hidden" name="offon" >
	    <input type="hidden" name="optype" value="A">
	    <input type="hidden" name="cust_info">
	    <input type="hidden" name="opr_info">
	    <input type="hidden" name="note_info1">
	    <input type="hidden" name="haseval">
	    <input type="hidden" name="evalcode">      
	    <input type="hidden" name="note_info2">
	    <input type="hidden" name="note_info3">
	    <input type="hidden" name="note_info4">
	    <input type="hidden" name="printcount">
	    <%@ include file="/npage/include/footer.jsp" %>   
</form>
</body>
</html>


