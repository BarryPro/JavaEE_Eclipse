<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%  
    String opCode="7420";
    String opName="����100ҵ������ò�ѯ";
    String offer_id = request.getParameter("offer_id");
%>

<HTML>
<HEAD>
	<TITLE>������BOSS-��Ʒ������ѡ��</TITLE>

<SCRIPT type=text/javascript>

var dynTbIndex=1;	//���ڶ�̬�����ݵ�����λ��,��ʼֵΪ1.���Ǳ�ͷ

onload=function(){
	var cfmpacket = new AJAXPacket("f7411Qry.jsp", "�����ύ,���Ժ�......");
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
		rdShowMessageDialog("������Ϣ��"+retMsg+" ������룺"+retCode,0);
		return false;
	}
} 	

function queryAddAllRow(smode_code,product_code,product_name,product_type,product_note,product_discount){
	//alert("["+smode_code+"]["+product_code+"]["+product_name+"]["+product_type+"]["+product_note+"]");
	var tr1=dyntb.insertRow();	//ע�⣺����ı������������һ��,������ɿ���
	tr1.id="tr"+dynTbIndex; 
    tr1.insertCell().innerHTML = '<input id=R1 type=hidden value="'+ smode_code+'" readOnly>'+smode_code+'</input>';       
    tr1.insertCell().innerHTML = '<input id=R2 type=hidden value="' + product_code + '" readOnly>'+product_code+'</input>';         
    tr1.insertCell().innerHTML = '<input id=R3 type=hidden value="'+ product_name+'"  readOnly>'+product_name+'&nbsp;</input>';   
	if(product_type.trim()=="0")
    {
    	tr1.insertCell().innerHTML = '<input id=R4 type=hidden value="'+ product_type+'"  readOnly>����Ʒ&nbsp;</input>'; 
    } 
    else if(product_type.trim()=="1") 
    {
    	tr1.insertCell().innerHTML = '<input id=R4 type=hidden value="'+ product_type+'"  readOnly>������Ʒ&nbsp;</input>'; 
    }    
    if(product_discount.trim()=="Y")
    {
    	tr1.insertCell().innerHTML = '<input id=R6 type=hidden value="'+ product_discount+'"  readOnly>��</input>'; 
    } 
    else if(product_discount.trim()=="N") 
    {
    	tr1.insertCell().innerHTML = '<input id=R6 type=hidden value="'+ product_discount+'"  readOnly>��</input>'; 
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
		<div id="title_zi">�ʷ���Ϣ��Ϣ</div>
	</div>
    <table cellSpacing=0> 
    	<tr>
			<th width="15%">
				<b>�ʷ�����</b>
			</th>
			<th width="15%">
				<b>��ʼʱ��</b>
			</th>
			<th width="15%">
				<b>����ʱ��</b>
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
		<div id="title_zi">�Ӳ�Ʒ��Ϣ</div>
	</div>
    <table cellSpacing="0" id="dyntb"> 
    	<tr>
			<th width="10%">
				<b>�Ӳ�ƷƷ��</b>
			</th>
			<th width="10%">
				<b>�Ӳ�Ʒ����</b>
			</th>
			<th width="10%">
				<b>�Ӳ�Ʒ����</b>
			</th>
			<th width="10%">
				<b>�Ӳ�Ʒ���</b>
			</th>
			<th width="10%">
				<b>�Ƿ������ۿ�</b>
			</th>
			<th width="20%">
				<b>�Ӳ�Ʒע��</b>
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
                <input class="b_foot" name=back onClick="window.close()" style="cursor:hand" type=button value="�ر�">&nbsp;
            </td>
        </tr>   
    </table>
    <input type="hidden" name="result_length" value=0>
    <%@ include file="/npage/include/footer.jsp" %>  
</FORM>
</BODY>
</HTML>
