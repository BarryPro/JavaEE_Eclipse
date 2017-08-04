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
	String[] acceptlist = acceptStr.trim().split("\\|");
	String[] opcodelist = opcodeStr.trim().split("\\|");
	String[] billTypes = new String[acceptlist.length];
	for(int i = 0 ; i < acceptlist.length ; i ++){
	 		billTypes[i] = billType;
	}
	
	String login_name=" ";
	String smSql = "select login_name from dloginmsg where login_no= '"  + work_no + "'";
%>
    <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone" routerValue="<%=activePhone%>" id="seq"/>
		<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=activePhone%>" outnum="1">
    <wtc:sql><%=smSql%>
    </wtc:sql>
		</wtc:pubselect>
		<wtc:array id="login_name_arr" scope="end"/>		
<%
  System.out.println("seq============"+seq);
 	login_name=(login_name_arr.length>0)?login_name_arr[0][0]:"";
	String returnPage = "f7038_1.jsp?activePhone="+activePhone;
	String strHasEval = request.getParameter("haseval");//是否有用户满意度评价 
	String strEvalCode = request.getParameter("evalcode");//用户满意度评价代码 
	System.out.println("strHasEval="+strHasEval);
	System.out.println("strEvalCode="+strEvalCode);

    
 	if (request.getParameter("returnPage") != null) {
	   returnPage = request.getParameter("returnPage");
	}
	
	String year = total_date.substring(0,4);
	String month = total_date.substring(4,6);
	String day = total_date.substring(6,8);
    
	
	//int [] lens ={2,1};
	//CallRemoteResultValue  value  = viewBean.callService("1", org_code.substring(0,2) , "s7143Qry","3", lens , inParas);
%>
		<wtc:service name="sPrt_Qprint" routerKey="phone" routerValue="<%=activePhone%>" outnum="13" >
			<wtc:param value="<%=beginDate%>"/>
			<wtc:param value="<%=seq%>"/>
			<wtc:param value="<%=work_no%>"/>
			<wtc:params value="<%=acceptlist%>"/>
			<wtc:params value="<%=opcodelist%>"/>
			<wtc:params value="<%=billTypes%>"/>
			
		</wtc:service>
		<wtc:array id="result" scope="end"/>	
<%
	String return_code=retCode;
	String error_msg =retMsg;
	//return_code = (result!=null&&result.length>0)?result[0][0]:"999999";
	//error_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(return_code));
	System.out.println("return_code="+return_code+"  error_msg:"+error_msg);
%>
			
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
				for(int i=0;i<result.length;i++){
	%>
					var temResultArr = new Array();
	<%
					for(int j=0;j<result[i].length;j++){
					String tempStr = result[i][j].replaceAll("\r\n","");
					tempStr = tempStr.replaceAll("\"","\\\\\"");
					System.out.println("result["+i+"]["+j+"]=="+tempStr);
	%>
						
						temResultArr[<%=j%>] = "<%=tempStr%>";
	<%				
					}
	%>
					impResultArr[<%=i%>]=temResultArr;
	<%
				}	
	%>
	 if(<%=return_code%>=="000000")
    {	 
    	if(impResultArr.length>0){
        var num = impResultArr.length;//总行数
        var page=Math.ceil((num/45));//每页45行
        var fColor = 0*65536+0*256+0; 
				var x = 0;
        for(var j=0;j<page;j++){
					try{
						//打印初始化
						printctrl.Setup(0);
						printctrl.StartPrint();
						printctrl.PageStart();
							
							for(var i=j*45;i<(j+1)*45;i++){
							 if(i<num){
									if(impResultArr[i][6]=="N"){
										 impResultArr[i][6]=0
									}else{
										 impResultArr[i][6]=5
									} 
										printctrl.PrintEx(parseInt(impResultArr[i][3]),parseInt(impResultArr[i][2]-j*45),impResultArr[i][12],parseInt(impResultArr[i][4]),fColor,impResultArr[i][6],impResultArr[i][11],impResultArr[i][10]);
								}
							 //x++;
							}
						//x = 0;
						//打印结束

						printctrl.PageEnd();
						printctrl.StopPrint();

				  }catch(e){
				  	//alert(e);
				  }
			  }
        document.location.replace("<%=returnPage%>");
      }else{
      	rdShowMessageDialog("打印错误!<br>错误代码：'<%=return_code%>'，错误信息：'<%=error_msg%>'。",0);
			  document.location.replace("<%=returnPage%>");
      }
    }else{
			rdShowMessageDialog("打印错误!<br>错误代码：'<%=return_code%>'，错误信息：'<%=error_msg%>'。",0);
			document.location.replace("<%=returnPage%>");
	  }
</script>
