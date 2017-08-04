	<%-- modified by hejwa in 20110714 多OP改造--内容管理 begin --%>
	<% //常用功能
	
		String  powerCodeOp = session.getAttribute("powerCode")==null?"":((String)session.getAttribute("powerCode")).trim();//角色代码
		String c_commfunc = "常用功能" ;
		String c_commfuncCls = "ico_user";
		String contentSql_11 = "select content_cls,content_name from dcontentmsg where content_id='p_commfunc'  and op_roleid=(select trim(h.m_rolecode) from dmoprolerela h where h.b_rolecode='"+powerCodeOp+"') and is_effect='1'";
	%>
	 
	<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  		<wtc:sql><%=contentSql_11%></wtc:sql>
 		</wtc:pubselect>
	<wtc:array id="commfunc1" scope="end"/>
	<%
		if("000000".equals(code)){
				if(commfunc1.length>0){
						c_commfuncCls = commfunc1[0][0];
						c_commfunc = commfunc1[0][1];
				}
		}
		c_commfunc = c_commfunc.trim();
		c_commfuncCls = c_commfuncCls.trim();
		
	%>
	
	<% //系统功能
		String c_sysmenu = "系统菜单" ;
		String c_sysmenuCls = "ico_tree";
		String contentSql_22 = " select content_cls,content_name from dcontentmsg where content_id='p_sysmenu' and op_roleid=(select trim(h.m_rolecode) from dmoprolerela h where h.b_rolecode='"+powerCodeOp+"') and is_effect='1'";
	%>
	 
	<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  		<wtc:sql><%=contentSql_22%></wtc:sql>
 		</wtc:pubselect>
	<wtc:array id="sysmenu1" scope="end"/>
	<%
		if("000000".equals(code)){
				if(sysmenu1.length>0){
						c_sysmenuCls = sysmenu1[0][0];
						c_sysmenu = sysmenu1[0][1];
				}
		}
		c_sysmenu = c_sysmenu.trim();
		c_sysmenuCls = c_sysmenuCls.trim();
	%>
	<% //全部功能
		String c_privset = "全部功能" ;
		String c_privsetCls = "ico_fav";
		String contentSql_33 = " select content_cls,content_name from dcontentmsg where content_id='p_privset' and op_roleid=(select trim(h.m_rolecode) from dmoprolerela h where h.b_rolecode='"+powerCodeOp+"') and is_effect='1'";
	%>
	 
	<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  		<wtc:sql><%=contentSql_33%></wtc:sql>
 		</wtc:pubselect>
	<wtc:array id="privset1" scope="end"/>
	<%
		if("000000".equals(code)){
				if(privset1.length>0){
						c_privsetCls = privset1[0][0];
						c_privset = privset1[0][1];
				}
		}
		c_privset = c_privset.trim();
		c_privsetCls = c_privsetCls.trim();
	%>
	
	<% //业务向导
		String c_busiguide = "业务向导" ;
		String c_busiguideCls = "ico_buGu";
		String contentSql_44 = " select content_cls,content_name from dcontentmsg where content_id='p_busiguide' and op_roleid=(select trim(h.m_rolecode) from dmoprolerela h where h.b_rolecode='"+powerCodeOp+"') and is_effect='1'";
	%>
	 
	<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  		<wtc:sql><%=contentSql_44%></wtc:sql>
 		</wtc:pubselect>
	<wtc:array id="busiguide1" scope="end"/>
	<%
		if("000000".equals(code)){
				if(busiguide1.length>0){
						c_busiguideCls = busiguide1[0][0];
						c_busiguide = busiguide1[0][1];
				}
		}
		c_busiguide = c_busiguide.trim();
		c_busiguideCls = c_busiguideCls.trim();
	%>
	<%-- modified by hejwa in 20110714 多OP改造--内容管理 end --%>
					
 
<div id="navPanel" onclick="hideFavMenu()" style="width: 220px;">
	<div class="title">
		<ul>
			<li id="getFavFunc" onclick="HoverNav('fav')" title="<%=c_commfunc%>" class="on">
				<div class="<%=c_commfuncCls%>"></div>
				<span><%=c_commfunc%></span>	
			</li>
			<li id="getTree"  onclick="HoverNav('tree','99999','<%=c_sysmenu%>')"  title="<%=c_sysmenu%>">
				<div class="<%=c_sysmenuCls%>"></div>
				<span><%=c_sysmenu%></span>	
			</li>
			<li id="getAllTree" onclick="HoverNav('alltree','99999','<%=c_privset%>')" title="<%=c_privset%>">
				<div class="<%=c_privsetCls%>"></div>
				<span><%=c_privset%></span>	
			</li>
			
			<li id="buGu" onclick="HoverNav('buGu')" title="<%=c_busiguide%>">
				<div class="<%=c_busiguideCls%>"></div>
				<span><%=c_busiguide%></span>	
				<li id="tbc_04" style="display:none;"></li>
			</li>
		</ul>
	</div>
	
		<div class="search_bar">
			<div class="input">
				<input name="funcText" id="funcText" type="text" onkeyup="if(this.value=='')$('#system_search_result').hide();" onkeypress="if(event.keyCode==13) searchFunc($('#funcText').val());" value="搜索模块 (Alt+3)" >
			</div>
			<button onclick="searchFunc($('#funcText').val())"></button>
		</div>
		<div id="system_search_result" class="search_result" >
			<div class="close" onclick="$('#system_search_result').hide();"></div>
			<ul class="custom_module" id="functionResult"></ul>
		</div>
	
		<div class="navMain" id="navMainTmp">
				<div id="wait">
					<div class="loading_gif"></div>
				</div>
		</div>
</div>

<div class="rightmenu" id="favMenu" style="display:none">
	<ul>
		<li id="delIcon"><span class="del"></span>删除</li>
		<li id="editIcon"><span class="edit"></span>设置快捷键</li>
		<li id="todoIcon"><span class="todo"></span>在线帮助</li>
	</ul>
</div>