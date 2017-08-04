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
<%@ include file="../../npage/bill/getMaxAccept_boss.jsp" %>
<%@ page import="com.sitech.boss.pub.exception.BOException"%>
<%		

  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
  String op_Flag = request.getParameter("op_Flag");
  
  String loginNo = (String)session.getAttribute("workNo");
  String orgCode = (String)session.getAttribute("orgCode");
  
%>
<%
  String retFlag="",retMsg="";//存放是否校验失败的标志、信息
/****************由移动号码得到密码、机主姓名、温馨家庭申请等信息 s1251Init***********************/
  String[] paraAray1 = new String[4];
  String main_card = request.getParameter("chief_no");
  String mem_card = request.getParameter("srv_no");
  String passwordFromSer="";
  String show_phone = "";
  if(op_Flag.equals("0"))
  { 
  	paraAray1[0] = main_card;	
  	show_phone = main_card;			/* 主卡号码   */
  }
	else 
	{
		paraAray1[0] = mem_card;	/* 副卡号码   */
		show_phone = mem_card;	
	}				 
  paraAray1[1] = opCode; 		/* 操作代码   */
  paraAray1[2] = op_Flag;			/* 查询标志   */
 System.out.println("------------999999999999999999999999999paraAray1[0]---------------"+paraAray1[0]);
 System.out.println("------------999999999999999999999999999paraAray1[1]---------------"+paraAray1[1]);
 System.out.println("------------999999999999999999999999999paraAray1[2]---------------"+paraAray1[2]);
  for(int i=0; i<paraAray1.length; i++)
  {		
		if( paraAray1[i] == null )
		{
		  paraAray1[i] = "";
		}
  }
%>
	<wtc:service name="s7327SelNew" retcode="retCode1" retmsg="retMsg1" outnum="16">			
	<wtc:param value="<%=paraAray1[0]%>"/>	
	<wtc:param value="<%=paraAray1[1]%>"/>	
	<wtc:param value="<%=paraAray1[2]%>"/>	
	</wtc:service>	
	<wtc:array id="result1"  start="0" length="2" scope="end"/>
	<wtc:array id="result2"  start="2" length="1" scope="end"/>
	<wtc:array id="result3"  start="3" length="1" scope="end"/>
	<wtc:array id="result4"  start="4" length="1" scope="end"/>
	<wtc:array id="result5"  start="5" length="1" scope="end"/>
	<wtc:array id="result6"  start="6" length="1" scope="end"/>
	<wtc:array id="result7"  start="7" length="1" scope="end"/>
	
	<wtc:array id="result8"  start="8" length="1" scope="end"/>
	<wtc:array id="result9"  start="9" length="1" scope="end"/>		
	<wtc:array id="result10"  start="10" length="1" scope="end"/>	
	
	<wtc:array id="result11"  start="11" length="1" scope="end"/>
	<wtc:array id="result12"  start="12" length="1" scope="end"/>
	<wtc:array id="result13"  start="13" length="1" scope="end"/>
	<wtc:array id="result14"  start="14" length="1" scope="end"/>
	<wtc:array id="result15"  start="15" length="1" scope="end"/>
<%
  String  bp_name="";
  String otherCardFlag = "",mainDisabledFlag="";
  String[][] tempArr= new String[][]{};
  String[][] beginTimeArr= new String[][]{};
  String[][] phoneNoArr= new String[][]{};
  String[][] custNameArr= new String[][]{};
  String[][] limitPayArr= new String[][]{};
  String[][] sumPayArr= new String[][]{};
  String[][] activePayArr= new String[][]{};
  /* add by wanglm 20110324 显示副卡状态，副卡欠费原因，副卡欠费金额 start*/
  String[][] stateFlagArr= new String[][]{};
  String[][] flagArr= new String[][]{};
  String[][] billFeeArr= new String[][]{};
  /* add by wanglm 20110324 显示副卡状态，副卡欠费原因，副卡欠费金额 end */
  
  String mainCartState = "";
  String mainCartOwe = "";
  String mainCartOweMoney = "";
  String errCode = retCode1;
  String errMsg = retMsg1;
  String[][] main_nameA = new String[][]{}; // mainCartState 主卡状态
  String[][] second_nameA = new String[][]{}; // stateFlagArr
  String main_nameB = "";
  String second_nameB = "";
  System.out.println("errCode======"+errCode);
  if(result2.length==0)
  {
	if(!retFlag.equals("1"))   
	{
	   retFlag="1";
	   retMsg="" + errMsg ;
    }  
  }else if(errCode.equals("000000") && result2.length > 0)
  { 
	  beginTimeArr = result2;			//付费时间 
	  phoneNoArr = result3;		//主卡号码 或 副卡号码
    custNameArr = result4;		//客户姓名
    limitPayArr = result5;		//付费金额
    sumPayArr = result6;			//付费总金额
   	activePayArr = result7;			//付费实际金额
   	stateFlagArr = result8;    //副卡状态
   	flagArr = result9;        //副卡欠费原因
   	billFeeArr = result10;    //副卡欠费金额
	mainCartState = result11[0][0]; //主卡状态
    /*xl add for 主卡状态转name*/
	second_nameA = result14;
	main_nameA = result15;
	main_nameB = result15[0][0];
   mainCartOwe = result12[0][0]; 
   mainCartOweMoney = result13[0][0];
	  //判断是否存在申请纪录  
	  if(phoneNoArr==null || phoneNoArr.length==0 || phoneNoArr[0][0].equals("")){
		if(!retFlag.equals("1"))
	    {
	       retFlag="1";
	       retMsg="该号码没有对应的申请信息!";
        }  
	  }else if(phoneNoArr.length>1){
	    otherCardFlag = "1";//判断是否存在付卡
	  }
	}else{
		if(!retFlag.equals("1"))
	    {
	       retFlag="1";
	       retMsg="查询号码基本信息失败!"+errMsg;
        }
	}  

  

  /****得到打印流水****/
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
  function ret()
  {
  		
  		window.location.href='/npage/bill/f7327Kf.jsp?phoneNo=<%=show_phone%>&opName=<%=opName%>&opCode=<%=opCode%>';
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
            <td>查询</td> 
		    <td class="blue">查询号码</td>
            <td>
			  <input name="phone_no" type="text" class="InputGrey" id="phone_no" value="<%=show_phone%>" readonly >
			</td>     
      </tr>
      <%
        if(op_Flag.equals("1") && stateFlagArr.length>0 && flagArr.length>0){
          %>
             <tr> 
            <td class="blue">副卡状态</td>
            <td><%=second_nameA[0][0]%></td> 
		    <td class="blue">副卡停机原因</td>
            <td>
            	<%
            	   if("0".equals(flagArr[0][0])){
            	      %>
            	       主卡欠费
            	      <%
            	   }else if("1".equals(flagArr[0][0])){
            	   	  %>
            	       副卡欠费
            	      <%
            	   }else{
            	      %>
            	      <%=flagArr[0][0]%>
            	      <%	
            	   }
            	%>
			</td> 
			     
      </tr>
      <tr>
      	<td class="blue" >副卡欠费金额</td>
            <td colspan="3">
            	 <%=billFeeArr[0][0]%>
			</td> 
  </tr>
          <%
        }else{
      %>
       <tr> 
            <td class="blue">主卡状态</td>
            <td><%=main_nameB%></td> 
		    <td class="blue">主卡停机原因</td>
            <td>
            	<%
            	   if("0".equals(mainCartOwe)){
            	      %>
            	       主卡欠费
            	      <%
            	   }else if("1".equals(mainCartOwe)){
            	   	  %>
            	       副卡欠费
            	      <%
            	   }else{
            	      %>
            	      <%=mainCartOwe%>
            	      <%	
            	   }
            	%>
            	
			</td> 
			     
      </tr>
      <tr>
      	<td class="blue" >主卡欠费金额</td>
            <td colspan="3">
            	 <%=mainCartOweMoney%>
			</td> 
  </tr>
  <%}%>
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
		    <th align=center>开始时间</th>
		    <%
		    	if(op_Flag.equals("0"))
		    	{
		    %>
			  <th align=center>副卡号码</th>
			  <th align=center>客户姓名</th>                    
			  <th align=center>为副卡付费的限额</th>                    
			  <th align=center>为副卡付费的实际金额(6个月内含当月)</th>
			  <th align=center>副卡状态</th>
			  <th align=center>副卡停机原因</th>
			  <th align=center>副卡欠费金额</th>
			  <%}
			  	else
			  	{	
			  %>
			  <th align=center>主卡号码</th>							                                        
			  <th align=center>客户姓名</th>                    
			  <th align=center>主卡代其付费的限额</th>                    
			  <th align=center>主卡代其付费的实际金额</th>
			  <th align=center>主卡状态</th>
			  <th align=center>主卡停机原因</th>
			  <th align=center>主卡欠费金额</th>                
			 	<%}%>                                                  
			</tr>                                               
			<% 
			 for(int j=0;j<phoneNoArr.length;j++){
			 	String tdClass = (j%2==0)?"Grey":"";              
			/*xl add for 主卡状态转name 有循环了*/
			%>
		    <tr> 
			  <TD align=center class="<%=tdClass%>"><%=beginTimeArr[j][0]%></TD>
			  <TD align=center class="<%=tdClass%>"><%=phoneNoArr[j][0]%></TD>
			  <TD align=center class="<%=tdClass%>"><%=custNameArr[j][0]%></TD>
			  <TD align=center class="<%=tdClass%>"><%=limitPayArr[j][0]%></TD>
			  <TD align=center class="<%=tdClass%>"><%=sumPayArr[j][0]%></TD>
			  <%
			    if(op_Flag.equals("1")){
			  %>
			  <TD align=center class="<%=tdClass%>"><%=main_nameA[j][0]%></TD>
			  <%
			      if("1".equals(mainCartOwe)){
			      %>
			         <TD align=center class="<%=tdClass%>">副卡欠费</TD>
			      <%
			  }else if("0".equals(mainCartOwe)){
			  	%>
			         <TD align=center class="<%=tdClass%>">主卡欠费</TD>
			      <%
			  }else{
			     %> 
			         <TD align=center class="<%=tdClass%>"><%=mainCartOwe%></TD>
			      <%	
			  }
			  %>
			  <TD align=center class="<%=tdClass%>"><%=mainCartOweMoney%></TD>
			  <%
			    }else{
			  %>
			  <TD align=center class="<%=tdClass%>"><%=second_nameA[j][0]%></TD>
			  <%
			      if("1".equals(flagArr[j][0])){
			         %>
			          <TD align=center class="<%=tdClass%>">副卡欠费</TD>
			         <%
			      }else if("0".equals(flagArr[j][0])){
			  	%>
			         <TD align=center class="<%=tdClass%>">主卡欠费</TD>
			      <%
			      }else{
			     %> 
			         <TD align=center class="<%=tdClass%>"><%=flagArr[j][0]%></TD>
			      <%	
			      }
			  %>
			  <TD align=center class="<%=tdClass%>"><%=billFeeArr[j][0]%></TD>
			  <%
			   }
			  %>
			</tr>				
			<%
			 }
			%>
		</table>
	    <TABLE  cellSpacing="0">
          <TBODY> 
		  <tr> 
            <td id="footer" colspan="4"> <div align="center"> 
                <input name="reset" type="reset" class="b_foot" value="清除" >
                &nbsp; 
                <input name="back" onClick="ret();" type="button" class="b_foot" value="返回">
                &nbsp; 
				
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



