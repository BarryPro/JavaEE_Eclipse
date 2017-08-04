<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%  
    String opCode="7420";
    String opName="动力100业务包配置查询";
    String offer_id = request.getParameter("offer_id");
%>

<HTML>
<HEAD>
	<TITLE>黑龙江BOSS-产品包代码选择</TITLE>

<SCRIPT type=text/javascript>

var dynTbIndex=1;	//用于动态表数据的索引位置,开始值为1.考虑表头

onload=function(){
	var cfmpacket = new AJAXPacket("f7411Qry.jsp", "正在提交,请稍候......");
	cfmpacket.data.add("offer_id", "<%=offer_id%>");
	core.ajax.sendPacket(cfmpacket,DoGetQry,false);
	cfmpacket=null;
}

function DoGetQry(cfmpacket){
	var retCode = unescape(cfmpacket.data.findValueByName("retCode"));
	var retMsg = unescape(cfmpacket.data.findValueByName("retMsg"));
	if(retCode=="000000"){
		frm.offer_name.value = cfmpacket.data.findValueByName("offer_name");
		frm.eff_date.value = cfmpacket.data.findValueByName("eff_date");
		frm.exp_date.value = cfmpacket.data.findValueByName("exp_date");
						
		var result_product = cfmpacket.data.findValueByName("result_product");
		frm.result_length.value = result_product.length;
		for(var n = 0;n < result_product.length;n++){	
			smode_code = result_product[n][0];	
			product_code = result_product[n][1];
			product_name = result_product[n][2];
			product_type = result_product[n][3];
			product_note = result_product[n][4];			
			product_discount = result_product[n][5];	
			queryAddAllRow(smode_code,product_code,product_name,product_type,product_note,product_discount);
		}
	}else{
		rdShowMessageDialog("错误信息："+retMsg+" 错误代码："+retCode,0);
		return false;
	}
} 	

function queryAddAllRow(smode_code,product_code,product_name,product_type,product_note,product_discount){
	//alert("["+smode_code+"]["+product_code+"]["+product_name+"]["+product_type+"]["+product_note+"]");
	var tr1=dyntb.insertRow();	//注意：插入的必须与下面的在一起,否则造成空行
	tr1.id="tr"+dynTbIndex; 
    tr1.insertCell().innerHTML = '<input id=R1 type=hidden value="'+ smode_code+'" readOnly>'+smode_code+'</input>';       
    tr1.insertCell().innerHTML = '<input id=R2 type=hidden value="' + product_code + '" readOnly>'+product_code+'</input>';         
    tr1.insertCell().innerHTML = '<input id=R3 type=hidden value="'+ product_name+'"  readOnly>'+product_name+'&nbsp;</input>';   
	if(product_type.trim()=="0")
    {
    	tr1.insertCell().innerHTML = '<input id=R4 type=hidden value="'+ product_type+'"  readOnly>主产品&nbsp;</input>'; 
    } 
    else if(product_type.trim()=="1") 
    {
    	tr1.insertCell().innerHTML = '<input id=R4 type=hidden value="'+ product_type+'"  readOnly>附属产品&nbsp;</input>'; 
    }    
    if(product_discount.trim()=="Y")
    {
    	tr1.insertCell().innerHTML = '<input id=R6 type=hidden value="'+ product_discount+'"  readOnly>是</input>'; 
    } 
    else if(product_discount.trim()=="N") 
    {
    	tr1.insertCell().innerHTML = '<input id=R6 type=hidden value="'+ product_discount+'"  readOnly>否</input>'; 
    }  
   ///*tr1.insertCell().innerHTML = '<input id=R5 type=text class="InputGrey" value="'+ product_note+'" readOnly></input>';*/
	tr1.insertCell().innerHTML = '<input id=R5 type=hidden value="'+ product_note+'" readOnly>'+product_note+'</input>';  
	dynTbIndex++;
}

</SCRIPT>

</HEAD>
<BODY>
<FORM method=post name="frm">
    <%@ include file="/npage/include/header.jsp" %>  
<div class="title">
		<div id="title_zi">资费信息信息</div>
	</div>
    <table cellSpacing=0> 
    	<tr>
			<th width="15%">
				<b>资费名称</b>
			</th>
			<th width="15%">
				<b>开始时间</b>
			</th>
			<th width="15%">
				<b>结束时间</b>
			</th>
    	</tr>
    	<tr>
    		<td class="Blue" nowrap>
    			<input type="text" class="InputGrey" name="offer_name" value=""></input>
    		</td>
    		<td class="Blue" nowrap>
    			<input type="text" class="InputGrey" name="eff_date" value=""></input>
    		</td>
    		<td class="Blue" nowrap>
    			<input type="text" class="InputGrey" name="exp_date" value=""></input>
    		</td>
    	</tr> 
    </table>
	</div>
	<div id="Operation_Table">
	<div class="title">
		<div id="title_zi">子产品信息</div>
	</div>
    <table cellSpacing="0" id="dyntb"> 
    	<tr>
			<th width="10%">
				<b>子产品品牌</b>
			</th>
			<th width="10%">
				<b>子产品代码</b>
			</th>
			<th width="10%">
				<b>子产品名称</b>
			</th>
			<th width="10%">
				<b>子产品类别</b>
			</th>
			<th width="10%">
				<b>是否享受折扣</b>
			</th>
			<th width="20%">
				<b>子产品注释</b>
			</th>
    	</tr> 
    	<tr id="tr0" style="display:none"> 
            <td>
            	<input type="text" id="R1" value="">
            </td>
            <td>
            	<input type="text" id="R2" value="">
            </td>
            <td>
            	<input type="text" id="R3" value="">
            </td>  
           <td>
            	<input type="text" id="R4" value="">
            </td>  
            <td>
            	<input type="text" id="R6" value="">
            </td>
            <td>
            	<input type="text" id="R5" value="">
            </td> 
        </tr>
		</table>
		<table cellSpacing="0">
        <tr>
            <td align=center id="footer" colspan="5">
                <input class="b_foot" name=back onClick="window.close()" style="cursor:hand" type=button value="关闭">&nbsp;
            </td>
        </tr>   
    </table>
    <input type="hidden" name="result_length" value=0>
    <%@ include file="/npage/include/footer.jsp" %>  
</FORM>
</BODY>
</HTML>
