<%
/***************************
* url模式，重用页面时需要包含的页面
* 石柏成
* 20080413
***************************/
%>

<%
	String _wano = (String)request.getAttribute("_wano");
	String _dataId = (String)request.getAttribute("_dataId");
	String _acceptFlag = (String)request.getAttribute("_acceptFlag");
	String _viewFlag = (String)request.getAttribute("_viewFlag");
	System.out.println("提交过去的_dataId==="+_dataId);
%>
	<script type="text/javascript" src="/page/workflow/admin/js/jquery.js"></script>
  <script>
  	//提交函数
	function _comm1(obj2,url)
	{
		with(obj2)
		{
		method='post';
		attributes["action"].value=url;
		submit();
		}
	}

//公共验证函数，提交之前会调用
function _check()
{
	//如果验证回调函数存在，则调用
	if(typeof _validateForm!='undefined')
	{
		return _validateForm();
	}
	return true;
}

//输入参数：需要保存的表单引用 例如document.forms[0]
function _save(obj2)
{
	if(_check()==false) return;
	if(obj2.enctype=='multipart/form-data')
	{
	alert("保存的表单123");
		//上传类型
		var url='/page/workflow/admin/pub/f_wb_pub_multi_save.jsp?dataid=<%=_dataId%>&_wano=<%=_wano%>';
	}
	else
	{
	alert("保存的表单");
		var url='/page/workflow/admin/pub/f_wb_pub_save.jsp?dataid=<%=_dataId%>&_wano=<%=_wano%>';
	}
	_comm1(obj2,url);
	
}
//输入参数：函数调用的字符串 比如'alert("xxx")'
function _specSubmit(func){
	if(_check()==false) return;
	eval(func);
}

//输入参数：需要保存的表单引用 例如document.forms[0]
function _saveAndSubmit(obj){
	if(_check()==false) return;
	var tmp = obj.attributes["action"].value;
	if(tmp.indexOf('?')!=-1)
	{
		obj.attributes["action"].value=obj.attributes["action"].value+'&dataid=<%=_dataId%>&_wano=<%=_wano%>';
	}
	else
	{
		obj.attributes["action"].value=obj.attributes["action"].value+'?dataid=<%=_dataId%>&_wano=<%=_wano%>';
	}
	//alert(obj.attributes["action"].value);
	//_comm1(obj,obj.action);
}

//关闭时更新父窗口
function _refreshParent()
{
	opener.condquery2();
	opener.condquery1();
	_refreshCache();
}

function _refreshCache()
{
		var url="/page/workflow/admin/pub/clearCache.jsp?_dataId=<%=_dataId%>";
		$.ajax({
    url: url,
    type: 'GET',
    dataType: 'html',
    timeout: 10000,
    error: function(){
    	var tt=1;
    },
    success: function(html){
			var tt=1;
    }
		});
}

function _hiddenSubmit()
{
	var tmp = document.getElementById("commanddiv");
	tmp.style.display='none';
}
<%
//删除缓存
if(_acceptFlag!=null&&_acceptFlag.equals("t"))
{
out.println("window.attachEvent('onunload',_refreshParent);");
}
else
{
out.println("window.attachEvent('onunload',_refreshCache);");
}
%>


<%
//隐藏提交按钮
if(_viewFlag!=null&&_viewFlag.equals("t"))
{
out.println("window.attachEvent('onload',_hiddenSubmit);");
}
%>

</script>