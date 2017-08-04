<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%  
    String opName="动力100业务包子产品套餐信息";
    String subsm_code = request.getParameter("subsm_code");
    String motive_price = request.getParameter("motive_price");
    String motive_srvname = request.getParameter("motive_srvname");
    String regionCode = request.getParameter("regionCode");
    int selected_num = Integer.parseInt(request.getParameter("selected_num"));
    String[] motive_price_list = motive_price.substring(0, motive_price.length()-1).split("\\|",selected_num);
    String[] motive_srvname_list = motive_srvname.substring(0, motive_srvname.length()-1).split("\\|",selected_num);
    
	String sqlstr = "select mode_code,mode_name from sbillmodecode where start_time<sysdate and stop_time>sysdate";
	sqlstr = sqlstr + " and region_code = '?' and sm_code = '?'";
	System.out.println("sqlstr:"+sqlstr);
%>


<HTML>
<HEAD>
	<TITLE>吉林BOSS-业务包子产品套餐选择</TITLE>
</HEAD>

<SCRIPT type=text/javascript>

function saveTo()
{
    var motive_price = "";
    var mode_code = "";
    var mode_name = "";
    var motive_srvname = "";
    var return_value = "";
    <%
    	if(selected_num == 1){
    %>        
			
	if(document.fPubSimpSel.mode_check.checked==true){
		motive_price = document.fPubSimpSel.motive_price.value;  
		motive_srvname = document.fPubSimpSel.motive_srvname.value; 
		mode_code = document.fPubSimpSel.mode_code.value; 
		mode_name = document.fPubSimpSel.mode_code.options[document.fPubSimpSel.mode_code.selectedIndex].text;
		if(mode_code == "****"){
			rdShowMessageDialog("请选择一个子产品套餐！");
			return false;
		} 
    }
		
    <%
    	}else if(selected_num > 1){
    %>
    var selected_num = "<%=selected_num%>";
    for(i=0;i<selected_num;i++){    
		if(document.fPubSimpSel.mode_check[i].checked==true){
			motive_price = motive_price + document.fPubSimpSel.motive_price[i].value + "|";
			motive_srvname = motive_srvname + document.fPubSimpSel.motive_srvname[i].value + "|";   
			mode_code = mode_code + document.fPubSimpSel.mode_code[i].value + "|"; 
			mode_name = mode_name + document.fPubSimpSel.mode_code[i].options[document.fPubSimpSel.mode_code[i].selectedIndex].text + "|";						
		}	
	}
    <%
    	}
    %>
    if(mode_code.indexOf("****") != -1){
		rdShowMessageDialog("请选择一个子产品套餐！");
		return false;
	} 
    
    return_value = motive_price + "~" + motive_srvname + "~" + mode_code + "~" + mode_name + "~";
    if(return_value == "~~~~"){
    	rdShowMessageDialog("请至少选择一个子产品套餐记录！");
		return false;
    }
	window.returnValue=return_value;
	window.close(); 
}

</SCRIPT>

<BODY>
<FORM method=post name="fPubSimpSel">
    <%@ include file="/npage/include/header_pop.jsp" %>   
  	
	<div class="title">
		<div id="title_zi">子产品套餐选择</div>
	</div>
    <table cellSpacing=0> 
    	<tr>
			<th>
				<b>选择</b>
			</th>
			<th>
				<b>业务包费用折扣</b>
			</th>
			<th>
				<b>子产品套餐</b>
			</th>
    	</tr>
    	<%
    		if(selected_num > 0){
    			for(int i = 0;i < selected_num;i++){
    	%>
    	<tr>
    		<td class="Blue" nowrap>
    			<input type="checkbox" name="mode_check" value=""></input>
    		</td>
    		<td class="Blue" nowrap>
    			<input type="hidden" name="motive_price" value="<%=motive_price_list[i]%>">
    			<input type="hidden" name="motive_srvname" value="<%=motive_srvname_list[i]%>"><%=motive_srvname_list[i]%>
    		</td>
    		<td class="Blue" nowrap>
    			<select name="mode_code">
    				<option value="****">请选择...</option>
    				<wtc:qoption name="sPubSelect" outnum="2">
						<wtc:sql>
							<%=sqlstr%>
						</wtc:sql>
						<wtc:param value="<%=regionCode%>"/>
						<wtc:param value="<%=subsm_code%>"/>
					</wtc:qoption>
				</select>
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
