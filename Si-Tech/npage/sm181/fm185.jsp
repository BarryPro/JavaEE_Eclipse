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
		String loginNoPass = (String)session.getAttribute("password");
		String ipAddrss = (String)session.getAttribute("ipAddr");
		String beizhussdese="根据phoneNo=["+activePhone+"]进行查询";

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
          System.out.println("custname+++++++"+custname);        
          }
    }
%>    
    
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>"  id="loginAccept" />
	
	<wtc:service name="sMarkMsgQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="10" >
	<wtc:param value="0"/>
	<wtc:param value="01"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=work_no%>"/>
	<wtc:param value=""/>
	<wtc:param value="<%=activePhone%>"/>
	<wtc:param value=""/>
	<wtc:param value=""/>
	</wtc:service>
	<wtc:array id="result" scope="end"  start="0"  length="3"/>	
		<%
			if(retCode1.equals("000000")) {
					if(result.length>0) {
					kyjfz=result[0][0];
					}
			}else {
%>
	<script language="javascript">
		rdShowMessageDialog("查询当前用户可用积分失败！错误代码：<%=retCode1%>，错误信息：<%=retMsg1%>");
	</script>
<%				
				}
		%>	
	
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
  onload=function()
  {
  		
	var myPacket = new AJAXPacket("fm185Qry.jsp","正在查询信息，请稍候......");
	myPacket.data.add("phone_no",$("#zr_phone").val());
	myPacket.data.add("banlitype","00");

	core.ajax.sendPacketHtml(myPacket,querinfo,true);
	getdataPacket = null;
  
  }

 function doCfm(){

 
	    	var xuanzhongsrephone = $("#srephonenumber").val();	
	    	if(xuanzhongsrephone=="") {
	    		rdShowMessageDialog("请选择要操作的受让人号码！");
   			  return false;			
	    		}   
	     
				var zz_jf = $("#zz_jf").val();				
				if(zz_jf.trim()=="") {
	        rdShowMessageDialog("转让积分不能为空！");
   			  return false;					
				}
				
				var kyjfvalue = $("#kyjfvalue").val();
				if(Number(zz_jf)>Number(kyjfvalue)) {
					rdShowMessageDialog("转赠积分不能超过转赠人当前可用积分！");
   			  return false;		
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
				document.form1.action = "fm185Cfm.jsp";
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
      
      cust_info+="手机号码：   "+"<%=activePhone%>"+"|";
      cust_info+="客户姓名：    <%=custname%>|";
      opr_info +="业务受理时间：" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' +  "|";
      opr_info +="业务类型：积分转赠    操作流水: "+"<%=loginAccept%>" +"|";     
      opr_info +="转赠手机号码："+$("#zr_phone").val()+"    被转赠手机号码："+$("#srephonenumber").val()+"|";
      opr_info +="转赠积分值："+$("#zz_jf").val()+"|";
 
      
      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
      return retInfo;
    } 
    
 
 function returnvalues(srephonenumber) {
	
	$("#srephonenumber").val(srephonenumber);	
		
}
 
		
		function listtype()
{
		var phoneNo = $("#sr_phone").val();
		
		if(!checkElement(document.all.sr_phone)){
			return false;
		}

		if(phoneNo.trim()!="") {
    var myPacket = new AJAXPacket("queryCustname.jsp", "正在查询客户信息，请稍候......");
    myPacket.data.add("phoneNo", phoneNo);
    core.ajax.sendPacket(myPacket,doShowName);
    myPacket = null;
    }
}

function doShowName(packet){
  var retCode = packet.data.findValueByName("retCode");
  var retMsg = packet.data.findValueByName("retMsg");
  var custname = packet.data.findValueByName("custname");
  if(retCode!="000000"){
    rdShowMessageDialog("取用户名出错，错误代码："+retCode+"<br>错误信息："+retMsg,0);
    return false;
  }else{			
			$("#sr_name").val(custname);
  }
}

		function querinfo(data){
				//找到添加表格的div
				var markDiv=$("#showTab"); 
				markDiv.empty();
				markDiv.append(data);
				
		}

 	function resetPage(){
 		location = location;
	}

function relatLink_m181(){
		parent.parent.parent.L('2','m181','积分转赠受让人设置','sm181/fm181.jsp','1');
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
              <div align="left" class="blue">转让人手机号码</div>
            </td>
            <td > 
            <div align="left"> 
                <input class="InputGrey" type="text" name="zr_phone" id="zr_phone" v_must="1" v_type="mobphone" v_must=1 value="<%=activePhone%>"  maxlength=11 index="3" readonly />
                </div>
            </td>
         
                    <td width="16%"  > 
              <div align="left" class="blue">可用积分</div>
            </td>
             <td > 
            <div align="left"> 
                <input class="InputGrey" type="text"  name="kyjfvalue" id="kyjfvalue"  value="<%=kyjfz%>"   readonly />
                </div>
            </td>  
         </tr>
   
         		  <TR> 
	    
	             <td width="16%"  > 
              <div align="left" class="blue">转赠积分值</div>
            </td>
            <td colspan="3"> 
            <div align="left"> 
                <input  type="text" name="zz_jf" id="zz_jf"  value=""  onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
                <font class='orange'>*</font>
                </div>
            </td>
         </TR> 

		       
	</table>

	<div id="showTab" ></div>
	

         <table cellspacing="0">
          <tr>
            <td noWrap id="footer">
              <div align="center">	
              <input class="b_foot" type=button name="confirm" value="确认" onClick="doCfm(this)" index="2">
              <input class="b_foot" type=button name=back value="刷新" onClick="resetPage()">
		      		<input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab()">
              </div>
            </td>
          </tr>
          <tr><td align="center"><font class="orange">设置完成后请刷新界面更新信息</font></td></tr>
        </table>
      <input type="hidden" name="opCode" id="opCode" value="<%=opCode%>" />
      <input type="hidden" name="opName" id="opName" value="<%=opName%>" />
      <input type="hidden" name="srephonenumber" id="srephonenumber" />
      <input type="hidden" name="loginAccept" id="loginAccept" value="<%=loginAccept%>" />
    <%@ include file="/npage/include/footer_simple.jsp"%>
       <div class="relative_link">
					<span>相关链接：</span><a href="#" onclick="relatLink_m181()">m181·积分转赠受让人设置 </a>
				</div>    
   </form>
</body>
</html>