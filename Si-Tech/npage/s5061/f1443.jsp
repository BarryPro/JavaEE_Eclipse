   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-10
********************/
%>
              
<%
  String opCode = "1443";
  String opName = "四季有礼";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page language="java" import="java.sql.*" %>
<%@ page contentType="text/html;charset=gbk"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.io.*"%>

<%
    String phone_no = (String)request.getParameter("activePhone");
    String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String org_Code = (String)session.getAttribute("orgCode");
    String work_Pwd = (String)session.getAttribute("password");
	String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));
	String dirtPage=request.getParameter("dirtPage");

  request.setCharacterEncoding("GBK");
%>

<%@ include file="/npage/common/pwd_comm.jsp" %>
<%
	//String prtSql="select to_char(sMaxSysAccept.nextval) from dual";
	//paraStr[0]=(((String[][])co1.fillSelect(prtSql))[0][0]).trim();
	String regionCode = (String)session.getAttribute("regCode");
%>

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" routerValue="<%=regionCode%>"  id="paraStr1" /> 

<%	
	String paraStr= paraStr1;
	System.out.println("11111111111" +paraStr);
	String sqlStr="";
	int recordNum=0;
    int i=0;
    String[][] result = new String[][]{};
%>


<%
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
	if((document.all.phoneno.value).trim().length<1){
  		rdShowMessageDialog("手机号码不能为空！");
 	  	return;
	} 
  	var myPacket = new AJAXPacket("post1443.jsp","正在查询客户，请稍候......");
	myPacket.data.add("phoneNo",(document.all.phoneno.value).trim());
	myPacket.data.add("opCode",(document.all.op_code.value).trim());
	myPacket.data.add("mode_type",(document.all.mode_type.value).trim());
	core.ajax.sendPacket(myPacket);
	myPacket = null;
}

 //--------4---------doProcess函数----------------
function doProcess(packet)
{
 	var vRetPage=packet.data.findValueByName("rpc_page");  
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	var cust_name = packet.data.findValueByName("cust_name");
	var user_name = packet.data.findValueByName("user_name");
	var address = packet.data.findValueByName("address");
	var id_iccid = packet.data.findValueByName("id_iccid");
	if(retCode == 0){
		document.all.phoneno.value = cust_name;
		document.all.user_name.value = user_name;
		document.all.address.value = address;
		document.all.id_iccid.value = id_iccid;
		document.all.confirm.disabled=false;
	}else{
		rdShowMessageDialog("错误:"+ retCode + "->" + retMsg);
		return;
	}   
    
}

//-------2---------验证及提交函数-----------------

function printCommit()
{
	getAfterPrompt();
	//校验
	
  	if(!checkElement(document.f1443.phoneno)) return false;
  
	if(!check(f1443)) return false;
	
   //打印工单并提交表单
	document.all.t_sys_remark.value="用户"  + document.all.phoneno.value +":"+document.all.tranType[document.all.tranType.selectedIndex].value+"受理";
  	var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");

  	if((ret=="confirm")){
  		if(rdShowConfirmDialog('确认电子免填单吗？')==1){  
	  	f1443.submit();
    }
		
	if(ret=="remark"){
    	if(rdShowConfirmDialog('确认要提交信息吗？')==1){
	       　f1443.submit();
         }
	   }
	}
    else
    {
       if(rdShowConfirmDialog('确认要提交信息吗？')==1)
       {
	     　f1443.submit();
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
     var sysAccept =<%=paraStr%>;                       // 流水号
     var printStr = printInfo(printType);   //调用printinfo()返回的打印内容
     var mode_code=null;                        //资费代码
     var fav_code=null;                         //特服代码
     var area_code=null;                        //小区代码
     var opCode =   "<%=opCode%>";                         //操作代码
     var phoneNo = <%=activePhone%>;                            //客户电话
     
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
		
		
    cust_info+="手机号码："+document.all.phoneno.value+"|";  
    cust_info+="客户姓名："+document.all.user_name.value+"|";  
    cust_info+="客户地址："+document.all.address.value+"|";  
    cust_info+="证件号码："+document.all.id_iccid.value+"|";  
    
    opr_info+="业务类型："+"四季有礼"+"|";  
    opr_info+="业务流水："+document.all.loginAccept.value+"|";  
    
	note_info1+="备注："+"|";
	
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //把“#"替换为url格式

    return retInfo;
  }

 //-->
</script>


</head>
<body onMouseDown="hideEvent()" onKeyDown="hideEvent()">
<form action="f1443BackCfm.jsp" method="POST" name="f1443"  onKeyUp="chgFocus(f1443)">
	<%@ include file="/npage/include/header.jsp" %>
	<input type="hidden" name="op_code" id="op_code" value="<%=op_code%>">
	<input type="hidden" name="ReqPageName" id="ReqPageName" value="s1210Login">
	<input type="hidden" name="loginAccept" value="<%=paraStr%>">
	<input type="hidden" name="user_name" value="">
	<input type="hidden" name="address" value="">
	<input type="hidden" name="id_iccid" value="">
	<%@ include file="../../include/remark.htm" %>
	
	<div class="title">
		<div id="title_zi">四季有礼</div>
	</div>
        <table cellspacing="0">
        	<TR>
                 <TD class="blue" >业务类型&nbsp;</td>
                 <td colspan="3">
                 	<select id=tranType name=tranType onChange="onTranType()" >
<%      
				  sqlStr ="select op_code,op_type,op_type||'-->'||op_name,note from sGiftType where op_code='1443'";
%>
			
					<wtc:pubselect name="sPubSelect" outnum="4" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
			  	 <wtc:sql><%=sqlStr%></wtc:sql>
			 	  </wtc:pubselect>
				 <wtc:array id="result_t1" scope="end"/>
<%                      
                      result = result_t1;
                      recordNum = result.length;
                      System.out.println("recordNum"+recordNum);
		
                  for(i=0;i<recordNum;i++)
                  {
                    System.out.println("result[i][0]="+result[i][0]);
                    out.println("<option class='button' value='" + result[i][1] + "'>" + result[i][2] + "</option>");
                  }
%>
                    </select>             
     				</td>
                </TR>
                
    
          <tr> 
             <td nowrap class="blue">用户号码</td>
             <td>
	              <input type="text" name="phoneno" v_must=1 v_type="mobphone" onBlur="if(this.value!=''){if(checkElement(document.all.phoneno)==false){return false;}}" maxlength=11  index="6" value ="<%=phone_no%>"  Class="InputGrey" readOnly >  
	            <font class="orange">*</font>
	            <input type="button" name="qryId_No" value="校验" onClick="simChk()"  class="b_text"> 
         	 </td>
         	 
         	<%
         	String sql_newP1443 = "select offer_name,to_char(offer_id) from product_offer where offer_code like '%00070AAA%'";
         	%> 
         	<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
			  	 <wtc:sql><%=sql_newP1443%></wtc:sql>
			 	  </wtc:pubselect>
				 <wtc:array id="result_newP1443" scope="end"/>
				 	
				 	<%
				 	String offer_namew = "";
				 	String offer_codew = "";
				 	if(result_newP1443.length>0){
				 	offer_namew = result_newP1443[0][0];
				 	offer_codew = result_newP1443[0][1];
				 		
				 	}
				 	
				 	%>
			<TD colspan="2" width="50%" class="blue"><%=offer_namew%>
				<select name=mode_type >
            	<option value="<%=offer_codew%>" selected><%=offer_codew%></option>
				</select>
            </TD>   
          </tr>
 
          <tr> 
              <td class="blue">备注</td>
              <td colspan="3">
              <input type="text"  name="t_sys_remark" id="t_sys_remark" size="60"  maxlength=30   Class="InputGrey" readOnly>
            	</td>
          </tr>
          </tr>
          <tr> 
            <td colspan="4" height="30" id="footer"> 
              <div align="center"> 
                <input  type="button" name="confirm" value="打印&确认"  onClick="printCommit()" index="26" disabled class="b_foot_long">
                <input  type=reset name=back value="清除" onClick="document.all.confirm.disabled=true;" class="b_foot">
                <input  type="button" name="b_back" value="关闭"  onClick="removeCurrentTab()" index="28" class="b_foot">
              </div>
            </td>
          </tr>
        </table>

  <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>


</html>
<script language="javascript">
 function onTranType()
{
	
	if(document.f1443.tranType.value==1)
	{
		document.all.mode_type.disabled=false;
	}
	else
	{
		document.all.mode_type.disabled=true;
	}
}	
</script>
