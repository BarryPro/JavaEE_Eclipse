<div class="title"><div id="title_zi">������</div></div> 
<div class="input">	
			<table>
				<tr>
					<td class="blue">����������</td>
					<td>
						<input type="text" name="agent_name" class="required"/>
					</td>
					<td class="blue"> ֤������</td>
					<td>
					          
					          <select name="agent_idType" onChange="change_idType(this,document.getElementById('agent_idNo'),document.getElementById('agent_len_text'))">
						          <wtc:pubselect  name="sPubSelect"  outnum="3">
     					               <wtc:sql>select trim(ID_TYPE),ID_NAME,ID_LENGTH from sIdType order by id_type</wtc:sql>													 
     						     </wtc:pubselect> 
                              	 <wtc:iter id="rowsjingban" indexId="i">
                    						<%if(rowsjingban[0].equals("2")) {%>
                    					<option selected="selected" value=<%=rowsjingban[0]%> v_ID_length=<%=rowsjingban[2]%>><%=rowsjingban[1]%></option>	
                    									<%}else{%>
                    					<option value=<%=rowsjingban[0]%> v_ID_length=<%=rowsjingban[2]%>><%=rowsjingban[1]%></option>				
                    									<%}%>
                    		          </wtc:iter> 
					     </select>
					</td>
				</tr> 
				<tr>	
					<td class="blue"> ֤������</td>
					<td>
					          <input type="text" name="agent_idNo" class="idCard" v_minlength="18" v_maxlength="18" maxLength="18"  id="agent_idNo"/>
					          <input type="text" name="agent_len_text" id="agent_len_text" value="(18λ)"  style="background:none;border:none" readonly >
					</td>
				
					<td class="blue">��ϵ�绰</td>
					<td>
							<input type="text" name="agent_phone" class="andCellphone"/>
					</td>					
				</tr>				 			 
			</table>
</div>