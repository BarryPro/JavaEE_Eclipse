<div id="Main">
	<%-- /**  modified by hejwa in 20110713 多OP改造--页面导航  begin **/ --%>
	
		<% 
			boolean pageNavFlag = false;
			//页面导航信息表中若有，则显示表中数据，若没有则查询sGetFuncRoot服务。
			String pageNavMNGSql = " select nav_path from dfuncnavmsg where function_code=:function_code and is_use='1' ";
			String pageNavMNGParam = "function_code="+WtcUtil.repNull(opCode);
		%>
		<wtc:service name="TlsPubSelCrm" outnum="1"  retcode="pageNavMNGRetCode" retmsg="pageNavMNGRetMsg">
			<wtc:param value="<%=pageNavMNGSql%>" />
			<wtc:param value="<%=pageNavMNGParam%>" />
		</wtc:service>
		<wtc:array id="pageNavMNGList" scope="end"/>
		<%
			 //System.out.println("pageNavMNGRetCode==="+pageNavMNGRetCode);
			if("000000".equals(pageNavMNGRetCode)){
			//System.out.println("pageNavMNGList.length==="+pageNavMNGList.length);
				if(pageNavMNGList.length>0){
					  pageNavFlag = true;
					  String pageNav = pageNavMNGList[0][0].trim();
					  String[] pageNavArr = pageNav.split(";");
					 %>
						<table  cellspacing="0" style="font-size: 12px;text-align: left;width:100%;background-color: #F5F5F5;border-top-width: 1px;border-left-width: 1px;border-top-style: solid;border-left-style: solid;border-top-color: #F5F5F5;border-left-color: #F5F5F5;line-height: 17px;margin: 0px;padding: 0px;">
							<tr>
								<td>
									当前位置：
							<%
								for(int pageNavNum=0;pageNavNum<pageNavArr.length;pageNavNum++){
									if(pageNavNum==pageNavArr.length-1){
							 		%>
							 			<span title="<%=pageNavArr[pageNavNum].trim()%>" style="text-decoration: underline;color: #ff8100;cursor: pointer;" ><%=pageNavArr[pageNavNum].trim()%></span>
							 		<%
							 		}else{
							 		%>
							 			<span style="cursor: pointer;" title="<%=pageNavArr[pageNavNum].trim()%>" ><%=pageNavArr[pageNavNum].trim()%></span>&gt;&gt;
							 		<%
							 		}
					 		  }
					 		%>
					 		
						 		</td>
							</tr>
						</table>
					 <%
				}
			}
			
		if(!pageNavFlag){//若页面导航信息表没有则调用sGetFuncRoot服务查询
		%>	
		  <wtc:service name="sGetFuncRoot" retcode="pageNavRetCode" retmsg="pageNavRetMsg"  outnum="2">
				<wtc:param value="<%=WtcUtil.repNull(opCode)%>" />
			</wtc:service>
			<wtc:array id="pageNavRetList" scope="end"/>
			<%
				//System.out.println("pageNavRetCode----"+pageNavRetCode);
				if("000000".equals(pageNavRetCode)){
					if(pageNavRetList.length>0){
				%>
					<table  cellspacing="0" style="font-size: 12px;text-align: left;width:100%;background-color: #F5F5F5;border-top-width: 1px;border-left-width: 1px;border-top-style: solid;border-left-style: solid;border-top-color: #F5F5F5;border-left-color: #F5F5F5;line-height: 17px;margin: 0px;padding: 0px;">
						<tr>
							<td>
								当前位置：
					<%
					 for(int pageNavNum=pageNavRetList.length-3;pageNavNum>=0;pageNavNum--){
					 		//System.out.println("pageNavRetList----"+pageNavRetList[pageNavNum][0]);
					 		if(pageNavNum==0){
					 		%>
					 			<span title="<%=pageNavRetList[pageNavNum][0].trim()%>" style="text-decoration: underline;color: #ff8100;cursor: pointer;" ><%=pageNavRetList[pageNavNum][1].trim()%></span>
					 		<%
					 		}else{
					 		%>
					 			<span style="cursor: pointer;" title="<%=pageNavRetList[pageNavNum][0].trim()%>" ><%=pageNavRetList[pageNavNum][1].trim()%></span>&gt;&gt;
					 		<%
					 		}
					 }%>
					 		</td>
						</tr>
					</table>
			<%	}
				}
		}
		%>
		<%-- /**  modified by  hejwa in 20110713  多OP改造--页面导航  end **/ --%>
		<div id="Operation_Title">
			<div class="icon"></div>
				<B><font face="Arial"><%=WtcUtil.repNull(opCode)%></font>·<%=WtcUtil.repNull(opName)%></B>
		</div>
   <DIV id="Operation_Table"> 
