
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
     String sqlStrl ="SELECT a.offer_id,a.offer_name,wap_id FROM product_offer a,product_offer_wap b WHERE a.offer_id = b.offer_id and a.exp_date > sysdate and business_type = '66'";
 %> 	
    <wtc:service name="TlsPubSelCrm" outnum="40" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=sqlStrl%>" />
		</wtc:service>
		<wtc:array id="sqlResult" scope="end" />





<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<SCRIPT language=JavaScript>
 

$(function(){ 
　　$("#myselect").change(function(){
		
		//查询下拉框对应可选的App
		qryAppInfo();
		
		
		
		$("#app").show();
    
   
		});
		
}); 

function qryAppInfo(){
	
		var iProductId = $('#myselect option:selected').attr('iProductId');//获取当前产品id
	 var packet = new AJAXPacket("fm472_AppInfo_Qry.jsp","请稍后...");
       packet.data.add("iProductId",iProductId);//
     
    core.ajax.sendPacket(packet,do_AppInfo);
    packet =null;
	
	}

function do_AppInfo(packet){
	
		var code = packet.data.findValueByName("code"); //返回代码
		var msg = packet.data.findValueByName("msg"); //返回信息
	 if(code=="000000"){//调用服务成功
	 		 var retArray = packet.data.findValueByName("retArray"); //返回信息
	 		 
	 		 $("#apptd").html("");
	 			var  apptype_html = "";
	 		 for(var i=0;i<retArray.length;i++){
	 		 	
	 		 	apptype_html+=""+"<input type=\"checkbox\"   v_id='"+retArray[i][0]+"'> " +retArray[i][1]+"";
	 		 }
	 		 $("#app td:eq(1)").append(apptype_html);
	 		 
			
    }else{//操作失败
	     rdShowMessageDialog(code+":"+msg);
	     return;
    }
}
	
function go_Check(){
	
				 var iOfferId =  $("#myselect option:selected").attr("iOfferId");//获取当前资费代码
  			 var iProductId = $('#myselect option:selected').attr('iProductId');//获取当前产品id
		 			
					 var num = $("input[type='checkbox']:checked").length;//选中的app产品个数
					//资费所能选择的app校验
					//9元和30元只能选择一个app，18元最多选择三个
					 if(iProductId=="9991010000000010003"||iProductId=="9991010000000010001"){
						if(num>1){
							rdShowMessageDialog("该资费只允许选择一个APP",1);
							return;
							}
						}
						if(iProductId=="9991010000000010006"){
							if (num>3) {
								rdShowMessageDialog("该资费最多允许选择三个APP",1);
								return;
							}
						}
				 	if(num==""){
						rdShowMessageDialog("请选择一个视频APP",1);
						return;
					}
				 
		
					var id_array=new Array();  
					$('input[type="checkbox"]:checked').each(function(){  
					    id_array.push($(this).attr("v_id")); 
					});  
					var iServicId=id_array.join(','); 
		
			
	
    var packet = new AJAXPacket("fm472_Qry.jsp","请稍后...");
        packet.data.add("opCode","<%=opCode%>");//
        packet.data.add("iOfferId",iOfferId);//
        packet.data.add("iProductId",iProductId);//
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
	 		  showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes"); 
					 go_Cfm();
    
    }else{//操作失败
	     rdShowMessageDialog("校检失败"+code+":"+msg);
	     return;
    }
     
}

function go_Cfm(){
	
				 var iOfferId =  $("#myselect option:selected").attr("iOfferId");//获取当前资费代码
  			 var iProductId = $('#myselect option:selected').attr('iProductId');//获取当前产品id
				 var iServicId = ""; 
					var id_array=new Array();  
					$('input[type="checkbox"]:checked').each(function(){  
					    id_array.push($(this).attr("v_id")); 
					});  
					var iServicId=id_array.join(','); 
		
				
	
    var packet = new AJAXPacket("fm472_Cfm.jsp","请稍后...");
    		 packet.data.add("opCode","<%=opCode%>");//
         packet.data.add("iOfferId",iOfferId);//
         packet.data.add("iProductId",iProductId);//
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
	  opr_info +="业务类型：定向视频流量包办理    操作流水: "+"<%=loginAccept%>" +"|";
	  opr_info += "业务受理时间：" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' + "   " +   "|";
	  opr_info += "本次申请可选套餐："+$('#myselect').find('option:selected').text()+"|";
	  
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


<table cellSpacing="1">
	<tr>
	    <td class="blue" width="15%">手机号码</td>
		  <td width="">
			    <input type="text"  name="phoneNo" id="phoneNo"  maxlength="11" value="<%=activePhone%>" class="InputGrey" readonly />
		  </td>
		 
	</tr>
	<tr>
			 <td class="blue" width="15%">客户名称</td>
		  <td width="">
			    <input type="text"  name="custName" id="custName"   value="<%=custName%>" class="InputGrey" readonly/>
		  </td>	
	</tr>
	<tr>
		 <td class="blue">资费信息</td>		
			<td>
				<select  id="myselect" style = "width:380px;">
					<option >请选择</option>
			 		<% 
				   	if(sqlResult.length>0){
				   		for(int i=0;i<sqlResult.length;i++){
				   	%>
				    <option  value=<%=sqlResult[i][0]%>  iOfferId=<%=sqlResult[i][0]%>  iProductId=<%=sqlResult[i][2]%>   ><%=sqlResult[i][0]%>--><%=sqlResult[i][1]%></option>
				    <%
							}	
							}	    	
				    %>
			</select>
				</td>
			
			
	</tr>
	<tr id="app" style="display:none">
		 <td  class="blue" width="15%">视频APP</td>
		 <td id="apptd"></td>
	</tr>
	
</table>

<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="确认" onclick="go_Check()"            />
	 		<input type="button" class="b_foot" value="重置" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="关闭" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
<%@ include file="/npage/include/public_smz_check.jsp" %>
</FORM>
</BODY>
</HTML>