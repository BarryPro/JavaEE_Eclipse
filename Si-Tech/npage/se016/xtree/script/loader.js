//** power by fason
function loader()
{
	
	var oDiv = document.createElement("div");
	
	with(oDiv.style)
	{
		width = "99%";
		padding = "1px 5px";
		border = "1px solid #CC0099";
		color = "window";
		backgroundColor = "#3366cc";
		font = "9pt Arial";
	}
	
	oDiv.noWrap = true;
	oDiv.innerHTML = "<nobr>ҳ�����ڼ��أ�����򡭡���ʱ��û�м��������ˢ�£�</nobr>"
	document.body.insertBefore(oDiv,document.body.firstChild);	
	if(document.all)
	{		
		window.attachEvent("onload",function(){ oDiv.parentNode.removeChild(oDiv);});
	}
	else
	{
		window.addEventListener("load",function(){ oDiv.parentNode.removeChild(oDiv);},false);
	}	
}