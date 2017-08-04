<%
/********************
 
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa)2016-9-14 10:29:46------------------
 关于申请“ 移动城市通”产品新增专款、账目项及代收代付结算的函（9月19-9月30）
 
 
 -------------------------后台人员：xiahk--------------------------------------------
 
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
  String workName   = (String)session.getAttribute("workName");
  String orgCode    = (String)session.getAttribute("orgCode");
  String regionCode = (String)session.getAttribute("regCode");
%> 
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="loginAccept" /> 
<%	
	String custName = "";
	String pp_name  = "";
	String id_type  = "";
	String id_name  = "";
	String id_iccid = "";
	
	/*
          查询客户信息公共服务
  */
   String paraAray[] = new String[9];
   paraAray[0]=loginAccept;
   paraAray[1]="01";
   paraAray[2]=opCode;
   paraAray[3]=workNo;
   paraAray[4]=password;
   paraAray[5]=activePhone;
   paraAray[6]="";
   paraAray[7]="";
   paraAray[8]="通过phoneNo[" + activePhone + "]查询客户信息";
%>


	
<wtc:service name="sUserCustInfo" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="80" >
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
									
									
										if("0".equals(id_type)) {
											id_name="身份证";
									  }else if("1".equals(id_type)) {
									  	id_name="军官证";
									 	}else if("2".equals(id_type)) {
									 		id_name="户口簿";
									 	}else if("3".equals(id_type)) {
									 		id_name="港澳通行证";
									 	}else if("4".equals(id_type)) {
									 		id_name="警官证";
									 	}else if("5".equals(id_type)) {
									 		id_name="台湾通行证";
									 	}else if("6".equals(id_type)) {
									 		id_name="外国公民护照";
									 	}else if("7".equals(id_type)) {
									 		id_name="其它";
									 	}else if("8".equals(id_type)) {
									 		id_name="营业执照";
									 	}else if("9".equals(id_type)) {
									 		id_name="护照";
									 	}else if("A".equals(id_type)) {
									 		id_name="组织机构代码";
									 	}else if("B".equals(id_type)) {
									 		id_name="单位法人证书";
									 	}else if("C".equals(id_type)) {
									 		id_name="单位证明";
									 	}else if("00".equals(id_type)) {
									 		id_name="身份证";
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
<script type="text/javascript" src="/njs/extend/My97DatePicker/WdatePicker.js"></script>
<SCRIPT language=JavaScript>

//重置刷新页面
function reSetThis(){
	  location = location;	
}


function go_cfm(){
	
	  var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes"); 
	  show_SJ_Prt();
	  
	 	if(rdShowConfirmDialog("确认要提交信息吗？")!=1) return;
	 	
	  var packet = new AJAXPacket("fm404_Cfm.jsp","请稍后...");
	      packet.data.add("opCode","<%=opCode%>");//
	      packet.data.add("opName","<%=opName%>");//
	      
	      packet.data.add("custName","<%=custName%>");//
	      packet.data.add("phoneNo","<%=activePhone%>");//
	      packet.data.add("loginAccept","<%=loginAccept%>");//
	      packet.data.add("nfc_fee","20");//
	  core.ajax.sendPacket(packet,do_cfm);
	  packet =null;
}

function do_cfm(packet){
    var error_code = packet.data.findValueByName("code");//返回代码
    var error_msg =  packet.data.findValueByName("msg");//返回信息

    if(error_code!="000000"){//调用服务失败
      rdShowMessageDialog(error_code+":"+error_msg);
	    return;
    }else{//操作成功
    	rdShowMessageDialog("操作成功",2);
    	reSetThis();
    }
} 

function showPrtDlg(printType,DlgMessage,submitCfm){  //显示打印对话框 
	  var h=180;
	  var w=350;
	  var t=screen.availHeight/2-h/2;
	  var l=screen.availWidth/2-w/2;		   	   
	  var pType="subprint";             				 	//打印类型：print 打印 subprint 合并打印
	  var billType="1";              				 			  //票价类型：1电子免填单、2发票、3收据
	  var sysAccept =<%=loginAccept%>;             	//流水号
	  var printStr = printInfo(printType);
	  
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
    
//打印模板id为：122
function printInfo(printType){
	  var cust_info="";
	  var opr_info="";
	  var note_info1="";
	  var note_info2="";
	  var note_info3="";
	  var note_info4="";
	  var retInfo = "";
	  
	  cust_info+="手机号码：   "+"<%=activePhone%>"+"|";
	  cust_info+="客户姓名：   "+"<%=custName%>"+"|";
	  
	  opr_info +="卡类型：NFC城市通卡    办理业务：城市通开卡代收费" +"|";
	  opr_info +="操作流水: "+"<%=loginAccept%>    操作时间：" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' +"|";
	  opr_info +="代收公交费：20元"+"|";
	  
	  note_info1 += "本卡内含20元公交卡费，仅在和包客户端开通移动城市通功能并进行实名绑定后方可使用。"+"|";
	  
	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;
}



//打印收据
function show_SJ_Prt(){
 	     
	  	var  billArgsObj = new Object();

			$(billArgsObj).attr("10001","<%=workNo%>");     //工号
			$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10005","<%=custName%>");   //客户名称
			$(billArgsObj).attr("10006","NFC城市通卡");    //业务类别
			$(billArgsObj).attr("10008","<%=activePhone%>");    //用户号码
			$(billArgsObj).attr("10015","20");   //本次发票金额
			$(billArgsObj).attr("10016","20");   //大写金额合计
			$(billArgsObj).attr("10017","*");        //本次缴费：现金
			$(billArgsObj).attr("10030","<%=loginAccept%>");   //流水号：--业务流水
			$(billArgsObj).attr("10036","<%=opCode%>");   //操作代码
	    $(billArgsObj).attr("10071","6");	//模板
 			$(billArgsObj).attr("10078", "<%=custBrandName%>"); //宽带品牌	
 			$(billArgsObj).attr("10083", "<%=id_name%>"); //证件类型
 			$(billArgsObj).attr("10084", "<%=id_iccid%>"); //证件号码
 			$(billArgsObj).attr("10085", "zsj"); //宽带费用收取方式 只弹出打印收据的框
 			$(billArgsObj).attr("10086", "尊敬的用户，如您需要开具公交卡20元代收费发票，请携带已开通移动城市通功能并实名制绑定的SIM卡片于开卡30日内至城市通指定网点领取发票，网点信息可关注城市通微信平台(hrbcst)查询，客服电话：95105188。"); //备注
 			
 			$(billArgsObj).attr("10072","0"); //计费xuxz要求写死
 			//$(billArgsObj).attr("10088","m404"); //收据模块
 			
 			
			var h=210;
			var w=400;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
			
			var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + "确实要进行发票打印吗？";
			
			var path = path +"&loginAccept=<%=loginAccept%>&opCode=m404&submitCfm=submitCfm";
			var ret = window.showModalDialog(path,billArgsObj,prop);
			
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
		  <td class="blue" width="15%">客户名称</td>
		  <td width="35%">
			    <%=custName%>
		  </td>
		  
	</tr>
	<tr>
	    <td class="blue" width="15%">NFC城市通代收费</td>
		  <td colspan="3">
			    20（元）
		  </td>
	</tr>
</table>
<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="确定" onclick="go_cfm()"           />
	 		<input type="button" class="b_foot" value="重置" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="关闭" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>