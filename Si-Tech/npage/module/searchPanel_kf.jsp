<%
  String sqlStr_temp="select cust_id_type,type_name from scustidtype  where show_flag = 'Y' order by show_order";
  String  powerCodesear = session.getAttribute("powerCode")==null?"":((String)session.getAttribute("powerCode")).trim();//角色代码
%>   
<wtc:pubselect name="sPubSelect" outnum="2">
	<wtc:sql><%=sqlStr_temp%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end" />

<%
/**  modified by hejwa in 2011-8-2 多OP改造--读取样式  begin **/
String reLayoutArr[][] = new String[][]{{"1","工作区最大化"},
  										  {"2","显示全部"},
  										  {"3","无菜单"},
  										  {"4","无树"}
  										};//没有配置工作台角色的工号进行默认设置
  String powerCodeSear = session.getAttribute("powerCode")==null?"":((String)session.getAttribute("powerCode")).trim();//角色代码
  String layout_sql = "select a.layout_css+1, a.layout_name, a.is_effect, b.is_default from dlayoutmsg a, dlayoutrole_rel b where  a.layout_css = b.layout_css and b.op_role=(select trim(h.m_rolecode) from dmoprolerela h where h.b_rolecode=:powerCode)     order by a.layout_css";
  String layout_param = "powerCode="+powerCodesear.trim();
%>   
<wtc:service name="TlsPubSelCrm" outnum="2" routerKey="region" routerValue="<%=regionCode %>">
	<wtc:param value="<%=layout_sql%>" />
	<wtc:param value="<%=layout_param%>" />
</wtc:service>
<wtc:array id="reLayout" scope="end"/>	
	
<% /**  modified by hejwa in 2011-8-2 多OP改造--读取样式  end **/%>	
<div id="searchPanel">
	<div class="serverCase">
		<!--客服修改(2) onlick事件去掉 update by songjia -->
		<div class="select"  >
			<input type="text" name="loginType" id="loginType" readonly loginType="1" value="手机号码" >
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
			<input type="text" name="iCustName" id="iCustName" onfocus="clearCustName()" onblur="if(this.value==''){this.value='请输入信息进行查询';}"  onkeyDown="if(event.keyCode==13) {javascript:document.getElementById('iCustName2').value=this.value;addTabBySearchCustName(document.all.loginType.loginType);}" value="请输入手机号码查询" maxlength="100"/>
			<input type='hidden' name='iCustName2' id='iCustName2' value='' /> 
			<!--客服(1) songjia 存储客户ID-->
			<input type='hidden' name='cust_type' id='cust_type' value='1' /> 
			<!--end-->
		</div>
		<button onClick="javascript:document.getElementById('iCustName2').value=document.getElementById('iCustName').value;if(document.getElementById('iCustName2').value!='') addTabBySearchCustName(document.all.loginType.loginType,'button')"></button>
		<!--input type="button" onClick="javascript:btnReadID2()" class="ico_id" title="二代身份证读卡" style="display:none"/-->
	</div>
	<div class="quickGo">
		<div class="input">
			<input type='text'  class="inp_name" id='tb' value='快速转入 (Alt+2)'/>
			<input type='hidden' id='tb_h' value='-1'/>
		</div>
		<button class="keyOn" id="lock" onclick="javascript:turnLock(this)" opcode=""></button>
	</div>
	<!--hejwa增加受理号码功能b-->
	<div class="newCust">
		        <input type=button  class="b_head_newCustkf" name="newCust" value="" onclick="newCustAddBut()"  />
	</div>
	<!--hejwa增加受理号码功能e-->	    
	<ul class="layerout">
		<%	
	/**  modified by hejwa in 2011-8-2 多OP改造--读取样式  begin **/
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
	/**  modified by hejwa in 2011-8-2 多OP改造--读取样式  end **/
%>

	
		<input type="hidden" id="layoutStatus" value="3">
			<% /**  modified by hejwa in 2011-8-2 多OP改造--读取样式  begin **/%>
			<li class="more_set" onclick="openwindow('../set/setTheme.jsp','整体面板定制','600','400')">整体面板定制
		
			<!-- 
				<div class="more_panel">
				<iframe id="moresetIf" style="position:absolute;width:120px;z-index:-1;top:-2px;left:-2px;" scrolling="no"frameborder="0" src="about:blank"></iframe>
					<ul>
						<li class="theme"><a href="#this" onclick="openwindow('../set/setTheme.jsp','主题模式定制','600','400')">主题模式定制</a></li>
						li class="menu"><a href="#this" onclick="openwindow('../set/setMenu.jsp','主菜单定制','600','400')">主菜单定制</a></li-->
						<!-- li class="work"><a href="#this" onclick="openwindow('../set/setWork.jsp','工作空间定制','600','600')">工作空间定制</a></li
					</ul>
					<div style="clear:both"></div>
				</div>
				 -->
				 <% /**  modified by hejwa in 2011-8-2 多OP改造--读取样式  end **/%>
		</li>
	</ul>
</div>
                