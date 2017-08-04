<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-02-05
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="com.sitech.boss.util.page.*"%>

<%
    String opCode =  "9109";
	String opName =  "SP业务信息审核结果查询";
	String op_code =  "9109";
	String op_name =  "SP业务信息审核结果查询";
	String workNo =  (String)session.getAttribute("workNo");
	String workName =  (String)session.getAttribute("workName");
	String regionCode = (String)session.getAttribute("regCode");
	
	int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	int iPageSize = 25;
	int iStartPos = (iPageNumber-1)*iPageSize;
	int iEndPos = iPageNumber*iPageSize;
	
	//ArrayList arr = (ArrayList)session.getAttribute("allArr");
	//String[][] fiveInfoSession = (String[][])arr.get(4);
	String workpw = (String)session.getAttribute("password");
	//String[][] baseInfo = (String[][])arr.get(0);
	String workno = workNo;
	String workname = workName;
	String orgCode = (String)session.getAttribute("orgCode");
	String ret_code = "";
	String ret_meg = "";
	String result[][] = null;
	String ip_Addr = (String)session.getAttribute("ipAddr");
	List lst = new ArrayList(); 
	for(int i=0; i<8; i++){lst.add(new String[][]{}) ;}////构造空结构
	int recNum = 0 ;
	String opNote="";
	String result1[][] = null;
	String ICPName = "" ;//SP中文名称
	String spBizName="";
	String beginPos=String.valueOf(iStartPos);
	String MaxNum=String.valueOf(iPageSize);
	String disPlay = request.getParameter("disPlay") ;
	String iSpCode ="";
	String iSpName = "";
	String iSpBizCode = "";
	String iSpBizName = "";
	String iBegin_Time = "";
	String iEnd_Time = "";
	String vIp_Address = "";
	String vOp_Note = "";
	//其他模块调用本界面，请修改时注意
	
	if("yes".equals(disPlay)){////控制第一次不显示
		if(request.getParameter("ICPName") != null){ICPName = request.getParameter("ICPName") ;}
			iSpCode = request.getParameter("spCode");
			iSpBizCode = request.getParameter("spBizCode");
			iSpBizName = request.getParameter("spBizName");
			iBegin_Time = request.getParameter("beginTime");
			iEnd_Time = request.getParameter("endTime");
	
	%>
	
		<wtc:service name="s9109Qry" routerKey="region" routerValue="<%=regionCode%>" outnum="28">
			<wtc:param value="<%=workno%>" />
			<wtc:param value="<%=orgCode%>" />
			<wtc:param value="<%=workpw%>" />
			<wtc:param value="<%=op_code%>" />
			<wtc:param value="<%=iSpCode%>" />
			<wtc:param value="<%=iSpBizCode%>" />
			<wtc:param value="<%=iSpBizName%>" />
			<wtc:param value="<%=iBegin_Time%>" />
			<wtc:param value="<%=iEnd_Time%>" />
			<wtc:param value="<%=vIp_Address%>" />
			<wtc:param value="<%=vOp_Note%>" />
			<wtc:param value="<%=beginPos%>"/>
			<wtc:param value="<%=MaxNum%>"/>
		</wtc:service>
  		<wtc:array id="r0" start="0" length="3" scope="end" />
		<wtc:array id="r1" start="3" length="3" scope="end" />
		<wtc:array id="r2" start="6" length="22" scope="end"/>
<%
		ret_code = retCode;
		ret_meg = retMsg;
		result = r2;
		result1 = r1;
	}
	if(!ret_code.equals("000000")&&!ret_code.equals(""))
	{%>
	 <script language='jscript'>
		rdShowMessageDialog('<%=ret_meg%>' + '[' + '<%=ret_code%>' + ']',0);
		history.go(-1);
	</script>
	<%}else{
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=op_name%></title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script language="JavaScript">
<!-- 
	function qry(){
	    if(!check(document.form)){
        	return false;			
        }
	    if((document.form.beginTime.value).trim()!="" || (document.form.endTime.value).trim()!=""){
    	    if(!forDate(document.form.beginTime)){
    	        return false;
    	    }
    	    if(!forDate(document.form.endTime)){
    	        return false;
    	    }
    	}
		document.form.submit();
	}	
-->
</script>
</head>
<body>
<FORM action="f9109_1.jsp" method=post name=form>
<%@ include file="/npage/include/header.jsp"%>
<div class="title">
	<div id="title_zi">SP业务信息审核结果查询</div>
</div>
  <input type="hidden" name="disPlay"  value="yes">
  
<table cellSpacing="0">
		<tr> 
			<td class=blue>SP企业代码</td>
			<td colspan="3">
				<input type="text" name="spCode" value="<%=iSpCode%>" v_must="0" v_type="string" size=15 />
			</td>
		</tr>
		<tr> 
			<td class=blue>SP业务代码</td>
			<td>
				<input type="text" name="spBizCode" value="" v_must="0" v_type="string" size=15 />
			</td>
			<td class=blue>SP业务名称</td>
			<td>
				<input type="text" name="spBizName" value="" v_must="0" v_type="string">
			</td>
		</tr>
		<tr> 
			<td class=blue>开始时间</td>
			<td>
				<input type="text" name="beginTime" value="" v_must="0" v_format="yyyyMMdd" v_type="string" size=15 />
			</td>
			<td class=blue>结束时间</td>
			<td>
				<input type="text" name="endTime" value="" v_must="0" v_format="yyyyMMdd" v_type="string">
			</td>
		</tr>
		 <tr id="footer"> 
	      <td colspan="4" align="center"><input class="b_foot" type=button value=查询 onclick="qry()"></td>
	    </tr>
	  </table>
</div>
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">查询结果</div>
</div>
      <table cellSpacing="0" id="ShowId">
	          <tr id="ShowTotalId">
	            <th>序号</th>
	            <th><div align="center">SP企业代码</div></th>
	            <th><div align="center">业务类型</div></th>
	            <th><div align="center">SP业务代码</div></th>
	            <th><div align="center">SP业务名称</div></th>
	            <th><div align="center">审核结果</div></th>
	            <th><div align="center">审核结果描述</div></th>
	            <th><div align="center">审核时间</div></th>
	            <th><div align="center">审核工号</div></th>
              </tr>
              <%
              	if(result!= null){
			    			recNum = result.length ;
							}
			 				%>
			  <%if(recNum<1){%>
		  	<tr><td colspan="12" align = "center"><b><font class="orange">无查询结果</font></td></tr>
		      <%}else{%>
	          <%
          		for(int i=0;i<recNum;i++){
          		String tdClass = "";            
         if (i%2==0){
             tdClass = "Grey";
         }
		  	  %>
			  <tr onmouseout="this.style.backgroundColor=''" onmouseover="this.style.backgroundColor='#E8E8E8';;this.style.cursor='hand'">
			    <td class="<%=tdClass%>"><div align="center"><%=(iStartPos+i+1)%>&nbsp;</div></td>
		  	  	<td class="<%=tdClass%>"><div align="center"><%=result[i][2]%>&nbsp;</div></td>
		  	  	<td class="<%=tdClass%>"><div align="center"><%=result[i][1]%>v</div></td>
		  	  	<td class="<%=tdClass%>"><div align="center"><%=result[i][3]%>&nbsp;</div></td>
		  	  	<td class="<%=tdClass%>"><div align="center"><%=result[i][4]%>&nbsp;</div></td>
		  	  	<td class="<%=tdClass%>"><div align="center"><%=result[i][17]%>&nbsp;</div></td>
		  	  	<td class="<%=tdClass%>"><div align="center"><%=result[i][18]%>&nbsp;</div></td>
		  	  	<td class="<%=tdClass%>"><div align="center"><%=result[i][20]%>&nbsp;</div></td>
		  	  	<td class="<%=tdClass%>"><div align="center"><%=result[i][19]%>&nbsp;</div></td>
	  	  	  </tr>
			  <%}}%>
		
		<!--add by sw -->
			  
			   <tr id="footer">
        	<td colspan="11" align="right">
	<%	
		int iQuantity=0;
		if(result1!=null){
		    iQuantity = Integer.parseInt(result1[0][0]);
		}
		Page pg = new Page(iPageNumber,iPageSize,iQuantity);
		PageViewCn view = new PageViewCn(request,out,pg); 
		view.setVisible(true,true,0,1);        
	%>        		
        	
        	</td>
        </tr>
			  
		</table>
   <%@ include file="/npage/include/footer.jsp"%> 
</FORM>
</BODY>
</HTML>
<%}%>
