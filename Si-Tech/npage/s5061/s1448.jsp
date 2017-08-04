   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-10
********************/
%>
              
<%
  String opCode = "1448";
  String opName = "邮寄帐单";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 
	



<%@ page language="java" import="java.sql.*" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.io.*"%>





<%
   String regionCode = (String)session.getAttribute("regCode");
	//String userPhoneNo=(String)session.getAttribute("userPhoneNo");
    String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String org_Code = (String)session.getAttribute("orgCode");

    String work_Pwd = (String)session.getAttribute("password");
	boolean workNoFlag=false;
  //if(workNoFromSession.substring(0,1).equals("k"))
    workNoFlag=true;
    
    String[][] temfavStr=(String[][])session.getAttribute("favInfo");
    String[] favStr=new String[temfavStr.length];
    for(int i=0;i<favStr.length;i++)
     favStr[i]=temfavStr[i][0].trim();
    boolean pwrf=false;
    boolean hfrf=false;
	for(int j=0;j<favStr.length;j++)
		System.out.println("======= favStr ======="+favStr[j]+"==============");
    if(WtcUtil.haveStr(favStr,"a272")){
		
	  pwrf=true;
	  System.out.println("===== pwrf ====" + pwrf);
	}
	//ArrayList initArr = new ArrayList();
        //ArrayList groupArr = new ArrayList();

	String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));

	String dirtPage=request.getParameter("dirtPage");



//----------------------------------------------------------
  
%>



<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="paraStr" /> 
	
	
<%
  request.setCharacterEncoding("GBK");

  HashMap hm=new HashMap();
  hm.put("1","没有客户ID！");
  hm.put("3","密码错误！");
  hm.put("4","手续费不确定，您不能进行任何操作！");
  
  hm.put("2","未取到数据1，请核查数据或咨询系统管理员！");
  hm.put("10","未取到数据2，请核查数据或咨询系统管理员！");
  hm.put("11","未取到数据3，请核查数据或咨询系统管理员！");
  hm.put("12","未取到数据4，请核查数据或咨询系统管理员！");
  hm.put("13","未取到数据5，请核查数据或咨询系统管理员！");
  hm.put("14","未取到数据6，请核查数据或咨询系统管理员！");
  String op_name="";
  String op_code = request.getParameter("op_code");
  //System.out.println("op_code === "+ op_code );
  //op_code="1250";
 
  if(op_code.equals("1220"))
    op_name="换卡变更";
  else if(op_code.equals("1217"))
    op_name="预销恢复";
  else if(op_code.equals("1260"))
    op_name="预拆恢复";
  else if(op_code.equals("2419"))
    op_name="积分转赠业务受理";
  else if(op_code.equals("1296"))
    op_name="动感地带积分转赠";
  else if(op_code.equals("1250"))
    op_name="积分兑奖";
  else if(op_code.equals("1221"))
    op_name="换卡冲正";
  else if(op_code.equals("1353"))
    op_name="工单补打";
  else if(op_code.equals("1290"))
    op_name="身份证挂失";
  else if(op_code.equals("1291"))
    op_name="手机证券申请";
  else if(op_code.equals("1295"))
    op_name="手续费";
  else if(op_code.equals("1299"))
    op_name="动感地带M值兑换";
  else if(op_code.equals("2420"))
    op_name="积分转赠业务冲正";
  else if(op_code.equals("2421"))
    op_name="改号通知业务";
  else if(op_code.equals("1442"))
    op_name="SIM卡营销";
  else if(op_code.equals("1445"))
    op_name="全球通签约计划";
  else if(op_code.equals("1448"))
    op_name="邮寄帐单";
  else if(op_code.equals("7114"))
    op_name="详单查询短信提醒";
  else if(op_code.equals("1458"))
    op_name="信息收集";
  else if(op_code.equals("1469"))
    op_name="全网sp业务退费";
  else if(op_code.equals("7115"))
    op_name="商务电话免费换机";
  else if(op_code.equals("2299"))
    op_name="二代身份证读卡器设置";
  else if(op_code.equals("1499"))
    op_name="数据业务付奖类型维护";
  else if(op_code.equals("1451"))
    op_name="电子帐单受理";
  else if(op_code.equals("1452"))
    op_name="二代身份证";
  else if(op_code.equals("5036"))
    op_name="客服系统套餐配制";
  else if(op_code.equals("5037"))
    op_name="卡类费用查询";
  else if(op_code.equals("1577"))
    op_name="彩信核检话单查询";
  else if(op_code.equals("1446"))
    op_name="改号通知";
  else if(op_code.equals("1440"))
    op_name="新业务兑奖";
  else if(op_code.equals("5118"))
    op_name="数据业务付奖";
  else if(op_code.equals("1449"))
    op_name="全球通签约计划冲正";
  else if(op_code.equals("1450"))
    op_name="积分兑换冲正";
  else if(op_code.equals("1443"))
    op_name="四季有礼";
  else if(op_code.equals("2267"))
    op_name="手机用户实名预登记查询/确认";
  else if(op_code.equals("2266"))
    op_name="促销品统一付奖";
  else if(op_code.equals("2849"))
    op_name="垃圾短信集团反馈结果信息查询";
  else if(op_code.equals("5303"))
    op_name="工号登陆短信提醒配置";
  else if(op_code.equals("5309"))
    op_name="工号登陆短信提醒配置历史查询";
%>

<html>
<head>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>



<title><%=op_name%></title>

<script language=javascript>
<!--
  onload=function()
  {
    	self.status="";
  }
 
function simChk()
{
	if((document.all.phoneno.value).trim().length<1)
	{
      rdShowMessageDialog("手机号码不能为空！",0);
 	  return;
	} 	
	//begin huangrong add 判断邮寄账单业务仅对全球通客户开放 2011-2-24
	if(document.all.r_cus[0].checked || document.all.r_cus[1].checked ||document.all.r_cus[3].checked)
	{
		if("<%=op_code%>"=="1448")
		{
			var myPacket1 = new AJAXPacket("getSmCode.jsp","正在查询客户手机品牌，请稍候......");
			myPacket1.data.add("phoneNo",(document.all.phoneno.value).trim());
			core.ajax.sendPacket(myPacket1,doGetSmCode);
    	myPacket1 = null;
    }
    var flag=document.getElementById("flag");
    if(flag.value=="1")
    {
    	return;
    }
  }
  
			
	//end huangrong add 判断邮寄账单业务仅对全球通客户开放 2011-2-24
	
  
  var myPacket = new AJAXPacket("postSim.jsp","正在查询客户，请稍候......");
	myPacket.data.add("phoneNo",(document.all.phoneno.value).trim());
	myPacket.data.add("pssword",(document.all.cus_pass.value).trim());
	myPacket.data.add("opCode",(document.all.op_code.value).trim());
	myPacket.data.add("postFlag",(document.all.postFlag.value).trim());
	for(var i = 0 ; i < document.all.r_cus.length ; i ++){
		if(document.all.r_cus[i].checked)
		{
			var value = document.all.r_cus[i].value;
			myPacket.data.add("r_cus",(value).trim());
		}
	}
	core.ajax.sendPacket(myPacket);
	myPacket = null;
}

function doGetSmCode(packet)
{
	  		var smCode=packet.data.findValueByName("smCode");  

				if(smCode!="gn")
				{
		    	rdShowMessageDialog("该用户非全球通用户，不能办理邮寄帐单业务！");	
		    	var flag=document.getElementById("flag");
		    	flag.value="1";
		    	return;
				}
		
}

 //--------4---------doProcess函数----------------
function doProcess(packet)
{
    var vRetPage=packet.data.findValueByName("rpc_page");  
	  
    var retCode = packet.data.findValueByName("retCode");
    var retMsg = packet.data.findValueByName("retMsg");
    
	var post_address = packet.data.findValueByName("post_address");
	var post_zip = packet.data.findValueByName("post_zip");
	var fax_no = packet.data.findValueByName("fax_no");
	var mail_address = packet.data.findValueByName("mail_address");
	var post_name = packet.data.findValueByName("post_name");
	var cust_name = packet.data.findValueByName("cust_name");
	var id_iccid = packet.data.findValueByName("id_iccid");
	var id_address = packet.data.findValueByName("id_address");
	var sm_name = packet.data.findValueByName("sm_name");
//	alert(retCode+retMsg);
	if(retCode == "000000"){
	
		document.all.post_address.value = post_address;
		document.all.post_zip.value = post_zip;
		if(fax_no=="000000")
		{
			document.all.fax_no.value="";
		}else{
		  document.all.fax_no.value = fax_no;
		}
		document.all.mail_address.value = mail_address;
		document.all.post_name.value = post_name;
		document.all.cust_name.value = cust_name;
		document.all.id_iccid.value = id_iccid;
		document.all.id_address.value = id_address;
		document.all.sm_name.value = sm_name;
		document.all.confirm.disabled=false;
		
	}else
	{
		rdShowMessageDialog("错误:"+ retCode + "->" + retMsg,0);
		return;
	}    
    
}

//-------2---------验证及提交函数-----------------

function printCommit(){
	getAfterPrompt();
   if( document.all.r_cus[3].checked)
   {
   	rdShowMessageDialog("查询不能确认提交",0);
		return;
   }
	//校验
    if(!checkElement(document.s1448.phoneno)) return false;	
	if(!check(s1448)) return false;
   //打印工单并提交表单
   document.all.t_sys_remark.value="用户"  + document.all.phoneno.value + "邮寄帐单";
    var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");

     if((ret=="confirm"))
      {
        if(rdShowConfirmDialog('确认电子免填单吗？')==1)
        {  
	      　s1448.submit();
        }


	    if(ret=="remark")
	    {
         if(rdShowConfirmDialog('确认要提交信息吗？')==1)
         {
	       s1448.submit();
         }
	   }
	}
    else
    {
       if(rdShowConfirmDialog('确认要提交信息吗？')==1)
       {
	     s1448.submit();
       }
    }	
    return true;
  }
  function showPrtDlg(printType,DlgMessage,submitCfm)
  {  //显示打印对话框 
     var h=150;
     var w=350;
     var t=screen.availHeight/2-h/2;
     var l=screen.availWidth/2-w/2;
   
     var printStr = printInfo(printType);
   
     var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
     
     var pType="subprint";                     // 打印类型print 打印 subprint 合并打印
     var billType="1";                      //  票价类型1电子免填单、2发票、3收据
     var sysAccept =<%=paraStr%>;                       // 流水号
     var printStr = printInfo(printType);   //调用printinfo()返回的打印内容
     var mode_code=null;                        //资费代码
     var fav_code=null;                         //特服代码
     var area_code=null;                        //小区代码
     var opCode =   "<%=opCode%>";                         //操作代码
     var phoneNo = document.all.phoneno.value;                            //客户电话
     var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
	 var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	 var ret=window.showModalDialog(path,printStr,prop);   
		
		
  }

  function printInfo(printType)
  {
   	var retInfo = "";
		var note_info1 = "";
		var note_info2 = "";
		var note_info3 = "";
		var note_info4 = "";
		var opr_info = "";
		var cust_info = "";
		

    cust_info+="客户姓名："+document.all.cust_name.value+"|";
    cust_info+="手机号码："+document.all.phoneno.value+"|";  
	  cust_info+="客户地址："+document.all.id_address.value+"|";
    cust_info+="证件号码："+document.all.id_iccid.value+"|";
	if(document.all.postFlag.value == "0")
	{
		opr_info+="邮寄方式： 邮寄"+"|";
	}else if (document.all.postFlag.value == "0")
	{
		opr_info+="邮寄方式： 传真"+"|";
	}
	else
	{
		opr_info+="邮寄方式： 电子邮件"+"|";
	}
    opr_info+="用户品牌："+document.all.sm_name.value+"|";
    if(document.all.r_cus[0].checked)
	{
      opr_info+="办理业务："+"申请"+"|";
	}
	if(document.all.r_cus[1].checked)
	{
      opr_info+="办理业务："+"修改"+"|";
	}
	if(document.all.r_cus[2].checked)
	{
      opr_info+="办理业务："+"删除"+"|";
	}
	if(document.all.r_cus[3].checked)
	{
      opr_info+="办理业务："+"查询"+"|";
	}
		opr_info+="操作流水："+document.all.loginAccept.value+"|";
    opr_info+="邮编："+document.all.post_zip.value+"|";
    opr_info+="邮寄地址："+document.all.post_address.value+"|";
    
    note_info1+="备注："+document.all.t_sys_remark.value+"|";
    note_info2+="备注："+document.all.t_op_remark.value+" "+document.all.simBell.value+"|";
      
  	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //把“#"替换为url格式

    return retInfo;
  }

 //-->
</script>

<%@ include file="/npage/common/pwd_comm.jsp" %>
<%
//String prtSql="select to_char(sMaxSysAccept.nextval) from dual";

%>



</head>
<script language=javascript>
function showWorldMsg()
{
		
     if( document.all.r_cus[0].checked){}
}
</script>
<body  onMouseDown="hideEvent()" onKeyDown="hideEvent()">
<form action="1448BackCfm.jsp" method="POST" name="s1448"  onKeyUp="chgFocus(s1448)">
	<%@ include file="/npage/include/header.jsp" %>


	<div class="title">
		<div id="title_zi">邮寄帐单</div>
	</div>
	<input type="hidden" name="op_code" id="op_code" value="<%=op_code%>">
	<input type="hidden" name="ReqPageName" id="ReqPageName" value="s1210Login">
	<input type="hidden" name="id_iccid"  value="">
	<input type="hidden" name="id_address"  value="">
	<input type="hidden" name="sm_name"  value="">
	<input type="hidden" name="flag" id="flag" value="">
	
	<input type="hidden" name="loginAccept" value="<%=paraStr%>">
	<%@ include file="../../include/remark.htm" %>
        <table cellspacing="0" >
          <tr> 
            <td class="blue" nowrap height=10>操作类型</td>
            <td class="blue" nowrap colspan="3" height=10>
            <input type="radio" name="r_cus" index="0" value="0" checked class="blue">登记
  					<input type="radio" name="r_cus"  index="1" value="1" class="blue">修改
  					<input type="radio" name="r_cus" index= "2" value="2" class="blue">删除
  					<input type="radio" name="r_cus" index="3" value="-1" class="blue">查询
            </td>
          </tr>
          <tr> 
            <td nowrap width="16%" class="blue">用户号码</td>
            <td nowrap> 
  <%
  		String ph_no=request.getParameter("ph_no");
  %>          	
              <input   type="text" name="phoneno" v_name="用户号码" v_must=1  v_type="mobphone" onBlur="if(this.value!=''){if(checkElement('phoneno')==false){return false;}}" maxlength=11  index="6" value =<%=activePhone!=null?activePhone:ph_no%>  Class="InputGrey" readOnly >              
            </td>
            <td class="blue">用户密码</td>
          	<td>
          	<jsp:include page="/npage/common/pwd_one.jsp">
							      <jsp:param name="width1" value="16%"  />
							      <jsp:param name="width2" value="34%"  />
							      <jsp:param name="pname" value="cus_pass"  />
							      <jsp:param name="pwd" value="12345"  />
	 	  			</jsp:include>
            <input  type="button" name="qryId_No" value="查询" onClick="simChk()" class="b_text">
            </td>
          </tr>
          <tr> 
            <td nowrap width="16%" class="blue">用户名称</td>
            <td  nowrap width="28%"> 
              <div align="left"> 
                <input name="cust_name" type="text"   v_name="用户名称" index="6" >
            </td>
            <td  nowrap width="16%" class="blue">邮寄方式</td>
            <td  nowrap width="40%"> 
             <select name="postFlag"  index="15">
		 						<option value="1" selected >邮寄</option>
               <!-- <option value="2">电子邮件</option>
                <option value="3">传真</option>
                -->
                </select>
            </td>
          </tr>
          <tr> 
            <td nowrap width="16%" class="blue">邮政编码</td>
            <td  nowrap width="28%"> 
              <input type="text"  name="post_zip"  v_minlength=0 v_maxlength=10  v_type=zip  v_name="邮政编码" maxlength=10 value="" tabindex="0">
            </td>
            <td  nowrap width="16%" class="blue">通信地址</td>
            <td  nowrap width="40%"> 
             <input type="text"  name="post_address" maxlength=60 v_must=0 v_minlength=0 v_type=string v_name = "通信地址" value="" tabindex="0">
            </td>
          </tr>
          <tr> 
            <td nowrap height=10 class="blue">收信人名</td>
             <td nowrap colspan="3" height=10>
              <input  type="test" name="post_name" v_must=0 v_name="收信人名"  v_type=string v_minlength=0 value="">
             </td>
          </tr>
          <tr> 
            <td nowrap width="16%" class="blue">E_mail址</td>
            <td  nowrap  width="28%"> 
              <input  type="text" name="mail_address" value="" >
            </td>
            <td  nowrap width="16%" class="blue">传    真</td>
            <td  nowrap width="40%"> 
            <input  type="text" name="fax_no"  v_must=0 v_maxlength=30 v_minlength=0 v_type=phone v_name="传真" value="" tabindex="0">
            </td>
          </tr>
          
          <tr bgcolor="eeeeee"> 
            <td valign="top"> 
              <div align="left" class="blue">备注</div>
            </td>
            <td colspan="4" valign="top"> 
            	
              <input type="text"  name="t_sys_remark" id="t_sys_remark" size="60" readonly maxlength=30  Class="InputGrey">
            </td>
          <tr bgcolor="e8e8e8"> 
            <td colspan="4" height="30" id="footer"> 
              <div align="center"> 
                <input  type="button" name="confirm" id="comSubmit" value="打印&确认"  onClick="printCommit()" index="26" disabled class="b_foot_long">
                <input  type=reset name=back value="清除" onClick="document.all.confirm.disabled=true;"  class="b_foot">
                <input  type="button" name="b_back" value="返回"  onClick="removeCurrentTab()" index="28" class="b_foot">
              </div>
            </td>
          </tr>
        </table>

  <%@ include file="/npage/include/footer.jsp" %>
  <input type="hidden"  name="t_op_remark" id="t_op_remark" size="60" v_maxlength=60  v_type=string  v_name="用户备注" index="28" maxlength=60> 
</form>
</body>


</html>
