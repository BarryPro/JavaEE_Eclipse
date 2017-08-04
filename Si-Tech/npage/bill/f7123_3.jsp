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
   String loginNoPass = (String)session.getAttribute("password");
  String loginNo = (String)session.getAttribute("workNo");
  String orgCode = (String)session.getAttribute("orgCode");
%>
<%
  String retFlag="",retMsg="";//存放是否校验失败的标志、信息
/****************由移动号码得到密码、机主姓名、温馨家庭申请等信息 s1251Init***********************/
  String[] paraAray1 = new String[4];
  String main_card = request.getParameter("chief_srv_no");
  String op_code = request.getParameter("op_code");
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
  //retList = impl.callFXService("s7123Qry", paraAray1, "36", "phone",main_card);
%>
	<wtc:service name="s7123Qry" routerKey="phone" routerValue="<%=main_card%>" retcode="retCode1" retmsg="retMsg1" outnum="36">			
	<wtc:param value="<%=paraAray1[0]%>"/>	
	<wtc:param value="<%=paraAray1[1]%>"/>	
	<wtc:param value="<%=paraAray1[2]%>"/>	
	<wtc:param value="<%=paraAray1[3]%>"/>
	<wtc:param value=" "/>	
	<wtc:param value=" "/>	
	<wtc:param value="<%=loginNoPass%>"/>	
	</wtc:service>	
	<wtc:array id="result1"  start="0" length="29" scope="end"/>
	<wtc:array id="result2"  start="29" length="1" scope="end"/>
	<wtc:array id="result3"  start="30" length="1" scope="end"/>
	<wtc:array id="result4"  start="31" length="1" scope="end"/>
	
	<wtc:array id="result7"  start="32" length="1" scope="end"/>
	<wtc:array id="result8"  start="33" length="1" scope="end"/>

<%
/* add by qidp @ 2009-09-09
	<!-- 
	<wtc:array id="result5"  start="32" length="1" scope="end"/>
	<wtc:array id="result6"  start="33" length="1" scope="end"/>
	<wtc:array id="result7"  start="34" length="1" scope="end"/>
	<wtc:array id="result8"  start="35" length="1" scope="end"/>
	-->
	*/

  String  bp_name="",sm_code="",family_code="",rate_code="",op_type="",bigCust_flag="",sm_name="",rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="",prepay_fee="",print_note="";
  String otherCardFlag = "",mainDisabledFlag="";
  String[][] tempArr= new String[][]{};
  String[][] familyCodeArr= new String[][]{};
  String[][] otherCodeArr= new String[][]{};
  String[][] cardTypeArr= new String[][]{};
  String[][] beginTimeArr= new String[][]{};
  String[][] endTimeArr= new String[][]{};
  String[][] opTimeArr= new String[][]{};
  //add by qidp @ 2009-09-09
  String[][] result5= new String[][]{};
  String[][] result6= new String[][]{};
  //end
  String[][] newRateCodeArr= new String[][]{};
  String errCode = retCode1;
  String errMsg = retMsg1;
  tempArr = result1;
  System.out.println("errCode======"+errCode);
  if(result1.length==0)
  {
	if(!retFlag.equals("1"))
	{
	   retFlag="1";
	   retMsg="s7123Qry查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg: " + errMsg ;
    }  
  }else if(errCode.equals("000000") && result1.length>0)
  {
	
	    bp_name = tempArr[0][3];//机主姓名
	  
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
	 
	    print_note = tempArr[0][27];//工单广告词
	 
	  familyCodeArr = result2;//家庭号码 
	  otherCodeArr = result3;//付卡号码
	//--成员号码
      cardTypeArr = result4;//卡类型
//--加入时间
      beginTimeArr = result5;//开始时间
	//--办理工号
      endTimeArr = result6;//结束时间
//--办理流水
      opTimeArr = result7;//操作时间
//--不用
	  newRateCodeArr = result8;//温馨家庭资费代码
//--不用
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
	       retMsg="s7123Qry查询号码基本信息失败!"+errMsg;
        }
	}
  


  //******************得到下拉框数据***************************//
  /**
  comImpl co=new comImpl();
  //资费代码 
  String sqlNewRateCode2  = "";  
  sqlNewRateCode2  = "select a.mode_code, a.mode_code||'--'||b.mode_name from sRegionNormal a, sBillModeCode b where a.region_code=b.region_code and a.mode_code=b.mode_code and a.region_code='" + orgCode.substring(0,2) + "'";
  ArrayList newRateCodeArr2  = co.spubqry32("2",sqlNewRateCode2 );
  String[][] newRateCodeStr2  = (String[][])newRateCodeArr2.get(0);
  **/

  /****得到打印流水****/
  String printAccept="";
  printAccept = getMaxAccept();
%>
<head>
<title>家庭服务计划查询</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
 
<script language="JavaScript">
    //如果校验失败，则返回上一界面
	<%if(retFlag.equals("1")){%>
	 rdShowMessageDialog("<%= retMsg %>");
	 window.location="f7123.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
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
  
  //***
  function frmCfm(){
 	frm.submit();
	return true;
  }
  //***//校验one
  function checkOne(){    
	var flag = 0;
	var card_type,phoneNo ;
	var radio1 = document.getElementsByName("phoneNo");
	for(var i=0;i<radio1.length;i++){
	  if(radio1[i].checked){
	    flag = 1;
		phoneNo = oneTokSelf(radio1[i].value,"~",1);//卡号码
		card_type = oneTokSelf(radio1[i].value,"~",2);//卡类型
		document.frm.phoneNoForPrt.value=phoneNo;
		document.frm.cardTypeForPrt.value=card_type;
	  }
	}
	if(flag==0){
	  rdShowMessageDialog("请选择要取消的号码!");
	  return false;
	}else
	{
	  if(card_type=="1")
	  {
	    if(document.frm.new_rate_code2.value=="")
		{
		  rdShowMessageDialog("请选择新套餐代码!");
		  document.frm.new_rate_code2.focus();
	      return false;
		}
	  }
	}
	return true;
  }
  //
 
  /*根据卡类型动态改变行的可见性*/
  function controlByCardType(str)
  {
    var card_type = oneTokSelf(str,"~",2);//卡类型
	var phoneNo = oneTokSelf(str,"~",1);//卡号码
	document.frm.phoneNoForPrt.value=phoneNo;
    document.frm.cardTypeForPrt.value=card_type;
	if(card_type=="1")
	{
		document.all.newRateCode2Tr.style.display="";
	}else
	{
	    document.all.newRateCode2Tr.style.display="none";
	}
	return true;
  }

	function goBack(){
		window.location="f7123.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
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
            <td colspan="3">查询</td>
          </tr>
          <tr> 
		    <td class="blue">手机号码</td>
            <td>
			  <input name="main_card" type="text" class="InputGrey" id="main_card" value="<%=main_card%>" readonly >
			</td>
            <td class="blue">业务类型</td>
            <td>
			  <input name="sm_name" type="text" class="InputGrey" id="sm_name" value="<%=sm_code + "--" + sm_name%>" readonly>
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
			  <!-- <th align=center>操作工号</th> -->
			  <!-- <th align=center>操作流水</th> -->
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
			  <!--  <TD align=center class="<%=tdClass%>"></TD>
			  <TD align=center class="<%=tdClass%>"></TD> -->
			</tr>				
			<%
			 }
			%>
		</table>
	    <TABLE  cellSpacing="0">
          <TBODY> 
		  <tr> 
            <td id="footer" colspan="4"> <div align="center"> 
                
                <input name="back" onClick="goBack()" type="button" class="b_foot" value="返回">
                <input name="reset" type="reset" class="b_foot" value="关闭" onclick="removeCurrentTab()">
				
				</div>
			</td>
          </tr>
       </table>
 
  <input type="hidden" name="phoneNoForPrt" ><!--要取消的手机号码,用于打印-->
  <input type="hidden" name="cardTypeForPrt" ><!--要取消的卡类型,用于打印-->
  <input type="hidden" name="printAccept" value="<%=printAccept%>"><!--打印流水-->
   <%@ include file="/npage/include/footer.jsp" %>  
</form>
</body>
</html>



