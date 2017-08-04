<%
/********************
 
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa)[2017/2/7 15:46:09]------------------
 关于下发电子化有价卡业务全网改造方案及上线计划的通知
 
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
        
  String countTotalSql = "select store_money from sstoretype where substr(store_type,1,1) = 'd' order by store_money asc";
         
%>   

  <wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=countTotalSql%>" />
	</wtc:service>
	<wtc:array id="result_countTotal" scope="end"    />
		
			 
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<SCRIPT language=JavaScript>


//重置刷新页面
function reSetThis(){
	  location = location;	
}


function go_Cfm(){

		if(!check(msgFORM)) return false;
	
	  var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes"); 
	  
	 	if(rdShowConfirmDialog("确认要提交信息吗？")!=1) return;
	 	
    var packet = new AJAXPacket("fm449_Cfm.jsp","请稍后...");
        packet.data.add("opCode","<%=opCode%>");//
        packet.data.add("phoneNo","<%=activePhone%>");//
        packet.data.add("loginAccept","<%=loginAccept%>");//
        packet.data.add("sel_CountTotal",$("#sel_CountTotal").val());//
        packet.data.add("sel_Count",$("#sel_Count").val());//
        packet.data.add("sel_Payment",$("#sel_Payment").val());//
        
    core.ajax.sendPacket(packet,do_Cfm);
    packet =null;
    	 	
}

function do_Cfm(packet){
    var error_code = packet.data.findValueByName("code");//返回代码
    var error_msg =  packet.data.findValueByName("msg");//返回信息

    if(error_code!="000000"){//调用服务失败
      rdShowMessageDialog(error_code+":"+error_msg);
	    return;
    }else{//操作成功
	    rdShowMessageDialog("操作成功，进行发票打印",2);
    	show_bill_Prt();
    }
}

//提交服务成功后 打印发票
function show_bill_Prt(){
 	     
 	  var  billArgsObj = new Object();
 	     
 	  var TotalFee = Number($("#sel_CountTotal").val()) * Number($("#sel_Count").val());
 	  
 	    
 	  var cardNos = "12345678901234556、12345678901234556、12345678901234556、12345678901234556、12345678901234556、12345678901234556、12345678901234556、12345678901234556、12345678901234556、12345678901234556";
 	    
		$(billArgsObj).attr("10001","<%=workNo%>");       //工号
 		$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
 		
 		
 		
 		$(billArgsObj).attr("10006","电子卡销售(个人)"); //业务类别
 		$(billArgsObj).attr("10008","<%=activePhone%>"); //用户号码
 		$(billArgsObj).attr("10015", TotalFee); //本次发票金额(小写)￥
 		$(billArgsObj).attr("10016", TotalFee); //大写金额合计
 		$(billArgsObj).attr("10036","<%=opCode%>"); //操作代码	
 		$(billArgsObj).attr("10030","<%=loginAccept%>"); //流水号--业务流水
 		
 		$(billArgsObj).attr("10044", $("#sel_CountTotal").val()); //单价 -- 卡面额
 		$(billArgsObj).attr("10043", $("#sel_Count").val());//数量
 		$(billArgsObj).attr("10012", cardNos);//有价卡卡号 最多10张顿号分隔卡号
 		
 		
		$(billArgsObj).attr("10071","8");//模板号
		

 			
			var h=210;
			var w=400;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
			
			
			
			var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + "确实要进行发票打印吗？";
			
			//发票项目修改为新路径
			 //path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=确实要进行发票打印吗？";
					
			
			
			 path = path +"&loginAccept=<%=loginAccept%>&opCode=<%=opCode%>&submitCfm=submitCfm";
			var ret = window.showModalDialog(path,billArgsObj,prop);
			
}

function showPrtDlg(printType,DlgMessage,submitCfm){  //显示打印对话框 
	  var h=180;
	  var w=350;
	  var t=screen.availHeight/2-h/2;
	  var l=screen.availWidth/2-w/2;		   	   
	  var pType="subprint";             				 	//打印类型：print 打印 subprint 合并打印
	  var billType="1";              				 			  //票价类型：1电子免填单、2发票、3收据
	  var sysAccept ="<%=loginAccept%>";             	//流水号
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
//打印模板id为：
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
	  
	  opr_info +="业务类型：电子卡销售(个人)     操作流水: "+"<%=loginAccept%>" +"|";
	  opr_info += "业务受理时间：" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' + "   " + "|";
		opr_info += "面额："+$("#sel_CountTotal").val()+"    购卡数量："+$("#sel_Count").val()+"|";

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
	    <td class="blue" width="15%">卡业务种类</td>
		  <td width="35%">
		  	<select id="sel_CardType" name="sel_CardType" >
				    <option value="00">话费充值卡</option>
				</select>
		  </td>
		  <td class="blue" width="15%">面额</td>
		  <td>
		  	<select id="sel_CountTotal" name="sel_CountTotal" >
<%
					for(int i=0;i<result_countTotal.length;i++){
%>					
						<option value="<%=result_countTotal[i][0]%>"><%=result_countTotal[i][0]%></option>
<%					
					}
%>		  		
				</select>
		  </td>
	</tr>
	<tr>
	    <td class="blue">购卡数量</td>
		  <td>
				<select id="sel_Count" name="sel_Count" >
				    <option value="1">1</option>
				    <option value="2">2</option>
				    <option value="3">3</option>
				    <option value="4">4</option>
				    <option value="5">5</option>
				    <option value="6">6</option>
				    <option value="7">7</option>
				    <option value="8">8</option>
				    <option value="9">9</option>
				    <option value="10">10</option>
				</select>  
		  </td>
		  <td class="blue" >支付方式</td>
		  <td>
		  	<select id="sel_Payment" name="sel_Payment" >
				    <option value="0">现金支付</option>
				</select>
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