<%
   /*
   * ����: ��ϵ����Ϣ 
�� * �汾: v1.0
�� * ����: 2009-01-13 14:37
�� * ����: wanglj
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      		�޸���      �޸�Ŀ��
 ��*/
%>
<div class="title"><div class="text">��ϵ��</div></div>
<div class="input">	
			<table>
				<tr>
					<th>��ϵ�����ƣ�</th>
					<td>
						<input type="text" name="contactor_name" />
					</td>
					<th> ֤�����ͣ�</th>
					<td>
					          
					          <select name="contactor_idType" onChange="change_idType(this,document.getElementById('contactor_idNo'),document.getElementById('contactor_len_text'))">
     						     <wtc:pubselect  name="sPubSelect"  outnum="3">
						               <wtc:sql>select trim(ID_TYPE),ID_NAME,ID_LENGTH from sIdType order by id_type</wtc:sql>													 
							     </wtc:pubselect> 
                              	     <wtc:iter id="rows" indexId="i">
                    						<%if(rows[0].equals("2")) {%>
                    					<option selected="selected" value=<%=rows[0]%> v_ID_length=<%=rows[2]%>><%=rows[1]%></option>	
                    									<%}else{%>
                    					<option value=<%=rows[0]%> v_ID_length=<%=rows[2]%>><%=rows[1]%></option>				
                    									<%}%>	
                    		          </wtc:iter> 
     					     </select>
					</td>
				</tr>
				<tr>	
					<th> ֤�����룺</th>
					<td>
					          <input type="text" name="vouch_idNo" class="idCard required" v_minlength="18" v_maxlength="18" maxLength="18" id="vouch_idNo" value=""/>
					          <input type="text" name="vouch_len_text" id="vouch_len_text" value="(18λ)"  style="background:none;border:none" readonly />					        
					</td>
				
					<th>��ϵ�绰��</th>
					<td>
							<input type="text" name="contactor_phone"/>
					</td>					
				 </tr>
				 <tr>	
					<th> �ֻ���</th>
					<td>
					          <input type="text" name="contactor_mobile"/>
					</td> 
					<th> E-MAIL��</th>
					<td>
					          <input type="text" name="contactor_email"/>
					</td> 					
				 </tr>
				 <tr>	
					<th> ��ϵ���ʱࣺ</th>
					<td>
					          <input type="text" name="contactor_post"/>
					</td>
				
					<th>��ϵ�˵�ַ��</th>
					<td>
							<input type="text" name="contactor_addr"/>
					</td>					
				</tr>
				 			 			 
			</table>
</div>