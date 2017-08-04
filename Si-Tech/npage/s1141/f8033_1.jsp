<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
/********************
 version v2.0
开发商: si-tech
<!-- baixf 20080613 modify 将“集团无条件赠机”名称更改为“集团客户行业应用赠机”  -->
********************/
%>
<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.02.09
 模块:集团客户行业应用赠机-冲正
********************/
%>


	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
%>

<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ page import="java.math.*"%>


<%		
  String opCode = request.getParameter("opcode");
  String opName = request.getParameter("opname");
  	
  String loginNo = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");
  String orgCode = (String)session.getAttribute("orgCode");
  String ip_Addr = (String)session.getAttribute("ipAddr");
  String regionCode = (String)session.getAttribute("regCode");
%>
<%
  String retFlag="",retMsg="";
  ArrayList retList = new ArrayList();
  String[] paraAray1 = new String[4];
  String phoneNo = request.getParameter("srv_no");
  String opcode = request.getParameter("opcode");
  String backaccept = request.getParameter("backaccept");
  String passwordFromSer="";
  
  paraAray1[0] = phoneNo;		/* 手机号码   */ 
  paraAray1[1] = opcode; 	    /* 操作代码   */
  paraAray1[2] = loginNo;	    /* 操作工号   */
  paraAray1[3] = backaccept;	/* 操作流水   */
/*****王梅 添加 20060605*****/
  ArrayList retArray = new ArrayList();
  String[][] result = new String[][]{};
  String sqlStr = "";
  String awardName="";
  sqlStr = "select award_name from wawardpay where phone_no ='"+phoneNo+"'"+
		    " and login_accept="+backaccept  ;
  String[] inParams = new String[2];
  inParams[0] = "select award_name from wawardpay where phone_no =:phoneNo and login_accept=:backaccept";	
  inParams[1] = "phoneNo="+phoneNo+",backaccept="+backaccept;	
  //retArray = callView.sPubSelect("1",sqlStr);
%>
	<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="1">			
	<wtc:param value="<%=inParams[0]%>"/>	
	<wtc:param value="<%=inParams[1]%>"/>
	</wtc:service>	
	<wtc:array id="resultTemp1"  scope="end"/>
<%
	if(resultTemp1.length>0)
  		result = resultTemp1;
  	else{
  		result = new String[1][1];
  		result[0][0] = "";	
  	}
  awardName = result[0][0];	
  
  System.out.println("awardName="+awardName);

  if(!awardName.equals("")){
  %>
	<script language="JavaScript" >
   		rdShowMessageDialog("此用户为已中奖用户，中奖奖品为：<%=awardName%> 请用户完好无损返回奖品，再继续办理冲正业务！");
		//location='f8032_login.jsp';
		history.go(-1);
	</script>
  
<%}


  /*sunzx add at 20070904  */
  sqlStr = "select res_info from wawarddata where flag = 'Y' and phone_no = '"+phoneNo+"'"+
		    " and login_accept="+backaccept  ;

  inParams[0] = "select res_info from wawarddata where flag = 'Y' and phone_no =:phoneNo and login_accept:backaccept";
  inParams[1] = "phoneNo="+phoneNo+",backaccept="+backaccept;	
  //retArray = callView.sPubSelect("1",sqlStr);
%>
	<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode2" retmsg="retMsg2" outnum="1">			
	<wtc:param value="<%=inParams[0]%>"/>	
	<wtc:param value="<%=inParams[1]%>"/>
	</wtc:service>	
	<wtc:array id="resultTemp2"  scope="end"/>
<%  		
  if(resultTemp2.length>0)
  {
	  result = resultTemp2;
	  awardName = result[0][0];	
	  
	  System.out.println("awardName2="+awardName);
	
	  if(!awardName.equals("")){
%>
		  <script language="JavaScript" >
		    rdShowMessageDialog("此用户已在促销品统一付奖中进行<%=awardName%>领奖，请进行促销品统一付奖冲正，并确保奖品完好");
			history.go(-1);
	      </script>
<%	  }
   }
	//sunzx add end
/***** 添加 20060605*******/
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

  //retList = impl.callFXService("s8033Init", paraAray1, "20","phone",phoneNo);
%>
	<wtc:service name="s8033Init" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode3" retmsg="retMsg3" outnum="31" >
	<wtc:param value="<%=paraAray1[0]%>"/>
    <wtc:param value="<%=paraAray1[1]%>"/>
	<wtc:param value="<%=paraAray1[2]%>"/>
	<wtc:param value="<%=paraAray1[3]%>"/>
	</wtc:service>
	<wtc:array id="tempArr" scope="end"/>
<%
  String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="",run_name="",vip="",posint="",prepay_fee="",sale_name="",sum_pay="",card_no="",card_num="",limit_pay="",use_point="",card_summoney="",mach="",machine_type="" ;
  //String[][] tempArr= new String[][]{};
  String errCode = retCode3;
  String errMsg = retMsg3;
  if(tempArr.length==0)
  {
	if(!retFlag.equals("1"))
	{
	   System.out.println("retFlag="+retFlag);
	   retFlag = "1";
	   retMsg = "s8033init查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }    
  }else if(!(tempArr.length==0))
  {
  System.out.println("errCode="+errCode);
  System.out.println("errMsg="+errMsg);
  if(!errCode.equals("000000")){%>
	<script language="JavaScript">
	<!--
  	rdShowMessageDialog("错误代码：<%=errCode%>错误信息：<%=errMsg%>");
  	 history.go(-1);
  	//-->
  	</script>
  <%
  	return;
  }
	
	    bp_name = tempArr[0][2];//机主姓名
	   
	    bp_add = tempArr[0][3];//客户地址
	 
	    cardId_type = tempArr[0][4];//证件类型
	 
	    cardId_no = tempArr[0][5];//证件号码
	 
	    sm_code = tempArr[0][6];//业务品牌
	 
	    region_name = tempArr[0][7];//归属地
	 
	    run_name = tempArr[0][8];//当前状态
	 
	    vip = tempArr[0][9];//ＶＩＰ级别
	 
	    posint = tempArr[0][10];//当前积分
	 
	    prepay_fee = tempArr[0][11];//可用预存
	 
	    sale_name = tempArr[0][12];//营销方案名
	 
	    sum_pay = tempArr[0][13];//应付金额
	 
	    card_no = tempArr[0][14];//卡金额串
	 
	    card_num = tempArr[0][15];//卡张数串
	 
	    limit_pay = tempArr[0][16];//预存话费
	 
	    use_point = tempArr[0][17];//销费积分数
	  
	    card_summoney = tempArr[0][18];//卡类总金额
	 
	    machine_type = tempArr[0][19];//机器类型
	 
		double mach_fee;
		double sum=0.00;
		double limit=0.00;
	
		sum=Double.parseDouble(sum_pay);
		limit=Double.parseDouble(limit_pay);
		mach_fee=sum-limit;
		/*mach =String.valueOf(mach_fee);*/
		DecimalFormat currencyFormatter = new DecimalFormat("0.00");
		currencyFormatter.format(mach_fee);
		System.out.println("mach_fee="+currencyFormatter.format(mach_fee));
		mach=currencyFormatter.format(mach_fee)+"";
		System.out.println("mach="+mach);
	}
 
%>
 
<% 
// **************得到冲正流水***************//
	String printAccept="";
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone" routerValue="<%=phoneNo%>"  id="seq"/>
<%
	printAccept = seq;
	System.out.println(printAccept);
%>

<html  xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>集团客户行业应用赠机</title>
<META content="no-cache" http-equiv="Pragma">
<META content="no-cache" http-equiv="Cache-Control">
<META content="0" 	     http-equiv="Expires" > 
<meta http-equiv="Content-Type" content="text/html; charset=gbk">

<script language="JavaScript">

<!--
 
  
  function frmCfm(){
  	getAfterPrompt();
 	frm.submit();
	return true;
  }
 //***
 function printCommit()
 { 
  //校验
  //if(!check(frm)) return false;
  
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
   var h=210;
   var w=400;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;

   var pType="subprint";                                      // 打印类型：print 打印 subprint 合并打印
   var billType="1";                                          //  票价类型：1电子免填单、2发票、3收据
   var sysAccept="<%=printAccept%>";                          // 流水号
   var printStr=printInfo(printType);                         //调用printinfo()返回的打印内容
   var mode_code=null;                                        //资费代码
   var fav_code=null;                                         //特服代码
   var area_code=null;                                        //小区代码
   var opCode="<%=opcode%>";                                  //操作代码
   var phoneNo=document.all.phone_no.value;                   //客户电话
       /* ningtn */
    var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
		var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
    /* ningtn */

   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
   var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm+"&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;
   path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
   var ret=window.showModalDialog(path,printStr,prop);
   return ret;
}

function printInfo(printType)
{
  	var cust_info=""; //客户信息
	var opr_info=""; //操作信息
	var note_info1=""; //备注1
	var note_info2=""; //备注2
	var note_info3=""; //备注3
	var note_info4=""; //备注4
    var retInfo = "";  //打印内容
	
	cust_info+="手机号码："+document.all.phone_no.value+"|";
	cust_info+="客户姓名："+document.all.cust_name.value+"|";
	cust_info+="客户地址："+document.all.cust_addr.value+"|";
	cust_info+="证件号码："+document.all.cardId_no.value+"|";
	
	opr_info+="业务类型：集团客户行业应用赠机--冲正"+"|";
  	opr_info+="业务流水："+document.all.login_accept.value+"|";
  	opr_info+="手机型号： "+"<%=machine_type%>"+"|";
  	opr_info+="退款合计："+document.all.sum_money.value+"元、含预存话费"+"<%=limit_pay%>"+"元"+"|";
  	
  	note_info1+="备注："+"|";
	
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
    return retInfo;	
}


//-->
</script>
</head>
<body>
<form name="frm" method="post" action="f8033Cfm.jsp" onload="init()">
<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
        <table cellspacing="0">
		  <tr> 
            <td class="blue">操作类型</td>
            <td colspan="3">集团客户行业应用赠机--冲正</td>
          </tr>
          <tr> 
            <td class="blue">客户姓名</td>
            <td>
			  <input name="cust_name" value="<%=bp_name%>" type="text" class="InputGrey" v_must=1 readonly id="cust_name" maxlength="20" v_name="姓名"> 
            </td>
            <td class="blue">客户地址</td>
            <td>
			  <input name="cust_addr" value="<%=bp_add%>" type="text" class="InputGrey" v_must=1 readonly id="cust_addr" maxlength="20" > 
            </td>
            </tr>
            <tr> 
            <td class="blue">证件类型</td>
            <td>
			  <input name="cardId_type" value="<%=cardId_type%>" type="text" class="InputGrey" v_must=1 readonly id="cardId_type" maxlength="20" > 
            </td>
            <td class="blue">证件号码</td>
            <td>
			  <input name="cardId_no" value="<%=cardId_no%>" type="text" class="InputGrey" v_must=1 readonly id="cardId_no" maxlength="20" > 
            </td>
            </tr>
            <tr> 
            <td class="blue">业务品牌</td>
            <td>
			  <input name="sm_code" value="<%=sm_code%>" type="text" class="InputGrey" v_must=1 readonly id="sm_code" maxlength="20" > 
            </td>
            <td class="blue">运行状态</td>
            <td>
			  <input name="run_type" value="<%=run_name%>" type="text" class="InputGrey" v_must=1 readonly id="run_type" maxlength="20" > 
            </td>
            </tr>
            <tr> 
            <td class="blue">VIP级别</td>
            <td>
			  <input name="vip" value="<%=vip%>" type="text" class="InputGrey" v_must=1 readonly id="vip" maxlength="20" > 
            </td>
            <td class="blue">可用预存</td>
            <td>
			  <input name="prepay_fee" value="<%=prepay_fee%>" type="text" class="InputGrey" v_must=1 readonly id="prepay_fee" maxlength="20" > 
            </td>
            </tr>
           <tr> 
            <td class="blue">营销方案</td>
            <td>
				<input name="sale_name" value="<%=sale_name%>" type="text" class="InputGrey" v_must=1 readonly id="sale_name" maxlength="20" size="40"> 
			</td>
			<td class="blue">应退金额</td>
            <td >
			  <input name="sum_money" type="text" class="InputGrey" id="sum_money" value="<%=sum_pay%>" readonly>
			</td>            
          </tr>
          <tr> 
            <td class="blue">购机款</td>
            <td >
			  <input name="price" type="text" class="InputGrey" id="price" value="<%=mach%>" readonly  >
			</td>
            <td class="blue">预存话费</td>
            <td>
			  <input name="limit_pay" type="text"  class="InputGrey" id="limit_pay" value="<%=limit_pay%>" readonly>
			</td>
          </tr>
          <tr> 
            <td class="blue">备注</td>
            <td colspan="3">
             <input name="opNote" type="text" class="InputGrey" id="opNote" size="60" maxlength="60" value="集团客户行业应用赠机--冲正" readOnly> 
            </td>
          </tr>

          <tr> 
<jsp:include page="/npage/public/hwReadCustCard.jsp">
	<jsp:param name="hwAccept" value="<%=printAccept%>"  />
	<jsp:param name="showBody" value="01"  />
</jsp:include>
            <td colspan="4" id="footer"> <div align="center"> 
                <input name="confirm" type="button" class="b_foot" index="2" value="确认&打印" onClick="printCommit()">
                <input name="reset" type="reset" class="b_foot" value="清除" >
                <input name="back" onClick="history.go(-1)" type="button" class="b_foot" value="返回">
                </div>
            </td>
          </tr>
        </table>
 
    <input type="hidden" name="phone_no" value="<%=phoneNo%>">
    <input type="hidden" name="work_no" value="<%=loginName%>">
	<input type="hidden" name="opcode" value="<%=opcode%>">
    <input type="hidden" name="login_accept" value="<%=printAccept%>">
	<input type="hidden" name="backaccept" value="<%=backaccept%>">
    <input type="hidden" name="card_dz" value="0" >
	<input type="hidden" name="sale_type" value="1" >
    <input type="hidden" name="used_point" value="0" >  
	<input type="hidden" name="point_money" value="0" > 
	<input type="hidden" name="machine_type" value="<%=machine_type%>" >
	<%@ include file="/npage/include/footer.jsp" %>   
</form>
</body>
</body>
<%@ include file="/npage/public/hwObject.jsp" %> 
</html>