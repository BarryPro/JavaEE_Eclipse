<%
  String sqlStr_temp="select cust_id_type,type_name from scustidtype  where show_flag = 'Y' order by show_order";
  String  powerCodesear = session.getAttribute("powerCode")==null?"":((String)session.getAttribute("powerCode")).trim();//��ɫ����
%>   
<wtc:pubselect name="sPubSelect" outnum="2">
	<wtc:sql><%=sqlStr_temp%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end" />

<%
/**  modified by hejwa in 2011-8-2 ��OP����--��ȡ��ʽ  begin **/
String reLayoutArr[][] = new String[][]{{"1","���������"},
  										  {"2","��ʾȫ��"},
  										  {"3","�޲˵�"},
  										  {"4","����"}
  										};//û�����ù���̨��ɫ�Ĺ��Ž���Ĭ������
  String powerCodeSear = session.getAttribute("powerCode")==null?"":((String)session.getAttribute("powerCode")).trim();//��ɫ����
  String layout_sql = "select a.layout_css+1, a.layout_name, a.is_effect, b.is_default from dlayoutmsg a, dlayoutrole_rel b where  a.layout_css = b.layout_css and b.op_role=(select trim(h.m_rolecode) from dmoprolerela h where h.b_rolecode=:powerCode)     order by a.layout_css";
  String layout_param = "powerCode="+powerCodesear.trim();
%>   
<wtc:service name="TlsPubSelCrm" outnum="2" routerKey="region" routerValue="<%=regionCode %>">
	<wtc:param value="<%=layout_sql%>" />
	<wtc:param value="<%=layout_param%>" />
</wtc:service>
<wtc:array id="reLayout" scope="end"/>	
	
<% /**  modified by hejwa in 2011-8-2 ��OP����--��ȡ��ʽ  end **/%>	
<div id="searchPanel">
	<div class="serverCase">
		<!--�ͷ��޸�(2) onlick�¼�ȥ�� update by songjia -->
		<div class="select"  >
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
			<input type="text" name="iCustName" id="iCustName" onfocus="clearCustName()" onblur="if(this.value==''){this.value='��������Ϣ���в�ѯ';}"  onkeyDown="if(event.keyCode==13) {javascript:document.getElementById('iCustName2').value=this.value;addTabBySearchCustName(document.all.loginType.loginType);}" value="�������ֻ������ѯ" maxlength="100"/>
			<input type='hidden' name='iCustName2' id='iCustName2' value='' /> 
			<!--�ͷ�(1) songjia �洢�ͻ�ID-->
			<input type='hidden' name='cust_type' id='cust_type' value='1' /> 
			<!--end-->
		</div>
		<button onClick="javascript:document.getElementById('iCustName2').value=document.getElementById('iCustName').value;if(document.getElementById('iCustName2').value!='') addTabBySearchCustName(document.all.loginType.loginType,'button')"></button>
		<!--input type="button" onClick="javascript:btnReadID2()" class="ico_id" title="�������֤����" style="display:none"/-->
	</div>
	<div class="quickGo">
		<div class="input">
			<input type='text'  class="inp_name" id='tb' value='����ת�� (Alt+2)'/>
			<input type='hidden' id='tb_h' value='-1'/>
		</div>
		<button class="keyOn" id="lock" onclick="javascript:turnLock(this)" opcode=""></button>
	</div>
	<!--hejwa����������빦��b-->
	<div class="newCust">
		        <input type=button  class="b_head_newCustkf" name="newCust" value="" onclick="newCustAddBut()"  />
	</div>
	<!--hejwa����������빦��e-->	    
	<ul class="layerout">
		<%	
	/**  modified by hejwa in 2011-8-2 ��OP����--��ȡ��ʽ  begin **/
	String layoutCss  = "";
	String layoutName = "";
	String spaceCss   = "";
	if(reLayout.length==0){
		reLayout = reLayoutArr;
	}
	for(int hjw=0;hjw<reLayout.length;hjw++){
		spaceCss  = "";
		layoutCss  = reLayout[hjw][0].trim();     
		layoutName = reLayout[hjw][1].trim();     
		if(layout.trim().equals(layoutCss)){
			spaceCss = "bSpaceOn";
		}else{
			spaceCss = "aSpace";
		}
		String outStr = "<li id='a"+layoutCss+"' class='"+spaceCss+"' onclick='layoutSwitch("+layoutCss+")' title='"+layoutName+"'></li>";
		out.print(outStr);
	}
	/**  modified by hejwa in 2011-8-2 ��OP����--��ȡ��ʽ  end **/
%>

	
		<input type="hidden" id="layoutStatus" value="3">
			<% /**  modified by hejwa in 2011-8-2 ��OP����--��ȡ��ʽ  begin **/%>
			<li class="more_set" onclick="openwindow('../set/setTheme.jsp','������嶨��','600','400')">������嶨��
		
			<!-- 
				<div class="more_panel">
				<iframe id="moresetIf" style="position:absolute;width:120px;z-index:-1;top:-2px;left:-2px;" scrolling="no"frameborder="0" src="about:blank"></iframe>
					<ul>
						<li class="theme"><a href="#this" onclick="openwindow('../set/setTheme.jsp','����ģʽ����','600','400')">����ģʽ����</a></li>
						li class="menu"><a href="#this" onclick="openwindow('../set/setMenu.jsp','���˵�����','600','400')">���˵�����</a></li-->
						<!-- li class="work"><a href="#this" onclick="openwindow('../set/setWork.jsp','�����ռ䶨��','600','600')">�����ռ䶨��</a></li
					</ul>
					<div style="clear:both"></div>
				</div>
				 -->
				 <% /**  modified by hejwa in 2011-8-2 ��OP����--��ȡ��ʽ  end **/%>
		</li>
	</ul>
</div>
                