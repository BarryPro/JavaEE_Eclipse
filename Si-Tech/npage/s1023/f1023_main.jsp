 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-12 页面改造,修改样式
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%	
	String implRegion= (String)session.getAttribute("regCode");	
	String orgCode= (String)session.getAttribute("orgCode");	
	String opCode = "d920";		
	String opName = "集团客户统一视图";	//header.jsp需要的参数 	
	String sql1 = "select service_no,name from dgrpmanagermsg";
	String sql2 = "select owner_code,owner_name from sgrpownercode";
	String sql3 = "select a.trade_code,a.trade_name from sgrpbigtradecode a";
	System.out.println("\n============1023======+++++++++++++++++++++++++++++++++++++++++++");	
%>	
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=implRegion%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
			<wtc:sql><%=sql1%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result" scope="end" />
			
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=implRegion%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
			<wtc:sql><%=sql2%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result1" scope="end" />

		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=implRegion%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
			<wtc:sql><%=sql3%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result2" scope="end" />
<%
System.out.println("\n============1023======+++++++++++++++++++++++++++++++++++++++++++"+result[1][1]);
%>
<html>
<head>	
	<title>业务代码与成员资费关系维护</title>
	<script language=javascript>
	
		function queryEC(){		

	//		var service_no=document.getElementById("grpMan").value;
			var unit_name=document.getElementById("unit_name").value;
			unit_name=unit_name.trim();
			var owner_code=document.getElementById("grpExt").value;
			var trade_code=document.getElementById("trade_code").value;
			var unit_id = document.all.unit_id.value;
			unit_id=unit_id.trim();
			document.middle.location="f1023_qry.jsp?unit_id="+unit_id+"&owner_code="+owner_code+"&unit_name="+unit_name+"&trade_code="+trade_code;
			tabBusi.style.display="";
		}
		

	
	</script>

</head>
<body>
<form action="" name="form1"  method="post">
	<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">查询条件</div>
		</div>	
      <table cellspacing="0">
	    <tr >	     
		  <TD width="16%" class="blue">集团编号</TD>
	  	  <TD  width="34%">
		  	<input type=text name=spCode id="unit_id"  v_type=int />
		  </TD>		 
		 <!-- <TD width="16%" class="blue">客户经理</TD>
	  	  <td width="35%">
      <span id='span_OrderSourceID'>
      <select align="left" name="grpMan" id="grpMan" width=50>
      <option value="">------不限制------</option>
      <% for(int ii=0;ii<result.length;ii++)
      { %>
      <option value="<%=result[ii][0]%>"><%=result[ii][1]%></option>
      
      <%
      	}
      %>
      </select>
     </span>
    </td>  -->
    	<TD width="16%" class="blue">集团名称</TD>
	  	  <TD  width="34%">
		  	<input type=text name=unit_name id="unit_name"   />
		  </TD>	
	    </tr>
	    <tr >	     
		  <TD width="16%" class="blue">集团规模</TD>
	  	<td width="35%">
      <span id='span_OrderSourceID'>
      <select align="left" name="grpExt" id="grpExt" width=50>
      <option value="">------不限制------</option>
      <% for(int ii=0;ii<result1.length;ii++)
      { %>
      <option value="<%=result1[ii][0]%>"><%=result1[ii][1]%></option>
      
      <%
      	}
      %>
      </select>
     </span>
    </td>		 
		  <TD width="16%" class="blue">行业类别</TD>
	  	  <td width="35%">
      <span id='span_OrderSourceID'>
      <select align="left" name="trade_code" id="trade_code" width=50>
      <option value="">------不限制------</option>
      <% for(int ii=0;ii<result2.length;ii++)
      { %>
      <option value="<%=result2[ii][0]%>"><%=result2[ii][1]%></option>
      
      <%
      	}
      %>
      </select>
     </span>
    </td>	
	    </tr>
	  </table>		
      	<TABLE id="tabBtn" style="display:block"  cellspacing="0" >	    
		<TR> 
	 	  <TD id="footer"> 
	 	    <input name="queryAcBtn" class="b_foot" style="cursor:hand" type="button"  value="查  询" onClick="queryEC();">
	 	    &nbsp;  
	 	    <input name="" type="button" class="b_foot" style="cursor:hand"  value="关  闭" onClick="removeCurrentTab();" >
	 	  </TD>
		</TR>
      </TABLE> 
      <br>	  

      <TABLE id="tabBusi" style="display:none"  id="mainOne"  cellspacing="0" >	
        <TR> 
	      <td nowrap>
		    <IFRAME frameBorder=0 id=middle name=middle scrolling="yes" style="HEIGHT: 456px; VISIBILITY: inherit; WIDTH: 100%; Z-INDEX: 1">
		    </IFRAME>
	      </td> 
        </TR>
     </TABLE>
      <%@ include file="/npage/include/footer.jsp" %>  
</form>
</body>
</html>

