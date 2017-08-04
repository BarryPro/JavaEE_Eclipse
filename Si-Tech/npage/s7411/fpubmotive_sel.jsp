<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%  
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
	
    String opName="动力100业务包信息";
    String sm_code = request.getParameter("sm_code");
    String opr_type = request.getParameter("opr_type");
    String motive_type = request.getParameter("motive_type");
    System.out.println("sm_code="+sm_code);
    System.out.println("opr_type="+opr_type);
    String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
	String sqlstr="";
	/*
	if(!opr_type.equals("Q")){
		sqlstr = "select MOTIVE_CODE,MOTIVE_NAME from SMOTIVEPRODCFG where SM_CODE = '" + sm_code + "' and MOTIVE_TYPE = '" + motive_type + "'";
	}
    else
    {
    	sqlstr = "select a.product_code,b.product_name from sSmProduct a,sProductCode b";
	    sqlstr = sqlstr + " where a.product_code = b.product_code and b.product_status = 'Y'";
	    sqlstr = sqlstr + " and a.sm_code = '" + sm_code + "' order by a.product_code";
    }
    */
	sqlstr = "select motive_code,motive_name from SMOTIVEPRODCFG where motive_type='"+motive_type+"' and end_date>sysdate";
	System.out.println("sqlstr:"+sqlstr);
%>
<wtc:pubselectah name="sPubSelect" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:sql>
		<%=sqlstr%>
	</wtc:sql>
</wtc:pubselectah>
<wtc:array id="result" scope="end"/>

<HTML>
<HEAD>
	<TITLE>黑龙江BOSS-业务包产品代码选择</TITLE>
	<META content=no-cache http-equiv=Pragma>
  <META content=no-cache http-equiv=Cache-Control>
</HEAD>

<SCRIPT type=text/javascript>


function saveTo()
{
    var product_name = "";
    var product_code = "";
    var return_value = "";
   
        
    <%
    	if(result.length == 1){
    %>
	if (document.fPubSimpSel.product_code.name=="product_code"){		
	    if(document.fPubSimpSel.product_code.checked==true){
	    	product_code = document.fPubSimpSel.product_code.value;  
	    	product_name = document.fPubSimpSel.product_name.value; 
	    	return_value = product_code + "|" + product_name + "|"; 
     	}
	}	
    <%
    	}else if(result.length > 1){
    %>
    for(i=0;i<document.fPubSimpSel.product_code.length;i++){
	    if (document.fPubSimpSel.product_code[i].name=="product_code"){		
		    if(document.fPubSimpSel.product_code[i].checked==true){
		    	product_code = document.fPubSimpSel.product_code[i].value;  
		    	product_name = document.fPubSimpSel.product_name[i].value; 
		    	return_value = product_code + "|" + product_name + "|"; 
         	}
		}
	}
    <%
    	}
    %>
    if(return_value == ""){
    	rdShowMessageDialog("请选择一个业务包代码！");
		return false;
    }
    //alert(return_value);
	window.returnValue=return_value;
	window.close(); 
}


</SCRIPT>

<BODY>
<FORM method=post name="fPubSimpSel">
    <%@ include file="/npage/include/header_pop.jsp" %>   
  	
	<div class="title">
		<div id="title_zi">业务包选择</div>
	</div>
    <table cellSpacing=0> 
    	<tr>
			<th width="40%" nowrap>
				<b>业务包代码</b>
			</th>
			<th nowrap>
				<b>业务包名称</b>
			</th>
    	</tr>
    	<%
    		if(result.length > 0){
    			for(int i = 0;i < result.length;i++){
    	%>
    	<tr>
    		<td class="Blue" nowrap>
    			<input type="radio" name="product_code"+"<%=i%>" value="<%=result[i][0]%>"><%=result[i][0]%></input>
    		</td>
    		<td class="Blue" nowrap>
    			<input type="hidden" name="product_name" value="<%=result[i][1]%>"><%=result[i][1]%>
    		</td>
    	</tr> 
    	<%
    			}
    		}
    	%> 
    </table>
    <table cellSpacing=0>    
        <tr>
            <td align=center id="footer">
                <input class="b_foot" name=commit onClick="saveTo()" style="cursor:hand" type=button value=确认>&nbsp;
                <input class="b_foot" name=back onClick="window.close()" style="cursor:hand" type=button value=返回>&nbsp;
            </td>
        </tr>   
    </table>
    <%@ include file="/npage/include/footer_pop.jsp" %>   
</FORM>
</BODY>
</HTML>
