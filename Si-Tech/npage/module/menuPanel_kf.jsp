	<div id="menuPanel">
		<div id="oli" style="display:inline;">
			<%if(result.length < 11)
			{out.println("<ul id=\"menu-h\">");
			  for(int i=0;i<result.length;i++){
			%>
					<li  id="<%=result[i][1].trim()%>"><span><%=result[i][2].trim()%></span></li>
			<%} out.println("</ul>");

			}else
			{ out.println("<ul id=\"menu-h\">");

					for(int i=0;i<11;i++){%>
					<li  id="<%=result[i][1].trim()%>"><span><%=result[i][2].trim()%></span></li>
					<%
					}%></ul>
				<% out.println("<div id=\"mor1\" onclick=\"popMenu()\" style=\"display:inline;\">更多>></div>");
				
			}%>
		
			<%out.println("<div id=\"menu-v\" style=\"width:120px\" >");
				out.println("<ul id=\"menuvul\" style=\"width:120px\" >");
				for(int i = 11 ; i < result.length ; i ++){%>
					<li  id="<%=result[i][1].trim()%>" style="float:none;width:120px"><span><%=result[i][2].trim()%></span></li>
					<%
					}
				out.println("</ul>");
				out.println("</div>");%>
			<div id="layerout">
				
				
					<%-- /**  modified by hejwa in 20110714 多OP改造  begin **/ --%>
				<%
					 String reLayoutArrl[][] = new String[][]{
					 					  {"1","工作区最大化","1","0"},
  										  {"2","显示全部","1","1"},
  										  {"3","无菜单","1","0"},
  										  {"4","无树","1","0"}
  										};//没有配置工作台角色的工号进行默认设置
  										
					String layout_sql = "select a.layout_css, a.layout_name, a.is_effect, b.is_default from dlayoutmsg a, dlayoutrole_rel b where  a.layout_css = b.layout_css and b.op_role=(select trim(h.m_rolecode) from dmoprolerela h where h.b_rolecode=:powerCode)     order by a.layout_css";
					String layout_param = "powerCode="+powerCode.trim();
				%>
				
				<wtc:service name="TlsPubSelCrm" outnum="4" routerKey="region" routerValue="<%=regionCode %>">
					<wtc:param value="<%=layout_sql%>" />
					<wtc:param value="<%=layout_param%>" />
				</wtc:service>
				<wtc:array id="layoutList" scope="end"/>
				<%				
			if("000000".equals(retCode)){ 	
				if(layoutList.length<=0){//若返回值为空，默认显示全部
					%>
					<img src="../../nresources/default/images/layout_switcher_0_on.gif" alt="显示全部"      onClick="layoutSwitch(0)" >
					<%
				}
				if(layoutList.length==0){
					layoutList = reLayoutArrl;
				}
				for(int i=0;i<layoutList.length;i++){
					String jsParam = "0";
					String imgPath = "/nresources/default/images/layout_switcher_0_on.gif"; //默认为显示全部
					if("1".equals(layoutList[i][0])){	
						if("1".equals(layoutList[i][3])){//若为默认显示 on 图片
							imgPath = "/nresources/default/images/layout_switcher_0_on.gif"; 
						}else{
							imgPath = "/nresources/default/images/layout_switcher_0.gif"; 
						}
					}else if("2".equals(layoutList[i][0])){
						if("1".equals(layoutList[i][3])){//若为默认显示 on 图片
							imgPath = "/nresources/default/images/layout_switcher_1_on.gif"; 
						}else{
							imgPath = "/nresources/default/images/layout_switcher_1.gif"; 
						}
					}else if("3".equals(layoutList[i][0])){
						if("1".equals(layoutList[i][3])){//若为默认显示 on 图片
							imgPath = "/nresources/default/images/layout_switcher_2_on.gif"; 
						}else{
							imgPath = "/nresources/default/images/layout_switcher_2.gif"; 
						}
					}else if("4".equals(layoutList[i][0])){
						if("1".equals(layoutList[i][3])){//若为默认显示 on 图片
							imgPath = "/nresources/default/images/layout_switcher_3_on.gif"; 
						}else{
							imgPath = "/nresources/default/images/layout_switcher_3.gif"; 
						}
					}					
					%>
					<img src="<%=request.getContextPath()+imgPath%>" alt="<%=layoutList[i][1]%>" onClick="layoutSwitch(<%=layoutList[i][0]%>)" >
					<%
				}
			}else{//如果服务执行失败,默认“显示全部”
				%>
				<img src="../../nresources/default/images/layout_switcher_0_on.gif" alt="显示全部"      onClick="layoutSwitch(0)" >
				<%
			}
			%>		
			<!--<img src="../../nresources/default/images/layout_switcher_0_on.gif" alt="恢复默认窗口"      onClick="layoutSwitch(0)" >
			<img src="../../nresources/default/images/layout_switcher_1.gif"    alt="收缩页头" 			    onClick="layoutSwitch(1)" >
			<img src="../../nresources/default/images/layout_switcher_2.gif"    alt="隐藏导航树"  		  onClick="layoutSwitch(2)">
			-->
			
			<%-- /**  modified by hejwa in 20110714 多OP改造  end **/ --%>
			
			
			
			</div>
	        </div> 
	</div>
