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
	String op_code =  "9125";
	String op_name =  "SP企业信息查询";
	String opCode = op_code;
	String opName = op_name;
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
	
	String ret_code = "";
	String ret_meg = "";
	String result[][] = null;
	String aresult[][] = null;
	String ip_Addr = request.getRemoteAddr();
	List lst = new ArrayList(); 
	for(int i=0; i<8; i++){lst.add(new String[][]{}) ;}////构造空结构
	int recNum = 0 ;
	int recNum1 = 0 ;
	String opNote="";
	String result1[][] = null;
	String aresult1[][] = null;
	String ICPName = "" ;//SP中文名称
	String spBizName="";
	String beginPos=String.valueOf(iStartPos);
	String MaxNum=String.valueOf(iPageSize);
	String disPlay = request.getParameter("disPlay") ;
	
	//其他模块调用本界面，请修改时注意
	String ifCall=(request.getParameter("ifCall") != null) ? request.getParameter("ifCall") : "false";
	String phoneno=(request.getParameter("phoneno") != null) ? request.getParameter("phoneno") : "";
	String bizType=(request.getParameter("bizType") != null) ? request.getParameter("bizType") : "";
	String spCode=(request.getParameter("spCode") != null) ? request.getParameter("spCode") : "";
	String spBizCode=(request.getParameter("spBizCode") != null) ? request.getParameter("spBizCode") : "";
	String bizType1=(request.getParameter("bizType1") != null) ? request.getParameter("bizType1") : "";
	String spCode1=(request.getParameter("spCode1") != null) ? request.getParameter("spCode1") : "";
	String spBizCode1=(request.getParameter("spBizCode1") != null) ? request.getParameter("spBizCode1") : "";
	String opType=(request.getParameter("optype") != null) ? request.getParameter("optype") : "";
	System.out.println(bizType);
	
	if("yes".equals(disPlay)){////控制第一次不显示
		if(request.getParameter("ICPName") != null){ICPName = request.getParameter("ICPName") ;}
	%>
	
		<wtc:service name="s9125Qry" routerKey="region" routerValue="<%=regionCode%>" outnum="47">
			<wtc:param value="0" />
			<wtc:param value="01" />
			<wtc:param value="<%=op_code%>" />
			<wtc:param value="<%=workno%>" />
			<wtc:param value="<%=workpw%>" />
			<wtc:param value="<%=phoneno%>" />
			<wtc:param value="" />
			<wtc:param value="<%=regionCode%>" />
			<wtc:param value="<%=bizType%>" />
			<wtc:param value="<%=ICPName%>" />
			<wtc:param value="<%=spCode%>" />
			<wtc:param value="<%=opType%>" />
			<wtc:param value="<%=ip_Addr%>" />
			<wtc:param value="<%=opNote%>"/>
			<wtc:param value="<%=beginPos%>"/>
			<wtc:param value="<%=MaxNum%>"/>
		</wtc:service>
  		<wtc:array id="r0" start="0" length="3" scope="end" />
		<wtc:array id="r1" start="3" length="3" scope="end" />
		<wtc:array id="r2" start="6" length="10" scope="end"/>
<%
		ret_code = retCode;
		ret_meg = retMsg;
		result = r2;
		result1 = r1;
	}
	else if("yes1".equals(disPlay)){////控制第一次不显示
			if(request.getParameter("spBizName") != null){spBizName = request.getParameter("spBizName") ;}
%>
		<wtc:service name="s9126Qry" routerKey="region" routerValue="<%=regionCode%>" outnum="26">
			<wtc:param value="0" />
			<wtc:param value="01" />
			<wtc:param value="<%=op_code%>" />
			<wtc:param value="<%=workno%>" />
			<wtc:param value="<%=workpw%>" />
			<wtc:param value="<%=phoneno%>" />
			<wtc:param value="" />
			<wtc:param value="<%=regionCode%>" />
			<wtc:param value="<%=bizType1%>" />
			<wtc:param value="<%=spCode1%>" />
			<wtc:param value="<%=spBizCode1%>" />
			<wtc:param value="<%=spBizName%>" />
			<wtc:param value="<%=opType%>" />
			<wtc:param value="<%=ip_Addr%>" />
			<wtc:param value="<%=opNote%>"/>
			<wtc:param value="<%=beginPos%>"/>
			<wtc:param value="<%=MaxNum%>"/>
		</wtc:service>
		<wtc:array id="r01" start="0" length="3" scope="end" />
		<wtc:array id="r11" start="3" length="3" scope="end" />
		<wtc:array id="r21" start="6" length="20" scope="end"/>
<%
		ret_code = retCode;
		ret_meg = retMsg;
		aresult = r21;
		aresult1 = r11;
	}
	if(!ret_code.equals("000000")&&!ret_code.equals(""))
	{%>
	 <script language='javascript'>
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
	
	<script language='javascript'>
function spCodeQry(){
		var bizType=document.all.bizType.value;
		if(bizType.length<=0){
	    	rdShowMessageDialog("请先选择业务类型！",0);
	    	return false;
	    }
		var pageTitle = "SP企业信息查询";
		var fieldName = "sp企业代码|sp企业名称|sp企业英文名称|";
		var selType = "S";    //'S'单选；'M'多选
		var retQuence = "2|0|1|";
		var retToField = "spCode|ICPName|";
		var sqlStr ="select a.SPID,decode(a.SPNAME,null,a.spshortname,a.SPNAME) SPNAME,a.spenname from DDSMPSPINFO a,sOBSpType b where trim(a.spid) between b.beginspid and b.endspid and a.SPSTATUS='A' and a.BIZTYPE= :bizType and a.spid in (select distinct c.spid from DDSMPSPBIZINFO c where c.BIZSTATUS='A') order by a.SPID";
		var varStr="bizType="+bizType;
		var serviceName="TlsPubSelCen";
		var routerKey="region";
		var routerValue="<%=regionCode%>";
		if(PubSimpSel_BD(pageTitle,fieldName,sqlStr,varStr,selType,retQuence,retToField,serviceName,routerKey,routerValue));
	}
	
	
	
	function spBizCodeQry(){
		var spCode=document.all.spCode.value;
		if(spCode.length<=0){
	    	rdShowMessageDialog("请先输入SP企业代码！",0);
	    	return false;
	    }
	    var pageTitle = "SP业务信息查询";
		var fieldName = "sp业务代码|sp业务名称|业务描述|";
		var sqlStr ="select b.bizcode,b.servname,b.BIZDESC from DDSMPSPINFO a,DDSMPSPBIZINFO b where  a.SPID=b.SPID and  b.BIZSTATUS='A' and a.SPID=:spid order by b.bizcode";
		var varStr="spid="+spCode;
		var selType = "S";    //'S'单选；'M'多选
		var retQuence = "2|0|1|";
		var retToField = "spBizCode|spBizName|";
		var serviceName="TlsPubSelCen";
		var routerKey="region";
		var routerValue="<%=regionCode%>";
		if(PubSimpSel_BD(pageTitle,fieldName,sqlStr,varStr,selType,retQuence,retToField,serviceName,routerKey,routerValue));
	}
	
	function selectSp(spCode){
		window.opener.form.spCode.value=spCode;	
		window.close();
	}
	
	function qry(){
		var checkPopedomPacket = new AJAXPacket("/npage/public/pubCheckPopedom.jsp", "请稍候......");
		checkPopedomPacket.data.add("workNo", "<%=workNo%>");
		checkPopedomPacket.data.add("opCode", "9125");
		core.ajax.sendPacket(checkPopedomPacket, doCheckPopedom);
		checkPopedomPacket = null;
	}
	function qry1(){
		var checkPopedomPacket = new AJAXPacket("/npage/public/pubCheckPopedom.jsp", "请稍候......");
		checkPopedomPacket.data.add("workNo", "<%=workNo%>");
		checkPopedomPacket.data.add("opCode", "9126");
		core.ajax.sendPacket(checkPopedomPacket, doCheckPopedom1);
		checkPopedomPacket = null;
	}
	function doCheckPopedom (packet) {
		var retCode = packet.data.findValueByName("retCode");
		var popedomNo = packet.data.findValueByName("popedomNo");
		
		if (retCode == "000000" && parseInt(popedomNo) > 0) {
			if(!check(document.form)){
				return false;			
			}
			document.form.action="f9125_1.jsp?disPlay=yes&bizType="+document.all.bizType.value;
			document.form.submit();
		} else {
			alert("您无此功能的权限！");
			window.close();
			return;
		}
	}
	function doCheckPopedom1 (packet) {
		var retCode = packet.data.findValueByName("retCode");
		var popedomNo = packet.data.findValueByName("popedomNo");
		
		if (retCode == "000000" && parseInt(popedomNo) > 0) {
			if(!check(document.form)){
				return false;			
			}
			document.form.action="f9125_1.jsp?disPlay=yes1&bizType="+document.all.bizType1.value;
			document.form.submit();
		} else {
			alert("您无此功能的权限！");
			window.close();
			return;
		}
	}
</script>
</head>
<body>
<FORM action="f9125_1.jsp" method=post name=form>
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">SP企业信息查询</div>
</div>
  <input type="hidden" name="optype"  value="<%=opType%>">
  <input type="hidden" name="ifCall"  value="<%=ifCall%>">
  <input type="hidden" name="phoneno"  value="<%=phoneno%>">
  
<table cellspacing="0">
		<tr>  
		  <td class="blue">业务类型</td>
			<td colspan="3">
				<select name="bizType" <%=ifCall.equals("true") ? "disabled" : ""%>>
                	<option value="">--全部--</option>
					<wtc:qoption  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>"  outnum="2" value="<%=bizType%>">
	            		<wtc:sql>
	            			select oprcode,oprname from sOBBizType where regtype='0' order by oprcode asc
	            		</wtc:sql>
	            	</wtc:qoption>
	            </select>
			</td>
		</tr>
		<tr> 
			<td class="blue">SP企业代码</td>
			<td>
				<input type="text" name="spCode" value="<%=spCode%>" v_must="0" v_type="string" size=15 />
			</td>
			<td class="blue">SP中文名称</td>
			<td>
				<input type="text" name="ICPName" value="<%=ICPName%>" v_must="0" v_type="string">
			</td>
		  
		 <tr id="footer"> 
	      <td colspan="4" align="center"><input class="b_foot" type=button value=查询 onclick="qry()"></td>
	    </tr>
	  </table>
</div>
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">查询结果</div>
</div>
      <table cellspacing="0" id="ShowId">
	          <tr id="ShowTotalId">
	            <th>序号</th>
	            <th><div align="center">SP企业代码</div></th>
	            <th><div align="center">SP中文名称</div></th>
	            <th><div align="center">服务代码</div></th>
	            <th><div align="center">服务属性</div></th>
	            <th><div align="center">业务联系人</div></th>
	            <th><div align="center">客服联系人</div></th>
	            <th><div align="center">客服电话</div></th>
	            <th><div align="center">网址</div></th>
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
			  <tr onmouseout="this.style.backgroundColor=''" onmouseover="this.style.backgroundColor='#E8E8E8';;this.style.cursor='hand'" onmousedown='<%=ifCall.equals("true") ? "selectSp(\""+result[i][0]+"\")" : ""%>'  \>
			    <td class="<%=tdClass%>"><div align="center"><%=(iStartPos+i+1)%>&nbsp;</div></td>
		  	  	<td class="<%=tdClass%>"><div align="center"><%=result[i][0]%>&nbsp;</div></td>
		  	  	<td class="<%=tdClass%>"><div align="center"><%=result[i][2]%>&nbsp;</div></td>
		  	  	<td class="<%=tdClass%>"><div align="center"><%=result[i][1]%>&nbsp;</div></td>
		  	  	<td class="<%=tdClass%>"><div align="center"><%=result[i][9]%>&nbsp;</div></td>
		  	  	<td class="<%=tdClass%>"><div align="center"><%=result[i][8]%>&nbsp;</div></td>
		  	  	<td class="<%=tdClass%>"><div align="center"><%=result[i][8]%>&nbsp;</div></td>
		  	  	<td class="<%=tdClass%>"><div align="center"><%=result[i][6]%>&nbsp;</div></td>
		  	  	<td class="<%=tdClass%>"><div align="center"><%=result[i][7]%>&nbsp;</div></td>
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
		<div class="title">
	<div id="title_zi">SP业务信息查询</div>
</div>

  <input type="hidden" name="optype"  value="<%=opType%>">
  <input type="hidden" name="ifCall"  value="<%=ifCall%>">
  <input type="hidden" name="phoneno"  value="<%=phoneno%>">
 
<table cellspacing="0">		  
		  <tr>
		  	<td class=blue>业务类型</td>
			<td>
				<select name="bizType1"  <%=ifCall.equals("true") ? "disabled" : ""%>>
                	<option value="">------------</option>
					<wtc:qoption  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>"  outnum="2" value="<%=bizType%>">
	            		<wtc:sql>
	            			select oprcode,oprname from sOBBizType where regtype='0' order by oprcode asc
	            		</wtc:sql>
	            	</wtc:qoption>
	            </select>
			</td>
		  <td class=blue>SP企业代码</td>
			<td>
				<input type="text" name="spCode1" value="<%=spCode1%>" v_must="0" v_type="string" size=15 >
			</td>
		</tr>
		
		<tr>
		<td class=blue>SP业务代码</td>
			<td>
				<input type="text" name="spBizCode1" value="<%=spBizCode1%>" v_must="0" v_type="string" size=15 >
			</td>
			<td class=blue>SP业务名称</td>
			<td>
				<input type="text" name="spBizName" value="<%=spBizName%>" v_type="string"/>
			
			</td>
		</tr>
		 <tr id="footer">
	      <td colspan="4" align="center"><input class="b_foot" type=button value=查询 onclick="qry1()"></td>
	    </tr>
	  </table>
</div>
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">查询结果</div>
</div>
      <table cellspacing="0" id="ShowId1">
	          <tr id="ShowTotalId1">
	            <th>序号</th>
	            <th>业务名称</th> 
	            <th>业务代码</th>
	            <th>业务类型</th>
	            <th>资费类型</th>
	            <th>费率(元)</th>
	            <th>SP简称</th>
	            <th>SP企业代码</th>
	          </tr>
				<%
				if(aresult!= null){
			    	recNum1 = aresult.length ;
				}
			  %>
			  <%if(recNum1<1){%>
		  		<tr><td colspan="12" align = "center"><b><font class="orange">无查询结果</font></td></tr>
		      <%}else{%>
	          <%
          		for(int i=0;i<recNum1;i++){
              		String tdClass = "";            
                    if (i%2==0){
                         tdClass = "Grey";
                    }
		  	  %>
			  <tr onmouseout="this.style.backgroundColor=''" onmouseover="this.style.backgroundColor='#E8E8E8';this.style.cursor='hand'" onmousedown='<%=ifCall.equals("true") ? "selectSp(\""+aresult[i][1]+"\",\""+aresult[i][0]+"\")" : ""%>'>
			    
			    <td class="<%=tdClass%>"><div align="center"><%=(iStartPos+i+1)%>&nbsp;</div></td>
		  	    <td class="<%=tdClass%>"><div align="center"><%=aresult[i][14]%>&nbsp;</div></td>
		  	  	<td class="<%=tdClass%>"><div align="center"><%=aresult[i][1]%>&nbsp;</div></td>
		  	  	<td class="<%=tdClass%>"><div align="center"><%=aresult[i][2]%>&nbsp;</div></td>
		  	  	<td class="<%=tdClass%>"><div align="center"><%=aresult[i][6]%>&nbsp;</div></td>
				<%
				/*
				System.out.println("______________________________");    
				for(int j=0;j<recNum;j++)
				System.out.println(result[i][j]);
				System.out.println("______________________________");
				*/
				String prices = aresult[i][5];
				int pricesLen = prices.length();
				if(pricesLen==0){
					prices = "0";				
				}
				 double price = Double.parseDouble(prices);
			//	 price = price/1000 ;//交费需要/1000
				 %>
		  	  	<td class="<%=tdClass%>"><div align="center"><%=price%>&nbsp;</div></td>
		  	  	<td class="<%=tdClass%>"><div align="center"><%=aresult[i][16]%>&nbsp;</div></td>
		  	  	<td class="<%=tdClass%>"><div align="center"><%=aresult[i][0]%>&nbsp;</div></td>
	  	  	  </tr>
			  <%}}%>
			  
			   <tr id="footer">
        	<td colspan="11" align="right">
	<%	
		int iQuantity1=0;
		if(aresult1!=null){
		    iQuantity1 = Integer.parseInt(aresult1[0][0]);
		}
		Page pg1 = new Page(iPageNumber,iPageSize,iQuantity1);
		//PageViewCn view = new PageViewCn(request,out,pg1); 
		PageView view1 = new PageView(request,out,pg1); 
		view1.setVisible(true,true,0,1);       
	%>        		
        	
        	</td>
        </tr>
			  
		</table>
   <%@ include file="/npage/include/footer.jsp"%> 
</FORM>
</BODY>
</HTML>
<%}%>
