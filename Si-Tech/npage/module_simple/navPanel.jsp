<div id="navPanel" onclick="hideFavMenu()">
	<div class="title">
		<ul>
		    <!--
			<li id="getFavFunc" onclick="HoverNav('fav')" title="���ù���" class="on">
				<div class="ico_user"></div>
				<span>���ù���</span>	
			</li>
			-->
			<li id="getTree"  onclick="HoverNav('tree','99999','ϵͳ����')"  title="ϵͳ����" class="on">
				<div class="ico_tree"></div>
				<span>ϵͳ����</span>	
			</li>
			<li id="getAllTree" onclick="HoverNav('alltree','99999','ȫ������')" title="ȫ������">
				<div class="ico_fav"></div>
				<span>ȫ������</span>	
			</li>
			<!--li id="getAuthorizeTree" onclick="HoverNav('authorizetree','99999','��Ȩ����')" title="��Ȩ����">
				<div class="ico_all"></div>
				<span>��Ȩ����</span>	
			</li-->
		</ul>
	</div>
	
		<div class="search_bar">
			<div class="input">
				<input name="funcText" id="funcText" type="text" onkeyup="if(this.value=='')$('#system_search_result').hide();" onkeypress="if(event.keyCode==13) searchFunc($('#funcText').val());" value="����ģ�� (Alt+3)" >
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
		<li id="delIcon"><span class="del"></span>ɾ��</li>
		<li id="editIcon"><span class="edit"></span>���ÿ�ݼ�</li>
		<li id="todoIcon"><span class="todo"></span>���߰���</li>
	</ul>
</div>