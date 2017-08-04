<%
/********************
 version v2.0
 开发商: si-tech
 模块: 家庭服务计划变更
 update zhaohaitao at 2009.1.6
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">

<%
  response.setDateHeader("Expires", 0);
%>	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%		
  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
    	
  String loginNo = (String)session.getAttribute("workNo"); 
  String loginName = (String)session.getAttribute("workName"); 
  String orgCode = (String)session.getAttribute("orgCode"); 
  String regionCode = (String)session.getAttribute("regCode"); 
%>
<%
  String retFlag="",retMsg="";//用于判断页面刚进入时的正确性
/****************由移动号码得到密码、机主姓名、 等信息 s1205Init***********************/
  String[] paraAray1 = new String[6];

  String op_code = request.getParameter("op_code");
  String phoneNo = request.getParameter("chief_srv_no"); /* 家长号码*/
  
  System.out.println("mylog -----------phoneNo------------"+phoneNo);
  String home_no = request.getParameter("srv_no"); /* 成员号码*/	
  String openType = request.getParameter("open_type");/* 操作类型*/
  String passwordFromSer="";
  String show_phone = "";
  String trOneView = "";
   /*****************
  	*add by zhanghonga@2009-02-06,
  	*根据openType来更改opCode和opName,
  	*避免统一接触的opcode,opname记录错误
  	*避免事前提示的混乱与不显示
  	****************/
	  switch(Integer.parseInt(openType)){
	  	case 0 : 
	  					opCode = "7123";
	  					opName = "家庭服务计划-建立家庭";
	  					break;
	  	case 1 :
	  					opCode = "7124";
	  					opName = "家庭服务计划-加入家庭";
	  					break;
	  	case 2 :
	  					opCode = "7125";
	  					opName = "家庭服务计划-退出家庭";
	  					break;
	  	case 3 :
	  					opCode = "7126";
	  					opName = "家庭服务计划-取消家庭";
	  					break;
	  	default:
	  					opCode = "7123";
	  					opName = "家庭服务计划-建立家庭";
	  					break;
	  }
	  System.out.println("########################################fg123_2.jsp->opCode->"+opCode+"&opName->"+opName);
  /**************add end here******************/
  
  
  if(openType.equals("0")){
	op_code="7123";
	show_phone = phoneNo;
	trOneView = "";//行可见
  }else if(openType.equals("1")){
	op_code="7124";
	show_phone = home_no;
	trOneView = "";//行可见
  }else if(openType.equals("2")){
	op_code="7125";
	show_phone = home_no;
	trOneView = "display:none";//行不可见
  }else{
	op_code="7126";
	show_phone = phoneNo;
	trOneView = "display:none";//行不可见
  }

  
  paraAray1[0] = home_no;		/* 手机号码   */ 
  paraAray1[1] = loginNo; 	    /* 操作工号   */
  paraAray1[2] = orgCode;	    /* 归属代码   */
  paraAray1[3] = op_code;		/* 操作代码   */
  paraAray1[4] = phoneNo;		/* 家庭成员	*/
  paraAray1[5] = openType;		/* 申请类型	*/
	
  System.out.println("home_no === "+ home_no);
  System.out.println("loginNo === "+ loginNo);
  System.out.println("orgCode === "+ orgCode);
  System.out.println("op_code === "+ op_code);
  System.out.println("phoneNo === "+ phoneNo);
  System.out.println("openType === "+ openType);
  
  for(int i=0; i<paraAray1.length; i++)
  {	
	
	if( paraAray1[i] == null )
	{
	  paraAray1[i] = "";
	}
  }
  
  //retList = impl.callFXService("s7123Valid", paraAray1, "27");
%>
	<wtc:service name="s7123ValidEx" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="27">			
	<wtc:param value="<%=paraAray1[0]%>"/>	
	<wtc:param value="<%=paraAray1[1]%>"/>	
	<wtc:param value="<%=paraAray1[2]%>"/>	
	<wtc:param value="<%=paraAray1[3]%>"/>	
	<wtc:param value="<%=paraAray1[4]%>"/>	
	<wtc:param value="<%=paraAray1[5]%>"/>	
	</wtc:service>	
	<wtc:array id="tempArr"  scope="end"/>
<%
  String  bp_name="",sm_code="",family_code="",rate_code="",bigCust_flag="",sm_name="",rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="",prepay_fee="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="",group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="",favorcode="",card_no="",print_note="", password="";
  String errCode = retCode1;
  String errMsg = retMsg1;
  System.out.println("errCode === "+ errCode);
  if(tempArr.length==0)
  {
	if(!retFlag.equals("1"))
	{
	   retFlag = "1";
	   retMsg = "s7123Valid查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }    
  }else if(errCode.equals("000000") && tempArr.length>0)
  {
	
	    bp_name = tempArr[0][3];//机主姓名
	 
	    bp_add = tempArr[0][4];//客户地址
	 
	    passwordFromSer = tempArr[0][2];//密码
	 
	    sm_code = tempArr[0][11];//业务类别
	 
	    sm_name = tempArr[0][12];//业务类别名称
	  
	    hand_fee = tempArr[0][13];//手续费
	 
	    favorcode = tempArr[0][14];//优惠代码
	 
	    rate_code = tempArr[0][5];//资费代码
	 
	    rate_name = tempArr[0][6];//资费名称
	 
	    next_rate_code = tempArr[0][7];//下月资费代码
	 
	    next_rate_name = tempArr[0][8];//下月资费名称
	 
	    bigCust_flag = tempArr[0][9];//大客户标志
	 
	    bigCust_name = tempArr[0][10];//大客户名称
	 
	    lack_fee = tempArr[0][15];//总欠费
	 
	    prepay_fee = tempArr[0][16];//总预交
	  
	    cardId_type = tempArr[0][17];//证件类型
	  
	    cardId_no = tempArr[0][18];//证件号码
	  
	    cust_id = tempArr[0][19];//客户id
	  
	    cust_belong_code = tempArr[0][20];//客户归属id
	 
	    group_type_code = tempArr[0][21];//集团客户类型
	 
	    group_type_name = tempArr[0][22];//集团客户类型名称
	
		 family_code = tempArr[0][23]; //用户家庭代码
	 
	    next_main_stream = tempArr[0][24];//预约资费开通流水
	 
	    print_note = tempArr[0][25];//工单广告词
	 
	    password = tempArr[0][26];//密码
	 
	}else{
		if(!retFlag.equals("1"))
		{
		   retFlag = "1";
	       retMsg = "s7123Valid查询号码基本信息失败!<br>errCode: " + errCode + "<br>errMsg: " + errMsg;
		}
	}
//********************得到营业员权限，核对密码，并设置优惠权限*****************************//   
   //优惠信息
  String[][] favInfo = (String[][])session.getAttribute("favInfo");  //数据格式为String[0][0]---String[n][0]
  boolean pwrf = false;//a272 密码免验证
  String handFee_Favourable = "readonly";        //a230  手续费
  int infoLen = favInfo.length;
  String tempStr = "";
  for(int i=0;i<infoLen;i++)
  {
    tempStr = (favInfo[i][0]).trim();
    if(tempStr.compareTo("a272") == 0)
    {
      pwrf = true;
    }
	if(tempStr.compareTo(favorcode) == 0)
    {
      handFee_Favourable = "";
    }
  }
  if(openType.equals("0")||openType.equals("1")||openType.equals("3"))
 {
	String passTrans=WtcUtil.repNull(request.getParameter("chief_cus_pass")); 
	if(!pwrf)
	{
		 String passFromPage=Encrypt.encrypt(passTrans);
		 if(0==Encrypt.checkpwd2(password.trim(),passFromPage))	{
		   if(!retFlag.equals("1"))
		   {
		      retFlag = "1";
			  retMsg = "密码错误!";
		   }
	    
		}       
	}
 }
  if(openType.equals("1")||openType.equals("2"))
 {
	String passTrans_2=WtcUtil.repNull(request.getParameter("cus_pass")); 
	if(!pwrf)
	{
		String passFromPage_2=Encrypt.encrypt(passTrans_2);
		 if(0==Encrypt.checkpwd2(passwordFromSer.trim(),passFromPage_2))	{
		 if(!retFlag.equals("1"))
		 {
			retFlag = "1";
			retMsg = "密码错误!";
		 }
	    
		}       
	}
  }
	String sqlRateCode = "";
    //资费信息
   
	sqlRateCode = "select a.mode_code,a.mode_code||'--'||a.mode_name from sbillmodecode a,sFamModeCode b  where a.region_code=b.region_code and a.mode_code=b.mode_code and b.region_code='"+regionCode +"'" ;
	System.out.println("sqlRateCode="+sqlRateCode);
	String[] paramIn = new String[2];
	//paramIn[0] = "select a.mode_code,a.mode_code||'--'||a.mode_name from sbillmodecode a,sFamModeCode b  where a.region_code=b.region_code and a.mode_code=b.mode_code and b.region_code=:regionCode";
	paramIn[0] = "select a.offer_id,a.offer_id ||'--'||a.offer_name from product_offer a,region b,sregioncode c WHERE  a.offer_id = b.offer_id AND b.group_id = c.group_id AND c.region_code='"+regionCode+"' and a.GROUP_TYPE_ID='10'";
	paramIn[1] = "regionCode="+regionCode;
	//ArrayList rateCodeArr = co.spubqry32("2",sqlRateCode);
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2"  outnum="2">
    	<wtc:sql><%=paramIn[0]%></wtc:sql>
    </wtc:pubselect>
	<wtc:array id="rateCodeStr"  scope="end"/>
<%

	System.out.println("retCode2==="+retCode2);
	System.out.println("rateCodeStr"+rateCodeStr.length);

 String op_note="";
  if(openType.equals("0")){
	op_note="建立家庭";
  }else if(openType.equals("1")){
	op_note="加入家庭";
  }else if(openType.equals("2")){
	op_note="退出家庭";
  }else{
	op_note="取消家庭";
  }
    /****得到打印流水****/
  String printAccept="";
  printAccept = getMaxAccept();
  
  String getParentPnSql = "select acc_nbr from group_instance_member where group_id =(select a.group_id from group_instance_member a,dcustmsg b where  a.serv_id = b.id_no and    b.phone_no ='"+home_no+"' and    a.member_role_id = 10010 and    sysdate between eff_date and exp_date) and    member_role_id = 11010 ";
%>

 	<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=getParentPnSql%></wtc:sql>
 	</wtc:pubselect>
	<wtc:array id="result_t" scope="end"/>
	 	<%
	 	String parentPnSV1 = "";
	 	if(result_t.length>0&&result_t[0][0]!=null){
	 		parentPnSV1 = result_t[0][0];
	 	}
	 	
	 	
	 	if(phoneNo==null||phoneNo.equals("")) phoneNo  = parentPnSV1;
	 	%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>家庭服务计划变更</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
 
<script language="JavaScript">

  <%if(retFlag.equals("1")){%>
    rdShowMessageDialog("<%=retMsg%>",0);
    history.go(-1);
  <%}%>

<!--
  //定义应用全局的变量
  onload=function()
  {		
  } 
  
  
  function frmCfm()
  {
 	frm.submit();
	return true;
  }
  //校验
  function check()
  {
 		with(document.frm)
		{	
		var now_rate_code = "<%=rate_code%>";
		var next_rate_code = "<%=next_rate_code%>";
		return true;
    }
  }
  
  function controlButt(subButton){
	subButt2 = subButton;
    subButt2.disabled = true;
	setTimeout("subButt2.disabled = false",3000);
  } 
  
 function printCommitOne(subButton){
 	getAfterPrompt();
	//controlButt(subButton);//延时控制按钮的可用性
//subButton.disabled = true;
	document.frm.new_rate_code.value=document.frm.add_mode.value.substring(0,8);
	if ((document.frm.new_rate_code.value=="")&&(document.frm.op_code.value=="7123"||document.frm.op_code.value=="7124"))
	{
		rdShowMessageDialog("家庭套餐代码不能为空!");
		//document.frm.new_rate_code.focus();
		return false;
	}
	setOpNote();//为备注赋值
	frm.action = "fg123Cfm.jsp";
    //打印工单并提交表单
    var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes"); 
    if(typeof(ret)!="undefined")
    {
      if((ret=="confirm"))
      {
        if(rdShowConfirmDialog('确认电子免填单吗？如确认,将提交本次业务!')==1)
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
		var h=210;
		var w=400;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		
		var pType="subprint";                                      // 打印类型：print 打印 subprint 合并打印
		var billType="1";                                          //  票价类型：1电子免填单、2发票、3收据
		var sysAccept=<%=printAccept%>;                            // 流水号
		var printStr=printInfo(printType);                         //调用printinfo()返回的打印内容
		var mode_code=null;                                        //资费代码
		var fav_code=null;                                         //特服代码
		var area_code=null;                                        //小区代码
		var opCode="<%=op_code%>";      
		var phoneNo=document.frm.show_phone.value;                 //客户电话
		
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
		var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);
		return ret;
  }

  function printInfo(printType)
  {
		var exeDate = "<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>";//得到执行时间
		
		var cust_info=""; //客户信息
		var opr_info=""; //操作信息
		var note_info1=""; //备注1
		var note_info2=""; //备注2
		var note_info3=""; //备注3
		var note_info4=""; //备注4
		var retInfo = "";  //打印内容
		
		cust_info+="手机号码："+"<%=show_phone%>"+"|";
		cust_info+="客户姓名："+document.frm.bp_name.value+"|";
		
		opr_info+="开始时间： "+exeDate+"|";
		opr_info+="业务类型：家庭服务计划变更"+"<%=op_note%>"+"|";
		opr_info+="开通号码："+document.frm.show_phone.value+"|";
		opr_info+="流水："+"<%=printAccept%>"+"|";
		opr_info+="工单广告词："+"<%=print_note%>"+"|"; 
		
		note_info1+="备注："+document.all.opNote.value.trim()+"|";
		
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
		return retInfo;
  }
  //提交处理 
  function printCommit(subButton){
  	getAfterPrompt();
	controlButt(subButton);//延时控制按钮的可用性
	//校验
	setOpNote();//为备注赋值
    //提交表单
    frmCfm();	
	return true;
  }
 

function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "<%=request.getContextPath()%>/npage/public/fPubSimpSel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;  
    retInfo = window.showModalDialog(path);
    if(retInfo ==undefined)      
    {   return false;   }
    var chPos_field = retToField.indexOf("|");
    var chPos_retStr;
    var valueStr;
    var obj;
    while(chPos_field > -1)
    {
        obj = retToField.substring(0,chPos_field);
        chPos_retInfo = retInfo.indexOf("|");
        valueStr = retInfo.substring(0,chPos_retInfo);
        document.all(obj).value = valueStr;
        retToField = retToField.substring(chPos_field + 1);
        retInfo = retInfo.substring(chPos_retInfo + 1);
        chPos_field = retToField.indexOf("|");
        
    }
	return true;
}
/******为备注赋值********/
function setOpNote(){
	if(document.frm.opNote.value=="")
	{  
		<%
			if(opCode.equals("7125")){
			 %>
					var notePhone="<%=parentPnSV1%>";
			 <%
			}else{
				%>
					var notePhone=document.frm.phoneNo.value;
				<%				
				}
		%>
	  document.frm.opNote.value = "家庭服务计划变更--<%=op_note%> 家长号码:"+notePhone; 
	}
	return true;
}
//-->
//事中提示
function controlFlagCodeTdView(){
	getMidPrompt("10442",codeChg(document.frm.add_mode.value),"ipTd");
}
</script>

</head>


<body>
<form name="frm" method="post">
	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>

      <table cellspacing="0">
		  <tr> 
		    <td class="blue">操作类型</td>
            <td colspan="3">
			  <input name="op_type" type="text" class="InputGrey" id="op_type" value="<%=op_note%>" readonly>
			</td>
          </tr>
		  <tr>
		    <td class="blue">手机号码</td>
            <td>
			  <input name="show_phone" type="text" class="InputGrey" id="show_phone" value="<%=show_phone%>" readonly> 
			</td> 
		    <td class="blue">机主姓名</td>
            <td>
			  <input name="bp_name" type="text" class="InputGrey" id="bp_name" value="<%=bp_name%>" readonly>			  
			</td>           
          </tr>
          <tr> 
		    <td class="blue">业务品牌</td>
            <td>
			  <input name="sm_name" type="text" class="InputGrey" id="sm_name" value="<%=sm_code + "--" + sm_name%>" readonly>
			</td>
            <td class="blue">大客户标志</td>
            <td>
			<input name="bigCust_flag" type="text" class="InputGrey" id="bigCust_flag" value="<%=bigCust_flag+"--"+bigCust_name%>" readonly>
			</td>            
          </tr>
		  <tr> 
		    <td class="blue">证件类型</td>
            <td>
			  <input name="cardId_type" type="text" class="InputGrey" id="cardId_type" value="<%=cardId_type%>" readonly>
			</td>
            <td class="blue">证件号码</td>
            <td>
			<input name="cardId_no" type="text" class="InputGrey" id="cardId_no" value="<%=cardId_no%>" readonly>
			</td>            
          </tr>
          <tr> 
            <td class="blue">当前主套餐</td>
            <td>
			  <input name="rate_name" type="text" class="InputGrey" id="rate_name" value="<%=rate_code+"--"+rate_name%>" readonly>
			</td>
			<td class="blue">下月主套餐</td>
            <td>
			  <input name="next_rate_name" type="text" class="InputGrey" id="next_rate_name" value="<%=next_rate_code+"--"+next_rate_name%>" readonly>
			</td>             
          </tr>
		  <tr>
			<td class="blue">家庭代码</td>
            <td colspan="<%=(trOneView=="display:none"?"3":"1")%>">
			  <input type="text" name="family_code" id="family_code"  v_must=1 value = "<%=family_code%>" readonly class="InputGrey">
			   <font color="orange">*</font>
			</td> 
			<TD class="blue" style=<%=trOneView%>> 家庭套餐代码</TD>
			<TD style="<%=trOneView%>" id="ipTd">
			  <select  name="add_mode" id="add_mode" onChange="controlFlagCodeTdView();">
				<option value="">--请选择--</option>
				<%for(int i = 0 ; i < rateCodeStr.length ; i ++){%>
				<option value="<%=rateCodeStr[i][0]%>"><%=rateCodeStr[i][1]%></option>
				<%}%>
			  </select>
			  <font color="orange">*</font>
			</TD>
          </tr>
		  
          <tr> 
            <td class="blue">备注</td>
            <td colspan="3">
             <input name="opNote" type="text" id="opNote" value="" onFocus="setOpNote();" readonly size="40" class="InputGrey"> 
            </td>
          </tr>
		  <tr> 
            <td colspan="4" id="footer"> <div align="center"> 
                &nbsp; 
				<input name="confirm" id="confirm" type="button" class="b_foot"  value="确认&打印" onClick="printCommitOne(this)" >
                &nbsp; 
                <input name="reset" type="reset" class="b_foot" value="清除" >
                &nbsp; 
                <input name="back" onClick="history.go(-1);" type="button" class="b_foot" value="返回">
                &nbsp; 
				</div>
			</td>
          </tr>
      </table>
 
  <input type="hidden" name="favorcode">
  <input type="hidden" name="next_main_stream">
  <input type="hidden" name="open_type" value="<%=openType%>">
  <input type="hidden" name="home_no" value="<%=home_no%>">
  <input type="hidden" name="new_rate_code" value=""><!--待定，可选资费代码-->
  <input type="hidden" name="printAccept" value="<%=printAccept%>"><!--打印流水-->
  <input type="hidden" name="print_note" value="<%=print_note%>"><!--打印工单广告-->
  <input type="hidden" name="op_code" value="<%=op_code%>"><!--操作代码-->
  <input type="hidden" name="phoneNo" value="<%=phoneNo%>"><!--打印工单广告-->
    <%@ include file="/npage/include/footer.jsp" %>   
</form>
</body>
</html>
