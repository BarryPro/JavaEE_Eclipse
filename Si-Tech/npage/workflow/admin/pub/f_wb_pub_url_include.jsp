<%
/***************************
* urlģʽ������ҳ��ʱ��Ҫ������ҳ��
* ʯ�س�
* 20080413
***************************/
%>

<%
	String _wano = (String)request.getAttribute("_wano");
	String _dataId = (String)request.getAttribute("_dataId");
	String _acceptFlag = (String)request.getAttribute("_acceptFlag");
	String _viewFlag = (String)request.getAttribute("_viewFlag");
	System.out.println("�ύ��ȥ��_dataId==="+_dataId);
%>
	<script type="text/javascript" src="/page/workflow/admin/js/jquery.js"></script>
  <script>
  	//�ύ����
	function _comm1(obj2,url)
	{
		with(obj2)
		{
		method='post';
		attributes["action"].value=url;
		submit();
		}
	}

//������֤�������ύ֮ǰ�����
function _check()
{
	//�����֤�ص��������ڣ������
	if(typeof _validateForm!='undefined')
	{
		return _validateForm();
	}
	return true;
}

//�����������Ҫ����ı����� ����document.forms[0]
function _save(obj2)
{
	if(_check()==false) return;
	if(obj2.enctype=='multipart/form-data')
	{
	alert("����ı�123");
		//�ϴ�����
		var url='/page/workflow/admin/pub/f_wb_pub_multi_save.jsp?dataid=<%=_dataId%>&_wano=<%=_wano%>';
	}
	else
	{
	alert("����ı�");
		var url='/page/workflow/admin/pub/f_wb_pub_save.jsp?dataid=<%=_dataId%>&_wano=<%=_wano%>';
	}
	_comm1(obj2,url);
	
}
//����������������õ��ַ��� ����'alert("xxx")'
function _specSubmit(func){
	if(_check()==false) return;
	eval(func);
}

//�����������Ҫ����ı����� ����document.forms[0]
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

//�ر�ʱ���¸�����
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
//ɾ������
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
//�����ύ��ť
if(_viewFlag!=null&&_viewFlag.equals("t"))
{
out.println("window.attachEvent('onload',_hiddenSubmit);");
}
%>

</script>