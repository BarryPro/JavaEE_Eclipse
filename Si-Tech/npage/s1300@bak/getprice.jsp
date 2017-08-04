<%
	/********************
	 version v2.0
	开发商: si-tech
	update:zhaoht@2009-03-10 页面改造,修改样式
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=gbk" %>
<%/*
* name    : 
* author  : changjiang@si-tech.com.cn
* created : 2003-11-01
* revised : 2003-12-31
*/%>

<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
    response.setDateHeader("Expires", 0); 
    
    String opName = "有价卡销售及回退";
	String card_price = request.getParameter("card_price");
	String regioncode = request.getParameter("regioncode");
	
	String card_type = card_price.substring(0,2);
	String colNum = "2";
	String sqlStr = "select a.FAV_RATE*b.STORE_MONEY,a.fav_rate from sStoreTypeFav a,sStoreType b where a.store_type=b.store_type and a.region_code = '"+regioncode+"' and a.store_type='"+card_type+"'";
				
	System.out.println("sqlStr===="+sqlStr);
	
	//s1310Impl viewBean = new s1310Impl();//实例化viewBean
	String result[][] = new String[][]{};
	String result1[][] = new String[][]{};
	
	//arlist = viewBean.s1330Query(colNum,sqlStr); 
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regioncode%>" outnum="2">
	<wtc:sql><%=sqlStr%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result1Temp" scope="end" />
<%
	
    //int recordNum = Integer.parseInt((String)arlist.get(0));

	if (result1Temp.length==0)
	{
		//System.out.println("return no rows");
%>
		<script language="JavaScript">
		window.returnValue="0";
		window.close();
		</script>
<%
		return;
	}
	else{
		result1 = result1Temp;
	
		if (result1.length==1 ){
%>
		<script language="JavaScript">
		window.returnValue="<%=result1[0][0].trim()%>";	
		window.close(); 
		</script>
<%      
		return;
		}
    }
%>


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>查询卡实价</title>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">

<script language="JavaScript">
	
function save_to(){	

      for(i=0;i<document.frm.elements.length;i++) 
		      if (document.frm.elements[i].name=="radio1"){
				   if (document.frm.elements[i].checked==true){
					 window.returnValue=document.frm.elements[i].value;     
               }
			   }
		window.close(); 
	}

	function quit(){
		window.close(); 
	}
</script>

</head>

<BODY>
<form name="frm" method="post" action="">
     <%@ include file="/npage/include/header_pop.jsp" %>
	<div class="title">
		<div id="title_zi">查询结果</div>
	</div>	
  <table cellspacing="0">
    <tr> 
      <th>&nbsp;</th>	
      <th> 
        <div align="center">实价</div>
      </th>
      <th> 
        <div align="center">优惠率</div>
      </th>
    </tr>
    
   <% for(int i=0; i < result1.length; i++){
   		String tdClass = (i%2)==0?"Grey":"";
   
   %>
    <tr> 
      <td class="<%=tdClass%>"> 
        <div align="center"> 
          <input type="radio" name="radio1" value="<%=result1[i][0].trim()%>">
        </div>
      </td>
      <td class="<%=tdClass%>"> 
        <div align="center"><%=result1[i][0]%></div>
      </td>
      <td class="<%=tdClass%>"> 
        <div align="center"><%=result1[i][1]%></div>
      </td>
    </tr>
   <%}%>
    <tr> 
      <td id="footer" colspan="3"> 
        <div align="center"> 
          <input class="b_foot" type="button" name="Button" value="确定" onClick="save_to()">
          <input class="b_foot" type="button" name="return" value="返回" onClick="quit()">
        </div>
      </td>
    </tr>
  </table>
  <%@ include file="/npage/include/footer_pop.jsp" %>
</form>
</body>
</html>

