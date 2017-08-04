<%
/********************
 
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa)[2017/3/6 星期一 10:55:35]------------------
 关于申请本省流量卡失效兑换等额流量包活动的需求
 
 -------------------------后台人员：[liyang]--------------------------------------------
 
********************/
%>
              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%
	String opCode    = WtcUtil.repNull(request.getParameter("opCode"));
  String opName    = WtcUtil.repNull(request.getParameter("opName"));
  
  String workNo     = (String)session.getAttribute("workNo");
  String password   = (String)session.getAttribute("password");
  String regionCode = (String)session.getAttribute("regCode");

	String currentDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
%> 
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="loginAccept" /> 
<%	
	String custName = "";
	String pp_name  = "";
	String id_type  = "";
	String id_iccid = "";
	
	/*
          查询客户信息公共服务
  */
   String paraAray[] = new String[9];
   paraAray[0] = loginAccept;
   paraAray[1] = "01";
   paraAray[2] = opCode;
   paraAray[3] = workNo;
   paraAray[4] = password;
   paraAray[5] = activePhone;
   paraAray[6] = "";
   paraAray[7] = "";
   paraAray[8] = "通过phoneNo[" + activePhone + "]查询客户信息";
%>


	
<wtc:service name="sUserCustInfo" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="40" >
      <wtc:param value="<%=paraAray[0]%>"/>
      <wtc:param value="<%=paraAray[1]%>"/>
      <wtc:param value="<%=paraAray[2]%>"/>
      <wtc:param value="<%=paraAray[3]%>"/>
      <wtc:param value="<%=paraAray[4]%>"/>
      <wtc:param value="<%=paraAray[5]%>"/>
      <wtc:param value="<%=paraAray[6]%>"/>
      <wtc:param value="<%=paraAray[7]%>"/>
      <wtc:param value="<%=paraAray[8]%>"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
  </wtc:service>
<wtc:array id="result_t2" scope="end" />

<%

	for(int iii=0;iii<result_t2.length;iii++){
		for(int jjj=0;jjj<result_t2[iii].length;jjj++){
			System.out.println("--------hejwa-------------result_t2["+iii+"]["+jjj+"]=-----------------"+result_t2[iii][jjj]);
		}
	}

String custBrandName = "";
        if("000000".equals(retCode2)){
                if(result_t2.length>0){
                        custName = result_t2[0][5];
                        pp_name  = result_t2[0][38];
                        id_type  = result_t2[0][12];
                        id_iccid = result_t2[0][13];
                        
                  if (pp_name.equals("gn")) {
										custBrandName = "全球通";
									} else if (pp_name.equals("zn")) {
										custBrandName = "神州行";
									} else if (pp_name.equals("dn")) {
										custBrandName = "动感地带";
									} 
									
                }
        }else{
%>
                <script language="JavaScript">
                        rdShowMessageDialog("该用户不是在网用户或状态不正常！");
                        removeCurrentTab();
                </script>
<%              
        }
%>   	
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<SCRIPT language=JavaScript>

//重置刷新页面
function reSetThis(){
	  location = location;	
}



function go_Cfm(){
 
		
		if(!checkElement(document.all.ipt_llCardNo)) return false;
		
	
	 	if(rdShowConfirmDialog("确认要提交信息吗？")!=1) return;
	 	
	 	
    var packet = new AJAXPacket("fm460_Cfm.jsp","请稍后...");
        packet.data.add("opCode","<%=opCode%>");//
        packet.data.add("phoneNo","<%=activePhone%>");//
        packet.data.add("ipt_llCardNo",$("#ipt_llCardNo").val());//
    core.ajax.sendPacket(packet,do_Cfm);
    packet =null;
    
    		
	  
}



function do_Cfm(packet){
    var error_code = packet.data.findValueByName("code");//返回代码
    var error_msg =  packet.data.findValueByName("msg");//返回信息
		var itype =  packet.data.findValueByName("itype");//返回套餐类型
	
    if(error_code!="000000"){//调用服务失败
      rdShowMessageDialog(error_code+":"+error_msg);
	    return;
    }else{//操作成功
	    rdShowMessageDialog("操作成功",2);
    	reSetThis();
    }
    	var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes",itype); 
}



function showPrtDlg(printType,DlgMessage,submitCfm,itype){  //显示打印对话框 
	  var h=180;
	  var w=350;
	  var t=screen.availHeight/2-h/2;
	  var l=screen.availWidth/2-w/2;		   	   
	  var pType="subprint";             				 	//打印类型：print 打印 subprint 合并打印
	  var billType="1";              				 			  //票价类型：1电子免填单、2发票、3收据
	  var sysAccept =<%=loginAccept%>;             	//流水号
	    var printStr = printInfo(printType,itype);
	  
		                      //调用printinfo()返回的打印内容
	  var mode_code=null;           							  //资费代码
	  var fav_code=null;                				 		//特服代码
	  var area_code=null;             				 		  //小区代码
	  var opCode="<%=opCode%>" ;                   			 	//操作代码
	  var phoneNo="<%=activePhone%>";                  //客户电话
	  
	  var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	  var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
	  path+="&mode_code="+mode_code+
	  	"&fav_code="+fav_code+"&area_code="+area_code+
	  	"&opCode=<%=opCode%>&sysAccept="+sysAccept+
	  	"&phoneNo="+phoneNo+
	  	"&submitCfm="+submitCfm+"&pType="+
	  	pType+"&billType="+billType+ "&printInfo=" + printStr;
	  var ret=window.showModalDialog(path,printStr,prop);
	  return ret;
}				
//打印模板id为：
function printInfo(printType,itype){
	  var cust_info="";
	  var opr_info="";
	  var note_info1="";
	  var note_info2="";
	  var note_info3="";
	  var note_info4="";
	  var retInfo = "";
	  
	  opr_info += "业务受理时间：" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' + "|";
	  cust_info+="手机号码：   "+"<%=activePhone%>"+"|";
	  cust_info+="客户姓名：   "+"<%=custName%>"+"|";
	  opr_info +="业务类型：省内流量充值卡充值    操作流水: "+"<%=loginAccept%>" +"|";


	//  opr_info += "流量充值卡卡号："+ $('#ipt_llCardNo').val()+"|";
		opr_info+="新申请可选包资费名称："+itype+"|";
	  opr_info += "新申请可选包资费描述：该可选包用于等值流量充值卡的充值，可选包办理成功后，原流量充值卡作废，一张卡仅可兑换等值流量可选包一次。"+"|";
	  
	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;
}



</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi"><%=opName%></div></div>


<table cellSpacing="0">
	<tr>
	    <td class="blue" width="15%">手机号码</td>
		  <td width="35%">
			    <%=activePhone%>
		  </td>
		  <td class="blue" width="15%">客户姓名</td>
		  <td>
			    <%=custName%>
		  </td>
	</tr>
	<tr>
	    <td class="blue">流量充值卡卡号</td>
		  <td colspan="3">
			    <input type="text" name="ipt_llCardNo" id="ipt_llCardNo" value="" maxlength="27" v_type="0_9"  v_must="1" onblur="checkElement(this)"/> 
			    <font class="orange">*</font>
		  </td>
	</tr>
</table>




<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="确定" onclick="go_Cfm()"            />
	 		<input type="button" class="b_foot" value="重置" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="关闭" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>