<script>
		function getVouchCount(){
			if(!validateElement(document.all.vouch_idNo))
    	{
		      return false;
    	}	
    	var getVouchCount_packet = new AJAXPacket("/npage/common/qcommon/getVouchCount.jsp","正在读取该证件号码的开户数量，请稍候......");
			getVouchCount_packet.data.add("retType","getVouchCount");
			getVouchCount_packet.data.add("idType",g("id_type").value);
			getVouchCount_packet.data.add("idIccid",g("vouch_idNo").value);
			core.ajax.sendPacket(getVouchCount_packet,doProcess_008);
			getCustCount_packet = null;
		}
		function doProcess_008(packet){
			var retType = packet.data.findValueByName("retType");
			var retCode = packet.data.findValueByName("retCode");
			if(retCode != "000000"){
				if(rdShowConfirmDialog("没有该担保人信息,是否建立？")==0){
					g("vouch_idNo").value = ""	;
					g("vouch_idNo").focus();
					return false;
				}else{return true;}
			}
			if(retType == "getVouchCount"){
				var vouchCount = packet.data.findValueByName("vouchCount");
				if(vouchCount > 10){
						rdShowMessageDialog("该担保人已经担保10次,不能再担保!");
						g("vouch_idNo").value = ""	;
						g("vouch_idNo").focus();
						return false;
				}else{
						if(rdShowConfirmDialog("该证件号码已担保数量："+vouchCount+",是否继续担保")==1){
							var vouchName = packet.data.findValueByName("vouchName");
							var vouchPhone = packet.data.findValueByName("vouchPhone");
							var vouchPost = packet.data.findValueByName("vouchPost");
							var vouchAddr = packet.data.findValueByName("vouchAddr");
							var vouchNo = packet.data.findValueByName("vouchNo");
							g("vouch_name").value = vouchName;
							g("vouch_phone").value = vouchPhone
							g("vouch_post").value = vouchPost;
							g("vouch_addr").value = vouchAddr;
							alert(vouchNo);
							g("assureId").value = vouchNo;  //隐藏字段 担保标识
							g("assureNum").value = Number(vouchCount) + 1;//隐藏字段 担保数量
						}else{
							g("vouch_idNo").value = ""	;
							g("vouch_idNo").focus();
							return false;
						}
				}
			}	
		}
</script>
<div class="title"><div id="title_zi">担保人</div></div>

<div class="input">	
			<table>
				<tr>
					<td class="blue"  width="15%">担保人名称</td>
					<td  width="33%">
						<input type="text" name="vouch_name" value="" class="required"/>
					</td>
					<td class="blue"  width="15%"> 证件类型</td>
					<td>
					          
					          <select name="id_type" onChange="change_idType(this,document.getElementById('vouch_idNo'),document.getElementById('vouch_len_text'))">
                              	     <wtc:pubselect  name="sPubSelect"  outnum="3">
															               <wtc:sql>select trim(ID_TYPE),ID_NAME,ID_LENGTH  from sIdType order by id_type</wtc:sql>													 
																     </wtc:pubselect> 
                              	     <wtc:iter id="IdRows" indexId="i">
                              	     	<%if(IdRows[0].equals("2")) {%>
                    					<option selected="selected" value=<%=IdRows[0]%>   v_ID_length=<%=IdRows[2]%>><%=IdRows[1]%></option>	
                    									<%}else{%>
                    					<option value=<%=IdRows[0]%>  v_ID_length=<%=IdRows[2]%>><%=IdRows[1]%></option>				
                    									<%}%>
                    		          </wtc:iter>
     					     </select>
					</td> 
				</tr>
				<tr>	
					<td class="blue"> 证件号码</td>
					<td>
					          <input type="text" name="vouch_idNo" class="required idCard" v_minlength="18" v_maxlength="18" maxLength="18" id="vouch_idNo" value="" onchange="getVouchCount()"/>
					          <input type="text" name="vouch_len_text" id="vouch_len_text" value="(18位)"  style="background:none;border:none" readonly />					        
					</td>
					<td class="blue">联系电话</td>
					<td>
							<input type="text" class="andCellphone" name="vouch_phone" value=""/>
					</td>					
				</tr>
				 <tr>	
					<td class="blue"> 担保人邮编</td>
					<td>
					          <input type="text" class="postCode" name="vouch_post" value=""/>
					</td>
				
					<td class="blue">担保类型</td>
					<td>
							<input type="text" name="vouch_type" value=""/>
					</td>					
				</tr>	
				<tr>	
					<td class="blue">担保人地址 </td>
					<td colspan="3">
					     <input type="text" name="vouch_addr" value="" size="100" class="required"/>
					</td> 					
				</tr>			 			 
			</table>
			<input type="hidden" name="assureId" id="assureId" value="">
			<input type="hidden" name="assureNum" id="assureNum"  value="">
</div>
