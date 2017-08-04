<%
   /*
   * 功能: 资费导购软件配置-公共选择模块
　 * 版本: v1.0 
　 * 日期: 2008/01/17
　 * 作者: liukan
　 * 版权: sitech  
   * 修改历史 源自s5087/fpublicQuery.jsp 修正若干错误
   * 修改日期      修改人      修改目的
 　*/
%>
<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.02.25
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%
	
	
	String regionCode = (String)session.getAttribute("regCode");
	
	String opName = "资费导购套餐配置";
	String title_name = request.getParameter("title_name");
	String element_name = request.getParameter("element_name");
	String element_return = request.getParameter("element_return");
	String sql_str = request.getParameter("sql_str");
	String element_num = request.getParameter("element_num");
	String return_num = request.getParameter("return_num");
	String op_name = request.getParameter("op_name1");
	String form_name = request.getParameter("form_name");
	String title_num = request.getParameter("title_num");
	
	
	System.out.println("sql_str="+sql_str);
	
	ArrayList retList = new ArrayList();  
	
	//retList = impl.sPubSelect(return_num,sql_str,"region",regionCode);//原文件retrun_num写为element_num，导致返回参数减少
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="<%=return_num%>">
	<wtc:sql><%=sql_str%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="retListString" scope="end" />
<%
	//String[][] retListString = (String[][])retList.get(0);
	String errCode=retCode1;
	String errMsg=retMsg1;
	
	int title_len = Integer.parseInt(title_num); 
	int len = Integer.parseInt(element_num);				  		//显示列数
	int return_len = Integer.parseInt(return_num);			  //返回列数
	//int len =1;
	
	//输入参数  服务组
	String[] parain_title_name		= new String[title_len];
	String[] parain_element_name	= new String[len];
	String[] parain_element_return	= new String[return_len];
	
	if(title_len==1){
	  	StringTokenizer st0 = new StringTokenizer(title_name,",");
		parain_title_name[0] 		=	st0.nextToken();
		System.out.println(" parain_title_name[0]=="+parain_title_name[0]); 
	}else{
		StringTokenizer st0 = new StringTokenizer(title_name,",");
		for(int i=0; i<title_len;i++)
		{
			parain_title_name[i]	= st0.nextToken();
			System.out.println(" parain_title_name["+i+"]=="+parain_title_name[i]); 
		}	
	}
	
	if(len==1){
		StringTokenizer st1 = new StringTokenizer(element_name,",");
		parain_element_name[0] 		=	st1.nextToken();
		System.out.println(" parain_element_name[0]=="+parain_element_name[0]);
	}else{
		StringTokenizer st1 = new StringTokenizer(element_name,",");
		for(int i=0; i<len;i++)
		{
			parain_element_name[i] 	= st1.nextToken();
     		System.out.println(" parain_element_name["+i+"]=="+parain_element_name[i]);
        }
	}	
	
	if(return_len==1){
	  	StringTokenizer st2 = new StringTokenizer(element_return,",");
		
		parain_element_return[0]	=	st2.nextToken();
		
		System.out.println(" parain_element_return[0]=="+parain_element_return[0]);
	}else{
		StringTokenizer st2 = new StringTokenizer(element_return,",");

		for(int i=0; i<return_len;i++)
		{
			parain_element_return[i]	=	st2.nextToken();
			
			System.out.println(" parain_element_return["+i+"]=="+parain_element_return[i]);
		}
	}
%>

<html  xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=op_name%></title>
<META content="text/html; charset=gbk" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">

</head>
<body>
<form name="frm" method="POST" >
	<%@ include file="/npage/include/header_pop.jsp" %>   
	<table id="tab1" cellspacing="0">
		<tr>
			<th align="center" nowrap>
				选择
			</th>
			<%for(int i=0;i<title_len;i++){
				out.println("<th align='center' nowrap>"+parain_title_name[i]+"</th>");
			}%>
		</tr>
	</table>
	<table cellspacing="0">
		<tr>
			<td id="footer">
				<div align="center">
			      <input type="button" class="b_foot" name="commit" onClick="doCommit();" value=" 确定 ">
			      &nbsp;
			      <input type="button" class="b_foot" name="back" onClick="doClose();" value=" 关闭 ">
			    </div>
			</td>
		</tr>
	</table>
	 <%@ include file="/npage/include/footer_pop.jsp" %>   
</form>
</body>
</html>

<script>
<%for(int i=0;i < retListString.length;i++){%>
	var str='';
	<%for(int k=0;k<return_len;k++)  //修正原文件bug，用return_len代替原len，
	{
	System.out.println(parain_element_return[k]+"=="+retListString[i][k]);
	%>  
		str+='<input type="hidden" name="<%=parain_element_return[k]%>" value="<%=retListString[i][k]%>">';
		//修正原文件bug，用parain_element_return代替原parain_element_name，
	<%}%>

	var rows = document.getElementById("tab1").rows.length;
	var newrow = document.getElementById("tab1").insertRow(rows);
	
	newrow.align="center";
	newrow.insertCell(0).innerHTML ='<tr><input type="radio" name="num" value="<%=i%>"   onclick="change(this.value)">'+str+'</tr>';
   
    <%   
    int index0 = 1;
    if(title_len-len==1)
    {   
        index0 = 2;
    %>
	newrow.insertCell(1).innerHTML ='<%=i+1%>';
	<%
	}
	for(int k=0;k<len;k++)
	{
	%>
		newrow.insertCell(<%=index0%>+<%=k%>).innerHTML = '<%=retListString[i][k]%>&nbsp;';
	<%}%>
<%}%>

function doCommit()
{
	
	if("<%=retListString.length%>"=="0"){
		rdShowMessageDialog("没查到您要选择的数据集！");
		return false;
	}
	else if("<%=retListString.length%>"=="1"){//值为一时不需要用数组
		if(document.all.num.checked){
            
			<%for(int j=0;j<return_len;j++){%>
				window.opener.<%=form_name%>.<%=parain_element_return[j]%>.value=document.all.<%=parain_element_return[j]%>.value;
			    //修正原文件bug
			<%}%>
		}
		else{
			rdShowMessageDialog("您必须选择一行数据!");
			return false;
		}
	}
	else{//值为多条时需要用数组
		var a=-1;
		for(i=0;i<document.all.num.length;i++){
			if(document.all.num[i].checked){
				a=i;
				break;
			}
		}
		if(a!=-1){
			<%for(int j=0;j<return_len;j++){%>
				window.opener.<%=form_name%>.<%=parain_element_return[j]%>.value=document.all.<%=parain_element_return[j]%>[a].value;
				//修正原文件bug
			<%}%>
			window.close();
		}
		else{
			rdShowMessageDialog("您必须选择一行数据!");
			return false;
		}
	}
	window.close();
}
function change(index)
{    
	var index0 = parseInt(index) +1;
	var vlen = document.getElementById("tab1").rows.length;

     for(i=1;i<vlen;i++)
     {
     	document.getElementById("tab1").rows[i].style.color='black';
     }
	document.getElementById("tab1").rows[index0].style.color='red';
}
function doClose()
{
	window.close();
}
</script>