<%@ include file="/page/workflow/admin/pub/wb_include.jsp" %>
<%
String wano = (String)request.getParameter("wano");
String group_id=(String)session.getAttribute("_wb_groupid");
String group_name=(String)session.getAttribute("_wb_groupname");
System.out.println("----_wb_groupid---"+group_id);
System.out.println("----_wb_groupname---"+group_name);

%>

				
<html>
<head>
<title></title>
<link rel="stylesheet" type="text/css" href="/css/common.css">
<script type="text/javascript" src="/js/common/common.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<head>
<title><%=opName%></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="../../css/style.css" type="text/css">
</head>
<SCRIPT LANGUAGE="JavaScript">
<!--
function submitCfm()
{
  var change_type = document.form1.change_type.options[document.form1.change_type.selectedIndex].value;
	var groupId = document.form1.groupId.value;
	var assignLogin = document.form1.assignLogin.options[document.form1.assignLogin.selectedIndex].value;

	var url="f_wb_3_06.jsp?change_type="+change_type+"&groupId="+groupId+"&assignLogin="+assignLogin+"&wano="+<%=wano%>;
	
	$.ajax({
    url: url,
    type: 'GET',
    dataType: 'html',
    timeout: 10000,
    error: function(){
        alert('操作错误');
    },
    success: function(html){
    		eval(html.replace('/\r/g','').replace('/\n/g',''));
    		window.close();
    }
});

}


//-->
</SCRIPT>


				
<body bgcolor="#FFFFFF" text="#000000" background="/images/jl_background_2.gif" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  >
<form name="form1" method="post">
  <%@ include file="../../public/head_view_wf.jsp" %>
  <div id="Operation_Table">
    <table id=tbs9 width=100% height=25 border=0 align="center" >
      <tbody>
        <tr bgcolor="E8E8E8">
          <td width="15%" bgcolor="E8E8E8" align=left >分配类型：<select name="change_type" onChange="change()" >
              <option selected value='1'>本地工号</option>
              <option value='2'>异地区  </option>
			  			<option value='3'>异地工号</option>
            </select>
          </td>
        </tr>
        <tr bgcolor="E8E8E8">
          <TABLE id=role width=100% border=0 align="center" cellSpacing=1 >
            <TBODY>
              <TR bgcolor="#EEEEEE">
                <td width="15%" bgcolor="E8E8E8" align=left >分配地区：
                	<input type='hidden' name='groupId' value="<%=group_id%>">
                	<input type='text' name='groupName' value="<%=group_name%>" disabled="true">
                	<input type=button id='areaButton' value='选择区域' onclick='diplaytree()'>
                </td>
                <td width="15%" bgcolor="E8E8E8" align=left >工号：<select id='loginlist' name="assignLogin"  >
                    <option value="">...不限制...</option>
                  </select>
                </td>
              </TR>
            </TBODY>
          </TABLE>
        </tr>
      </TBODY>
    </TABLE>

	<div id='_tree'>
		
  <iframe name='treeframe' scrolling="yes"  border="0" vspace="0" hspace="0" marginwidth="0" marginheight="0" 
  	framespacing="0" frameborder="0"  width="100%" height='500'
  src="/page/common/wbgrouptree.jsp" ></iframe>
  
	</div>
	
    <TABLE width="100%" border=0 align=center cellpadding="4" cellSpacing=1>
      <TBODY>
        <TR bgcolor="#eeeeee">
          <TD align=middle bgcolor="#eeeeee"><input class="button"   index="3" type=button value="确认" onClick="submitCfm()" >
            &nbsp;&nbsp; 
            &nbsp;&nbsp;
            <input class="button" name=back  type=button value="关闭" onClick="window.close()">
          </TD>
        </TR>
      </TBODY>
    </TABLE>
    <input type='hidden' name='work_No' value='1'>
  </div>
  <%@ include file="../../public/foot.jsp" %>
</FORM>
</BODY>
</HTML>
<script>
	
	function refresh1(groupid)
	{
	var url="f_wb_3_05_01.jsp?login_no=<%=loginNo%>&group_id="+groupid+"&wano=<%=wano%>";
	$.ajax({
    url: url,
    type: 'GET',
    dataType: 'html',
    timeout: 10000,
    error: function(){
        //alert('操作错误');
    },
    success: function(html){
    
			var tmp = eval('('+html+')');
			var loginlist = document.getElementById("loginlist");
			//删除所有option
			loginlist.options.length=0;
			loginlist.options[0]= new Option('..不限制..','');   
			var linetext="";
			for(var ii=0;ii<tmp.length;ii++)
				{
					newoptionname   =   new Option(tmp[ii][1],tmp[ii][0]);   
  				loginlist.options[loginlist.options.length]   =   newoptionname;   
				}
    }
});

}

refresh1('<%=group_id%>');

var _treeDisplayFlag=0;
function diplaytree()
{
	if(_treeDisplayFlag==0)
	{
		//隐藏树
		var treeid = document.getElementById("_tree");
		treeid.style.display='none';
		var treebutt = document.getElementById("areaButton");
		treebutt.value='显示组织树';
		_treeDisplayFlag=1;
		return;
	}else
	{
		var treeid = document.getElementById("_tree");
		treeid.style.display='block';
		var treebutt = document.getElementById("areaButton");
		treebutt.value='隐藏组织树';
		_treeDisplayFlag=0;
		return;
	}
}

function hidetree()
{
		var treeid = document.getElementById("_tree");
		treeid.style.display='none';
		var treebutt = document.getElementById("areaButton");
		treebutt.value='显示组织树';
		_treeDisplayFlag=1;
		return;
}

function change(){      
        //对附加资料隐藏域的控制       
      
		var ic = document.form1.change_type.options[document.form1.change_type.selectedIndex].value 
     
		if(ic=="1")
	    { 
        document.form1.groupId.value='<%=group_id%>';
        document.form1.groupName.value='<%=group_name%>';
        refresh1('<%=group_id%>');
		   	document.form1.areaButton.disabled=true;
				document.form1.assignLogin.disabled=false;
				hidetree();
		   		
		}
		else if(ic=="2")
	  {
               document.form1.areaButton.disabled=false;
				document.form1.assignLogin.disabled=true;
		}
		else if(ic=="3")
	  {
               document.form1.areaButton.disabled=false;
				document.form1.assignLogin.disabled=false;
		}
		
		
}

//默认是本地状态
change();
</script>