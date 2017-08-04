
<script language="javascript">
//分页变量

var pageObj = {
		iRowStart : 1,  //开始记录数
		iRowEnd   : 10, //结束记录数
		iRowSum		: 0,  //总记录数
		iPageRow  : 10, //每页记录数
		icPage    : 1,  //当前页数
		ipageSum  : 0   //总页数
};


//根据总数初始化分页各个数据
function initPage(rowsum){
	var trowsum = parseInt(rowsum);
	pageObj.iRowSum = trowsum;
	pageObj.ipageSum = parseInt(trowsum/pageObj.iPageRow)+1;
	
	//alert("总数["+trowsum+"];页数["+pageObj.ipageSum+"]");
	
	//初始化展示
	$("#pageNoSpan").text(pageObj.icPage);
	$("#totalPagesSpan").text(pageObj.ipageSum);
	$("#pageSizeSpan").text(pageObj.iPageRow);
	$("#totalCountSpan").text(trowsum);
	
}
//点击首页
function jumpF(){
	pageObj.icPage=1;
	goFunc();
}
//点击上一页
function jumpP(){
	if(pageObj.icPage==1){
		//已经是第一页
	}else{
		 pageObj.icPage = pageObj.icPage-1;
	}
	goFunc();
}
//点击下一页
function jumpN(){
	if(pageObj.icPage==pageObj.ipageSum){
		//已经是最后一页
	}else{
		pageObj.icPage = pageObj.icPage+1;
	}
	goFunc();
}
//点击尾页
function jumpE(){
	pageObj.icPage=pageObj.ipageSum;
	goFunc();
}
//点击 GO 按钮
function jumpG(){
	//先判断输入数字是否正确
	var pageNum = $("#pageNum").val();
	if(/^\d+$/.test(pageNum)){
		if(parseInt(pageNum)>pageObj.ipageSum){
			rdShowMessageDialog("请输入小于总页数["+pageObj.ipageSum+"]的数字！");
			$("#pageNum").val("");
			$("#pageNum").focus();
		}else{
			pageObj.icPage = pageNum;
			goFunc();
		}
	}else{
		rdShowMessageDialog("请输入跳转页数的数字！");
		$("#pageNum").val("");
		$("#pageNum").focus();
	}
	
}

function goFunc(){
	
	//根据当前页数计算起始记录数，每页从1计数包括位数记录，若从0开始，+1 -1可去掉
	pageObj.iRowStart = (pageObj.icPage-1)*pageObj.iPageRow+1;
	pageObj.iRowEnd   = pageObj.iRowStart+pageObj.iPageRow-1;
	
	//alert("当前页数["+pageObj.icPage+"];起始记录数["+ pageObj.iRowStart+"];计数记录数["+pageObj.iRowEnd+"]");
	doQuery();
}
 

function onJumbPage(bt) {
	var totalCount = $(bt).attr("totalCount");
	var pageText1  = $(bt).attr("pageSize");
	var pageText   = $("#pageText").val();
	
	if (pageText == null || pageText == "") {
		pageText = 1;
	}
	var page=Math.ceil(parseInt(totalCount) / parseInt(pageText1));
	var bl = true;
	if((/^(\+|-)?\d+$/.test( pageText1 )) && (/^(\+|-)?\d+$/.test( pageText)) )
	{
	if (pageText > page && parseInt(totalCount)>0) {
		bl = false;
	}
	if (bl == true) {
		jumpPagoFunc(pageText,$("#ajaxFuncName").val());
		bl=false;
	}
	}else{
		alert("请输入整数");
	}
}
 
</script>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="30%" class="page_txt01">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    第[&nbsp;<span id="pageNoSpan"></span>&nbsp;]页&nbsp;
    共[&nbsp;<span id="totalPagesSpan"></span>&nbsp;]页&nbsp;
    每页[&nbsp;<span id="pageSizeSpan"></span>&nbsp;]条&nbsp;
    共[&nbsp;<span id="totalCountSpan"></span>&nbsp;]条&nbsp;</td>
    
     
        <td>
          <div align="center" class="page_txt">
          	<a href="javascript:void(0);"  
               onclick="jumpF(this)">
               &nbsp;首&nbsp;页&nbsp;
            </a>
          </div>
        </td>

        <td>
          <div align="center" >
          	<a href="javascript:void(0);" 
               onclick="jumpP(this)">
               &nbsp;上一页&nbsp;
            </a>
            </div>
        </td>

        <td>
          <div align="center" >
          	<a href="javascript:void(0);" 
          	   onclick="jumpN(this)">
          	   &nbsp;下一页&nbsp;
          	</a>
          </div>
        </td>
        
        <td>
          <div align="center" >
            <a href="javascript:void(0);"  
               onclick="jumpE(this);">
               &nbsp;尾&nbsp;页&nbsp;
            </a>
          </div>
        </td>
        
        <td>
        
          <div align="right" >跳转到第
            <input type="text" id="pageNum" size="5" maxlength="3"  value="" />页
          </div>
        </td>
        
        <td width="30px">
          <div align="center" >
            <a id="pageButton" 
               name="pageButton"  totalPage="0"   totalCount="0"  pageSize="0"  
               href="javascript:void(0);" 
               onclick="javascript:jumpG(this)">&nbsp;GO&nbsp;
            </a>
          </div>
        </td>
        
      </tr>
    </table>
  </tr>
</table>
