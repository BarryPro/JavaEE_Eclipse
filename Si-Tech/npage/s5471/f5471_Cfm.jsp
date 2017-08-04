<% /******************** version v2.0 开发商: si-tech * *update:zhanghonga@2008
          -08-19 页面改造,修改样式 * ********************/ %> 
<%@ page contentType="text/html;charset=GBK"%> 
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page import="java.text.*"%>
<%@ page import="com.sitech.boss.pub.util.*" %> 
<% 	
		String opCode2 =(String)request.getParameter("opCode"); 
		if (opCode2 == null){ opCode2 = "1270";} 
%> 
<%! /**这个方法是用来格式化后面的小写金额的**/ 
public static String formatNumber(String num, int zeroNum) 
{ 
	DecimalFormat form =(DecimalFormat)NumberFormat.getInstance(Locale.getDefault()); 
	StringBuffer patBuf = new StringBuffer("0"); 
	if(zeroNum > 0) 
	{ 
		patBuf.append("."); for(int i= 0; i < zeroNum; i++) { patBuf.append("0"); }
  }
  form.applyPattern(patBuf.toString());
  return form.format(Double.parseDouble(num)).toString();
}
%>
<%
	String regionCode = WtcUtil.repNull(request.getParameter("region_code"));
	String work_name = (String)session.getAttribute("workName");
	String thework_no = (String)session.getAttribute("workNo");                                   //操作工号                    0  操作工号 iLoginNo                          
	String psw =(String)session.getAttribute("password");                                         //工号密码					1  工号密码 iLoginPwd                           
	String MonthRent = WtcUtil.repNull(request.getParameter("month_rent_fee"));
	String ipAddr = WtcUtil.repNull(request.getParameter("ipAddr"));
	String serviceName="";
%>
<HTML>
<head>
</HEAD>
<BODY>
<FORM action="" method=post name="form1">
</FORM>
<BODY>
</HTML>
<%      
/*--------------------------------组织sCfm的传入参数-------------------------------*/
String theop_code = "5471";                         //操作代码					2  iOpCode                                                                             //登陆IP					    16 登录IP  iIpAddr                            										
String returnPage = WtcUtil.repNull(request.getParameter("return_page"));
String vModeCode = WtcUtil.repNull(request.getParameter("mode_code"));
String op_flag = WtcUtil.repNull(request.getParameter("op_flag"));
String opTime = WtcUtil.repNull(request.getParameter("begin_time"));											  
String stream = WtcUtil.repNull(request.getParameter("stream"));       //系统流水												  
String opNote = WtcUtil.repNull(request.getParameter("opNote"));
%>
<%

/*--------------------------------开始调用sCfm--------------------------------*/
		String [] RegionCodes = regionCode.split(",");
		String [] ModeCodes = vModeCode.split(",");
		String paraAray[] = new String[9];	
		paraAray[0] = "(参见RegionCodes数组,未传此参数)"; // 地市代码		
		paraAray[1] = "(参见vModeCode数组,未传此参数)"; //  资费代码 
		paraAray[2] = MonthRent; //		月租费    
		paraAray[3] = thework_no; //0  操作工号                iLoginNo  thework_no
		paraAray[4] = psw; //4  工号密码                iLoginPwd psw                      		           
		paraAray[5] = opTime; //5 开通时间    
		paraAray[6] = op_flag; //6  操作标志  
		paraAray[7] = opNote; //7  备注   
		paraAray[8] = theop_code; //8  操作代码 
				
	for(int i=0;i<paraAray.length;i++){
		System.out.println("paraAray["+i+"]="+paraAray[i]);
	}		
%>
		<wtc:service name="s5471Cfm" routerKey="regioncode" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:params value="<%=RegionCodes%>"/>
		<wtc:params value="<%=ModeCodes%>"/>
		<wtc:param value="<%=paraAray[2]%>"/>
		<wtc:param value="<%=paraAray[3]%>"/>
		<wtc:param value="<%=paraAray[4]%>"/>
		<wtc:param value="<%=paraAray[5]%>"/>
		<wtc:param value="<%=paraAray[6]%>"/>
		<wtc:param value="<%=paraAray[7]%>"/>
		<wtc:param value="<%=paraAray[8]%>"/>
		</wtc:service>
		<wtc:array id="result4" scope="end"/>	
<%	
		int ret_code = 999999;	
		if(retCode!=""){
			ret_code = Integer.parseInt(retCode);
		}
        String ret_msg = retMsg;
		System.out.println("ret_code=====222=============="+ret_code);
	
		System.out.println("%%%%%%%调用统一接触开始%%%%%%%%");	
		String cnttLoginAccept = "";
		String opName2 = (String)request.getParameter("opName");
		System.out.println("%%%%%%%传入参数 theop_code%%%%%%%%"+theop_code);	
		System.out.println("%%%%%%%传入参数 retCode%%%%%%%%"+retCode);	
		System.out.println("%%%%%%%传入参数 opName2%%%%%%%%"+opName2);	
		System.out.println("%%%%%%%传入参数 thework_no%%%%%%%%"+thework_no);	
		System.out.println("%%%%%%%传入参数 stream%%%%%%%%"+stream);	
			
		String url = "/npage/contact/upCnttInfo.jsp?opCode="+theop_code+"&retCodeForCntt="+retCode+"&opName="+opName2+"&workNo="+thework_no+"&loginAccept="+stream+"&opBeginTime="+opBeginTime+"&contactType=user";
		System.out.println("%%%%%%%传入参数 url%%%%%%%%"+url);
%>
		<jsp:include page="<%=url%>" flush="true" />
<%	
		System.out.println("%%%%%%%调用统一接触结束%%%%%%%%");

/*------------------------------依据调用服务返回结果进行页面跳转------------------------------*/
%>
</script>

<%if(ret_code==0){%>
<script language='jscript'>
rdShowMessageDialog('操作成功！',2);
if("<%=returnPage%>"!="") 
{
  if("<%=op_flag%>"=="A" || "<%=op_flag%>"=="U") 
  {
 		location="<%=returnPage%>";
  }
  else if("<%=op_flag%>"=="D")
  {
  	parent.location="/npage/s5471/f5471login.jsp?opName=<%=opName2%>&opCode=<%=theop_code%>";
  }	
}

else
{
  parent.removeTab('<%=opCode2%>');
}
</script>
<%}%>



<%if(!(ret_code==0)){%>
<script language='jscript'>
	var ret_code = "<%=ret_code%>";
	var ret_msg = "<%=ret_msg%>";
	rdShowMessageDialog("查询错误！<br>错误代码：'<%=ret_code%>'。<br>错误信息：'<%=ret_msg%>'。");
	history.go(-2);
</script>
<%}%>
