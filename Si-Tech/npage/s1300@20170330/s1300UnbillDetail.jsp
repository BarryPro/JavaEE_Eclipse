<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-18 页面改造,修改样式
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
 <%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0);
    
  String opCode = "1302";
	String opName="账号缴费";
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	//计算时间
	Calendar calendar = new GregorianCalendar();
	int year = calendar.get(Calendar.YEAR);
	int month = calendar.get(Calendar.MONTH);
  int day = 1;
	String Month ="";
	String LastMonth ="";
	if(month<10){
		Month="0"+month;
		LastMonth=year+Month+"01";
	}	
	
//System.out.println("LastMonth ="+LastMonth);
        
  Date date = new Date();
	String yearmonth = new java.text.SimpleDateFormat("yyyyMMdd").format(date);

//System.out.println("yearmonth222222 ="+yearmonth);
    
	String in_phoneno = request.getParameter("phone_no");    
	String in_contractno = request.getParameter("contractno");
    
	String in_begin_time = yearmonth.substring(0,6) + "01";
  	String in_end_time = yearmonth;
  	String workno = (String)session.getAttribute("workNo");
	 
	String inParas[] = new String[8];
  inParas[0] = "2";
	inParas[1] = in_phoneno;
	inParas[2] = in_begin_time;
	inParas[3] = in_end_time;
	inParas[4] = "2";
  inParas[5] = in_contractno;
  inParas[6] = workno;
  inParas[7] = opCode;

 	//CallRemoteResultValue value = viewBean.callService("2",in_phoneno,"s1524_Qry","8",lens,inParas);
%>
	<wtc:service name="s1524_Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="23" >
	<wtc:param value="<%=inParas[0]%>"/>
	<wtc:param value="<%=inParas[1]%>"/>
	<wtc:param value="<%=inParas[2]%>"/>
	<wtc:param value="<%=inParas[3]%>"/>
	<wtc:param value="<%=inParas[4]%>"/>
	<wtc:param value="<%=inParas[5]%>"/>
	<wtc:param value="<%=inParas[6]%>"/>
	<wtc:param value="<%=inParas[7]%>"/>
	</wtc:service>
	<wtc:array id="result1" start="0" length="2" scope="end"/>
	<wtc:array id="result2" start="2" length="6" scope="end"/>	
<%
  String record_num = result1[0][0];
	String return_code = result1[0][1];
 	String error_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(return_code));
%>

<HTML>
<HEAD>
<TITLE>未出帐话费明细查询</TITLE>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
</head>

<BODY>
<form name="frm" method="post" action="">      
  <%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">未出帐话费明细</div>
		</div>

  <table cellspacing="0">
      <tr align="center"> 
         <th>帐单年月</th>
				 <th>批次</th>
				 <th>费用名称</th>
				 <th>应收</th>
				 <th>优惠</th>
				 <th>帐单帐目项</th>
      </tr>

	  <% 
	     if (result2 != null) {
	     String tbClass="";
		   for (int i=0;i<result2.length; i++) {
			   if(i%2==0){
			  		tbClass="Grey";
			  	}else{
			  		tbClass="";	
			  	}
	  %>
      <tr align="center"> 
         <td class="<%=tbClass%>"><%=result2[i][0]%>&nbsp;</td>
				 <td class="<%=tbClass%>"><%=result2[i][1]%>&nbsp;</td>
				 <td class="<%=tbClass%>"><%=result2[i][2]%>&nbsp;</td>
				 <td class="<%=tbClass%>"><%=result2[i][3]%>&nbsp;</td>
				 <td class="<%=tbClass%>"><%=result2[i][4]%>&nbsp;</td>
				 <td class="<%=tbClass%>"><%=result2[i][5]%>&nbsp;</td>
	  	</tr>
	  <%   } 
	     }
	  %>
    
    <tr> 
      <td id="footer" colspan="6"> 
          <input class="b_foot" type="button" name="return" value="返回" onClick="window.close()">
      </td>
    </tr>
  </table>
</DIV>
</DIV>
</form>
</body>
</html>
