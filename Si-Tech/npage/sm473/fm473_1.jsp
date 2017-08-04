
<%
/********************
 
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------duming 2017.4.21------------------
 关于部署近期重点流量业务支撑系统改造的通知
 
 
 -------------------------后台人员：yull--------------------------------------------
 
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
			System.out.println("---------------------result_t2["+iii+"]["+jjj+"]=-----------------"+result_t2[iii][jjj]);
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


<%	
	//展示用户订购记录
	//标准化入参
	String paraAray2[] = new String[7];
	
	paraAray2[0] = "";                                       //流水
	paraAray2[1] = "";                                     //渠道代码
	paraAray2[2] = opCode;                                   //操作代码
	paraAray2[3] = (String)session.getAttribute("workNo");   //工号
	paraAray2[4] = (String)session.getAttribute("password"); //工号密码
	paraAray2[5] = activePhone;                                	 	 //手机号码
	paraAray2[6] = "";                                       //号码密码


	String serverName = "sDXSPLLOffList";

%>
		<wtc:service name="<%=serverName%>" outnum="10" retcode="code" retmsg="msg" routerKey="region" routerValue="<%=regionCode%>">
<%
			for(int i=0; i<paraAray2.length; i++ ){
				System.out.println("-----duming-------------paraAray["+i+"]------["+serverName+"]-------------->"+paraAray2[i]);
%>
				<wtc:param value="<%=paraAray2[i]%>" />
<%					
			}
%>									
		</wtc:service>
		<wtc:array id="offList" scope="end"   />
<%
	String retCode = "";
	String retMsg = "";
	retCode = code;
	retMsg = msg;
	System.out.println("--duming--------retCode-----serverName=["+serverName+"]---------"+retCode);
	System.out.println("--duming--------retMsg------serverName=["+serverName+"]---------"+retMsg);
	
%> 	







<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<SCRIPT language=JavaScript>


function go_Qry(){
		
		var radioObj = $("#tab_offer").find("input[type='radio']:checked");
		
		if(radioObj.size()==0){
			rdShowMessageDialog("请选择一条记录");
			return;
		}
		
		
		var iOfferId = radioObj.attr("iOfferId");
		var iProductId = radioObj.attr("iProductId");
		var iProdOffInsId = radioObj.attr("iProdOffInsId");
		var iServicId = radioObj.attr("iServicId");
		
		
		
    var packet = new AJAXPacket("fm473_Qry.jsp","请稍后...");
        packet.data.add("opCode","<%=opCode%>");//
        packet.data.add("iOfferId",iOfferId);//
        packet.data.add("iProductId",iProductId);//
        packet.data.add("iProdOffInsId",iProdOffInsId);//
        packet.data.add("iServicId",iServicId);//
        packet.data.add("phoneNo","<%=activePhone%>");//
    core.ajax.sendPacket(packet,do_Query);
    packet =null;
	
}

function do_Query(packet){
    var code = packet.data.findValueByName("code"); //返回代码
		var msg = packet.data.findValueByName("msg"); //返回信息
	
	 if(code=="000000"){//调用服务成功
		//调用提交服务打印免填单
		 var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes"); 
			go_Cfm();
    
    }else{//操作失败
	     rdShowMessageDialog("校检失败"+code+":"+msg);
	     return;
    }
     
}



function go_Cfm(){
		
		var radioObj = $("#tab_offer").find("input[type='radio']:checked");

   	var iOfferId = radioObj.attr("iOfferId");
		var iProductId = radioObj.attr("iProductId");
		var iProdOffInsId = radioObj.attr("iProdOffInsId");
		var iServicId = radioObj.attr("iServicId");
		
		
		
     var packet = new AJAXPacket("fm473_Cfm.jsp","请稍后...");
        packet.data.add("opCode","<%=opCode%>");//
        packet.data.add("iOfferId",iOfferId);//
        packet.data.add("iProductId",iProductId);//
        packet.data.add("iProdOffInsId",iProdOffInsId);//
        packet.data.add("iServicId",iServicId);//
        packet.data.add("phoneNo","<%=activePhone%>");//
    core.ajax.sendPacket(packet,do_Cfm);
    packet =null;
	
}


function do_Cfm(packet){
    var code = packet.data.findValueByName("code"); //返回代码
		var msg = packet.data.findValueByName("msg"); //返回信息
	
	 if(code=="000000"){//调用服务成功
	 		
	 		 rdShowMessageDialog("操作成功",2); 
	 		 reSetThis();
    }else{//操作失败
	     rdShowMessageDialog(code+":"+msg);
	     return;
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
	  opr_info +="业务类型：视频APP退订    操作流水: "+"<%=loginAccept%>" +"|";
	  opr_info += "业务受理时间：" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' + "   "  + "|";
	  opr_info += "本次退订可选套餐："+		  $("#tab_offer").find("input[type='radio']:checked").parent().parent().find("td:eq(3)").text().trim()+"|";
	  
	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;
}



function reSetThis(){
	location = location;
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
		  <td width="">
			    <input type="text"  name="phoneNo" id="phoneNo"  maxlength="11" value="<%=activePhone%>" class="InputGrey" readonly />
		  </td>
		  <td class="blue" width="15%">客户名称</td>
		  <td width="">
			    <input type="text"  name="custName" id="custName"   value="<%=custName%>" class="InputGrey" readonly/>
		  </td>
	</tr>

</table>


<table cellSpacing="0" id="tab_offer">
     <tr>
     		 <th width="5%">资费代码</th>
        <th width="10%">产品代码</th>
        <th width="5%">资费实例id</th>
        <th width="15%">资费名称</th>
        <th width="10%">生效时间</th>	
        <th width="10%" >失效时间</th>
        <th width="15%" >已购APP</th>	
    </tr>
    
     <%
  	 if(offList.length>0){
  	  String disabled_str = "";
    	for(int i=0;i<offList.length;i++){ 
    	if("A".equals(offList[i][4])){
    			disabled_str = "";
    		}else{
    			disabled_str = "disabled";
    		}
 	 %>  	
   	  <tr>
        <td><input type="radio"   <%=disabled_str%>  name="radioOffer" iOfferId="<%=offList[i][0]%>" iProductId="<%=offList[i][1]%>"   iProdOffInsId="<%=offList[i][2]%>" iServicId="<%=offList[i][7]%>" ><%=offList[i][0]%></td>
        <td><%=offList[i][1]%></td>
        <td><%=offList[i][2]%></td>
        <td><%=offList[i][3]%></td>	
        <td style="display:none" ><%=offList[i][4]%></td>	
        <td><%=offList[i][5]%></td>
        <td><%=offList[i][6]%></td>	
        <td style="display:none" ><%=offList[i][7]%></td>	
        <td><%=offList[i][8]%></td>	
   	 </tr>
   <%	
  	 
   	}
		}
   %>
    
</table>

<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="退订" onclick="go_Qry()"            />
	 		<input type="button" class="b_foot" value="重置" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="关闭" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>

</FORM>
</BODY>
</HTML>