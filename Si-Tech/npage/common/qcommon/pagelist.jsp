	<!--�����б�DIV-->
	<div class="list" id="list_page">
	</div>
	<div id="operation_pagination">
		��<input type="text" size="3" style="text-align:right" readOnly name="curpage" id="curpage" value="1">ҳ
		��<input type="text" size="3" style="text-align:right" readOnly name="totalpage" id="totalpage" value="1">ҳ
		<input type="text" size="5" style="text-align:right" name="totalrec" id="totalrec" value="1">����¼
		<a style="cursor:hand;" onclick=gotoPage("1")>[��ҳ]</a></span>&nbsp;
		<a style="cursor:hand;" onclick=gotoPage(Number(g("curpage").value)-1)>[��һҳ]</a>&nbsp;
		<a style="cursor:hand;" onclick=gotoPage(Number(g("curpage").value)+1)>[��һҳ]</a>&nbsp;
		<a style="cursor:hand;" onclick=gotoPage(Number(g("totalpage").value))>[βҳ]</a>&nbsp;
		ת��<input type="text" size="5" onchange="gotoPage(Number(this.value))">ҳ
	</div>