		<div id="workPanel">
			<img src="<%=request.getContextPath()%>/nresources/<%=cssPath%>/images/to-left_2.gif"  id="imgLeftRight" onclick="imgLeftRight()" />
			<div id="tabset">
				<div id="tab">
					<ul id="tabtag" >
						<li id="index" class="current" name="true"><span class="fristab"><IMG src="<%=request.getContextPath()%>/nresources/<%=cssPath%>/images/tab_work.gif" id="tab_user" id="tab_user"/>¹¤×÷¿Õ¼ä</span></li>
					</ul>
				</div>
				<span class="first"><img src="<%=request.getContextPath()%>/nresources/<%=cssPath%>/images/tabimages/btn_left.gif"  onclick="BtnMoveLeft(event)" id="imgLeft" /></span>
				<span class="next"><img src="<%=request.getContextPath()%>/nresources/<%=cssPath%>/images/tabimages/btn_right.gif" onclick="BtnMoveRight(event)"  id="imgRight" /></span>
				<dl id="contentArea">
					<dt class="on" >
						<iframe align="top"  class="workIframe"  id="ifram" src="../portal/work/portal.jsp" frameborder="0" scrolling="auto"  width="100%" height="100%" noresize>
					  </iframe>
					</dt>
				</dl>
			</div>
		</div>
	</div>	