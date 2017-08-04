<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-5
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
%>

<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>

<%		
	String opCode = "8030";
	String opName = "集团用户预存话费赠机";    
	String loginNo = (String)session.getAttribute("workNo");					//操作工号
	String regionCode = (String)session.getAttribute("regCode");				//地市
	String phoneNo =(String) request.getParameter("phoneNo");				//手机号码
	String opcode = request.getParameter("opcode");								//op_code
%>

<%
	String retFlag="",retMsg="";
	String[] paraAray1 = new String[3];
	
	String passwordFromSer="";
	String dept=request.getParameter("dept");
	String s_type="C";
 
	paraAray1[0] = phoneNo;		/* 手机号码   */ 
	paraAray1[1] = opcode; 	    /* 操作代码   */
	paraAray1[2] = loginNo;	    /* 操作工号   */

  for(int i=0; i<paraAray1.length; i++)
  {		
	if( paraAray1[i] == null )
	{
	  paraAray1[i] = "";
	  
	}
  }
 /* 输出参数 返回码，返回信息，客户姓名，客户地址，证件类型，证件号码，业务品牌，
 			归属地，当前状态，VIP级别，当前积分,可用预存
 */

  //retList = impl.callFXService("s8030Init", paraAray1, "21","phone",phoneNo);
  
%>

    <wtc:service name="s8030Init" outnum="21" retmsg="msg1" retcode="code1" routerKey="phoneNo" routerValue="<%=phoneNo%>">
			<wtc:param value="<%=paraAray1[0]%>" />
			<wtc:param value="<%=paraAray1[1]%>" />	
			<wtc:param value="<%=paraAray1[2]%>" />	
		</wtc:service>
		<wtc:array id="result_t" scope="end"  />

<%  
  String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="",run_name="",vip="",posint="",prepay_fee="",
  vUnitId="",vUnitName="",vUnitAddr="",vUnitZip="",vServiceNo="",vServiceName="",vContactPhone="",vContactPost="";
  String errCode = code1;
  String errMsg = msg1;
  if(result_t == null)
  {
	if(!retFlag.equals("1"))
	{
		System.out.println("retFlag="+retFlag);
	   retFlag = "1";
	   retMsg = "s8030Init查询号码基本信息为空!<br>errCode " + errCode + "<br>errMsg+" + errMsg;
    }    
  }
  else
  {
  	System.out.println("errCode="+errCode);
  	System.out.println("errMsg="+errMsg);
	if(!errCode.equals("000000")){%>
		<script language="JavaScript">
			rdShowMessageDialog("错误代码<%=errCode%>，错误信息<%=errMsg%>",0);
			history.go(-1);
		</script>
	<%}
	else
	{
	    bp_name = result_t[0][2];//机主姓名
	    bp_add = result_t[0][3];//客户地址
	    cardId_type = result_t[0][4];//证件类型
	    cardId_no = result_t[0][5];//证件号码
	    sm_code = result_t[0][6];//业务品牌
	    region_name = result_t[0][7];//归属地
	    run_name = result_t[0][8];//当前状态
	    vip = result_t[0][9];//ＶＩＰ级别
	    posint = result_t[0][10];//当前积分
	    prepay_fee = result_t[0][11];//可用预存
	    vUnitId = result_t[0][12];//集团ID
	    vUnitName = result_t[0][13];//集团名称
	    vUnitAddr = result_t[0][14];//单位地址
	    vUnitZip = result_t[0][15];//单位邮编
	    vServiceNo = result_t[0][16];//集团工号
	    vServiceName = result_t[0][17];//集团工号名称
	    vContactPhone = result_t[0][18];//联系电话
	    vContactPost = result_t[0][19];//个人邮编
	    passwordFromSer = result_t[0][20];  //密码
	}
  }

%>
 <%  //优惠信息//********************得到营业员权限，核对密码，并设置优惠权限*****************************//   

  String[][] favInfo = (String[][])session.getAttribute("favInfo"); //数据格式为String[0][0]---String[n][0]
  String handFee_Favourable = "readOnly";        //a230  手续费
  int infoLen = favInfo.length;
  String tempStr = "";
 %>
<%
//******************得到下拉框数据***************************//
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="printAccept"/>
<%
	String exeDate="";
	exeDate = getExeDate("1","1141");

 	// comImpl co=new comImpl();
  //手机品牌
  String sqlAgentCode = " select  unique a.brand_code,trim(b.brand_name) from sPhoneSalCfg a,schnresbrand b where a.region_code='" + regionCode + "' and a.sale_type='5' and a.brand_code=b.brand_code and valid_flag='Y' and b.is_valid='1' and substr(spec_type,1,1)='"+s_type+"'";
  //手机类型
  String sqlPhoneType = "select unique a.type_code,trim(b.res_name), b.brand_code from sPhoneSalCfg a,schnrescode_chnterm b where a.region_code='" + regionCode + "' and  a.type_code=b.res_code and sale_type='5' and a.brand_code=b.brand_code and valid_flag='Y' and b.is_valid='1' and substr(spec_type,1,1)='"+s_type+"'";
  //营销代码
  String sqlsaleType = "select unique a.sale_code,trim(a.sale_name), a.sale_price,a.prepay_limit from sPhoneSalCfg a where a.region_code='" + regionCode + "' and a.sale_type='5' and valid_flag='Y' and substr(spec_type,1,1)='"+s_type+"'";
  //终端用途
  String sqltermType = "select unique item_code,item_name   from sSaletermCODE a ";
   //产品代码
  String sqlprodType = "select unique a.operation_code,a.product_code,a.operation_name,a.product_name from dbcustadm.ssaleproductcode  a where a.active_flag='1' ";
 
%>

		<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlAgentCode%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t1" scope="end"/>

		<wtc:pubselect name="sPubSelect" outnum="3" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlPhoneType%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t2" scope="end"/>
	 	

		<wtc:pubselect name="sPubSelect" outnum="4" retmsg="msg3" retcode="code3" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlsaleType%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t3" scope="end"/>	 	
	 	
	 	<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg4" retcode="code4" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqltermType%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t4" scope="end"/>	 		 		 
	 		 		 	 
	 	<wtc:pubselect name="sPubSelect" outnum="4" retmsg="msg5" retcode="code5" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlprodType%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t5" scope="end"/>	 		 		 	 
	 	
<%
	String[][] agentCodeStr = result_t1;
	String[][] phoneTypeStr = result_t2;
	String[][] saleTypeStr = result_t3;
	String[][] termTypeStr = result_t4;
	String[][] prodTypeStr = result_t5;

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>集团用户预存话费优惠购机</title>
<META content="no-cache" http-equiv="Pragma">
<META content="no-cache" http-equiv="Cache-Control">
<META content="0" 	     http-equiv="Expires" > 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
 <script language=javascript>

 function doProcess(packet){
 
 		errorCode = packet.data.findValueByName("errorCode");
		errorMsg =  packet.data.findValueByName("errorMsg");
		retType = packet.data.findValueByName("retType");
		backArrMsg = packet.data.findValueByName("backArrMsg");
		retResult = packet.data.findValueByName("retResult");
	
		self.status="";
		
		var tmpObj="";
		var i=0;
		var j=0;
		var ret_code=0;
		var tmpstr="";
		//alert(ret_code);
		ret_code =  parseInt(errorCode);
		//alert(ret_code);
		//alert("111111111111111111111111" +errorCode ); 
		//alert("111111111111111111111111" +errorMsg ); 
		
		if(retType=="getcard"){
			if( ret_code == 0 ){
				  tmpObj = "sale_code" 
				  document.all(tmpObj).options.length=0;
				  document.all(tmpObj).options.length=backArrMsg.length/4;	
		        for(i=0;i<backArrMsg.length/4;i++)
			    {
				    document.all(tmpObj).options[i].text=backArrMsg[i][1];
				    document.all(tmpObj).options[i].value=backArrMsg[i][0];
		 	        document.all(tmpObj).options[i].nv2=backArrMsg[i][2];
			        document.all(tmpObj).options[i].nv3=backArrMsg[i][3];
			    }
			}else{
				rdShowMessageDialog("取信息错误"+errorMsg+"!",0);
				return;			
			}
			change();
		}
		else if(retType == "checkAward")
		{
				var retCode = packet.data.findValueByName("retCode"); 
				var retMessage = packet.data.findValueByName("retMessage");
    		window.status = "";
    		if(retCode!=0){
    			rdShowMessageDialog(retMessage,0);
    			document.all.need_award.checked = false;
    			document.all.award_flag.value = 0;
    		}
    		document.all.award_flag.value = 1;
    	}else{
			//alert(retResult);
			if(retResult == "000000"){
					rdShowMessageDialog("IMEI号校验成功1！",2);
					document.frm.confirm.disabled=false;
					document.frm.IMEINo.readOnly=true;
					return ;

			}else if(retResult == "000001"){
					rdShowMessageDialog("IMEI号校验成功2！",2);
					document.frm.confirm.disabled=false;
					document.frm.IMEINo.readOnly=true;
					return ;

			}else if(retResult == "000003"){
					rdShowMessageDialog("IMEI号不在营业员归属营业厅或IMEI号与业务办理机型不符！",0);
					document.frm.confirm.disabled=true;
					return false;
			}else{
					rdShowMessageDialog("IMEI号不存在或者已经使用！",0);
					document.frm.confirm.disabled=true;
					return false;
			}
		}
 }
 function change(){
	with(document.frm){

		price.value=sale_code.options[sale_code.selectedIndex].nv2;
		pay_money.value=sale_code.options[sale_code.selectedIndex].nv3;
		var i=price.value;
		var j=pay_money.value;
		sum_money.value=(parseFloat(i)+parseFloat(j)).toFixed(2);
	}
}
 </script>
<script language="JavaScript">

<!--
  //定义应用全局的变量
  var SUCC_CODE	= "0";   		//自己应用程序定义
  var ERROR_CODE  = "1";			//自己应用程序定义
  var YE_SUCC_CODE = "0000";		//根据营业系统定义而修改

  var oprType_Add = "a";
  var oprType_Upd = "u";
  var oprType_Del = "d";
  var oprType_Qry = "q";

  var arrPhoneType = new Array();//手机型号代码
  var arrPhoneName = new Array();//手机型号名称
  var arrAgentCode = new Array();//代理商代码
  var selectStatus = 0;
  
  var arrsalecode =new Array();
  var arrsaleName=new Array();
  var arrsalePrice=new Array();
  var arrsaleLimit=new Array();
  var arrsaletype=new Array();
  


 
<%  
  for(int i=0;i<phoneTypeStr.length;i++)
  {
	out.println("arrPhoneType["+i+"]='"+phoneTypeStr[i][0]+"';\n");
	out.println("arrPhoneName["+i+"]='"+phoneTypeStr[i][1]+"';\n");
	out.println("arrAgentCode["+i+"]='"+phoneTypeStr[i][2]+"';\n");
  }  
  for(int l=0;l<saleTypeStr.length;l++)
  {
	out.println("arrsalecode["+l+"]='"+saleTypeStr[l][0]+"';\n");
	out.println("arrsaleName["+l+"]='"+saleTypeStr[l][1]+"';\n");
	out.println("arrsalePrice["+l+"]='"+saleTypeStr[l][2]+"';\n");
	out.println("arrsaleLimit["+l+"]='"+saleTypeStr[l][3]+"';\n");
	
  }  
%>
	
  //***
  function frmCfm(){
 	frm.submit();
	return true;
  }
 //***
 function checkimeino()
{
	 if (document.frm.IMEINo.value.length == 0) {
      rdShowMessageDialog("IMEI号码不能为空，请重新输入 !!",0);
      document.frm.IMEINo.focus();
      document.frm.confirm.disabled = true;
	  return false;
     } 
     
	//alert(document.all.agent_code.options[document.all.agent_code.selectedIndex].value);
	//alert(document.all.phone_type.options[document.all.phone_type.selectedIndex].value);
	//alert(document.all.IMEINo.value);
	var myPacket = new AJAXPacket("queryimei.jsp","正在校验IMEI信息，请稍候......");
	myPacket.data.add("imei_no",(document.all.IMEINo.value).trim());
	myPacket.data.add("brand_code",(document.all.agent_code.options[document.all.agent_code.selectedIndex].value).trim());
	myPacket.data.add("style_code",(document.all.phone_type.options[document.all.phone_type.selectedIndex].value).trim());
	myPacket.data.add("retType","0");
	myPacket.data.add("opcode",(document.all.opcode.value).trim());
	core.ajax.sendPacket(myPacket);
	myPacket = null;  
    
}

 function viewConfirm()
{
	if(document.frm.IMEINo.value=="")
	{
		document.frm.confirm.disabled=true;
	}

}

 
 function printCommit()
 { 
 	getAfterPrompt();
  //校验
  //if(!check(frm)) return false;
  with(document.frm){
    if(cust_name.value==""){
	  rdShowMessageDialog("请输入姓名!",0);
      cust_name.focus();
	  return false;
	}
	if(vTargetCode.value==""){
	  rdShowMessageDialog("终端用途不能不空!",0);
      phone_type.focus();
	  return false;
	}
	if(vProductCode.value==""){
	  rdShowMessageDialog("集团产品不能为空!",0);
      vProductCode.focus();
	  return false;
	}
	
	if(agent_code.value==""){
	  rdShowMessageDialog("请输入手机品牌!",0);
      agent_code.focus();
	  return false;
	}
	if(phone_type.value==""){
	  rdShowMessageDialog("请输入手机型号!",0);
      phone_type.focus();
	  return false;
	}
	if(sale_code.value==""){
	  rdShowMessageDialog("请输入营销代码!",0);
      sale_code.focus();
	  return false;
	}
	if(vProductId.value==""){
	  rdShowMessageDialog("集团产品ID不能为空!",0);
      vProductId.focus();
	  return false;
	}
	if (IMEINo.value.length == 0) {
      rdShowMessageDialog("IMEI号码不能为空，请重新输入 !!",0);
      IMEINo.focus();
      confirm.disabled = true;
	  return false;
     } 
	 if (sale_month.value == "") {
      rdShowMessageDialog("营销案消费时间不能为空，请重新输入 !!",0);
      sale_month.focus();
      confirm.disabled = true;
	  return false;
     } 
	document.all.phone_typename.value=document.all.agent_code.options[document.all.agent_code.selectedIndex].text+document.all.phone_type.options[document.all.phone_type.selectedIndex].text;
	
	document.all.consum_note.value = document.all.sale_month.options[document.all.sale_month.selectedIndex].text;
  }
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
{  //显示打印对话框 
    var h=180;
     var w=350;
     var t=screen.availHeight/2-h/2;
     var l=screen.availWidth/2-w/2;
   
     var printStr = printInfo();
	 //alert(printStr);
   
     var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
     
     var pType="subprint";                     // 打印类型print 打印 subprint 合并打印
     var billType="1";                      //  票价类型1电子免填单、2发票、3收据
     var sysAccept =document.all.login_accept.value;                       // 流水号
     var printStr = printInfo(printType);   //调用printinfo()返回的打印内容
     var mode_code=null;                        //资费代码
     var fav_code=null;                         //特服代码
     var area_code=null;                        //小区代码
     var opCode =   "<%=opCode%>";                           //操作代码
     var phoneNo = "<%=phoneNo%>";                             //客户电话
     
    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);   
		
}

function printInfo(printType)
{
  vUnitId="",vUnitName="",vUnitAddr="",vUnitZip="",vServiceNo="",vServiceName="",vContactPhone="",vContactPost="";
	var month_fee ;
	var pay = document.all.pay_money.value;
	month_fee= Math.round(pay/12);

  	var retInfo = "";
		var note_info1 = "";
		var note_info2 = "";
		var note_info3 = "";
		var note_info4 = "";
		var opr_info = "";
		var cust_info = "";
		  
	var retInfo = "";
	cust_info+="手机号码："+document.all.phone_no.value+"|";
	cust_info+="客户姓名："+document.all.cust_name.value+"|";
	cust_info+="联系人电话："+'<%=vContactPhone%>'+"|";
	cust_info+="客户地址："+document.all.cust_addr.value+"|";
	opr_info+="邮政编码："+'<%=vContactPost%>'+"|";
	opr_info+="单位地址："+'<%=vUnitAddr%>'+"|";
	opr_info+="邮政编码："+'<%=vUnitZip%>'+"|";
	opr_info+="客户经理："+'<%=vServiceName%>'+"|";
	
	opr_info+="业务种类集团客户手机："+"|";
  	opr_info+="业务流水："+document.all.login_accept.value+"|";
  	opr_info+="手机型号："+document.all.phone_typename.value+"      IMEI号码"+document.all.IMEINo.value+"|";
 	opr_info+="预存话费："+document.all.pay_money.value+"元"+"|";
	opr_info+="业务执行时间："+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd ", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	note_info1+="备注：手机终端会自动对字数较多的短信进行拆分，不同型号手机终端拆分原则不同，我公司将按手机自动拆分的条数收费。"+"|";


		
	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //把“#"替换为url格式

	if(document.all.award_flag.value == "1")
	{
		retInfo+= "已参与赠送礼品活动"+"|";
	}
	else
	{
		retInfo+= " "+"|";
	}
    return retInfo;	
}



//-->
</script>

<script language="JavaScript">
<!--
/****************根据agent_code动态生成phone_type下拉框************************/
 function selectChange(control, controlToPopulate, ItemArray, GroupArray)
 {
   var myEle ;
   var x ;
   // Empty the second drop down box of any choices
   for (var q=controlToPopulate.options.length;q>=0;q--) controlToPopulate.options[q]=null;
   // ADD Default Choice - in case there are no values
    
   myEle = document.createElement("option") ;
    myEle.value = "";
        myEle.text ="--请选择--";
        controlToPopulate.add(myEle) ;
   for ( x = 0 ; x < ItemArray.length  ; x++ )
   {
      if ( GroupArray[x] == control.value )
      {
        myEle = document.createElement("option") ;
        myEle.value = arrPhoneType[x] ;
        myEle.text = ItemArray[x] ;
        controlToPopulate.add(myEle) ;
      }
   }
   
   document.all.need_award.checked = false;   
   document.all.award_flag.value = 0;

 } 
 function typechange(){
 
 	var myEle1 ;
   	var x1 ;
   	for (var q1=document.all.sale_code.options.length;q1>=0;q1--) document.all.sale_code.options[q1]=null;
   	myEle1 = document.createElement("option") ;
    	myEle1.value = "";
        myEle1.text ="--请选择--";
        document.all.sale_code.add(myEle1) ;
           	
   	for ( x1 = 0 ; x1 < arrsaletype.length  ; x1++ )
   	{
      		if ( arrsaletype[x1] == document.all.phone_type.value  && arrsalebarnd[x1] == document.all.agent_code.value)
      		{
        		myEle1 = document.createElement("option") ;
        		myEle1.value = arrsalecode[x1];
        		myEle1.text = arrsaleName[x1];
        		document.all.sale_code.add(myEle1) ;
      		}
   	}
   	document.all.need_award.checked = false;   
   	document.all.award_flag.value = 0;

	salechage();

 }
 
 function checkAward()
 {
 	 if(document.all.phone_type.value == "")
 	 {
 	 	 rdShowMessageDialog("请先选择机型",0);
 	 	 document.all.need_award.checked = false;
 	 	 document.all.award_flag.value = 0;
 	 	 return;
 	 }
 	 if(document.all.need_award.checked )
 	 {
 	 	 var packet = new AJAXPacket("phone_getAwardRpc.jsp","正在获得奖品明细，请稍候......");
 	 	 packet.data.add("retType","checkAward");
 	 	 packet.data.add("op_code","8030");
 	 	 packet.data.add("style_code",document.all.phone_type.value );
 	 	 
 	 	 core.ajax.sendPacket(packet);
 	 	 packet = null;
 	 	 
 	 }
 	 document.all.award_flag.value = 0;
 	 
 }

 function salechage(){
   
	var getNote_Packet = new AJAXPacket("f8030_getprepay.jsp","正在获得营销明细，请稍候......");
  getNote_Packet.data.add("retType","getcard");
	getNote_Packet.data.add("agentCode",document.all.agent_code.value);
	getNote_Packet.data.add("phoneType",document.all.phone_type.value);
	getNote_Packet.data.add("saletype","5");
	getNote_Packet.data.add("regionCode","<%=regionCode%>");
	getNote_Packet.data.add("salecode",document.all.sale_code.value);
	core.ajax.sendPacket(getNote_Packet);
	getNote_Packet = null;
	
 }


//-->
</script>


</head>


<body>
<form name="frm" method="post" action="f8030Cfm.jsp" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>


	<div class="title">
		<div id="title_zi">集团用户预存话费优惠购机</div>
	</div>

        <table cellspacing="0">
		  <tr bgcolor="E8E8E8"> 
            <td class="blue" class="blue">操作类型</td>
            <td class="blue">集团用户预存话费优惠购机--申请</td>
            <td class="blue">&nbsp;</td>
            <td class="blue">&nbsp;</td>
          </tr>        
		  <tr> 
            <td class="blue">集团ID</td>
            <td class="blue">
			  <input name="vUnitId" value="<%=vUnitId%>" type="text" v_must=1 Class="InputGrey" readOnly id="vUnitId" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            <td class="blue">集团名称</td>
            <td class="blue">
			  <input name="vUnitName" value="<%=vUnitName%>" type="text"  v_must=1  Class="InputGrey" readOnly id="vUnitName"  > 
			  <font class="orange">*</font>
            </td>
            </tr>

			<tr> 
            <td class="blue">终端用途</td>
            <td class="blue">
			  <select   name="vTargetCode"  >
                <option value ="">--请选择--</option>
                <%for(int i = 0 ; i < termTypeStr.length ; i ++){%>
                <option value="<%=termTypeStr[i][0]%>"><%=termTypeStr[i][1]%>
                </option>
                <%}%>
               </select>
			  <font class="orange">*</font>
            </td>
            <td class="blue">集团产品分类</td>
            <td class="blue">
			  <select   name="vProductCode"  >
                <option value ="">--请选择--</option>
                
                <%for(int i = 0 ; i < prodTypeStr.length ; i ++){%>
                <option value="<%=prodTypeStr[i][1]%>"><%=prodTypeStr[i][3]%>
                	</option>
                <%}%>
               </select>
			  <font class="orange">*</font>
            </td>
            </tr>
			<tr> 
            <td class="blue">集团产品ID</td>
            <td class="blue">
			  <input name="vProductId" value="" type="text"  id="vProductId" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            <td class="blue">&nbsp;</td>
            <td class="blue">&nbsp;</td>
            </tr>
		  
		  
		  <tr> 
            <td class="blue">客户姓名</td>
            <td class="blue">
			  <input name="cust_name" value="<%=bp_name%>" type="text"  v_must=1  Class="InputGrey" readOnly id="cust_name" maxlength="20" v_name="姓名"> 
			  <font class="orange">*</font>
            </td>
            <td class="blue">客户地址</td>
            <td class="blue">
			  <input name="cust_addr" value="<%=bp_add%>" type="text"  v_must=1  Class="InputGrey" readOnly id="cust_addr" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            </tr>
            <tr> 
            <td class="blue">证件类型</td>
            <td class="blue">
			  <input name="cardId_type" value="<%=cardId_type%>" type="text"  v_must=1  Class="InputGrey" readOnly id="cardId_type" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            <td class="blue">证件号码</td>
            <td class="blue">
			  <input name="cardId_no" value="<%=cardId_no%>" type="text"  v_must=1  Class="InputGrey" readOnly id="cardId_no" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            </tr>
            <tr> 
            <td class="blue">业务品牌</td>
            <td class="blue">
			  <input name="sm_code" value="<%=sm_code%>" type="text"  v_must=1  Class="InputGrey" readOnly id="sm_code" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            <td class="blue">运行状态</td>
            <td class="blue">
			  <input name="run_type" value="<%=run_name%>" type="text"  v_must=1  Class="InputGrey" readOnly id="run_type" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            </tr>
            <tr> 
            <td class="blue">VIP级别</td>
            <td class="blue">
			  <input name="vip" value="<%=vip%>" type="text"  v_must=1  Class="InputGrey" readOnly id="vip" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            <td class="blue">可用预存</td>
            <td class="blue">
			  <input name="prepay_fee" value="<%=prepay_fee%>" type="text"  v_must=1  Class="InputGrey" readOnly id="prepay_fee" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            </tr>
            
			
			
			
			
			<tr> 
            <td class="blue">手机品牌</td>
            <td class="blue">
			  <SELECT id="agent_code" name="agent_code" v_must=1  onchange="selectChange(this, phone_type, arrPhoneName, arrAgentCode);" v_name="手机代理商">  
			    <option value ="">--请选择--</option>
                <%for(int i = 0 ; i < agentCodeStr.length ; i ++){%>
                <option value="<%=agentCodeStr[i][0]%>"><%=agentCodeStr[i][1]%></option>
                <%}%>
              </select>
			  <font class="orange">*</font>	
			</td>
	 <td class="blue">手机型号</td>
            <td class="blue">
			  <select size=1 name="phone_type" id="phone_type" v_must=1 v_name="手机型号" onchange="typechange()">	
			  	  
              </select>
			  <font class="orange">*</font>
			</td>
          </tr>
          <tr> 
         
            <td class="blue">营销方案</td>
            <td class="blue" >
			  <select size=1 name="sale_code" id="sale_code" v_must=1 v_name="营销代码" onchange="change()">			  
              </select>
			  <font class="orange">*</font>
			</td>
			<td class="blue">营销案消费时间</td>
            <td class="blue" colspan="3">
			  <select size=1 name="sale_month" id="sale_month" v_must=1 v_name="营销案消费时间" >
			  <option value ="">--请选择--</option>
			  <option value ="12w">12个月消费完</option>
			  <option value ="18w">18个月消费完</option>
			  <option value ="24w">24个月消费完</option>
			  <option value ="36w">36个月消费完</option>
			  <option value ="12f">分12个月消费</option>
			  <option value ="24f">分24个月消费</option>
			  <option value ="36f">分36个月消费</option>
              </select>
			  <font class="orange">*</font>
			</td>
            
          </tr>
          <tr> 
            <td class="blue" >购机款</td>
            <td class="blue" >
			  <input name="price" type="text"  id="price" v_type="money" v_must=1    Class="InputGrey" readOnly v_name="手机价格" >
			  <font class="orange">*</font>	
			</td>
            <td class="blue">预存话费</td>
            <td class="blue">
			  <input name="pay_money" type="text"   id="pay_money" v_type="0_9" v_must=1   v_name="预存话费"  Class="InputGrey" readOnly>
			  <font class="orange">*</font>
			</td>
          </tr>
          <tr> 
            <td class="blue" >应付金额</td>
            <td class="blue" >
			  <input name="sum_money" type="text"  id="sum_money"  Class="InputGrey" readOnly>
			  <font class="orange">*</font>
			</td>
            <td class="blue" colspan="2">是否参与赠礼<input type="checkbox" name="need_award" onclick="checkAward()" />
				<input type="hidden" name="award_flag" value="0" />
			</td>
          </tr> 
          <TR bgcolor="#EEEEEE"> 
			<td class="blue"  nowrap> 
				<div align="left">IMEI码</div>
            </TD>
            <td class="blue" > 
				<input name="IMEINo"  type="text" v_type="0_9" v_name="IMEI码"  maxlength=15 value="" onblur="viewConfirm()">
				<input name="checkimei"  type="button" value="校验" onclick="checkimeino()" class="b_text">
                <font class="orange">*</font>
            </TD>
			<td class="blue">&nbsp;
			</td>
			<td class="blue">&nbsp;
			</td>
          </TR>
		  <TR bgcolor="#EEEEEE" id=showHideTr > 
			<td class="blue"  nowrap> 
				<div align="left">付机时间</div>
            </TD>
			<td class="blue" > 
				<input name="payTime"  type="text" v_name="付机时间"  value="<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>">
				(年月日)<font class="orange">*</font>                  
			</TD>
			<td class="blue"  nowrap> 
				<div align="left">保修时限 </div>
			</TD>
			<td class="blue" > 
				<input name="repairLimit" v_type="date.month"  size="10" type="text" v_name="保修时限" value="12" onblur="viewConfirm()">
				(个月)<font class="orange">*</font>
			</TD>
          </TR>
		  <tr bgcolor="E8E8E8"> 
            <td class="blue" height="32">备注</td>
            <td class="blue" colspan="3" height="32">
             <input name="opNote" type="text" id="opNote" size="60" maxlength="60" value="集团用户预存话费优惠购机" class="InputGrey" readOnly> 
            </td>
          </tr>
          <tr> 
            <td class="blue" colspan="4"> <div align="center"> 
                <input name="confirm" type="button"  index="2" value="确认&打印" onClick="printCommit()" class="b_foot_long">
                &nbsp; 
                <input name="reset" type="reset"  value="清除" class="b_foot">
                &nbsp; 
                <input name="back" onClick="history.go(-1);" type="button"  value="返回" class="b_foot"s>
                &nbsp; </div></td>
          </tr>
        </table>

    <input type="hidden" name="consum_note" value="">
    <input type="hidden" name="phone_no" value="<%=phoneNo%>">
	<input type="hidden" name="opcode" value="<%=opcode%>">
    <input type="hidden" name="login_accept" value="<%=printAccept%>">
    <input type="hidden" name="card_dz" value="0" >
	<input type="hidden" name="sale_type" value="5" >
    <input type="hidden" name="used_point" value="0" >  
	<input type="hidden" name="point_money" value="0" > 
	<input type="hidden" name="phone_typename" value="" >
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>