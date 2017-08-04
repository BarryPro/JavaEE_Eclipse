<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<!--新分页用到的类-->
<%@ page import="com.sitech.crmpd.core.wtc.util.*" %>

<%  
    String opName="动力100业务包子产品信息";
    String subsm_code = request.getParameter("subsm_code");
    String motive_price = request.getParameter("motive_price");
    String motive_srvname = request.getParameter("motive_srvname");
    String regionCode = request.getParameter("regionCode");
    String selected_num = request.getParameter("selected_num");
    
    System.out.println("subsm_code="+subsm_code);
    System.out.println("motive_price="+motive_price);
    System.out.println("motive_srvname="+motive_srvname);
    System.out.println("regionCode="+regionCode);
    System.out.println("selected_num="+selected_num);
    
    
    String sqlstr = "select a.product_code,b.product_name from sSmProduct a, sProductCode b";
    sqlstr = sqlstr + " where a.product_code = b.product_code";
    sqlstr = sqlstr + " and b.product_status = 'Y' and a.sm_code = '" + subsm_code + "' order by a.product_code";
    
    if(subsm_code.equals("ML")){
        sqlstr ="select bizcodeadd,product_note from sbillspcode a,dpartermsg b where trim(a.enterprice_code)=trim(b.parter_id) and b.parter_type='25'";
    }
    if(subsm_code.equals("MA")){
    	sqlstr ="select bizcodeadd,product_note from sbillspcode a,dpartermsg b where trim(a.enterprice_code)=trim(b.parter_id) and b.parter_type='27'";
    }
    if(subsm_code.equals("AD")){
    	sqlstr ="select bizcodeadd,product_note from sbillspcode a,dpartermsg b where trim(a.enterprice_code)=trim(b.parter_id) and b.parter_type=any('02','26')";
    }
    /*wuxy alter 20100309 为测试TD固话加入动力100**/
    if(!(subsm_code.equals("AD")||subsm_code.equals("ML")||subsm_code.equals("MA"))){
    	sqlstr ="select sm_code,sm_name from ssmcode where sm_code='"+subsm_code+"' and region_code='"+regionCode+"' ";
    }
      
    //if(subsm_code.equals("44") || subsm_code.equals("98")){
    //	sqlstr = "select biz_code,biz_name from sbizmodecode where biz_code like decode(44,'44','A','98','M')||'%' and biz_status='A' and oper_code not in ('02','03')";
    //}
    String sqlstr1 = "select srv_code,price_code,srv_name from SMOTIVEBASEFAVCFG where SRV_FLAG = 'S' order by price_code";
    System.out.println("sqlstr:"+sqlstr);
    
    Map map = request.getParameterMap();
    String totalNumber = "";
    String currentPage = request.getParameter("currentPage") == null ? "1" : request.getParameter("currentPage");
    String pageSize = "10";
%>
    	<!----分页的代码---->
    	<%
        	String countSql = PageFilterSQL.getCountSQL(sqlstr);
    	%>
		    <wtc:pubselect name="sPubSelect" outnum="1" routerKey="region" routerValue="<%=regionCode%>">
		    <wtc:sql><%=countSql%></wtc:sql>
		    </wtc:pubselect>
		    <wtc:array id="allNumStr" scope="end"/>
    	<%
        	if (allNumStr != null && allNumStr.length > 0) {
            	totalNumber = allNumStr[0][0];
        	}
    		String querySql = PageFilterSQL.getOraQuerySQL(sqlstr, currentPage, pageSize, totalNumber);
    	%>
		    <wtc:pubselect name="sPubSelect" outnum="3" routerKey="region" routerValue="<%=regionCode%>"><%--outnum要比取出的列数大1,因为它还取出了序列号--%>
		    <wtc:sql><%=querySql%></wtc:sql>
		    </wtc:pubselect>
		    <wtc:array id="result" scope="end"/>
	
<wtc:pubselectah name="sPubSelect" outnum="3" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:sql>
		<%=sqlstr1%>
	</wtc:sql>
</wtc:pubselectah>
<wtc:array id="result1" scope="end"/>

<HTML>
<HEAD>
	<TITLE>黑龙江BOSS-子产品代码选择</TITLE>
	<link rel="stylesheet" type="text/css" href="/nresources/default/css/fenye.css" media="all"/>

<SCRIPT type=text/javascript>

function getselect(obj){
	var select_id = fPubSimpSel.select_id.value;
	var len = "<%=result1.length%>";
	var len1 = "<%=result.length%>";
	var leng = parseInt(obj*len) + parseInt(len);
	var selected_num = "<%=selected_num%>";
	
	if(selected_num != 0){
		var path = "fpubmode_sel.jsp";
		path = path + "?subsm_code=" + "<%=subsm_code%>";	
		path = path + "&motive_price=" + "<%=motive_price%>";
		path = path + "&motive_srvname=" + "<%=motive_srvname%>";
		path = path + "&regionCode=" + "<%=regionCode%>";	
		path = path + "&selected_num=" + selected_num;
		var retInfo = window.showModalDialog(path,"","dialogWidth:45;dialogHeight:35;");
		if(typeof(retInfo) != "undefined" && retInfo != "~~~~"){
			if(len1 == 1){
				document.fPubSimpSel.motive_price.value = opener.oneTok(retInfo,"~",1);
				document.fPubSimpSel.motive_srvname.value = opener.oneTok(retInfo,"~",2);
				document.fPubSimpSel.mode_code.value = opener.oneTok(retInfo,"~",3);
				document.fPubSimpSel.mode_name.value = opener.oneTok(retInfo,"~",4);
			}else if(len1 > 1){
				document.fPubSimpSel.motive_price[obj].value = opener.oneTok(retInfo,"~",1);
				document.fPubSimpSel.motive_srvname[obj].value = opener.oneTok(retInfo,"~",2);
				document.fPubSimpSel.mode_code[obj].value = opener.oneTok(retInfo,"~",3);
				document.fPubSimpSel.mode_name[obj].value = opener.oneTok(retInfo,"~",4);
			}
			
		}
	}		
	
	for(var k = parseInt(obj*len);k < leng;k++){
		document.fPubSimpSel.product_price[k].disabled=false;
	}
	if(select_id != ""){
		select_id = parseInt(select_id);
		leng = parseInt(select_id*len) + parseInt(len);
		for(var m = parseInt(select_id*len);m < leng;m++){
			document.fPubSimpSel.product_price[m].checked=false;
			document.fPubSimpSel.product_price[m].disabled=true;
		}
	}
	fPubSimpSel.select_id.value=obj;
}

function saveTo()
{
    var rowid = $("#select_row").val();
    
    if(rowid == ""){
        rdShowMessageDialog("请选择一个子产品代码！");
		return false;
    }
    
    var vOperationSubTypeIDRadio = getRadiosVal(document.getElementsByName("OperationSubTypeIDRadio"+rowid));
    var vDiscountRadio = getRadiosVal(document.getElementsByName("DiscountRadio"+rowid));
    var vProduct_note = $("input[name='product_note"+rowid+"']").val();
    if(vOperationSubTypeIDRadio == ""){
        rdShowMessageDialog("请选择子产品类别！");
		return false;
    }
    
    if(vDiscountRadio == ""){
        rdShowMessageDialog("请选择是否享受折扣！");
		return false;
    }
    
    if(vProduct_note == ""){
        rdShowMessageDialog("请填写子产品注释！");
		return false;
    }
    var vProductCode = $("input[name='product_code"+rowid+"']").val();
    var vProductName = $("input[name='product_name"+rowid+"']").val();
    
    return_value = vProductCode + "~" + vProductName + "~" + vProduct_note + "~" + vOperationSubTypeIDRadio
	 			 + "~" + vDiscountRadio + "~";
	window.returnValue=return_value;
	opener.getproduct(return_value);
	window.close(); 
	
	return;
	
    //子产品信息
    var product_type="";
    var product_code = "";
    var product_name = "";
    var product_note = "";
    var product_price = "";
    var product_srv = "";
    var product_srvname = "";
    var return_price = "";
    //产品套餐信息
    var motive_price = "";
    var mode_code = "";
    var mode_name = "";
    var motive_srvname = "";
    var return_value = "";
    <%
    	if(result.length == 1){
    	
    %>
    //alert("111111");
    if(document.fPubSimpSel.product_code.checked==true){
    	<%
    		if(result1.length == 1){
    	%>
		
		<%
    		}else if(result1.length > 1){
    	%>
		
		<%
    		}
    	%>
    	var radios = document.getElementsByName("OperationSubTypeIDRadio");
    	for(var i=0;i<radios.length;i++){
		if(radios[i].checked){
			product_type=radios[i].value;
			break;
		}	
	    }
		
	 	product_code = document.fPubSimpSel.product_code.value; 
	 	product_name = document.fPubSimpSel.product_name.value; 		     	
	 	product_note = document.fPubSimpSel.product_note.value;
	 	
	 	//motive_price = document.fPubSimpSel.motive_price.value; 
	 	//motive_srvname = document.fPubSimpSel.motive_srvname.value; 
	 	//mode_code = document.fPubSimpSel.mode_code.value; 		     	
	 	//mode_name = document.fPubSimpSel.mode_name.value;
	 	//alert(product_type);
	 	
	 	if(product_type=="")
	 	{
	 		rdShowMessageDialog("请选择产品类别！");
			return false;
	 	}
	 	if(product_note == ""){
	 		rdShowMessageDialog("请填写子产品注释！");
			return false;
	 	}
	 	
	 	 		     	
	 	//return_value = product_code + "~" + product_name + "~" + product_note + "~" + return_price
	 			 + "~" + motive_price + "~" + motive_srvname + "~" + mode_code + "~" + mode_name + "~";
	 	return_value = product_code + "~" + product_name + "~" + product_note + "~" + product_type
	 			 + "~" ;
    }
    <%
    	}else if(result.length > 1){
    %>
    //alert("222222");
    for(i=0;i<document.fPubSimpSel.product_code.length;i++){   	
	    if (document.fPubSimpSel.product_code[i].name=="product_code"){		
		    if(document.fPubSimpSel.product_code[i].checked==true){
		    	<%
    				if(result1.length > 0){
    			%>
				
				<%
    				}
    			%>
    			var radios = document.getElementsByName("OperationSubTypeIDRadio");
    	        for(var j=0;j<radios.length;j++){
		        if(radios[j].checked){
			           product_type=radios[j].value;
			           break;
		         }	
	            }
		    	//return_price = product_srv + "~" + product_price + "~" + product_srvname;
		     	product_code = document.fPubSimpSel.product_code[i].value; 
		     	product_name = document.fPubSimpSel.product_name[i].value; 		     	
		     	product_note = document.fPubSimpSel.product_note[i].value;
		     	
		     	//motive_price = document.fPubSimpSel.motive_price[i].value; 
	 			//motive_srvname = document.fPubSimpSel.motive_srvname[i].value; 
	 			//mode_code = document.fPubSimpSel.mode_code[i].value; 		     	
	 			//mode_name = document.fPubSimpSel.mode_name[i].value;
		     	//alert(product_type);
		     	if(product_type.trim()=="")
	 			{
	 				rdShowMessageDialog("请选择产品类别！");
					return false;
	 			}
		     	if(product_note == ""){
	 				rdShowMessageDialog("请填写子产品注释！");
					return false;
	 			} 		     	
			 	return_value = product_code + "~" + product_name + "~" + product_note + "~" + product_type
			 			 + "~" ;
         	}
		}
	}
    <%
    	}
    %>
    if(return_value == ""){
    	rdShowMessageDialog("请选择一个子产品代码！");
		return false;
    }
    //alert(return_value);
    //return;
	window.returnValue=return_value;
	opener.getproduct(return_value);
	window.close(); 
}

function gotoPage(pageId){
	document.form2.currentPage.value= pageId;
	document.form2.submit();
	return true;
}


/**点击单选框的时候调用的函数**/
function doClickRadio(radio)
{
	var radios = document.getElementsByName("OperationSubTypeIDRadio");
	
	for(var i=0;i<radios.length;i++){
		if(radios[i].checked){
			//alert(radios[i].value);
			//$("#p_operationSubType").val(radios[i].value+"|");
			break;
		}	
	}
	

}

function doProductCodeRadio(rowId){
    $("#select_row").val(rowId);
    $("td[name='tr_"+rowId+"']").attr("disabled",false);
    $("td[name^='tr_'][name!='tr_"+rowId+"']").attr("disabled",true);
    
    $("input[name='product_note"+rowId+"']").attr("readonly",false);
    $("input[name^='product_note'][name!='product_note"+rowId+"']").attr("readonly",true);
    
    $("input[name='product_note"+rowId+"']").removeClass("InputGrey");
    $("input[name^='product_note'][name!='product_note"+rowId+"']").addClass("InputGrey");
    
    $("input[name^='product_note'][name!='product_note"+rowId+"']").val("");
    
    $("input[name^='product_code'][name!='product_code"+rowId+"']").attr("checked",false);
    $("input[name^='OperationSubTypeIDRadio'][name!='OperationSubTypeIDRadio"+rowId+"']").attr("checked",false);
    $("input[name^='DiscountRadio'][name!='DiscountRadio"+rowId+"']").attr("checked",false);
}


</SCRIPT>
</HEAD>

<BODY>
<FORM method=post name="fPubSimpSel">
	
    <%@ include file="/npage/include/header_pop.jsp" %>   
  	
	<div class="title">
		<div id="title_zi">子产品选择</div>
	</div>
    <table  cellSpacing=0> 
    	<tr>
			<th nowrap>
				<b>子产品代码</b>
			</th>
			<th nowrap>
				<b>子产品名称</b>
			</th>
			<th nowrap>
				<b>子产品类别</b>
			</th>
			<th nowrap>
				<b>是否享受折扣</b>
			</th>
			<!--<th nowrap>
				<b>子产品费用折扣</b>
			</th>
			<th nowrap>
				<b>业务包费用折扣</b>
			</th>
			<th nowrap>
				<b>子产品套餐</b>
			</th>-->
			<th nowrap>
				<b>子产品注释</b>
			</th>
    	</tr>
		<%
    		if(result.length > 0){
    			for(int i = 0;i < result.length;i++){
    	%>
    	<tr>
    		<td class="Blue" width="25%">
    			<!--<input type="radio" name="product_code" value="<%=result[i][0]%>" onclick="getselect(<%=i%>)"><%=result[i][0]%></input>-->
    			<input type="radio" name="product_code<%=i%>" value="<%=result[i][0]%>" onclick="doProductCodeRadio('<%=i%>');"><%=result[i][0]%></input>
    		</td>
    		<td class="Blue" width="25%">
    			<input type="hidden" name="product_name<%=i%>" value="<%=result[i][1]%>"><%=result[i][1]%>&nbsp;
    		</td>
    		<td name="tr_<%=i%>" disabled>
    			<input type="radio" name="OperationSubTypeIDRadio<%=i%>" value="0" >主产品
    			<input type="radio" name="OperationSubTypeIDRadio<%=i%>" value="1" >附属产品
    		</td>
    		<td name="tr_<%=i%>" disabled>
    			<input type="radio" name="DiscountRadio<%=i%>" value="Y" >是
    			<input type="radio" name="DiscountRadio<%=i%>" value="N" >否
    		</td>
    		<!--去掉了子产品优惠、套餐信息-->
    		<!--<td class="Blue" width="10%">
    			<input type="hidden" name="motive_price" value="">
    			<input type="text" class="InputGrey" name="motive_srvname" value="">&nbsp;
    		</td>
    		<td class="Blue" width="20%">
    			<input type="hidden" name="mode_code" value="">
    			<input type="text" class="InputGrey" name="mode_name" value="">&nbsp;
    		</td>-->
    		<td class="Blue" width="25%">
    			<input type="text" name="product_note<%=i%>" maxlength="40" class='InputGrey' readOnly>
    			<font color="orange">*</font>
    		</td>
    	</tr> 
    	<%
    			}
    		}
    	%>
    	<tr>
    		<td colspan="12" align="right">
				<%=PageListNav.pageNav(totalNumber, pageSize, currentPage)%><a>总计<B class="orange"><%=totalNumber%></B>条记录</a>
    		</td>
    	</tr> 
    </table>
    <table cellSpacing=0>    
        <tr>
            <td align=center id="footer">
                <input class="b_foot" name=commit onClick="saveTo()" style="cursor:hand" type=button value=确认>&nbsp;
                <input class="b_foot" name=back onClick="window.close()" style="cursor:hand" type=button value=返回>&nbsp;
            </td>
        </tr>   
    </table>
	
    <input type="hidden" name="select_id" value="">
    <input type='hidden' id='select_row' name='select_row' value='' />
    <%@ include file="/npage/include/footer_pop.jsp" %>   
</FORM>
<form name="form2" method="post">
    <%=PageListNav.writeRequestString(map, currentPage)%>
</form>
</BODY>
</HTML>
