	<!--定义列表DIV-->
	<div class="list" id="list_page">
	</div>
	<div id="operation_pagination">
		第<input type="text" size="3" style="text-align:right" readOnly name="curpage" id="curpage" value="1">页
		共<input type="text" size="3" style="text-align:right" readOnly name="totalpage" id="totalpage" value="1">页
		<input type="text" size="5" style="text-align:right" name="totalrec" id="totalrec" value="1">条记录
		<a style="cursor:hand;" onclick=gotoPage("1")>[首页]</a></span>&nbsp;
		<a style="cursor:hand;" onclick=gotoPage(Number(g("curpage").value)-1)>[上一页]</a>&nbsp;
		<a style="cursor:hand;" onclick=gotoPage(Number(g("curpage").value)+1)>[下一页]</a>&nbsp;
		<a style="cursor:hand;" onclick=gotoPage(Number(g("totalpage").value))>[尾页]</a>&nbsp;
		转到<input type="text" size="5" onchange="gotoPage(Number(this.value))">页
	</div>