   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-24
********************/
%>
              
<%
  String opCode = "2294";
  String opName = "集团客户预存送礼";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
%>

<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>


<%		
 
  String loginNo = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName"); 
  String regionCode = (String)session.getAttribute("regCode");


  
%>
<%
String retFlag="",retMsg="";
  String[] paraAray1 = new String[4];
  String phoneNo = request.getParameter("srv_no");
  String opcode = request.getParameter("opcode");
  String oldaccept=request.getParameter("backaccept");
  String passwordFromSer="";
  String dept=request.getParameter("dept");
 
 
  paraAray1[0] = phoneNo;		/* 手机号码   */ 
  paraAray1[1] = opcode; 	    /* 操作代码   */
  paraAray1[2] = loginNo;	    /* 操作工号   */
  paraAray1[3] = oldaccept;

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

  //retList = impl.callFXService("s2295Init", paraAray1, "30","phone",phoneNo);
  %>
  
     <wtc:service name="s2295Init" outnum="30" retmsg="msg" retcode="code" routerKey="phone" routerValue="<%=phoneNo%>">
			<wtc:param value="<%=paraAray1[0]%>" />
			<wtc:param value="<%=paraAray1[1]%>" />	
			<wtc:param value="<%=paraAray1[2]%>" />	
			<wtc:param value="<%=paraAray1[3]%>" />	
		</wtc:service>
		<wtc:array id="result_t" scope="end"  /> 
  
  <%
  String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="",run_name="",vip="",posint="",prepay_fee="",
  vUnitId="",vUnitName="",vUnitAddr="",vUnitZip="",vServiceNo="",vServiceName="",vContactPhone="",vContactPost="";
  String zhanbi_name="",product_name="",phone_type="",sale_name="",imei_no="",cash_pay="",prepay_money="";
  String[][] tempArr= new String[][]{};
  String errCode = code;
  String errMsg = msg;
  System.out.println("pppppppppppppppppppppp1111111111111111");
  if(result_t == null)
  {
	if(!retFlag.equals("1"))
	{
		System.out.println("retFlag="+retFlag);
	   retFlag = "1";
	   retMsg = "s8041Init查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }    
  }else if(!(result_t == null))
  {System.out.println("errCode="+errCode);
  System.out.println("errMsg="+errMsg);
  if(!errCode.equals("000000")){%>
<script language="JavaScript">
<!--
  	rdShowMessageDialog("错误代码<%=errCode%>错误信息<%=errMsg%>",0);
  	 history.go(-1);
  	//-->
  </script>
  <%}
	if (errCode.equals("000000")){

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
	    sale_name = result_t[0][12];//营销方案
	    cash_pay = result_t[0][13];//营销方案
	    prepay_money = result_t[0][16];//营销方案
	    phone_type = result_t[0][19];//手机品牌
	    vUnitId = result_t[0][20];//集团ID
	    vUnitName = result_t[0][21];//集团名称
	    vUnitAddr = result_t[0][22];//单位地址
	    vUnitZip = result_t[0][23];//单位邮编
	    vServiceName = result_t[0][25];//集团工号名称
	    vContactPhone = result_t[0][26];//联系电话
	    vContactPost = result_t[0][27];//个人邮编
	    zhanbi_name = result_t[0][28];//集团类别
	    product_name = result_t[0][29];//集团产品
	  
	} 
  }

%>
 <%  //优惠信息//********************得到营业员权限，核对密码，并设置优惠权限*****************************//   

   boolean pwrf = false;//a272 密码免验证
   String handFee_Favourable = "readonly";        //a230  手续费
   
	  //2011/9/2  diling 添加 对密码权限整改 start
	  	String pubOpCode = opcode;
	  %>
	  	<%@ include file="/npage/public/pubCheckPwdPower.jsp" %>
	  <%
	  	System.out.println("==第二批======f2295_1.jsp==== pwrf = " + pwrf);
	  //2011/9/2  diling 添加 对密码权限整改 end
	  
  String passTrans=WtcUtil.repNull(request.getParameter("cus_pass")); 
  if(!pwrf)
  {
     String passFromPage=Encrypt.encrypt(passTrans);
     if(0==Encrypt.checkpwd2(passwordFromSer.trim(),passFromPage))	{
	   if(!retFlag.equals("1"))
	   {
	      retFlag = "1";
          retMsg = "密码错误!";
	   }
	    
    }       
  }
 %>
<%
//******************得到下拉框数据***************************//
String printAccept="";
printAccept = getMaxAccept();
System.out.println(printAccept);
String exeDate="";
exeDate = getExeDate("1","1141");

 
 
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>集团客户购机有礼</title>
<META content="no-cache" http-equiv="Pragma">
<META content="no-cache" http-equiv="Cache-Control">
<META content="0" 	     http-equiv="Expires" > 
<meta http-equiv="Content-Type" content="text/html; charset=GBK">

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
		
		ret_code =  parseInt(errorCode);
		//alert("111111111111111111111111" +errorCode ); 
		//alert("111111111111111111111111" +errorMsg ); 
		//alert("111111111111111111111111----------"            +   verifyType ); 
		//	alert("111111111111111111111111" +backArrMsg );
		
		if(retType=="getcard"){
			if( ret_code == 0 ){
				  tmpObj = "sale_code" 
				  document.all(tmpObj).options.length=0;
				  document.all(tmpObj).options.length=backArrMsg.length;	
		        for(i=0;i<backArrMsg.length;i++)
			    {
				    document.all(tmpObj).options[i].text=backArrMsg[i][1];
				    document.all(tmpObj).options[i].value=backArrMsg[i][0];
		 	        document.all(tmpObj).options[i].nv2=backArrMsg[i][2];
			        document.all(tmpObj).options[i].nv3=backArrMsg[i][3];
			       
			
			    }
			}else{
				rdShowMessageDialog("取信息错误:"+errorMsg+"!",0);
				return;			
			}
			change();
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
					document.frm.IMEINo.readonly=true;
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
		//var i=price.value;
		//var j=pay_money.value;
		sum_money.value=price.value;
	}
}

 </script>
<script language="JavaScript">

<!--
  //定义应用全局的变量
  var SUCC_CODE	= "0";   		//自己应用程序定义
  var ERROR_CODE  = "1";			//自己应用程序定义
  var YE_SUCC_CODE = "0000";		//根据营业系统定义而修改


  


 
<%  
 
%>
 function frmCfm(){
 	frm.submit();
	return true;
  }
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
   var h=180;
   var w=350;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   
   var printStr = printInfo(printType);
    var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
     var pType="subprint";                     // 打印类型print 打印 subprint 合并打印
     var billType="1";                      //  票价类型1电子免填单、2发票、3收据
     var sysAccept =document.frm.login_accept.value                       // 流水号
     var printStr = printInfo(printType);   //调用printinfo()返回的打印内容
     var mode_code=null;                        //资费代码
     var fav_code=null;                         //特服代码
     var area_code=null;                        //小区代码
     var opCode =   "<%=opCode%>";                         //操作代码
     var phoneNo = "<%=phoneNo%>";                            //客户电话
	var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
	var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" 
	+$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm +"&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;

		var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);   
		
   return ret;    
}

function printInfo(printType)
{
  vUnitId="",vUnitName="",vUnitAddr="",vUnitZip="",vServiceNo="",vServiceName="",vContactPhone="",vContactPost="";
	
  
	   	var retInfo = "";
		var note_info1 = "";
		var note_info2 = "";
		var note_info3 = "";
		var note_info4 = "";
		var opr_info = "";
		var cust_info = "";
		
	cust_info+="手机号码："+document.all.phone_no.value+"|";
	cust_info+="客户姓名："+document.all.cust_name.value+"|";
	cust_info+="客户地址："+document.all.cust_addr.value+"|";
	cust_info+="证件号码："+'<%=cardId_no%>'+"|";
	
	
	opr_info+="单位地址："+'<%=vUnitAddr%>'+"|";
	opr_info+="联系电话："+'<%=vContactPhone%>'+"|";
	opr_info+="集团ID："+'<%=vUnitId%>'+"|";
	opr_info+="集团名称："+'<%=vUnitName%>'+"|";
	opr_info+="业务种类集团客户预存送礼冲正："+"|";
	opr_info+="客户预存款："+parseInt(document.all.prepay_money.value)+"元"+"|";
  opr_info+="赠送礼品："+document.all.gift_name.value+"|";
	opr_info+="业务流水："+document.all.login_accept.value+"|";

		note_info1+="备注：|";
	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //把“#"替换为url格式
    return retInfo;
}
//-->
</script>
</head>
<body>
<form name="frm" method="post" action="f2295_2.jsp" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>                         


	<div class="title">
		<div id="title_zi">集团客户购机有礼</div>
	</div>
 
        <table cellspacing="0">
		  <tr> 
            <td class="blue">操作类型</td>
            <td class="blue">集团客户购机有礼--冲正</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>        
		  <tr> 
            <td class="blue">集团ID</td>
            <td>
			  <input name="vUnitId" value="<%=vUnitId%>" type="text"  v_must=1 readonly class="InputGrey" id="vUnitId" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            <td class="blue">集团名称</td>
            <td>
			  <input name="vUnitName" value="<%=vUnitName%>" type="text"  v_must=1 readonly  class="InputGrey" id="vUnitName" maxlength="60" > 
			  <font class="orange">*</font>
            </td>
            </tr>

			
		  
		  
		  <tr> 
            <td class="blue">客户姓名</td>
            <td>
			  <input name="cust_name" value="<%=bp_name%>" type="text"  v_must=1 readonly  class="InputGrey" id="cust_name" maxlength="20" v_name="姓名"> 
			  <font class="orange">*</font>
            </td>
            <td class="blue">客户地址</td>
            <td>
			  <input name="cust_addr" value="<%=bp_add%>" type="text"  v_must=1 readonly  class="InputGrey" id="cust_addr" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            </tr>
            <tr> 
            <td class="blue">证件类型</td>
            <td>
			  <input name="cardId_type" value="<%=cardId_type%>" type="text"  v_must=1 readonly  class="InputGrey" id="cardId_type" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            <td class="blue">证件号码</td>
            <td>
			  <input name="cardId_no" value="<%=cardId_no%>" type="text"  v_must=1 readonly  class="InputGrey" id="cardId_no" maxlength="20" > 
			  <font class="orange">*</font>
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
			  <input name="run_type" value="<%=run_name%>" type="text"  v_must=1 readonly  class="InputGrey" id="run_type" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            </tr>
            <tr> 
            <td class="blue">VIP级别</td>
            <td>
			  <input name="vip" value="<%=vip%>" type="text"  v_must=1 readonly  class="InputGrey" id="vip" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            <td class="blue">可用预存</td>
            <td>
			  <input name="prepay_fee" value="<%=prepay_fee%>" type="text"  v_must=1 readonly  class="InputGrey" id="prepay_fee" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            </tr>
            
            <tr> 
            <td class="blue">集团归类</td>
            <td>
			  <input name="group_type" value="<%=zhanbi_name%>" type="text"  v_must=1 readonly  class="InputGrey" id="group_type" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
           <td>&nbsp;</td>
           <td>&nbsp;</td>
            </tr>
			
			
			
			
			<tr> 
            <td class="blue">赠送礼品</td>
            <td>
			<input type="text" readonly  class="InputGrey" name="gift_name"   value="<%=sale_name%>">
			    
			  <font class="orange">*</font>	
			</td>
	 <td class="blue">应交预存</td>
            <td>
			  <input type="text" readonly  class="InputGrey" name="prepay_money" id="prepay_money" v_must=1 v_name="应交预存"  value="<%=prepay_money%>">	
			  	  
              </select>
			  <font class="orange">*</font>
			</td>
          </tr>
          
         
		 
		  <tr> 
            <td height="32"   class="blue">备注</td>
            <td colspan="3" height="32">
             <input name="opNote" type="text"   readonly  class="InputGrey" id="opNote" size="60" maxlength="60" value="集团客户预存送礼冲正" > 
            </td>
          </tr>
          </table>
          <jsp:include page="/npage/public/hwReadCustCard.jsp">
	<jsp:param name="hwAccept" value="<%=printAccept%>"  />
	<jsp:param name="showBody" value="01"  />
</jsp:include>

          <table>
          <tr> 
            <td colspan="4" id="footer"> <div align="center"> 
                <input name="confirm" type="button" class="b_foot_long" index="2" value="确认&打印" onClick="printCommit()">
                &nbsp; 
                <input name="reset" type="reset"  value="清除" class="b_foot">
                &nbsp; 
                <input name="back" onClick="history.go(-1);" type="button" class="b_foot" value="返回">
                &nbsp; </div></td>
          </tr>
        </table>
 
    <input type="hidden" name="phone_no" value="<%=phoneNo%>">
    <input type="hidden" name="work_no" value="<%=loginName%>">
		<input type="hidden" name="opcode" value="<%=opcode%>">
    <input type="hidden" name="login_accept" value="<%=printAccept%>">
    <input type="hidden" name="card_dz" value="0" >
		<input type="hidden" name="sale_type" value="9" >
    <input type="hidden" name="used_point" value="0" >  
		<input type="hidden" name="point_money" value="0" > 
	
	<input type="hidden" name="oldaccept" value="<%=oldaccept%>">
	<%@ include file="/npage/include/footer.jsp" %>
	<%@ include file="/npage/public/hwObject.jsp" %> 

</form>
</body>
</html>
