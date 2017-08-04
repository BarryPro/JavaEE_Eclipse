<div id="navPanel" onclick="hideFavMenu()">
	<div class="title">
		<ul>
		    <!--
			<li id="getFavFunc" onclick="HoverNav('fav')" title="常用功能" class="on">
				<div class="ico_user"></div>
				<span>常用功能</span>	
			</li>
			-->
			<li id="getTree"  onclick="HoverNav('tree','99999','系统功能')"  title="系统功能" class="on">
				<div class="ico_tree"></div>
				<span>系统功能</span>	
			</li>
			<li id="getAllTree" onclick="HoverNav('alltree','99999','全部功能')" title="全部功能">
				<div class="ico_fav"></div>
				<span>全部功能</span>	
			</li>
			<!--li id="getAuthorizeTree" onclick="HoverNav('authorizetree','99999','授权功能')" title="授权功能">
				<div class="ico_all"></div>
				<span>授权功能</span>	
			</li-->
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
	
		<div class="navMain">
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