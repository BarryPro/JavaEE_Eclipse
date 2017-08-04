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
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%		

  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
  
  String loginNo = (String)session.getAttribute("workNo");
  String orgCode = (String)session.getAttribute("orgCode");
  String loginPwd    = (String)session.getAttribute("password");
  String regionCode = orgCode.substring(0,2);
  
  String opname="畅聊家庭产品管理";
  String opcode="7333";
%>
<%
  String retFlag="",retMsg="";//存放是否校验失败的标志、信息
/****************由移动号码得到密码、机主姓名、温馨家庭申请等信息 s1251Init***********************/
  String[] paraAray1 = new String[4];
  String main_card = request.getParameter("chief_srv_no");
  String op_code = request.getParameter("opCode");
  String openType = request.getParameter("open_type");/* 操作类型*/
  String passwordFromSer="";
  
  paraAray1[0] = main_card;		/* 手机号码   */ 
  paraAray1[1] = loginNo; 	/* 操作工号   */
  paraAray1[2] = orgCode;	/* 归属代码   */
  paraAray1[3] = op_code;	/* 操作代码   */
 
  for(int i=0; i<paraAray1.length; i++)
  {		
	if( paraAray1[i] == null )
	{
	  paraAray1[i] = "";
	}
  }
  //retList = impl.callFXService("s7328Qry", paraAray1, "37", "phone",main_card);
%>
	<wtc:service name="s7328Qry" routerKey="phone" routerValue="<%=main_card%>" retcode="retCode1" retmsg="retMsg1" outnum="39">			

		<wtc:param value="0"/>
		<wtc:param value="01"/>		
		<wtc:param value="<%=paraAray1[3]%>"/>
		<wtc:param value="<%=paraAray1[1]%>"/>
		<wtc:param value="<%=loginPwd%>"/>									
		<wtc:param value="<%=paraAray1[0]%>"/>
		<wtc:param value=""/>	
		<wtc:param value="<%=paraAray1[2]%>"/>
	</wtc:service>	
	<wtc:array id="result1"  start="0" length="25" scope="end"/>
	<wtc:array id="result0"  start="26" length="1" scope="end"/>
	<wtc:array id="result9"  start="27" length="1" scope="end"/>
	<wtc:array id="result10" start="28" length="1" scope="end"/>
	<wtc:array id="result2"  start="29" length="1" scope="end"/>
	<wtc:array id="result3"  start="30" length="1" scope="end"/>
	<wtc:array id="result4"  start="31" length="1" scope="end"/>
	<wtc:array id="result5"  start="32" length="1" scope="end"/>
	<wtc:array id="result6"  start="33" length="1" scope="end"/>
	<wtc:array id="result7"  start="34" length="1" scope="end"/>
	<wtc:array id="result8"  start="35" length="1" scope="end"/>
	<wtc:array id="result11"  start="36" length="1" scope="end"/>	
<%
  String  bp_name="",sm_code="",family_code="",rate_code="",op_type="",bigCust_flag="",sm_name="",rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="",prepay_fee="",prodId="",prodNote="";
  String otherCardFlag = "",mainDisabledFlag="",print_note="",bp_add="",cardId_no="",prod_name="";
  String[][] tempArr= new String[][]{};
  String[][] familyCodeArr= new String[][]{};
  String[][] otherCodeArr= new String[][]{};
  String[][] cardTypeArr= new String[][]{};
  String[][] beginTimeArr= new String[][]{};
  String[][] endTimeArr= new String[][]{};
  String[][] opTimeArr= new String[][]{};
  String[][] newRateCodeArr= new String[][]{};
  String[][] FamilyProdArr= new String[][]{};
  String[][] FamilyNoteArr= new String[][]{};
  String[][] ParentProdArr= new String[][]{};
  String[][] FriendNoArr= new String[][]{};
  String errCode = retCode1;
  String errMsg = retMsg1;
  tempArr = result1;
  System.out.println("errCode======"+errCode);
  if(result1.length==0)
  {
	if(!retFlag.equals("1"))
	{
	   retFlag="1";
	   retMsg="s7328Qry查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg: " + errMsg ;
    }  
  }else if(errCode.equals("000000") && result1.length>0)
  {
	
	    bp_name = tempArr[0][3];//机主姓名
	    
	    bp_add = tempArr[0][4];//客户地址
	  
	    passwordFromSer = tempArr[0][2];//密码
	 
	    sm_code = tempArr[0][11];//业务类别
	 
	    sm_name = tempArr[0][12];//业务类别名称
	 
	    rate_code = tempArr[0][5];//资费代码
	 
	    rate_name = tempArr[0][6];//资费名称
	 
	    next_rate_code = tempArr[0][7];//下月资费代码
	 
	    next_rate_name = tempArr[0][8];//下月资费名称
	
	    bigCust_flag = tempArr[0][9];//大客户标志
	 
	    bigCust_name = tempArr[0][10];//大客户名称
	
	    lack_fee = tempArr[0][15];//总欠费
	 
	    prepay_fee = tempArr[0][16];//总预交
	    
	     cardId_no = tempArr[0][19];//证件号码
	    
	  FamilyProdArr = result0;  //产品代码
	  FamilyNoteArr = result9;	//产品详情
	  ParentProdArr = result10;	//产品标志（'0'——家庭主产品，其余都是附加产品）
	  familyCodeArr = result2;//家庭号码 
	  FriendNoArr = result11; //家庭亲情包的亲情号码
	  if(result2.length!=0)
	  {
	  	family_code = familyCodeArr[0][0].substring(4,10);
	  }
	  otherCodeArr = result3;//付卡号码--成员号码
      cardTypeArr = result4;//卡类型--加入时间
      beginTimeArr = result5;//开始时间--办理工号
      endTimeArr = result6;//结束时间--办理流水
      opTimeArr = result7;//操作时间--不用
	  newRateCodeArr = result8;//温馨家庭资费代码--不用
	  //判断是否存在申请纪录
	  if(familyCodeArr==null || familyCodeArr.length==0 || familyCodeArr[0][0].equals("")){
		if(!retFlag.equals("1"))
	    {
	       retFlag="1";
	       retMsg="该号码没有对应的申请信息!";
        }  
	  }else if(familyCodeArr.length>1){
	    otherCardFlag = "1";//判断是否存在付卡
	  }
	}else{
		if(!retFlag.equals("1"))
	    {
	       retFlag="1";
	       retMsg="s7328Qry查询号码基本信息失败!"+errMsg;
        }
	}
	

  //******************得到下拉框数据***************************//
 String sqlRateCode = "";
    //资费信息
   
	sqlRateCode = "select a.mode_code,a.mode_code||'--'||a.mode_name from sbillmodecode a,sFamModeCode b  where a.region_code=b.region_code and a.mode_code=b.mode_code and b.region_code='"+regionCode +"'" ;
	System.out.println("sqlRateCode="+sqlRateCode);
	String[] paramIn = new String[2];
	paramIn[0] = "select a.mode_code,a.mode_code||'--'||a.mode_name from sbillmodecode a,sFamModeCode b  where a.region_code=b.region_code and a.mode_code=b.mode_code and b.region_code=:regionCode";
	paramIn[1] = "regionCode="+regionCode;
	//ArrayList rateCodeArr = co.spubqry32("2",sqlRateCode);
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="2">			
	<wtc:param value="<%=paramIn[0]%>"/>	
	<wtc:param value="<%=paramIn[1]%>"/>	
	</wtc:service>	
	<wtc:array id="rateCodeStr"  scope="end"/>
<%

	System.out.println("retCode2==="+retCode2);
	System.out.println("rateCodeStr"+rateCodeStr.length);
	String op_note="";
	op_note="亲情号码变更";	
  	String printAccept="";
  	printAccept = getMaxAccept();
%>
<head>
<title>畅聊家庭信息查询</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
 
<script language="JavaScript">
    //如果校验失败，则返回上一界面
	<%if(retFlag.equals("1")){%>
	 rdShowMessageDialog("<%= retMsg %>");
	 history.go(-1);
	<%}%>
<!--
  //定义应用全局的变量
  var SUCC_CODE	= "0";   		//自己应用程序定义
  var ERROR_CODE  = "1";			//自己应用程序定义
  var YE_SUCC_CODE = "0000";		//根据营业系统定义而修改

  var oprType_Add = "a";
  var oprType_Upd = "u";
  var oprType_Del = "d";
  var oprType_Qry = "q";
 
  onload=function()
  {		
  }
  
  function frmCfm()
  {
 	frm.submit();
	return true;
  }
  //***
  function printfrmCfm(){
  	getAfterPrompt();
  	if(document.all.friend_no.value=="")
  	{
  		rdShowConfirmDialog('请选择要变更的家庭亲情号码!点击单选按钮进行选择!');
  	}
  	else if(document.all.friend_no.value=="0") 
  	{
  		rdShowConfirmDialog('主产品没有亲情号，请选择其下附加产品！');
  	}	
  	else if(document.all.new_friend_no.value=="")
  	{
  		rdShowConfirmDialog('请输入新亲情号码!')
  		document.all.new_friend_no.focus();	
  	}
  	else if(document.all.new_friend_no.length <	11)
  	{
  		rdShowConfirmDialog('你输入新亲情号码有误，请重新输入!')
  		document.all.new_friend_no.focus();	
  	}  	
	else
	{
	  	//alert(document.all.friend_no.value+"|"+document.all.fam_prod_id.value+"|"+document.all.pay_fee.value);
	  	setOpNote();//为备注赋值
	  	document.frm.action="f7333Cfm.jsp";
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
		var opCode="<%=op_code%>";                                  //操作代码
		var phoneNo=document.frm.main_card.value;                 //客户电话
		
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
		var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+document.frm.main_card.value+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
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
		
		cust_info+="手机号码："+"<%=main_card%>"+"|";
		cust_info+="客户姓名："+"<%=bp_name%>"+"|";
		
		
		opr_info+="用户品牌："+document.all.sm_name.value+"  "+"办理业务：畅聊家庭产品管理之<%=op_note%>"+"|";
		opr_info+="操作流水："+"<%=printAccept%>"+"|";		
		
		opr_info+="变更前的号码为：  "+document.frm.friend_no.value+"|";
		opr_info+="变更成的号码为：  "+document.frm.new_friend_no.value+"|";
		opr_info+="变更手续费：  "+document.frm.pay_fee.value+" 元"+"|";
		opr_info+="生效时间： "+"当日"+"|";
		note_info1+="备注："+"|";
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
		return retInfo;
  } 
 function setOpNote(){
	if(document.frm.opNote.value=="")
	{
	  document.frm.opNote.value = "家庭产品管理--<%=op_note%> 家长号码:"+document.frm.main_card.value; 
	}
	return true;
}
function f7328Init(obj){
	document.frm.fam_prod_id.value = obj.FamilyProd.trim();
	document.frm.friend_no.value = obj.FriendNo.trim();
	if(document.frm.friend_no.value=="0")
	{
		document.all.new_friend_no.disabled=true;
		document.all.new_friend_no_id.disabled=true;
		document.all.pay_fee_id.disabled=true;
		document.all.pay_fee.disabled=true;
		document.all.new_friend_no.value="";
	}
	else
	{
		document.all.new_friend_no_id.disabled=false;
		document.all.new_friend_no.disabled=false;
		document.all.pay_fee_id.disabled=false;
		document.all.pay_fee.disabled=false;
	}		
}

//-->
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
            <td colspan="3">亲情号码变更</td>
            <input name="op_type" type="hidden" class="InputGrey" id="op_type" value="<%=openType%>" >
          </tr>
          <tr> 
		    <td class="blue">手机号码</td>
            <td>
			  <input name="main_card" type="text" class="InputGrey" id="main_card" value="<%=main_card%>" readonly >
			</td>
            <td class="blue">业务类型</td>
            <td>
			  <input name="sm_name" type="text" class="InputGrey" id="sm_name" value="<%=sm_name%>" readonly>
			</td>
          </tr>
          <tr> 
            <td class="blue">当前主套餐</td>
            <td>
			  <input name="rate_name" type="text" class="InputGrey" id="rate_name" size="30" value="<%=rate_code+"--"+rate_name%>" readonly>
			</td>
			<td class="blue">下月主套餐</td>
            <td>
			  <input name="next_rate_name" type="text" class="InputGrey" id="next_rate_name" size="30"  value="<%=next_rate_code+"--"+next_rate_name%>" readonly>
			</td>             
          </tr>
		  <tr>
		    <td class="blue">机主姓名</td>
            <td>
			  <input name="bp_name" type="text" class="InputGrey" id="bp_name" value="<%=bp_name%>" readonly>
			</td>
            <td class="blue">大客户标志</td>
            <td>
			<input name="bigCust_flag" type="text" class="InputGrey" id="bigCust_flag" value="<%=bigCust_flag+"--"+bigCust_name%>" readonly>
			</td>
          </tr>
		</table>
		</div>

<div id="Operation_Table"> 
<div class="title">
	<div id="title_zi">业务明细</div>
</div>
		<TABLE cellSpacing="0">
          <TBODY> 
		  <tr>
			<tr>
		      <th align=center>家庭代码</th>
			  <th align=center>家庭身份</th>
			  <th align=center>手机号码</th>
			  <th align=center>开始时间</th>
			  <th align=center>操作工号</th>
			  <th align=center>操作流水</th>
			</tr>
			<% 
			 for(int j=0;j<otherCodeArr.length;j++){
			 	String tdClass = (j%2==0)?"Grey":"";
                if(cardTypeArr[j][0].equals("0") && otherCardFlag.equals("1")){
				  mainDisabledFlag = "disabled";
				}else{
				  mainDisabledFlag = "";
				}
			%>
		    <tr> 
			  <TD align=center class="<%=tdClass%>"><%=familyCodeArr[j][0]%></TD>
			  <TD align=center class="<%=tdClass%>"><%=newRateCodeArr[j][0]%></TD>
			  <TD align=center class="<%=tdClass%>"><%=otherCodeArr[j][0]%></TD>
			  <TD align=center class="<%=tdClass%>"><%=cardTypeArr[j][0]%></TD>
			  <TD align=center class="<%=tdClass%>"><%=beginTimeArr[j][0]%></TD>
			  <TD align=center class="<%=tdClass%>"><%=endTimeArr[j][0]%></TD>
			</tr>				
			<%
			 }
			%>
		</table>
	</div>
<div id="Operation_Table"> 
	<div class="title">
	<div id="title_zi">当前家庭产品信息</div>
	</div>
	    <TABLE  cellSpacing="0">
          <TBODY> 
          <tr>
			<tr align="middle" >
				<th align=center>选择</th>
		      <th align=center>家庭产品代码</th>
			  <th align=center>产品明细</th>
			  <th align=center>亲情号码</th>
			</tr> 
			<% 
				 for(int i=0;i<FamilyProdArr.length;i++){
				 	String TdClass = (i%2==0)?"Grey":"";		 	
			%>
			<tr>
				<td class="Grey" align=center>
		      		<input type="radio" name="radio" class="button" FamilyProd="<%=FamilyProdArr[i][0]%>" FamilyNote="<%=FamilyNoteArr[i][0]%>" FriendNo="<%=FriendNoArr[i][0]%>" onclick="f7328Init(this)">	</td>
				<TD align=center class="<%=TdClass%>"><%=FamilyProdArr[i][0]%></TD>
			   	<TD align=center class="<%=TdClass%>"><%=FamilyNoteArr[i][0]%></TD>			   	
			   	<TD align=center class="<%=TdClass%>"><%=FriendNoArr[i][0]%></TD>
			</tr>
			<%}%>
		</tr>
	</table> 
</div>
<div id="Operation_Table"> 
<div class="title">
	<div id="title_zi">亲情号码信息</div>
	</div>	
		<TABLE cellSpacing="0">
          <TBODY> 
          <tr>
			<td class="blue" align=center>
				原亲情号码
			</td>
            <td>
				<input name="friend_no" type="text" class="InputGrey" id="friend_no"  maxlength=8 readonly>
			</td>
			<td class="blue" align=center id="new_friend_no_id" disabled >新亲情号码</td>  	
			<td>	
				<input name="new_friend_no" type="text" class="button" id="new_friend_no" maxlength=11 size="12" v_type="0_9" v_must=1 v_minlength=1 v_maxlength=12 disabled>    
        	</td> 
        </tr>
        <tr>
        	<td class="blue" align=center id="pay_fee_id" disabled>变更手续费</td>  
        	<td colspan=4>	
				<input name="pay_fee" type="text" class="button" id="pay_fee" maxlength=6 size="6" v_type="0_9" v_must=1 v_minlength=1 v_maxlength=12 value="0.00" disabled>    
        	</td> 
        </tr>
		  <tr> 
            <td id="footer" colspan="4"> <div align="center"> 
            	 &nbsp; 
				<input name="confirm" id="confirm" type="button" class="b_foot"  value="确认" onClick="printfrmCfm(this)" >
                 &nbsp;
                <input name="reset" type="hidden" class="b_foot" value="清除" >
                &nbsp; 
                <input name="back" onClick="history.go(-1);" type="button" class="b_foot" value="返回">
                &nbsp; 				
				</div>
			</td>
          </tr>
       </table>
 <input type="hidden" name="bp_addr" id="bp_addr" value="<%=bp_add%>"> <!--客户地址-->
 <input name="cardId_no" type="hidden" id="cardId_no" value="<%=cardId_no%>"> <!--证件号码-->
  <input type="hidden" name="phoneNoForPrt" ><!--要取消的手机号码,用于打印-->
  <input type="hidden" name="cardTypeForPrt" ><!--要取消的卡类型,用于打印-->
  <input type="hidden" name="printAccept" value="<%=printAccept%>"><!--打印流水-->
  <input type="hidden" name="phoneNo" value="<%=main_card%>">
  <input type="hidden" name="op_code" value="<%=opCode%>">
  <input name="fam_prod_id" type="hidden" id="fam_prod_id" maxlength=8 > <!--家庭代码-->
  <input name="opNote" type="hidden" id="opNote" value="" onFocus="setOpNote();" > 
  <input type="hidden" name="return_page" value="/npage/bill/f7333_login.jsp?activePhone=<%=main_card%>&opName=<%=opname%>&opCode=<%=opcode%>">
   <%@ include file="/npage/include/footer.jsp" %>  
</form>
</body>
</html>



