<%
   /*
   * 功能: 联系人信息 
　 * 版本: v1.0
　 * 日期: 2009-01-13 14:37
　 * 作者: wanglj
　 * 版权: sitech
   * 修改历史
   * 修改日期      		修改人      修改目的
 　*/
%>
<div class="title"><div class="text">联系人</div></div>
<div class="input">	
			<table>
				<tr>
					<th>联系人名称：</th>
					<td>
						<input type="text" name="contactor_name" />
					</td>
					<th> 证件类型：</th>
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
					<th> 证件号码：</th>
					<td>
					          <input type="text" name="vouch_idNo" class="idCard required" v_minlength="18" v_maxlength="18" maxLength="18" id="vouch_idNo" value=""/>
					          <input type="text" name="vouch_len_text" id="vouch_len_text" value="(18位)"  style="background:none;border:none" readonly />					        
					</td>
				
					<th>联系电话：</th>
					<td>
							<input type="text" name="contactor_phone"/>
					</td>					
				 </tr>
				 <tr>	
					<th> 手机：</th>
					<td>
					          <input type="text" name="contactor_mobile"/>
					</td> 
					<th> E-MAIL：</th>
					<td>
					          <input type="text" name="contactor_email"/>
					</td> 					
				 </tr>
				 <tr>	
					<th> 联系人邮编：</th>
					<td>
					          <input type="text" name="contactor_post"/>
					</td>
				
					<th>联系人地址：</th>
					<td>
							<input type="text" name="contactor_addr"/>
					</td>					
				</tr>
				 			 			 
			</table>
</div>