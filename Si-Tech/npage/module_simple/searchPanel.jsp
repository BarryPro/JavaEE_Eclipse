<%
  String sqlStr_temp="select cust_id_type,type_name from scustidtype  where show_flag = 'Y' order by show_order";
%>   
<wtc:pubselect name="sPubSelect" outnum="2">
	<wtc:sql><%=sqlStr_temp%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end" />
<div id="searchPanel">
	<div class="serverCase">
		<div class="select" onclick="chgLoginType()">
			<input type="text" name="loginType" id="loginType" readonly loginType="1" value="�ֻ�����" >
			<div class="select_panel">
			 <%
			  for(int i=0;i<result.length;i++)
			  {
			 %>
				<p value="<%=result[i][0]%>"><%=result[i][1]%></p>
			 <%
			  }
			 %>			
		</div>
    </div>
</div>
	<div class="serverNum">
		<div class="input">
			<input type="text" name="iCustName" id="iCustName" onfocus="clearCustName()"  javascript:document.getElementById('iCustName2').value=this.value;this.value='�������ֻ������ѯ';" onkeyDown="if(event.keyCode==13)addTabBySearchCustName(document.all.loginType.loginType)" value="�������ֻ������ѯ" maxlength="100"/>
			<input type='hidden' name='iCustName2' id='iCustName2' value='' /> 
		</div>
		<!--<button onClick="javascript:if(document.getElementById('iCustName2').value!='') addTabBySearchCustName(document.all.loginType.loginType,'button')"></button>-->
		<button onClick="javascript:document.getElementById('iCustName2').value=document.getElementById('iCustName').value;document.getElementById('iCustName').value='�������ֻ������ѯ';if(document.getElementById('iCustName2').value!='') addTabBySearchCustName(document.all.loginType.loginType,'button')"></button>
		<!--input type="button" onClick="javascript:btnReadID2()" class="ico_id" title="�������֤����" style="display:none"/-->
	</div>
	<div class="quickGo">
		<div class="input">
			<input type='text'  class="inp_name" id='tb' value='����ת�� (Alt+2)'/>
			<input type='hidden' id='tb_h' value='-1'/>
		</div>
		<button class="keyOn" id="lock" onclick="javascript:turnLock(this)" opcode=""></button>
	</div>
	<div class="newCust">
	    <input type=button name="newCust" value="" onclick="newCustF()" class="b_head_newCust"/>
	</div>
	
	<ul class="layerout">
		<li id="a1" <%if(layout.trim().equals("1")){%>class="bSpaceOn"<%}else{%>class="aSpace"<%}%> onclick="layoutSwitch(1)" title="���������"></li>
		<li id="a2" <%if(layout.trim().equals("2")){%>class="bSpaceOn"<%}else{%>class="aSpace"<%}%> onclick="layoutSwitch(2)" title="��ʾȫ��"></li>
		<li id="a3" <%if(layout.trim().equals("3")){%>class="bSpaceOn"<%}else{%>class="aSpace"<%}%> onclick="layoutSwitch(3)" title="�޲˵�"></li>
		<li id="a4" <%if(layout.trim().equals("4")){%>class="bSpaceOn"<%}else{%>class="aSpace"<%}%> onclick="layoutSwitch(4)" title="����"></li>
		<input type="hidden" id="layoutStatus" value="3">
	</ul>
</div>
                