 
<%@ page import="java.util.*"%>
<%
		 Calendar cal_0024 = Calendar.getInstance(Locale.getDefault());
     cal_0024.add(Calendar.DAY_OF_MONTH,10);//ʱ������Ϊһ��
     String warnTime = new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(cal_0024.getTime());                      
     System.out.println("....................warnTime : "+warnTime);
     String master_serv_id_0024 = "";
     String service_offer_id_0024 = request.getParameter("servBusiId");
%>
<script>
	function changeNotice(obj){
	      var cValue = obj.options[obj.selectedIndex].value;
	      if(cValue == "1"){
	          document.getElementById(obj.v_div).disabled = false;
	          document.getElementById(obj.v_div2).disabled  = false;	          
	      }else{
	          document.getElementById(obj.v_div).disabled = true;	
	          document.getElementById(obj.v_div2).disabled = true;
	      }   
	} 
	
		function stopSpe(ele)
		{
			var b=ele.value;
			if(/[^0-9a-zA-Z\u4E00-\u9FA5]/.test(b)) ele.value=ele.value.replace(/[^0-9a-zA-Z\u4E00-\u9FA5]/g,'');
		}
</script>
		<wtc:pubselect  name="sPubSelect"  outnum="1">
       <wtc:sql>select master_serv_id from product a , service_offer b where a.product_id =b.PRODUCT_ID  and b.service_offer_id='?'</wtc:sql>													 
       <wtc:param value="<%=service_offer_id_0024%>"/>
    </wtc:pubselect> 
    <wtc:iter id="IdRows" indexId="i">
		<%
				 master_serv_id_0024 = IdRows[0];
				 System.out.println("..................master_serv_id_0024="+master_serv_id_0024);
		%>
</wtc:iter>
<%
	String sqlstr_0024 ="select deal_level,deal_level||'-->'||level_name from sServOrderDealLevel";
	if("0".equals(master_serv_id_0024)){
		sqlstr_0024 += " where deal_level='1'";
	}
%>
<div class="input">	
			<table>
				<tr>
					<td class='blue'>������</td>
					<td>
						<select name="handler_level">
						      <wtc:qoption name="sPubSelect" outnum="2">
	              	      <wtc:sql><%=sqlstr_0024%></wtc:sql>
	              	 </wtc:qoption>     
					     </select>
					</td>
					<td class='orange'>* ��ϵ��</td>
					<td>
					          <input type="text" class="required" name="contact_name" />
					</td>
				</tr>
				<tr>
					<td class='orange'>* ��ϵ�绰</td>
					<td>
					          <input type="text" class="required andCellphone" name="contact_phone"/>
					</td>
		      <td class='blue'>�����������</td>
		      <td>
		          <input type="text" class="yyyyMMdd" value="20500101"  name="finish_limit_time" onfocus="setday(this)" >
		      </td>
				</tr>
				<tr>		      
		      <td class='orange' style="display:none">*����Ԥ��ʱ��</td>
		      <td style="display:none">
		          <input type="text" class="required yyyyMMdd"  name="alerm_time" value="<%=warnTime%>" onfocus="setday(this)" >
		      </td>
					<td class='blue' id="is_preserv1">�Ƿ�ԤԼ����</td>	
					<td>
						<select name="is_preserv" v_div="preserv1" v_div2="preserv2" onchange="changeNotice(this)">
							<option value="1" >��</option>
							<option value="2" selected>��</option>
						</select>
					</td>	
					<td class='orange' id="preserv1" disabled=true>*ԤԼʱ��</td>
					<td >
						<input type="text" disabled=true class="required yyyyMMdd" id="preserv2" name="pre_time" onfocus="setday(this)" >
					</td>
				</tr>
				<tr>
					<td class='blue'>��ע</td>
					<td colspan="3">
							<input type="text" name="op_note" class="isLengthOf haveSpe" onkeyup="stopSpe(this)" maxlength="60" v_maxlength="60" size="100"/>
					</td>					
				</tr>				 			 
			</table>
</div>