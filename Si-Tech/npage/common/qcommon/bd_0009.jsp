<%
   /*
   * 功能: 发展人信息
　 * 版本: v1.0
　 * 日期: 2009-01-13 14:37
　 * 作者: wanglj
　 * 版权: sitech
   * 修改历史
   * 修改日期      		修改人      修改目的
 　*/
%>
<div class="title"><div  id="title_zi">发展人</div></div>
<div class="input">	
			<table>
				<tr>
					<td class="blue">发展人名称：</td>
					<td>
						<input type="text" name="develop_name" class="required" />
					</td>
					<td class="blue"> 证件类型</td>
					<td>
					          
					     <select name="develop_idType" onChange="change_idType(this,document.getElementById('develop_idNo'),document.getElementById('develop_len_text'))">
					          <wtc:pubselect  name="sPubSelect"  outnum="3">
					               <wtc:sql>select trim(ID_TYPE),ID_NAME,ID_LENGTH from sIdType order by id_type</wtc:sql>													 
						     </wtc:pubselect> 
                         	     <wtc:iter id="rows09" indexId="i">
               						<%if(rows09[0].equals("2")) {%>
                    					<option selected="selected" value=<%=rows09[0]%> v_ID_length=<%=rows09[2]%>><%=rows09[1]%></option>	
                    									<%}else{%>
                    					<option value=<%=rows09[0]%> v_ID_length=<%=rows09[2]%>><%=rows09[1]%></option>				
                    									<%}%>
               		          </wtc:iter> 
					     </select>
					</td>
				</tr>
				<tr>	
					<td class="blue"> 证件号码</td>
					<td>
					         <input type="text" name="develop_idNo" class="required idCard" v_minlength="18" v_maxlength="18" maxLength="18" id="develop_idNo" value=""/>
					          <input type="text" name="develop_len_text" id="develop_len_text" value="(18位)"  style="background:none;border:none" readonly />					        
					</td> 				
				</tr>				 			 
			</table>
</div>