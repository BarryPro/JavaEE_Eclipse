<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *update:zhanghonga@2008-09-06 页面改造,修改样式
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%
	java.util.Random r = new java.util.Random();
	int ran = r.nextInt(9999);
	int ran1 = r.nextInt(10)*1000;
	if ((ran+"").length()<4) {
		ran = ran+ran1;
	}
	int key = 99999;
	int realKey = 0;
	if (request.getParameter("realKey") == null) {
		realKey = ran ^ key;
	} else {
		realKey = Integer.parseInt(request.getParameter("realKey"));
	}
	System.out.println("====wanghfa====pubBillPrintCfm.jsp==== 随机取realKey = " + realKey);

	String org_code = (String)session.getAttribute("orgCode");
	String total_date = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String total_date2 = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	String acceptStr = request.getParameter("acceptStr");
    String work_no = request.getParameter("work_no");
	String phone_no = request.getParameter("phone_no");
	String opCode=request.getParameter("opCode");
	String beginDate=request.getParameter("beginDate");
	String endDate=request.getParameter("endDate");
	String queryDate=beginDate.substring(0,6);
	String idNo=request.getParameter("idNo");
	String opcodeStr = request.getParameter("opcodeStr");
	String billType = request.getParameter("billType");
	System.out.println("acceptStr="+acceptStr);
	System.out.println("billType="+billType);
	
	
	String returnPage = "fb549_1.jsp?activePhone="+activePhone;
	String strHasEval = request.getParameter("haseval");//是否有用户满意度评价 
	String strEvalCode = request.getParameter("evalcode");//用户满意度评价代码 
	System.out.println("strHasEval="+strHasEval);
	System.out.println("strEvalCode="+strEvalCode);
	
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="printAccept"/>

<wtc:service name="sBillPrt_Print" routerKey="phone" routerValue="<%=phone_no%>" retcode="retCode" retmsg="retMsg" outnum="13" >
	<wtc:param value="<%=acceptStr%>"/>
	<wtc:param value="<%=opcodeStr%>"/>
	<wtc:param value="<%=billType%>"/>
	<wtc:param value="<%=phone_no%>"/>
</wtc:service>
<wtc:array id="result" scope="end"/>

<html>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<body >
<OBJECT
classid="clsid:0CBD5167-6DF3-45C4-AC69-852C6CB75D32"
codebase="/ocx/PrintEx.cab#version=1,1,0,3"
id="printctrl"
style="DISPLAY: none"
VIEWASTEXT
>
</OBJECT>
</body>
</html>



<SCRIPT language="JavaScript">
var impResultArr = new Array();	

	<%
			System.out.println("====wanghfa==== result.length = "+result.length);
			if(result.length>0){
				for(int i=0;i<result.length;i++){
	%>
					var temResultArr = new Array();
	<%
					System.out.println("====wanghfa==== result[i].length = "+result[i].length);
					for(int j=0;j<result[i].length;j++){
					System.out.println("result["+i+"]["+j+"]=="+result[i][j]);
	%>
						
						temResultArr[<%=j%>] = "<%=result[i][j].replaceAll("\r\n","")%>";
	<%				
					}
	%>
					impResultArr[<%=i%>]=temResultArr;
	<%
				}
			}
	%>
	
  	if("<%=retCode%>"=="000000")
    {
    		var fColor = 0*65536+0*256+0;
				try{
					/*打印初始化*/
					printctrl.Setup(0);
					printctrl.StartPrint();
					printctrl.PageStart();
					
					printctrl.Print(16,4,9,0, "防伪码：<%=ran%>");	//发票防伪码
					var infoStr = "";
						for(var i=0;i<impResultArr.length;i++){
									if(impResultArr[i][6]=="N"){
										 impResultArr[i][6]=0
									}else{
										 impResultArr[i][6]=5
									}
							infoStr += impResultArr[i][10] + "|";
							printctrl.PrintEx(parseInt(impResultArr[i][3]),parseInt(impResultArr[i][2]),impResultArr[i][12],parseInt(impResultArr[i][4]),fColor,impResultArr[i][6],impResultArr[i][11],impResultArr[i][10]);
							
						}
						
					//打印结束
					printctrl.PageEnd();
					printctrl.StopPrint();
					
					
					var h=180;
					var w=350;
					var t=screen.availHeight/2-h/2;
					var l=screen.availWidth/2-w/2;
					var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
					
					var path = "/npage/innet/pubBillPrintCfm.jsp?dlgMsg=";
					var loginAccept = "<%=printAccept%>";
					var pBillDate = "<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>";
					var pBillPhone = "<%=phone_no%>";
					var path = path + "&infoStr="+infoStr+"&loginAccept="+loginAccept+"&pBillDate="+pBillDate+"&pBillPhone="+pBillPhone+"&opCode=<%=opCode%>&submitCfm=submit&realKey=<%=realKey%>";
					var ret=window.showModalDialog(path, "", prop);
					
			  }catch(e){
			  	alert(e);
			  }finally{
					
					rdShowMessageDialog("发票补打成功！");
					document.location.replace("<%=returnPage%>");
				}
    } else {
			rdShowMessageDialog("发票补打失败！错误代码："+"<%=retCode%>"+"错误信息："+"<%=retMsg%>");
			document.location.replace("<%=returnPage%>");
    }
    
</SCRIPT>