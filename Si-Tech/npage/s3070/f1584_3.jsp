<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-13
********************/
%>
              
<%
  String opCode = "1584";
  String opName = "申请延长有效期";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%request.setCharacterEncoding("GB2312");%>
<%@page contentType="text/html;charset=Gb2312"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.util.*"%>


<HTML>
<HEAD>
<TITLE>黑龙江BOSS-申请有效期延长</TITLE>
</HEAD>

<BODY>
<FORM action="" method=post name="form1">
</FORM>
</BODY>
</HTML>

<%
  String opCode1 = "1584";
  String opName1 = "申请延长有效期";
/*--------------------------------组织s1259Cfm的传入参数-------------------------------*/
String stream = ReqUtil.get(request,"stream");                    //系统流水      
String theop_code ="1584";                                        //操作代码
String thework_no = (String)session.getAttribute("workNo");                                 //操作工号    
String psw = (String)session.getAttribute("password");                           //工号密码	
String org_code = (String)session.getAttribute("orgCode");									                  //org_code 
String themob = ReqUtil.get(request,"i1");                        //手机号码
String expireTime = ReqUtil.get(request,"expire_time");           //到期时间
String fircash = ReqUtil.get(request,"i20");                      //固定手续费	
String realcash = ReqUtil.get(request,"i19");                     //实际手续费	
String sysnote = ReqUtil.get(request,"sysnote");                  //系统备注	
String donote = ReqUtil.get(request,"tonote");                    //操作备注	
String ip = (String)session.getAttribute("ipAddr");                                        //登陆IP		
float  handcash = Float.parseFloat(realcash);                     //手续费单精度
String regionCode = (String)session.getAttribute("regCode");
String ret_code = "";
String ret_msg = "";

/*--------------------------------开始调用s1259Cfm--------------------------------*/

try{
    //retArray = callView.s1258CfmProcess(stream, theop_code,thework_no, psw,org_code, themob,expireTime, fircash, realcash,sysnote, donote, ip).getList();
%>

    <wtc:service name="s1258Cfm" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
    	    <wtc:param value="<%=stream%>" />
			<wtc:param value="<%=theop_code%>" />
			<wtc:param value="<%=thework_no%>" />
			<wtc:param value="<%=psw%>" />
			<wtc:param value="<%=org_code%>" />				
			<wtc:param value="<%=themob%>" />	
			<wtc:param value="<%=expireTime%>" />
			<wtc:param value="<%=fircash%>" />
			<wtc:param value="<%=realcash%>" />
			<wtc:param value="<%=sysnote%>" />				
			<wtc:param value="<%=donote%>" />
			<wtc:param value="<%=ip%>" />		
		</wtc:service>
		<wtc:array id="result_t2" scope="end" />

<%    

		for(int iii=0;iii<result_t2.length;iii++){
				for(int jjj=0;jjj<result_t2[iii].length;jjj++){
					System.out.println("---------------------result_t2["+iii+"]["+jjj+"]=-----------------"+result_t2[iii][jjj]);
				}
		}
System.out.println("------------code-------------"+code);
System.out.println("------------msg-------------"+msg);
ret_code = code;
ret_msg  = msg;
}
catch(Exception e){
    e.printStackTrace() ;
	  System.out.println("***********call service is failed****************");
}
%>


<%
/*************************************获得打印发票的参数****************************************/
String cardno = ReqUtil.get(request,"icard_no");      //身份证号码
	   //themob = ReqUtil.get(request,"i1");					  //移动号码
String name =   ReqUtil.get(request,"iname");         //用户名称
String address =  ReqUtil.get(request,"iaddr");				//用户地址
	   //realcash = ReqUtil.get(request,"i19");   			//手续费
	   //stream = ReqUtil.get(request,"stream");        //系统流水
/***********************************************************************************************/

%>

<script language="jscript">
function printBill(){
	 var infoStr="";
	 infoStr+='<%=cardno%>'+"|";   //身份证号码                                                  
   infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";  //日期
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=themob%>'+"|";   //移动号码                                                   
	 infoStr+=""+"|";              //合同号码                                                          
	 infoStr+='<%=name%>'+"|";     //用户名称                                                
	 infoStr+='<%=address%>'+"|";  //用户地址   
	 infoStr+="现金"+"|";
	 infoStr+='<%=handcash%>'+"|";
	 infoStr+="申请有效期延长。*手续费："+'<%=handcash%>'+"*流水号："+'<%=stream%>'+"|";
	 location="<%=request.getContextPath()%>/npage/change/chkPrint.jsp?retInfo="+infoStr+"&dirtPage=<%=request.getContextPath()%>/npage/s3070/f1584_1.jsp?ph_no=<%=themob%>";                    
}
</script>

<%if(!ret_code.equals("000000")){%>
    <script language='jscript'>
    var ret_code = "<%=ret_code%>";
    var ret_msg = "<%=ret_msg%>";
    rdShowMessageDialog("查询错误！<br>错误代码：'<%=ret_code%>'。<br>错误信息：'<%=ret_msg%>'。",0);
    history.go(-1);
    </script>
<%}%>

<%if(ret_code.equals("000000")&&handcash>0.0){%>
    <script language="jscript">
    rdShowMessageDialog('操作成功！打印发票.......',2);

    printBill();
    </script>
<%}%>

<%if(ret_code.equals("000000")){%>
    <script language='jscript'>
    rdShowMessageDialog('操作成功！请返回.......',2);
    document.location.replace("f1584_1.jsp?ph_no=<%=themob%>");
    </script>
<%}%>


<%String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode1+
							"&retCodeForCntt="+ret_code+
							"&opName="+opName1+
							"&workNo="+thework_no+
							"&loginAccept="+stream+
							"&pageActivePhone="+themob+
							"&retMsgForCntt="+ret_msg+
							"&opBeginTime="+opBeginTime; %>
<jsp:include page="<%=url%>" flush="true" />