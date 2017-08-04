<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-12 页面改造,修改样式
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%

	String opCode = "1500";
  String opName = "综合信息查询之优惠信息查询";
  
	String id_no  = request.getParameter("idNo");
	String open_time  = request.getParameter("openTime");
	String phoneNo  = request.getParameter("phoneNo");
	String cust_name  = request.getParameter("custName");
	String work_no=request.getParameter("workNo");
	String work_name=request.getParameter("workName");
	String nopass = (String)session.getAttribute("password");
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());

	String totalFav = "无";
	String usedFav = "无";
	String totalMessFav = "无";
	String usedMessFav = "无";
	String totalGprsFav = "无";
	String usedGprsFav = "无";
	String otherGprsFav ="无";
  String partGprsFav ="无";
	String partUsedGprsFav ="无";

		
		
	String  inputParsm [] = new String[2];
	inputParsm[0] = phoneNo;
	inputParsm[1] = dateStr;
	
	//String [] cussidArr=co.callService("sGetUserFavMsg",inputParsm,"6","phone",phoneNo);
%>
	<wtc:service name="sGetUserFavMsg" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="11" >
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value="<%=dateStr%>"/>
	</wtc:service>
	<wtc:array id="cussidArr" scope="end"/>
<%
		if(cussidArr!=null&&cussidArr.length>0)
	{
		totalFav = cussidArr[0][0];
		usedFav = cussidArr[0][1];
		totalMessFav = cussidArr[0][2];
		usedMessFav = cussidArr[0][3];
	}
	
	
	/*取GRPS优惠信息*/
	String  inputParsm1 [] = new String[5];
	inputParsm1[0] = work_no;
	inputParsm1[1] = nopass;
	inputParsm1[2] = "5186";
	inputParsm1[3] = phoneNo;
	inputParsm1[4] = dateStr;
	
//	String [] cussidArr1=co1.callService("s5186FavMsg",inputParsm1,"3","phone",phoneNo);
%>
		<wtc:service name="s5186FavMsg" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode2" retmsg="retMsg2" outnum="6" >
		<wtc:param value="<%=inputParsm1[0]%>"/>
		<wtc:param value="<%=inputParsm1[1]%>"/>
		<wtc:param value="<%=inputParsm1[2]%>"/>
		<wtc:param value="<%=inputParsm1[3]%>"/>
		<wtc:param value="<%=inputParsm1[4]%>"/>
		</wtc:service>
		<wtc:array id="cussidArr1" scope="end"/>
<%
	if(cussidArr1!=null&&cussidArr1.length>0){
		totalGprsFav = cussidArr1[0][0];
		usedGprsFav = cussidArr1[0][1];
		otherGprsFav = cussidArr1[0][2];
		partGprsFav = cussidArr1[0][3];//分段应优惠
		partUsedGprsFav = cussidArr1[0][4];//分段已优惠
	}
%>
        
<HTML>
	<HEAD>
	<title>优惠信息查询</title>
	</HEAD>
<BODY>
<FORM method=post name="fGetUserFavMsg.jsp">
	<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">优惠信息查询&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;客户名称:<%=cust_name%></div>
		</div>
		<TABLe cellSpacing="0">
	    <TR> 
	      <td class="blue">服务号码</TD>
	      <TD><input class="InputGrey" name="phoneNo" value="<%=phoneNo%>" maxlength="25" size=20 readonly></TD>
	      <td class="blue">入网时间</TD>
	      <TD><input class="InputGrey" name="open_time" value="<%=open_time%>" maxlength="25" size=20 readonly></TD>
	    </TR>
	       
			<tr>
				<td class="blue">应优惠分钟数</TD>
		    <TD><input class="InputGrey" name="totalFav" value="<%=totalFav%>" maxlength="25" size=20 readonly></TD>
		   	<td class="blue">已优惠分钟数</TD>
				<TD><input class="InputGrey" value="<%=usedFav%>" maxlength="25" size=20 readonly></TD>
			</tr>
			<tr>
				<td class="blue">应优惠短信数</TD>
		    <TD><input class="InputGrey" value="<%=totalMessFav%>" maxlength="25" size=20 readonly></TD>
		    <td class="blue">已优惠短信数</TD>
		    <TD><input class="InputGrey" value="<%=usedMessFav%>" maxlength="25" size=20 readonly></TD>
			</tr>
			<tr>
				<td class="blue">应优惠gprs流量：</TD>
		    <TD><input class="InputGrey" value="<%=totalGprsFav%>" maxlength="25" size=20 readonly></TD>
		    <td class="blue">已优惠gprs流量：</TD>
		    <TD><input class="InputGrey" value="<%=usedGprsFav%>" maxlength="25" size=20 readonly></TD>
			</tr>
			<tr>
				<td class="blue">无套餐GPRS流量：</TD>
		    <TD><input class="InputGrey" value="<%=otherGprsFav%>" maxlength="25" size=20 readonly></TD>
		    <td class="blue">分段已用gprs流量：</TD>
		    <TD><input class="InputGrey" value="<%=partUsedGprsFav%>" maxlength="25" size=20 readonly></TD>
			</tr>		
	   </table>  
		
        
	  <TABLE cellSpacing="0">
	    <TR> 
	      <TD id="footer"> 
	          <input type="button"  name="reset"   class="b_foot" value="返回" onclick="history.go(-1)">
	          <input type="button" name="return"  class="b_foot" value="关闭" onClick="parent.removeTab('<%=opCode%>')">
	      </TD>
	    </TR>
	  </TABLE>
    <%@ include file="/npage/include/footer.jsp" %>
</FORM>
</body>
</html> 


