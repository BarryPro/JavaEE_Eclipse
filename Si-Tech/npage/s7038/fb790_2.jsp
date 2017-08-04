<%
    /********************
     version v2.0
     开发商: si-tech
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/innet/getPrintOrderFtpPas.jsp" %><!-- 得到密码 -->



<%
	response.setHeader("Pragma","No-Cache");
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0);
  
  String opName = "电子化工单查询";   
	String opCode="b790";
	
	String workNo = (String)session.getAttribute("workNo");	
	String regionCode= (String)session.getAttribute("regCode");
	
	String queryType = (String)request.getParameter("queryType");
	String phone_no = (String)request.getParameter("phone_no");
	
  String begin_login = request.getParameter("begin_login");
	String end_login = request.getParameter("end_login");
	String groupId = request.getParameter("groupId");	
	String begin_date = request.getParameter("begin_time");
	String end_date = request.getParameter("end_time");	
	System.out.println("begin_login======"+begin_login);
	System.out.println("end_login======"+end_login);
	
	String work_no = request.getParameter("work_no");		
	
	String orderPasPropPath = request.getRealPath("npage/innet/configFtpPrintOrderPas.properties");
	System.out.println("------------------orderPasPropPath----------"+orderPasPropPath);
	String ftpPwd = getPas(orderPasPropPath);
	System.out.println("------------------getPas()----------"+ftpPwd);
	
	String custIdNo = "";
	String regCode = "";
	/*0 按手机号，1按工号*/
	String prtSql = "";
if ("1".equals(queryType)  )
{
	String sqlRegion="select substr(a.org_code,1,2) from dloginmsg a where login_no between '"
		+ begin_login +"' and '"+ end_login +"'";
%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
	    	<wtc:sql><%=sqlRegion%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="regCodeArr" scope="end"/>		
<%
	if (regCodeArr.length==0) 
	{
%>
		<script language="JavaScript">
			rdShowMessageDialog("未能查询到工号 "+work_no+" 信息! ",0);
			window.location="fb790_1.jsp";
		</script>
<%
	}
	else
	{
  		regCode = regCodeArr[0][0];
  		System.out.println("--++++++++++++++++++---regCode--------------------------"+regCode);
  	}	
	prtSql=" select distinct a.print_accept, a.phone_no, a.op_code, b.function_name, "+
		"to_char(a.op_time, 'yyyy-mm-dd hh24:mi:ss') , d.note_msg " +
		" from wHandWritePrt a, sfunccodenew b, dloginmsg c , dServOrderPrtMsg d "+
		" where a.op_code = b.function_code "+
		" and a.login_no = c.login_no "+
		" and a.print_accept = d.login_accept(+) "+
		" and a.group_id = '"+groupId+"' "+
		" and a.login_no between '"+begin_login+"' and '"+end_login+"' "+
		//" and a.op_time >= to_date('"+ begin_date.substring(0,8) +
		//" and a.op_time <= to_date('"+ end_date.substring(0,8) +
		" and a.op_time between to_date('"+ begin_date.substring(0,8) +
		" 00:00:00', 'yyyymmdd hh24:mi:ss') "+
		" and to_date('"+ end_date.substring(0,8) +
		" 23:59:59', 'yyyymmdd hh24:mi:ss') "+
		" order by a.print_accept " ;
	}
	else
	{
		prtSql =  " SELECT distinct T.PRINT_ACCEPT, t.phone_no , T.OP_CODE, T1.OP_NAME,          "+
					"      TO_CHAR(T.OP_TIME, 'yyyy-mm-dd hh24:mi:ss')  , d.note_msg     "+
					" FROM WHANDWRITEPRT T, SFUNCCODENEW T1   , dServOrderPrtMsg d               "+
					" where t.op_code = t1.function_code                     "+
					" and T.print_accept = d.login_accept(+) "+
					//"	and t.op_time >= to_date('"+
					" and t.op_time between  to_date('"+
					begin_date.substring(0,8) +" 00:00:00' , 'yyyymmdd hh24:mi:ss')  "+
					//"	and t.op_time <= to_date ('"+
					" and to_date ('"+
					end_date.substring(0,8)+" 23:59:59' , 'yyyymmdd hh24:mi:ss')  "+
					" and t.phone_no = '"+phone_no+"'    order by t.print_accept";
	}

  System.out.println("--------------------prtSql--------------------------"+prtSql);
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" outnum="6">
    	<wtc:sql><%=prtSql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="prtOrdArr" scope="end"/>		
<% 
		if (prtOrdArr.length==0) {
%>
		  <script language="JavaScript">
		    rdShowMessageDialog("未能查询到此服务号码的免填单打印信息! ");
		    window.location="fb790_1.jsp";
		  </script>
<% 
			return;
		}
%>
<HTML>
<HEAD>
<TITLE>电子化工单查询</TITLE>
<SCRIPT LANGUAGE="JavaScript">
<!--

/*************************** 从文件系统服务器ftp下载至weblogic服务器 start **********************************/
function doFtpDownLoad(regCode,printDate,loginAccept,retType){
	
	var print_Packet = new AJAXPacket("fb790_hw_download.jsp","正在下载，请稍候......");
	print_Packet.data.add("retType",retType);
	print_Packet.data.add("loginAccept",loginAccept);
	print_Packet.data.add("regCode",regCode);
	print_Packet.data.add("printDate",printDate);
	print_Packet.data.add("ftpPwd","<%=ftpPwd%>");	
	core.ajax.sendPacket(print_Packet,getdoFtpDownLoad);
	print_Packet=null;
}
function getdoFtpDownLoad(packet){
	var retCode = packet.data.findValueByName("errCode"); 
  var retMessage = packet.data.findValueByName("errMsg");
	if(retCode!="000000")
  {
		rdShowMessageDialog("web服务器操作电子化工单<br/>错误代码："+retCode+"<br/>错误信息："+retMessage, 0);
  }
}
/***************************** 从文件系统服务器ftp下载至weblogic服务器 end ***********************************/


function loadOrder(regCode,prtDate,prtAcc,orderModel,agreeModel){

		doFtpDownLoad(regCode,prtDate,prtAcc,"download");	
		try{
			var fso = new ActiveXObject("Scripting.FileSystemObject");  //取系统文件对象
		}catch(e){
			rdShowMessageDialog("请设置客户端安全性",0);
			return false;
		}
		if(fso!=undefined)
		{
			tmpFolder = fso.GetSpecialFolder(0); //取得系统安装目录
			var strtemp= tmpFolder+"";
			var filep1 = strtemp.substring(0,1)//取得系统目录盘符
			var agree_model_dir = "";
			var crmOrderDir = "http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/npage/crm_order/" ;
			var order_dir = crmOrderDir+prtAcc+"_<%=workNo%>.pdf";
			var order_model_dir = crmOrderDir+"orderModel/om_"+orderModel+".aip";
			if(agreeModel!="0"){
				agree_model_dir = crmOrderDir+"agreeModel/am_"+agreeModel+".aip";
			}
			virtualprint.CloseDoc(0);
			virtualprint.netagree_model_dir = agree_model_dir ;			
			
			var ret1 = virtualprint.LoadOrder("1",order_dir,order_model_dir);//读取工单
			if(ret1=="00"){
				doFtpDownLoad(regCode,prtDate,prtAcc,"delete");				//删除weblogic服务器工单  	
			}
		}else{
			rdShowMessageDialog("取系统文件对象 Scripting.FileSystemObject 失败",0);
			return false;
		}
}

function loadICCID(regCode,prtDate,prtAcc){
	document.all.b3_flag.value = "b3_"+prtAcc;
	var winStyle = 'height=200, width=400, top=300, left=300, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no';
	var path = "fb790_2_update.jsp?showBody=01";
	window.open(path,"newwindow",winStyle);
	
}

function updateOrder(regCode,prtDate,prtAcc){
	
	doFtpDownLoad(regCode,prtDate,prtAcc,"download");	
	try{
		var fso = new ActiveXObject("Scripting.FileSystemObject");  //取系统文件对象
	}catch(e){
		rdShowMessageDialog("请设置客户端安全性",0);
		return false;
	}
	if(fso!=undefined)
	{
		tmpFolder = fso.GetSpecialFolder(0);
		var strtemp= tmpFolder+"";
		var filep1 = strtemp.substring(0,1)
		var order_dir1 = filep1+":\\"+prtAcc+"_<%=workNo%>_old.pdf";
		var order_dir2 = filep1+":\\"+prtAcc+"_<%=workNo%>.pdf";
	}
	/** 下载电子工单 start **/	
	virtualprint.CloseDoc(0);
	var ret1 = virtualprint.LoadFileEx("http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/npage/crm_order/"+prtAcc+"_<%=workNo%>.pdf","pdf",0,0);
	var ret2 = virtualprint.SaveTo(order_dir1,"pdf",0);
	if(ret1==1 && ret2==1){
		doFtpDownLoad(regCode,prtDate,prtAcc,"delete");
		
		var cust_picture_dir = filep1+":\\custID\\print_iccid.jpg";
		var cust_picture_dir2 = filep1+":\\custID\\print_iccid2.jpg";
		var cust_infor_str_dir = filep1+":\\custID\\print_iccid_str.txt";
		var cust_infor_str_dir2 = filep1+":\\custID\\print_iccid_str2.txt";
		var cust_infor_str = "";
		var cust_infor_str2 = "";
			
		virtualprint.CloseDoc(0);
		if(fso.FileExists(cust_picture_dir)){//第一张身份证
			if(fso.FileExists(cust_infor_str_dir)){
				var iccidfile = fso.OpenTextFile(cust_infor_str_dir, 1);
				cust_infor_str = iccidfile.ReadLine();
			}else{
				cust_infor_str = "";
			}
		}else{
			cust_picture_dir = "";
			cust_infor_str = "";
			rdShowMessageDialog("请先录入身份证信息！",0);
		}		
		if(fso.FileExists(cust_picture_dir2)){//第二张身份证
			if(fso.FileExists(cust_infor_str_dir2)){
				var iccidfile = fso.OpenTextFile(cust_infor_str_dir2, 1);
				cust_infor_str2 = iccidfile.ReadLine();
			}else{
				cust_infor_str2 = "";
			}
		}else{
			cust_picture_dir2 = "";
			cust_infor_str2 = "";
		}

		virtualprint.cust_picture_dir = cust_picture_dir;
		virtualprint.cust_infor_str = cust_infor_str;
		virtualprint.cust_picture_dir2 = cust_picture_dir2;
		virtualprint.cust_infor_str2 = cust_infor_str2;
		var ret = virtualprint.ChangeCustInfo(2, order_dir1, order_dir2);
		alert(ret);
		if(ret=="00"){
			virtualprint.CloseDoc(0);
			/****  工单上传web服务器  start ****/		
			var ret1 = virtualprint.HttpInit();
	  		var ret2 = virtualprint.HttpAddPostFile("FileContent",order_dir2);
	  		var ret4 = virtualprint.HttpPost("http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/npage/innet/pubHW_upload.jsp?loginAccept="+prtAcc+"&dateStr="+prtDate);	  		
	  		/****  工单上传web服务器  end ****/
	  		if(ret1==1 && ret2==1 && ret4=="succeed"){	  			
	  			rdShowMessageDialog("电子工单修改成功！", 2);
				var b3_prtacc = "b3_"+prtAcc;
				document.getElementById(b3_prtacc).disabled = true ;
	  			
				f1 = fso.GetFile(order_dir1);
				f1.Delete();
				f2 = fso.GetFile(order_dir2);
				f2.Delete();
				if(fso.FolderExists(filep1+":\\custID")){
					fso.DeleteFolder(filep1+":\\custID",true);
				}				
	  		}else{
	  			rdShowMessageDialog("手写板接口信息，上传工单(01)<br/>ret1："+ret1+"<br/>ret2："+ret2, 0);
	  			alert("手写板接口信息，上传工单(02)\n"+ret4);
	  		}
		}else{
			rdShowMessageDialog("手写板接口信息，工单修改失败！", 0);
		}		
	}else{
		rdShowMessageDialog("手写控件下载信息（下载电子工单）<br/>ret1："+ ret1 +"<br/>ret2："+ ret2,0);
	}
	/** 下载电子工单 end **/
}


function loadOrderNew(regCode,prtDate,prtAcc){
	window.open("http://10.110.0.100:59000/bp006.go?method=crmReadInit&sysAccept="+prtAcc+"&opTime="+prtDate);

}
function updateOrderNew(regCode,prtDate,prtAcc){
	var iccidInfo = $("#updateInfo").val();
	window.open(form.action = "http://10.110.0.100:59000/bp006.go?method=crmModifyInit&sysAccept="+prtAcc+"&iccidInfo="+iccidInfo);
	
}

//-->
</SCRIPT>
</HEAD>
<BODY leftmargin="0" topmargin="0">
	
<FORM action="" method=post name=form>
		<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
		    <div id="title_zi">免填单明细</div>
		</div>
		<table cellspacing="0">
		  <tr align="left">		       
		       <th>打印流水</th>
		       <th>电话号码</th>
		       <th>业务名称</th>		       
		       <th>操作时间</th>
		       <th>操作备注</th>		       
		       <th>读取</th>	       
		   </tr>
		<% 
		String tbclass="";
		for(int i=0; i < prtOrdArr.length  ; i++)
	{
			tbclass=(i%2==0)?"Grey":"";
		%>
			<tr align="left">
			  <td class="<%=tbclass%>">
				<div><%=prtOrdArr[i][0]%></div>
			  </td>
			  <td class="<%=tbclass%>">
				<div><%=prtOrdArr[i][1]%></div>
			  </td>
			   <td class="<%=tbclass%>">
				<div><%=prtOrdArr[i][2]+"-"+prtOrdArr[i][3]%></div>
			  </td>

			  <td class="<%=tbclass%>">
				<div><%=prtOrdArr[i][4]%></div>
			  </td>
			  			  <td class="<%=tbclass%>">
				<div><%=prtOrdArr[i][5]%></div>
			  </td>
			  
			  <td class="<%=tbclass%>">
					<input type="button" name="b1_<%=prtOrdArr[i][0]%>" class="b_text"   value="读取" onclick="loadOrderNew('<%=regCode%>','<%=prtOrdArr[i][4]%>','<%=prtOrdArr[i][0]%>')">
			  </td>
			</tr>
    <%}%>
		</table>
		<table>
			<tr>
			<td id="footer">
				  <input class="b_foot" name=doBackButton type=button value=返回 onclick="JavaScript:history.go(-1)">
				  <input class="b_foot" type="button" name="return2" value="关闭" onClick="parent.removeTab('<%=opCode%>')"  >
        </td>
      </tr>
    </table>
    <input type="hidden" value="" name="b3_flag">
    <input type="hidden" value="" name="updateInfo" id="updateInfo">
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
<!-- 
加载 handwrite 虚拟打印控件 
include file="/npage/innet/pubHWPrint.jsp"
-->

</BODY>
</HTML>

