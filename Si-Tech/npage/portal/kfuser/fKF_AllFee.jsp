<%
   /*
   * 功能: 话费简况
　 * 版本: v1.0
　 * 日期: 2008/09/12
　 * 作者: wuln
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import="java.text.*" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%!
	public String[] getTime(){
	
		Calendar c = Calendar.getInstance();
	  Date date = c.getTime();
	  SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	  String  startTime = sdf.format(date);
	  String end =  startTime;
	  String start =""; 
	  
	  SimpleDateFormat df = new SimpleDateFormat("yyyyMM"); 
	  String date1 = df.format(date);          
	  try {
	  		Date d1 = df.parse(date1);   
	  		c.setTime(d1);
	  		Calendar  g = Calendar.getInstance();   
        g.setTime(d1);   
        g.add(Calendar.MONTH,-5);              
        Date d2 = g.getTime();  
        start = df.format(d2)+"01"; 
	  }catch(ParseException e){
	  		e.printStackTrace();
	  }
  	  String[] time = new String[]{start,end};
  	  return time;
	}
%>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
		
		String org_code = (String)session.getAttribute("orgCode");
		String regionCode=org_code.substring(0,2);
		String workNo = (String)session.getAttribute("workNo");
		String password = (String)session.getAttribute("password");
		String phoneNo  = (String)session.getAttribute("activePhone");
		
		String begin_time =getTime()[0]; // "20080101 00:00:00";
		String begin_end = getTime()[1]; // "20081201 00:00:00";
%>
<wtc:service name="sKF_AllFee_new" outnum="3" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value="<%=begin_time%>"/>
	<wtc:param value="<%=begin_end%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />
<link href="../../../nresources/default/css/portalet.css" rel="stylesheet" type="text/css">
<link href="../../../nresources/default/css/font_color.css" rel="stylesheet" type="text/css">

<div  id="form">
	<div class="table_biaoge">
		<table width="100%" class="ctl" cellpadding="0" cellspacing="0">
	  	<tr> 
	    	<th>话费年月</th>
				<th width="40%">帐单生成时间</th>
				<th>当月费用</th>
		  </tr>
<%
		if(retCode.equals("000000")){
			if(result.length>0){
				for(int i=0;i<result.length;i++){
					String classes="";
					if(i%2==1){classes="grey";}
%>	             
			<tr>
				<td class="<%=classes%>" title="<%=result[i][0]%>"><%=result[i][0].equals("")?"&nbsp;":result[i][0]%></td>
				<td class="<%=classes%>" title="<%=result[i][1]%>"><%=result[i][1].equals("")?"&nbsp;":result[i][1]%></td>
				<td class="<%=classes%>" title="<%=result[i][2]%>"><%=result[i][2].equals("")?"&nbsp;":result[i][2]%></td>
			</tr>
<%
				}
			}
		}
%>
		</table>
	</div>
        </div>

