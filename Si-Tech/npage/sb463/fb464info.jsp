<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*" %>
<%
		ArrayList retArray = new ArrayList();
		String[][] result = new String[][]{};
		 
		 
		String loginName = WtcUtil.repNull((String)session.getAttribute("workName"));
		String orgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));
		String loginNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
		String ip_Addr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
		String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
		String regionCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
	
		/**************** 分页设置 ********************/
		int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
		int iPageSize = 10;
		int iStartPos = (iPageNumber-1)*iPageSize;
		int iEndPos = iPageNumber*iPageSize;
		/**********************************************/
		
		ArrayList retList = new ArrayList(); 
		ArrayList retList1 = new ArrayList();  
		String sqlStr="";
		String sqlStr1="";
		String whereSql="";
		String[][] allNumStr = new String[][]{};
		String[][] resultlist = new String[][]{};
	  	String phone_no = WtcUtil.repNull((String)request.getParameter("phone_no"));
		System.out.println("phone_no= [" + phone_no+"]");
		
		whereSql = " and a.phone_no = '"+phone_no+"'";
		sqlStr = " select count(*) from WWLANCARDMSG a,DBRESADM.DWLANCARDRES b where trim(a.wlan_seq) = b.CARD_NO ";
		sqlStr1= " select d.card_type,d.wlan_seq,d.eff_time from (  "
	           + " select a.card_type card_type,a.wlan_seq wlan_seq ,to_char(a.eff_date,'yyyymmddhh24miss') eff_time ,rownum rnum  from WWLANCARDMSG a,DBRESADM.DWLANCARDRES b where trim(a.wlan_seq) = b.CARD_NO ";			
		//查询内容  
     	sqlStr1= sqlStr1
	              	+ whereSql
	              	+" ) d "
	              	+" where d.rnum<= "+iEndPos+" and  d.rnum > "+iStartPos+" ";
	    
	    //查询总记录数
	   
	    sqlStr = sqlStr + whereSql;
	           
	              	
	try {
			System.out.println("sqlStr====="+sqlStr);
    		System.out.println("sqlStr1====="+sqlStr1);
			%>
			<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1">
				<wtc:sql><%=sqlStr%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="result1" scope="end" /> 
            <%
      		System.out.println("retCode1======"+retCode1);
      		System.out.println("retMsg1======"+retMsg1);	
			if("000000".equals(retCode1) && result1.length>0){
    		    allNumStr = result1;  
    		    System.out.println("allNumStr = " + result1[0][0]);
    		}
    		if(allNumStr==null || allNumStr.length == 0 || "0".equals(allNumStr[0][0])){
            %>
				<script language="javascript">
				 	rdShowMessageDialog("没有查到相关记录！",0);
				 	parent.location="fb464_1.jsp";
				</script>
            <%
		    }
		    %>
            <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="3">
				<wtc:sql><%=sqlStr1%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="result2" scope="end" /> 
      		<%
      		System.out.println("retCode2======"+retCode2);
      		System.out.println("retMsg2======"+retMsg2);
      		if("000000".equals(retCode2) && result2.length>0){
        	    resultlist   = result2;   
        	}
      		if(resultlist==null || resultlist.length == 0){
            %>
				<script language="javascript">
				 	rdShowMessageDialog("没有查到相关记录！",0);
				 	parent.location="fb464_1.jsp";
				</script>
            <%						 			
		    }
			}
			catch(Exception e)
			{
			    System.out.println("# return from fb464info.jsp -> Call Service sPubSelect Failed !");
			%>
				<script language="javascript">
				 	rdShowMessageDialog("查询失败！",0);
				 	parent.location="fb464_1.jsp";
				</script>
            <%	
                e.printStackTrace();	
			}
	%>	
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<META content="text/html; charset=gbk" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
<script type=text/javascript>
	function resend(cardtype,cardno,efftime)
	{
 		var packet1 = new AJAXPacket("resend.jsp","请稍后...");
 		var phone_no = <%=phone_no%>;
 		
 		packet1.data.add("phone_no",phone_no);
 		packet1.data.add("cardtype",cardtype);
 		packet1.data.add("cardno",cardno);
		packet1.data.add("efftime",efftime);
		
		core.ajax.sendPacket(packet1,doresend,true);
		
		packet1 =null;
		
	}
	
	function doresend(packet)
	{
		var retCode = packet.data.findValueByName("retCode"); 
    	var retMessage = packet.data.findValueByName("retMsg");	
		if(retCode=="000000")
		{  
			rdShowMessageDialog("补发成功",2);
		}
		else
		{
			retMessage = retMessage + "[errorCode:" + retCode + "]";
			rdShowMessageDialog(retMessage,0);
			return false;
    	}
		location = location;
 	}
	
</script>
</head>
<body >
<form name="form1" method="post" action="">	
	<div id="Operation_Table">	
		<table id="tabList" cellspacing=0 >		
			<tr>		
				<th>卡种类</th>		
				<th>卡序列号</th>
				<th>开卡时间</th>
				<th>操作</th>
			</tr>
			<%	
			for(int i = 0; i < resultlist.length; i++)
			{
			%>			
			<tr>				
				<td nowrap><%=resultlist[i][0].trim()%>&nbsp;</td>
				<td nowrap><%=resultlist[i][1].trim()%>&nbsp;</td>
				<td nowrap><%=resultlist[i][2].trim()%>&nbsp;</td>
				<td nowrap>
					<input name="queryAcBtn" style="cursor:hand" type="button" class="b_foot" value="补发" onClick="resend('<%=resultlist[i][0].trim()%>','<%=resultlist[i][1].trim()%>','<%=resultlist[i][2].trim()%>')">
				&nbsp;
				</td>
			</tr>
			<%
			}
			%>		
			<tr>	
				<td colspan="10">
					<div id="page0" style="position:relative;font-size:12px;">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
           				<%	
					    //实现分页
					    if(allNumStr!=null && allNumStr.length > 0 && !"0".equals(allNumStr[0][0])){
					    int iQuantity = Integer.parseInt(allNumStr[0][0].trim());
					    Page pg = new Page(iPageNumber,iPageSize,iQuantity);
						  PageView view = new PageView(request,out,pg); 
					   	view.setVisible(true,true,0,0);    
					   	}
					 	%>
					</div>
				</td>				
			</tr>	
		</table>		
	</div>   
<script language="javascript" type="text/javascript">
    var flag;
    var goodKind = ""; //靓号类型
jQuery(
	function (){
	window.parent.UnLoad();
});
</script>	
</form>
</body>
</html>
