<%
  /*
   * 功能: 用户信誉度修改2308
   * 版本: 1.0
   * 日期: 2009/1/15
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>

<%
	 					//操作工号
	//String phoneNo = request.getParameter("phoneNo").trim();					//用户号码
	//String opCode = request.getParameter("opCode");						//操作代码
	String opCode = "e470";	
	String orgCode = request.getParameter("orgCode");					//归属代码
	String regionCode = (String)session.getAttribute("regCode");		//地市代码
	String iLoginAccept ="0";
	//String iChnSource  =request.getParameter("channelId");
	String iChnSource  ="01";
	String workno = (String)session.getAttribute("workNo");
	//String pwd = request.getParameter("pwd");
	String pwd ="";
	String beginDt = request.getParameter("beginDt");
	String endDt = request.getParameter("endDt");
	String nopass = (String)session.getAttribute("password");
	String[] inParas1 =new String[2];
	inParas1[0] = "select b.region_name,a.login_no,a.op_time,a.phone_no1,a.op_note,a.groupid,a.groupname,a.should_pay_money from wchargecardmsg a,sregioncode b,dloginmsg c where a.login_no = c.login_no and b.region_code = substr(c.org_code,0,2) and a.op_code='e470' and substr(a.total_date,1,6)>=:beginDt and substr(a.total_date,1,6)<=:endDt  ";
	inParas1[1]="beginDt="+beginDt+",endDt="+endDt;
	String region_name="";
	String flag1="";
	String phone_No1="";
%>
	<wtc:service name="TlsPubSelBoss" retcode="retCode2" retmsg="retMsg2" outnum="10">
		<wtc:param value="<%=inParas1[0]%>"/>
		<wtc:param value="<%=inParas1[1]%>"/>
	</wtc:service>
	<wtc:array id="results" scope="end" />
<%
	String errCode2 = retCode2;
	String errMsg2 = retMsg2;
	String count_1 = "";
	String i1="";
	int l = 0;
	%>
		var response = new AJAXPacket();
	<%
	if(results!=null&&results.length>0)
	{
		flag1="0";
		l=results.length;
		%>response.data.add("count_is","<%=l%>");<%
		for(int i =0;i<results.length;i++)
		{
			region_name=results[i][0];
			phone_No1=results[i][3];
			%> 
				response.data.add("region_name"+"<%=i%>","<%=region_name%>");
				response.data.add("phone_No1"+"<%=i%>","<%=phone_No1%>"); 
			<%
		}
		//region_name=results[0][0];
	}
	else if(results.length==0)
	{
		flag1="1";
	}
	else
	{
		flag1="2";
	}
%>	
 
 
	
			
	response.data.add("flag_show","<%=flag1%>");
	
 
	core.ajax.receivePacket(response);
 