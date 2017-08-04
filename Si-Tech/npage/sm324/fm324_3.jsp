<%
/********************
 
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa)2015-10-9 14:19:54------------------
 关于合账分享业务业务限制及办理渠道拓展需求的函
 	
 	取消页面
 
 -------------------------后台人员：xiahk--------------------------------------------
 
********************/
%>
              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%

	 java.util.Calendar calendar = java.util.Calendar.getInstance();
	 calendar.add(Calendar.MONTH, 1);
	 calendar.set(Calendar.DAY_OF_MONTH, 1);
	 String next_month_Date = new java.text.SimpleDateFormat("yyyy年MM月dd日").format(calendar.getTime()); 
	 
	 
	String opCode      = WtcUtil.repNull(request.getParameter("opCode"));
  String opName      = WtcUtil.repNull(request.getParameter("opName"));
  String phone_no      = WtcUtil.repNull(request.getParameter("activePhone"));
  
  
  String workNo    = (String)session.getAttribute("workNo");
  String password  = (String)session.getAttribute("password");
  String workName  = (String)session.getAttribute("workName");
  String orgCode   = (String)session.getAttribute("orgCode");
  String ipAddrss  = (String)session.getAttribute("ipAddr");
	String regionCode = (String)session.getAttribute("regCode");	
	String cust_name = "";
	  
  String cust_name_sql = " select b.cust_name "+
  											 " from dcustdoc b "+
 												 " where b.cust_id = "+
       									 " (select a.cust_id from dcustmsg a where a.phone_no = :phone_no) ";
	String cust_name_sql_param = "phone_no="+phone_no;       									 
	
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="loginAccept" /> 
		
		
  <wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=cust_name_sql%>" />
		<wtc:param value="<%=cust_name_sql_param%>" />	
	</wtc:service>
	<wtc:array id="result_t" scope="end"/>
		
<%
	if(result_t.length>0){
		cust_name = result_t[0][0];
	}
	
	
	//7个标准化入参
	String paraAray[] = new String[8];
	
	paraAray[0] = "";                                       //流水
	paraAray[1] = "01";                                     //渠道代码
	paraAray[2] = opCode;                                   //操作代码
	paraAray[3] = (String)session.getAttribute("workNo");   //工号
	paraAray[4] = (String)session.getAttribute("password"); //工号密码
	paraAray[5] = phone_no;                                  //用户号码
	paraAray[6] = "";                        
	paraAray[7] = "d";   //a申请，d删除取消
	
%>

  <wtc:service name="sm324Qry" outnum="5" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=paraAray[0]%>" />
		<wtc:param value="<%=paraAray[1]%>" />
		<wtc:param value="<%=paraAray[2]%>" />
		<wtc:param value="<%=paraAray[3]%>" />
		<wtc:param value="<%=paraAray[4]%>" />
		<wtc:param value="<%=paraAray[5]%>" />
		<wtc:param value="<%=paraAray[6]%>" />					
		<wtc:param value="<%=paraAray[7]%>" />			
	</wtc:service>
	<wtc:array id="result_sm324Qry"  start="0"  length="2" scope="end" />
	<wtc:array id="result_sm324Qry2" start="2"  length="3" scope="end" />

<%
	if(!"000000".equals(code)){
%>
<SCRIPT language=JavaScript>
		rdShowMessageDialog("<%=code%>：<%=msg%>");
		removeCurrentTab();
</SCRIPT>
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
    function goCfm(){
 			
 			var check_f = false;
 			$("#upgMainTab tr:gt(0)").each(function(){
				if($(this).find("input[type='checkbox']").attr("checked")==true){
					check_f = true;
					return false;
				}
			});
			
			if(!check_f){
				rdShowMessageDialog("请选择要取消的副卡号码");
				return;
			}
			
      var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes"); 
      if(typeof(ret)!="undefined"){
        if((ret=="confirm")){
          if(rdShowConfirmDialog('确认要提交信息吗？')==1){
            frmCfm();
          }
        }
        if(ret=="continueSub"){
          if(rdShowConfirmDialog('确认要提交信息吗？')==1){
            frmCfm();
          }
        }
      }else{
        if(rdShowConfirmDialog('确认要提交信息吗？')==1){
          frmCfm();
        }
      }
    }

		function frmCfm(){
			
			var f_phone_no_strs   = "";
			
			$("#upgMainTab tr:gt(0)").each(function(){
				if($(this).find("input[type='checkbox']").attr("checked")==true){
					f_phone_no_strs += $(this).find("td:eq(1)").text().trim()+"|";
				}
			});
			
      var packet = new AJAXPacket("fm324_5.jsp","请稍后...");
    			packet.data.add("op_type","d");//
	    		packet.data.add("opCode","<%=opCode%>");//opcode
	    		packet.data.add("loginAccept","<%=loginAccept%>");//流水
	        packet.data.add("iPhoneNoMaster","<%=phone_no%>");//主卡号码
	        packet.data.add("f_phone_no_strs",f_phone_no_strs);//副卡号码
	        packet.data.add("f_phone_pass_strs","");//副卡密码
	    core.ajax.sendPacket(packet,do_frmCfm);
	    packet =null;	
    }
    
    function do_frmCfm(packet){
    	 	var error_code = packet.data.findValueByName("code");//返回代码
		    var error_msg =  packet.data.findValueByName("msg");//返回信息
		
		    if(error_code=="000000"){//操作成功
		    	 rdShowMessageDialog("操作成功",2);
					 location = location;
		    }else{//调用服务失败
		    	rdShowMessageDialog(error_code+":"+error_msg);
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
      var phoneNo="<%=phone_no%>";                  //客户电话
      
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
			
    function printInfo(printType){
      var cust_info="";
      var opr_info="";
      var note_info1="";
      var note_info2="";
      var note_info3="";
      var note_info4="";
      var retInfo = "";
      
      cust_info+="手机号码：   "+"<%=phone_no%>"+"|";
      cust_info+="客户姓名：   "+"<%=cust_name%>"+"|";
      
      var f_phone_nos = "";
			
			$("#upgMainTab tr:gt(0)").each(function(){
				if($(this).find("input[type='checkbox']").attr("checked")==true){
					f_phone_nos += $(this).find("td:eq(1)").text().trim()+" ";
				}
			});
			
      opr_info +="业务类型：集团客户部之合账分享"+"|"+"业务流水: "+"<%=loginAccept%>" +"|";
      opr_info += "主卡号码：<%=phone_no%>"+"|";
      opr_info += "副卡号码："+f_phone_nos+"|";
      opr_info += "办理时间：" + "<%=new java.text.SimpleDateFormat("yyyy年MM月dd日", Locale.getDefault()).format(new java.util.Date())%>" + "|";
      opr_info += "失效时间：<%=next_month_Date%>|";
      
      note_info1 += "备注：|尊敬的客户您好，您已成功办理合账分享取消业务，业务取消次月有效，本月需您根据主副卡消费情况，及时缴费，以免影响您使用。"+"|";
      
      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
      return retInfo;
    }

</SCRIPT>
</HEAD>	
<BODY>
<FORM name="frm" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi">主卡信息</div></div>


<table cellSpacing="0">
	<tr>
	    <td class="blue" width="15%">业务类型</td>
		  <td colspan="3">
			    取消
		  </td>
	</tr>
	<tr>
	    <td class="blue" width="15%">主卡号码</td>
		  <td width="35%">
			    <%=phone_no%>
		  </td>
		  <td class="blue" width="15%">主卡客户名称</td>
		  <td width="35%">
			    <%=cust_name%>
		  </td>
	</tr>
		
</table>

<div class="title"><div id="title_zi">副卡列表</div></div>
<TABLE cellSpacing="0" id="upgMainTab">
    <tr>
    		<th width="25%">选择</th>
        <th width="25%">副卡号码</th>
        <th width="25%">开始时间</th>	
        <th width="25%">结束时间</th>	
    </tr>
<%
for(int i=0;i<result_sm324Qry2.length;i++){
	if(!"".equals(result_sm324Qry2[i][0].trim())){
		out.println("<tr>");
		out.println("<td><input type='checkbox' /></td>");
		out.println("<td>"+result_sm324Qry2[i][0]+"</td>");
		out.println("<td>"+result_sm324Qry2[i][1]+"</td>");
		out.println("<td>"+result_sm324Qry2[i][2]+"</td>");
		out.println("</tr>");
	}
}
%>
</table>


<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="确定&打印" onclick="goCfm()"           />
	 		<input type="button" class="b_foot" value="重置" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="关闭" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>