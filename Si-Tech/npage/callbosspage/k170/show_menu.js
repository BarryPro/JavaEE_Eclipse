$(document).ready(function(){
var b = $('body > #Operation_Table > .bar > .title');
//alert(b.length);
b.click(function(e){
	//alert();
	//$('body > #Operation_Table > .bar > .tree ').hide();
	//$('.tree').hide();
	
	//update by hucw,20100601
	/*
	var tar = $(e.target).parent().parent();
	for(var i=0; i<b.length; i++){
		if(b.get(i) != tar.get(0)){
			$(b.get(i)).children('.tree').hide();
		}
	}
	var tree = tar.children('.tree');
	tree.toggle();
	*/
	$(this).parent().parent().children('.tree').toggle();
});
});

function getdetail(p)
{
	window.open('callreasonlist.jsp?id='+p.id,'myFrame4');
}
function changecolor(p)
{
	if($('#'+p.id).attr('class') == 'tree')
	{
		$('#'+p.id).removeClass();
		$('#'+p.id).addClass('treeup');
	}else{
		$('#'+p.id).removeClass();
		$('#'+p.id).addClass('tree');
	}
}