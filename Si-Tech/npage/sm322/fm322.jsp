<%
/********************
 version v2.0
开发商: si-tech
create by wanglm 20110321
********************/
%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
  request.setCharacterEncoding("GBK");
  String opCode = (String)request.getParameter("opCode");
  String opName = (String)request.getParameter("opName");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=opName%></title>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String current_timeNAME=new SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date());
		String regionCode= (String)session.getAttribute("regCode");
		String kyjfz="0";
		String custname="用户名称不存在";
		String IccId="";
		String IccIdaddress="";
		String loginNoPass = (String)session.getAttribute("password");
		String ipAddrss = (String)session.getAttribute("ipAddr");
		String beizhussdese="根据phoneNo=["+activePhone+"]进行查询";
		String sm_codes="";

%>
<wtc:service name="sUserCustInfo" outnum="100"  routerKey="region" routerValue="<%=regionCode%>" retcode="retCodess" retmsg="retMsgss">
			<wtc:param value="0" />
			<wtc:param value="01" />	
			<wtc:param value="<%=opCode%>" />	
			<wtc:param value="<%=work_no%>" />
			<wtc:param value="<%=loginNoPass%>" />
			<wtc:param value="<%=activePhone%>" />
			<wtc:param value="" />
			<wtc:param value="<%=ipAddrss%>" />
			<wtc:param value="<%=beizhussdese%>" />
</wtc:service>
<wtc:array id="baseArr" scope="end"/>
<%
    if(baseArr!=null&&baseArr.length>0){
    
    	if(baseArr[0][0].equals("00")) {
    		
          custname = (baseArr[0][5]);
          IccId = (baseArr[0][13]);
          IccIdaddress= (baseArr[0][14]);
          sm_codes= (baseArr[0][38]);
          System.out.println("custname+++++++"+custname);        
          }
    }
    

    String sql_appregionset1 = "select band_name from band where sm_code=:smcodes ";
    String sql_appregionset2 = "smcodes="+sm_codes;
    String sm_codenames ="其他品牌";

 %>
 		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCodeappregion" retmsg="retMsgappregion" outnum="1"> 
			<wtc:param value="<%=sql_appregionset1%>"/>
			<wtc:param value="<%=sql_appregionset2%>"/>
		</wtc:service>  
		<wtc:array id="appregionarry"  scope="end"/>
<%
		if(appregionarry.length>0) {
			sm_codenames = appregionarry[0][0];
		}	
			
%>    
    
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>"  id="loginAccept" />
	

	
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
  onload=function()
  {
  		
	var myPacket = new AJAXPacket("fm322Qry.jsp","正在查询信息，请稍候......");
	myPacket.data.add("phone_no",$("#zr_phone").val());

	core.ajax.sendPacketHtml(myPacket,querinfo,true);
	getdataPacket = null;
  
  }

 function doCfm(){

  			var el = document.getElementsByTagName('input');
				var len = el.length;
				var checklength=0;
				var offeridstr ="";
				var offernamestr="";
				var sm= new Array();
				for(var i=0; i<len; i++) {
				if((el[i].type=="checkbox") && (el[i].id=='ckbox') && (el[i].checked == true) ) {
					checklength++;

					sm =el[i].value.split("<!--!>");
					offeridstr+=sm[0]+"|";
					offernamestr+=sm[1]+"<!--!>";
					
				}
				}
				if(checklength==0) {
						rdShowMessageDialog("请选择要下线的特服！");
						return false;
				}
		
		$("#offeridstr").val(offeridstr);
		$("#offernamestr").val(offernamestr);
		
				
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
 
				function checkAll() { 
				var el = document.getElementsByTagName('input');
				var len = el.length;
				
				for(var i=0; i<len; i++) {
				if((el[i].type=="checkbox") && (el[i].id=='ckbox')) {
				el[i].checked = true;
				}
				}
				}
				function clearAll() {
				var el = document.getElementsByTagName('input');
				var len = el.length;
				for(var i=0; i<len; i++) {
				if((el[i].type=="checkbox") && (el[i].id=='ckbox')) {
				el[i].checked = false;
				}
				}
				}
				
				
 
  		function frmCfm(){
				document.form1.action = "fm322Cfm.jsp";
   			document.form1.submit();
        return true;
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
			
    function printInfo(printType){
      var cust_info="";
      var opr_info="";
      var note_info1="";
      var note_info2="";
      var note_info3="";
      var note_info4="";
      var retInfo = "";

       cust_info+="客户姓名：	"+"<%=custname%>"+"|";
       cust_info+="手机号码：	"+"<%=activePhone%>"+"|";
       cust_info+="证件号码：	"+"<%=IccId%>"+"|";
       cust_info+="客户地址：	"+"<%=IccIdaddress%>"+"|";

			opr_info+= opr_info+="业务受理时间："+"<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>"+"  用户品牌：<%=sm_codenames%>"+"|";
			opr_info+="办理业务：产品变更 "+"  "+"操作流水："+"<%=loginAccept%>"+"|";
			opr_info+="|";
      
      
     
 			//opr_info+="取消特服(预约生效)："+tempV2n+"|";
			var offeridsss = $("#offeridstr").val();
			var offernamesss = $("#offernamestr").val();
			
			var sm11= new Array();
					sm11=offeridsss.split("|");
			var sm22= new Array();
					sm22=offernamesss.split("<!--!>");	
			var printinfostrs="";	
					
					for(var i=0;i<sm11.length-1;i++)
			  {
			  	printinfostrs+=sm11[i]+"："+sm22[i]+"，";
			  }	
			  
			if(printinfostrs.length>0) {
				printinfostrs=printinfostrs.substring(0,(printinfostrs.length-1));	 
			}		

		   opr_info+="取消特服(24小时之内生效)："+printinfostrs+"|";
		


   	  note_info4+="备注： <%=work_no%>为客户<%=custname%>做产品变更 "+"|";
 
       note_info4+=""+"|";
			 note_info4+="4G试用商提示："+"|";
			 note_info4+="1、中国移动4G业务需要TD-LTE制式终端支持，并更换支持4G功能的USIM卡、开通4G服务功能；"+"|";
			 note_info4+="2、客户入网时选用或更换支持4G功能USIM卡时，将同时开通4G服务功能；"+"|";
			 note_info4+="3、4G网速较快，办理高档位套餐可以享受更多的流量优惠；"+"|";
			 note_info4+="4、4G业务仅在4G网络所覆盖的范围内提供，中国移动将不断扩大4G覆盖区域、提高服务质量。"+"|";
 
      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
      return retInfo;
    } 
    
		function querinfo(data){
				//找到添加表格的div
				var markDiv=$("#showTab"); 
				markDiv.empty();
				markDiv.append(data);
				
		}

 	function resetPage(){
 		window.location.href = "fm322.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=activePhone%>";
	}

</script>
</head>
<body>
<form name="form1" id="form1" method="POST" >
<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
      <table cellspacing="0">
         <tr> 
            <td width="16%"  > 
              <div align="left" class="blue">手机号码</div>
            </td>
            <td > 
            <div align="left"> 
                <input class="InputGrey" type="text" name="zr_phone" id="zr_phone"  value="<%=activePhone%>"   readonly />
                </div>
            </td>
         
            <td width="16%"  > 
              <div align="left" class="blue">客户姓名</div>
            </td>
             <td > 
            <div align="left"> 
                <input class="InputGrey" type="text"  name="custname" id="custname"  value="<%=custname%>"   readonly />
                </div>
            </td>  
         </tr>
   


		       
	</table>

	<div id="showTab" ></div>
	

              <table cellspacing="0">
          <tr>
            <td noWrap id="footer">
              <div align="center">	
              <input class="b_foot" type=button name="confirm" value="确认" onClick="doCfm(this)" index="2">
              <input class="b_foot" type=button name=back value="清除" onClick="resetPage()">
		      <input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab()">
              </div>
            </td>
          </tr>
        </table>
      <input type="hidden" name="opCode" id="opCode" value="<%=opCode%>" />
      <input type="hidden" name="opName" id="opName" value="<%=opName%>" />
      <input type="hidden" name="offeridstr" id="offeridstr"  />
      <input type="hidden" name="offernamestr" id="offernamestr"  />
      <input type="hidden" name="loginAccept" id="loginAccept" value="<%=loginAccept%>" />
    <%@ include file="/npage/include/footer_simple.jsp"%>
   </form>
</body>
</html>