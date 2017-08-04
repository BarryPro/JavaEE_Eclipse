<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-13 页面改造,修改样式
*
********************/
%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ include file="/npage/properties/getRDMessage.jsp" %>

<%!

%>
<%        
	
	String regionCode =  (String)session.getAttribute("regCode");	
	String accepts  = request.getParameter("accepts");	
	String work_no = (String)session.getAttribute("workNo");
	String ywtypes  = request.getParameter("ywtypes");		

	
	//add by diling for 安全加固修改服务列表
	String password = (String) session.getAttribute("password");	
	String  inputParsm [] = new String[17];
	inputParsm[0] = "0";
	inputParsm[1] = "01";
	inputParsm[2] = "m376";
	inputParsm[3] = work_no;
	inputParsm[4] = password;
	inputParsm[5] = "";
	inputParsm[6] = "";
	inputParsm[7] = accepts;
	
	String  divmsg="";
	if("0".equals(ywtypes)) {
		divmsg="强制开关机恢复(批量)-号码操作查询结果";
		inputParsm[2] = "2355";
	}else if("1".equals(ywtypes)) {
		divmsg="强制预销(批量)-号码操作查询结果";
		inputParsm[2] = "1216";
	}
	else if("2".equals(ywtypes)) {
		divmsg="单位客户预销(批量)-号码操作查询结果";
		inputParsm[2] = "m407";
	}
	else if("3".equals(ywtypes)) {
		divmsg="强制销户(批量)-号码操作查询结果";
		inputParsm[2] = "1218";
	}
	


	
%>
     <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAccept" />
     	
	<wtc:service name="sm376Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="8">
			<wtc:param value="<%=inputParsm[0]%>"/>
			<wtc:param value="<%=inputParsm[1]%>"/>
			<wtc:param value="<%=inputParsm[2]%>"/>
			<wtc:param value="<%=inputParsm[3]%>"/>
			<wtc:param value="<%=inputParsm[4]%>"/>
			<wtc:param value="<%=inputParsm[5]%>"/>
			<wtc:param value="<%=inputParsm[6]%>"/>
			<wtc:param value="<%=inputParsm[7]%>"/>
	</wtc:service>

    <wtc:array id="result2" scope="end"  />
	
<HTML><HEAD><TITLE></TITLE>
<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>


<script type="text/javascript">
var miguFlag="N";
function go_check407Print(){
	var pactket2 = new AJAXPacket("/npage/sm407/fm407ChkPrint.jsp","正在进行电子工单状态修改，请稍候......");
	pactket2.data.add("iLoginAccept",<%=accepts%>);
	core.ajax.sendPacket(pactket2,do_checkPrint);
	pactket2=null;
	
}
function do_checkPrint(packet){
	
	var s_ret_code = packet.data.findValueByName("retCode");
	var s_ret_msg = packet.data.findValueByName("retMsg");
	if(s_ret_code=="000000")
	{
		miguFlag=packet.data.findValueByName("miguFlag");
	}
}

function daYin(){
	go_check407Print();
	if("N"==miguFlag){
		if($.trim($("#phoneNums").val())!=""){
			var returnflag=showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
			if(returnflag!=undefined){
				var pactket2 = new AJAXPacket("/npage/sm407/fm407UpDserv.jsp","正在进行电子工单状态修改，请稍候......");
				pactket2.data.add("id_no","0");
				pactket2.data.add("paySeq",<%=accepts%>);
				core.ajax.sendPacket(pactket2,doserv);
				pactket2=null;
			}
		}
		else{
			rdShowMessageDialog("当前执行结果不可打印!只有全部执行完成才可打印,且只打印成功号码!");
		}
 		
	}
	else{
		rdShowMessageDialog("不可以重复打印免填单!");
	}
}	

function doserv(packet)
{
	var s_ret_code = packet.data.findValueByName("s_ret_code");
	var s_ret_msg = packet.data.findValueByName("s_ret_msg");
	if(s_ret_code!="000000")
	{
		//rdShowMessageDialog("更新电子工单状态失败!错误代码:"+s_ret_code+",错误原因:"+s_ret_msg);
	}else{
		//location = location;
	}
}
		  
		  function showPrtDlg(printType,DlgMessage,submitCfm){  //显示打印对话框 
		      var h=180;
		      var w=350;
		      var t=screen.availHeight/2-h/2;
		      var l=screen.availWidth/2-w/2;		   	   
		      var pType="subprint";             				 	//打印类型：print 打印 subprint 合并打印
		      var billType="1";              				 			  //票价类型：1电子免填单、2发票、3收据
		      var sysAccept =<%=accepts%>;             	//流水号
		      var printStr = printInfo(printType);
		      
			 		                      //调用printinfo()返回的打印内容
		      var mode_code=null;           							  //资费代码
		      var fav_code=null;                				 		//特服代码
		      var area_code=null;             				 		  //小区代码
		      var opCode="m407" ;                   			 	//操作代码
		      var phoneNo="";                  //客户电话
		      
		      var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
		      var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
		      path+="&mode_code="+mode_code+
		      	"&fav_code="+fav_code+"&area_code="+area_code+
		      	"&opCode=m407&sysAccept="+sysAccept+
		      	"&phoneNo="+phoneNo+
		      	"&submitCfm="+submitCfm+"&pType="+
		      	pType+"&billType="+billType+ "&printInfo=" + printStr;
		      var ret=window.showModalDialog(path,printStr,prop);
		      return ret;
		    }				
		    
		    var print_info_arr = new Array();
		    /*
		     输出参数：
						客户名称
						证件类型
						证件号码
						经办人姓名
						经办人证件号码
						主资费名称
						主资费描述
		出参。下标从0开始
		*/

				//打印模板id为：93
		    function printInfo(printType){
		      var cust_info="";
		      var opr_info="";
		      var note_info1="";
		      var note_info2="";
		      var note_info3="";
		      var note_info4="";
		      var retInfo = "";
		      var array = new Array();
		      array["8"]="营业执照";
		      array["A"]="组织机构代码";
		      array["B"]="单位法人证书";
		      array["C"]="单位证明";
		      
		      cust_info+="证件类型："+array[$("#zjLxHm").val().split("|")[0]]+"|";
				cust_info+="证件号码："+$("#zjLxHm").val().split("|")[1]+"|";
		      
				opr_info+="业务名称：单位客户预销(批量)"+"|";
				opr_info+="操作流水：<%=accepts%>"+"|";
				opr_info+="是否选择授权销户：否|";
				opr_info+="批量预销手机号码："+$("#phoneNums").val()+"|";
				
				
				var zchmLxhm_Arr = $("#zchmLxhm").val().split("|");
				
				if(zchmLxhm_Arr.length == 5){
					if(zchmLxhm_Arr[2]=="Y"){
						opr_info+="转费手机号码："+zchmLxhm_Arr[3]+"    客户联系电话："+zchmLxhm_Arr[4]+"|";
					}
				}
				
		      
		      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
		      return retInfo;
		    }
</script>
</HEAD>
<body>
    	
	
			<div id="Operation_Table"> 
			<div class="title">
				<div id="title_zi"><%=divmsg%></div>
			</div>
	    <table cellspacing="0" name="t1" id="t1">
	      <tr align="center"> 
	        <th>手机号码</th>
	        <th>操作时间</th>
	        <th>操作工号</th>
	        <th>执行结果</th>
			<th>失败原因</th>			
	      </tr>
		<%
		if(retCode.equals("000000")) {
		//System.out.println(result2.length);
		String phoneNums="";
		boolean resultFlag=false;
		if(result2.length>0) {
			String tbClass="";
			if("2".equals(ywtypes)) {
				%>
				<input type="hidden" id="zjLxHm" name="zjLxHm" value="<%=result2[0][6]%>"/>
				<input type="hidden" id="zchmLxhm" name="zchmLxhm" value="<%=result2[0][7]%>"/>
				<%
			}
			int phoneIndex=0;
			for(int y=0;y<result2.length;y++){
				if(y%2==0){
					tbClass="Grey";
				}else{
					tbClass="";
				}
				if("0".equals(result2[y][3])){
					resultFlag=true;
				}
				if("2".equals(result2[y][3])){
					phoneNums+=result2[y][0]+",";
					if(phoneIndex%5==0){
						phoneNums+="|";
					}
					phoneIndex++;
				}
		%>
						<tr align="center">
						<td class="<%=tbClass%>"><%=result2[y][0]%></td>					
						<td class="<%=tbClass%>"><%=result2[y][1]%></td>
						<td class="<%=tbClass%>"><%=result2[y][2]%></td>
						<td class="<%=tbClass%>"><%=result2[y][5]%></td>
						<%
						if("0".equals(result2[y][3]) || "2".equals(result2[y][3])){
						%>
						<td class="<%=tbClass%>"></td>
					  <%}else{%>
						<td class="<%=tbClass%>"><%=result2[y][4]%></td>
						<%}%>
						
		        </tr>
		<%
		    }
			if(resultFlag){
				phoneNums="";
			}
			if("2".equals(ywtypes)) {%>
					<tr align="center">
						<td colspan="5"><input type="hidden" id="phoneNums" name="phoneNums" value="<%=phoneNums%>"/><input type="button" class="b_foot_long" value="打印免填单" onclick="daYin();"/></td>
		        	</tr>
		<%}
			
		  }else {
		%>
<tr height='25' align='center' ><td colspan='5'>查询号码操作信息为空！</td></tr>
<%}}else {
			%>
			<tr height='25' align='center'><td colspan='5'>查询失败：<%=retCode%>--<%=retMsg%></td></tr>

					<%
	}%>
		</table>

	</BODY>
</HTML>