
<script language="javascript">
//��ҳ����

var pageObj = {
		iRowStart : 1,  //��ʼ��¼��
		iRowEnd   : 10, //������¼��
		iRowSum		: 0,  //�ܼ�¼��
		iPageRow  : 10, //ÿҳ��¼��
		icPage    : 1,  //��ǰҳ��
		ipageSum  : 0   //��ҳ��
};


//����������ʼ����ҳ��������
function initPage(rowsum){
	var trowsum = parseInt(rowsum);
	pageObj.iRowSum = trowsum;
	pageObj.ipageSum = parseInt(trowsum/pageObj.iPageRow)+1;
	
	//alert("����["+trowsum+"];ҳ��["+pageObj.ipageSum+"]");
	
	//��ʼ��չʾ
	$("#pageNoSpan").text(pageObj.icPage);
	$("#totalPagesSpan").text(pageObj.ipageSum);
	$("#pageSizeSpan").text(pageObj.iPageRow);
	$("#totalCountSpan").text(trowsum);
	
}
//�����ҳ
function jumpF(){
	pageObj.icPage=1;
	goFunc();
}
//�����һҳ
function jumpP(){
	if(pageObj.icPage==1){
		//�Ѿ��ǵ�һҳ
	}else{
		 pageObj.icPage = pageObj.icPage-1;
	}
	goFunc();
}
//�����һҳ
function jumpN(){
	if(pageObj.icPage==pageObj.ipageSum){
		//�Ѿ������һҳ
	}else{
		pageObj.icPage = pageObj.icPage+1;
	}
	goFunc();
}
//���βҳ
function jumpE(){
	pageObj.icPage=pageObj.ipageSum;
	goFunc();
}
//��� GO ��ť
function jumpG(){
	//���ж����������Ƿ���ȷ
	var pageNum = $("#pageNum").val();
	if(/^\d+$/.test(pageNum)){
		if(parseInt(pageNum)>pageObj.ipageSum){
			rdShowMessageDialog("������С����ҳ��["+pageObj.ipageSum+"]�����֣�");
			$("#pageNum").val("");
			$("#pageNum").focus();
		}else{
			pageObj.icPage = pageNum;
			goFunc();
		}
	}else{
		rdShowMessageDialog("��������תҳ�������֣�");
		$("#pageNum").val("");
		$("#pageNum").focus();
	}
	
}

function goFunc(){
	
	//���ݵ�ǰҳ��������ʼ��¼����ÿҳ��1��������λ����¼������0��ʼ��+1 -1��ȥ��
	pageObj.iRowStart = (pageObj.icPage-1)*pageObj.iPageRow+1;
	pageObj.iRowEnd   = pageObj.iRowStart+pageObj.iPageRow-1;
	
	//alert("��ǰҳ��["+pageObj.icPage+"];��ʼ��¼��["+ pageObj.iRowStart+"];������¼��["+pageObj.iRowEnd+"]");
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
		alert("����������");
	}
}
 
</script>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="30%" class="page_txt01">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    ��[&nbsp;<span id="pageNoSpan"></span>&nbsp;]ҳ&nbsp;
    ��[&nbsp;<span id="totalPagesSpan"></span>&nbsp;]ҳ&nbsp;
    ÿҳ[&nbsp;<span id="pageSizeSpan"></span>&nbsp;]��&nbsp;
    ��[&nbsp;<span id="totalCountSpan"></span>&nbsp;]��&nbsp;</td>
    
     
        <td>
          <div align="center" class="page_txt">
          	<a href="javascript:void(0);"  
               onclick="jumpF(this)">
               &nbsp;��&nbsp;ҳ&nbsp;
            </a>
          </div>
        </td>

        <td>
          <div align="center" >
          	<a href="javascript:void(0);" 
               onclick="jumpP(this)">
               &nbsp;��һҳ&nbsp;
            </a>
            </div>
        </td>

        <td>
          <div align="center" >
          	<a href="javascript:void(0);" 
          	   onclick="jumpN(this)">
          	   &nbsp;��һҳ&nbsp;
          	</a>
          </div>
        </td>
        
        <td>
          <div align="center" >
            <a href="javascript:void(0);"  
               onclick="jumpE(this);">
               &nbsp;β&nbsp;ҳ&nbsp;
            </a>
          </div>
        </td>
        
        <td>
        
          <div align="right" >��ת����
            <input type="text" id="pageNum" size="5" maxlength="3"  value="" />ҳ
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
