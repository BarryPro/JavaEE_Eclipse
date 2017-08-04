<%
	/********************
		version v2.0
		开发商: si-tech
		update:anln@2009-02-12 页面改造,修改样式
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.s1900.config.productCfg" %>
<%@ page import="com.sitech.boss.util.page.*"%>

<%
	//得到输入参数
	// ArrayList retArray = new ArrayList();
	// ArrayList retArray1 = new ArrayList();
   
	String regionCode = (String)session.getAttribute("regCode");
	String opName = "集团客户查询";	//header.jsp需要的参数  
	
	String return_code,return_message;
	String[][] result = new String[][]{};
	String[][] allNumStr =  new String[][]{};
	//SPubCallSvrImpl callView = new SPubCallSvrImpl();
	String workNo = (String)session.getAttribute("workNo");
%>

<%
/*
SQL语句        sql_content
选择类型       sel_type
标题           title
字段1名称      field_name1
*/
	System.out.println("AAAAAAAAAa");
    String pageTitle = request.getParameter("pageTitle");
    String fieldNum = "";
    String fieldName = request.getParameter("fieldName");
	String iccid = request.getParameter("iccid");
    String cust_id = request.getParameter("cust_id");
    String unit_id = request.getParameter("unit_id");
    String user_no = request.getParameter("user_no");
	String sm_code =request.getParameter("sm_code");
	String qryFlag =request.getParameter("qryFlag");
    String sqlFilter = "";

    int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
    
    int iPageSize = 25;
    int iStartPos = (iPageNumber-1)*iPageSize;
    int iEndPos = iPageNumber*iPageSize;
	String passwd=(String)session.getAttribute("password");




	System.out.println("AAAAAAAAAb~~~~~"+(String)session.getAttribute("password"));
    if (iccid != null)
    {
	    if (iccid.trim().length() > 0) {
	        sqlFilter = sqlFilter + " and a.id_iccid = '" + iccid + "'";
	    }
	}    
    if (cust_id != null)
    {
	    if (cust_id.trim().length() > 0) {
	        sqlFilter = sqlFilter + " and a.cust_id = " + cust_id + " and b.cust_id = " + cust_id + " and c.cust_id = " + cust_id;
	    }
    }
    if (unit_id != null)
    {
	    if (unit_id.trim().length() > 0) {
	        sqlFilter = sqlFilter + " and b.unit_id = " + unit_id;
	    }
    }
    if (user_no != null)
    {
	    if (user_no.trim().length() > 0) {
	        sqlFilter = sqlFilter + " and e.service_type = c.sm_code and e.service_no = '" + user_no + "'";
	    }
    }
    if (sm_code != null)
    {
		if (sm_code.trim().length() > 0) {
	        sqlFilter = sqlFilter + " and c.sm_code ='" + sm_code+"'";
	    }
	}
	if(iccid == null){
    iccid = "";
}
if(cust_id == null){
    cust_id = "";
}
if(unit_id == null){
    unit_id = "";
}
if(user_no == null){
    user_no = "";
}
    //String sqlStr = "SELECT nvl(count(*),0) num FROM dcustdoc a, dcustdocorgadd b, dgrpusermsg c, sproductcode d, dAccountIdInfo e WHERE c.product_code = d.product_code  AND a.cust_id = b.cust_id AND b.cust_id = c.cust_id AND d.product_level = 1 AND d.product_status = 'Y' AND c.bill_date > Last_Day(sysdate) + 1 and trim(c.user_no) = Trim(e.msisdn) and c.run_code = 'A' and c.sm_code not in ('pe') " + sqlFilter;
    String sqlStr = "SELECT nvl(count(*),0) num FROM dcustdoc a, dcustdocorgadd b, dgrpusermsg c, sproductcode d, dAccountIdInfo e,ssmproduct f,ssmcode g WHERE c.product_code = d.product_code AND a.cust_id = b.cust_id AND b.cust_id = c.cust_id AND d.product_level = 1 AND d.product_status = 'Y' AND c.bill_date > Last_Day(sysdate) + 1 and Trim(c.user_no) = Trim(e.msisdn(+)) and f.product_code=d.product_code and g.sm_code=f.sm_code and g.region_code=c.region_code and c.run_code = 'A' and c.sm_code not in ('pe') " + sqlFilter;
System.out.println(sqlStr);
    //String sqlStr1 = "select * from (SELECT a.id_iccid, a.cust_id, TRIM (b.unit_name), c.id_no, Trim(e.service_no), TRIM (c.user_name), c.product_code, d.product_name, b.unit_id, c.account_id, g.sm_name,g.sm_code,rownum id FROM dcustdoc a, dcustdocorgadd b, dgrpusermsg c, sproductcode d, dAccountIdInfo e,ssmproduct f,ssmcode g WHERE c.product_code = d.product_code AND a.cust_id = b.cust_id AND b.cust_id = c.cust_id AND d.product_level = 1 AND d.product_status = 'Y' AND c.bill_date > Last_Day(sysdate) + 1 and Trim(c.user_no) = Trim(e.msisdn) and f.product_code=d.product_code and g.sm_code=f.sm_code and g.region_code=c.region_code and c.run_code = 'A' and c.sm_code not in ('pe') " + sqlFilter + "  ) where id <"+iEndPos+" and id>="+iStartPos;
    String sqlStr1 = "select * from (SELECT a.id_iccid, a.cust_id, TRIM (b.unit_name), c.id_no, Trim(e.service_no), TRIM (c.user_name), c.product_code, d.product_name, b.unit_id, c.account_id, g.sm_name,g.sm_code,to_char(a.create_time,'yyyy-mm-dd'),to_char(c.RUN_TIME,'yyyy-mm-dd'),d.note ,rownum id FROM dcustdoc a, dcustdocorgadd b, dgrpusermsg c, sproductcode d, dAccountIdInfo e,ssmproduct f,ssmcode g WHERE c.product_code = d.product_code AND a.cust_id = b.cust_id AND b.cust_id = c.cust_id AND d.product_level = 1 AND d.product_status = 'Y' AND c.bill_date > Last_Day(sysdate) + 1 and Trim(c.user_no) = Trim(e.msisdn(+)) and f.product_code=d.product_code and g.sm_code=f.sm_code and g.region_code=c.region_code and c.run_code = 'A' and c.sm_code not in ('pe') " + sqlFilter + "  ) where id <"+iEndPos+" and id>="+iStartPos;

	System.out.println("!!!!!!!!!!!!!!!!!!!!!!!sqlStr1="+sqlStr1);
    String selType = request.getParameter("selType");
    String retQuence = request.getParameter("retQuence");
    //System.out.print("sqlStr="+sqlStr);
    if(selType.compareTo("S") == 0)
    {   selType = "radio";    }
    if(selType.compareTo("M") == 0)
    {   selType = "checkbox";   }
    if(selType.compareTo("N") == 0)
    {   selType = "";   }
    //=====================
    int chPos = 0;
    String typeStr = "";
    String inputStr = "";
    String valueStr = "";
%>

<HTML>
	<HEAD>
		<TITLE>黑龙江BOSS-集团客户查询</TITLE>
	</HEAD>
<BODY>

	<SCRIPT type=text/javascript>
	function saveTo()
	{
	      var rIndex;        //选择框索引
	      var retValue = ""; //返回值
	      var chPos;         //字符位置
	      var obj;
	      var fieldNo;        //返回域序列号
	      var retFieldNum = document.fPubSimpSel.retFieldNum.value;
	      var retQuence = document.fPubSimpSel.retQuence.value;  //返回字段域的序列
	      var retNum = retQuence.substring(0,retQuence.indexOf("|"));
	      retQuence = retQuence.substring(retQuence.indexOf("|")+1);
	      var tempQuence;
	      if(retFieldNum == "")
	      {     return false;   }
	       //返回单条记录
	          for(i=0;i<document.fPubSimpSel.elements.length;i++)
	          {
	                  if (document.fPubSimpSel.elements[i].name=="List")
	                  {    //判断是否是单选或复选框
	                       if (document.fPubSimpSel.elements[i].checked==true)
	                       {     //判断是否被选中
	                             //alert(document.fPubSimpSel.elements[i].value);
	                             rIndex = document.fPubSimpSel.elements[i].RIndex;
	                             tempQuence = retQuence;
	                             for(n=0;n<retNum;n++)
	                             {
	                                chPos = tempQuence.indexOf("|");
	                                fieldNo = tempQuence.substring(0,chPos);
	                                //alert(fieldNo);
	                                obj = "Rinput" + rIndex + fieldNo;
	                                //alert(obj);
	                                retValue = retValue + document.all(obj).value + "|";
	                                tempQuence = tempQuence.substring(chPos + 1);
	                             }
	                             //alert(retValue);
	                             window.returnValue= retValue;
	                       }
	                }
	            }
	        if(retValue =="")
	        {
	            rdShowMessageDialog("请选择信息项！",0);
	            return false;
	        }
	        var obj={};//方便扩展
	        var pobj = $(document.fPubSimpSel).find('tbody').find('input[type="radio"]:checked').parent().parent();
	        obj.uniqueStatus = pobj.find('input[id^="uniqueStatus"][id$="16"]').val();
	        opener.getvaluecust(retValue,obj);
	        window.close();
	}
	
	function allChoose()
	{   //复选框全部选中
	    for(i=0;i<document.fPubSimpSel.elements.length;i++)
	    {
	        if(document.fPubSimpSel.elements[i].type=="checkbox")
	        {    //判断是否是单选或复选框
	            document.fPubSimpSel.elements[i].checked = true;
	        }
	    }
	}
	
	function cancelChoose()
	{   //取消复选框全部选中
	    for(i=0;i<document.fPubSimpSel.elements.length;i++)
	    {
	        if(document.fPubSimpSel.elements[i].type =="checkbox")
	        {    //判断是否是单选或复选框
	            document.fPubSimpSel.elements[i].checked = false;
	        }
	    }
	}
	</SCRIPT>
</HEAD>
<BODY>
<FORM method=post name="fPubSimpSel">	
	<%@ include file="/npage/include/header_pop.jsp" %>
		<div class="title">
			<div id="title_zi">集团客户查询</div>
		</div>	
  <table  cellspacing="0">
    <tr align="center">
	<th>证件号码</TD>
	<th>集团客户ID</th>
	<th>集团客户名称</th>
	<th>集团产品ID</th>
	<th>用户编号</th>
	<th>用户名称</th>
	<th>产品代码</th>
	<th>产品名称</th>
	<th>集团编号</th>
	<th>产品付费帐户</th>
	<th>品牌名称</th>
	<th>品牌代码</th>
  </TR>
<%  
		//绘制界面表头
	     chPos = fieldName.indexOf("|");
	     out.print("");
	     String titleStr = "";
	     int tempNum = 0;
	     while(chPos != -1)
	     {
	        valueStr = fieldName.substring(0,chPos);
	        titleStr = "";
	        out.print(titleStr);
	        fieldName = fieldName.substring(chPos + 1);
	        tempNum = tempNum +1;
	        chPos = fieldName.indexOf("|");
	     }
	     out.print("");
	     //fieldNum = String.valueOf(tempNum+1);//原来逻辑切割“1”成13个，目前下标16放置了集团产品业务唯一标识
	     fieldNum = String.valueOf(tempNum+5);//liujian 2013-1-24 13:46:09 关于开发租赁式呼叫中心BOSS系统需求的函
%>

<%
    //根据传人的Sql查询数据库，得到返回结果
    try
    {
            //retArray = callView.sPubSelect(fieldNum,sqlStr1);
		if (qryFlag.equals("qryCptCpm") || qryFlag.equals("proProgress"))
		{
		%>
		    <wtc:service name="sQryUserMsg" routerKey="region" 
		    	routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="<%=fieldNum%>" >
		        <wtc:param value=""/> 
		       	<wtc:param value="01"/> 
		       	<wtc:param value="3691"/> 
		        <wtc:param value="<%=workNo%>"/>
		        <wtc:param value="<%=passwd%>"/>
		        <wtc:param value=""/>
		        <wtc:param value=""/>
		         <wtc:param value="<%=iccid%>"/> 
		        <wtc:param value="<%=cust_id%>"/>        	
		        <wtc:param value="<%=unit_id%>"/>
		        <wtc:param value="<%=user_no%>"/> 
		      <%
		      if(qryFlag.equals("proProgress")){
		      %>
		        <wtc:param value="1"/> 
        	<%
        	}
        	%>
		      
		    </wtc:service>
		    <wtc:array id="retArray" scope="end"/>	
		<%	
			result=retArray;
		}
		else
		{
		//out.println("---liujian3691---fieldNum=" + fieldNum);
		
		%>
		    <wtc:service name="s3096QryCheckE" routerKey="region" routerValue="<%=regionCode%>" 
		    	retcode="retCode1" retmsg="retMsg1" outnum="<%=fieldNum%>" >
		        <wtc:param value="<%=workNo%>"/>
		        <wtc:param value="<%=unit_id%>"/> 
		        <wtc:param value="u09"/> 
		        <wtc:param value=""/> 
		        <wtc:param value="<%=iccid%>"/> 
		        <wtc:param value="<%=cust_id%>"/> 
		        <wtc:param value="<%=user_no%>"/> 
		    </wtc:service>
		    <wtc:array id="retArray1" scope="end"/>	
		<%		
			result=retArray1;
		}
		
		
            int recordNum = result.length;
            for(int i=0;i<recordNum;i++)
            {
                typeStr = "";
                inputStr = "";
                out.print("<TR>");
                System.out.println("liujian3691~~~~Integer.parseInt(fieldNum)-1="+(Integer.parseInt(fieldNum)-1));
                for(int j=0;j<Integer.parseInt(fieldNum);j++)
                {
                		//System.out.println("diling----result[i]["+j+"]="+result[i][j]);
                    if(j==0)
                    {
                        typeStr = "<TD>&nbsp;";
                        if(selType.compareTo("") != 0)
                        {
                            typeStr = typeStr + "<input type='" + selType +
                                "' name='List' style='cursor:hand' RIndex='" + i + "'" +
                                "onkeydown='if(event.keyCode==13)saveTo();'" + ">";
                        }
                        typeStr = typeStr + (result[i][j]).trim() + "<input type='hidden' " +
                            " id='Rinput" + i + j + "'  value='" +
                            (result[i][j]).trim() + "'readonly></TD>";
                    }else if(j == 12 || j == 13 || j == 14 || j == 15){
                    }else if( j == 16) {
                    		typeStr = typeStr + "<input type='hidden' name='List' value='" + (result[i][j]).trim() + "' id='uniqueStatus" + i + j + "' />";
                    }
                    else{
                        inputStr = inputStr + "<TD>&nbsp;" + (result[i][j]).trim() + "<input type='hidden' " +
                            " id='Rinput" + i + j + "'  value='" +
                            (result[i][j]).trim() + "'readonly></TD>";
                    }
                }
                out.print(typeStr + inputStr);
                out.print("</TR>");
            }
        }catch(Exception e){
            e.printStackTrace();
        }
%>
<%


%>
   </tr>
  </table>

<!------------------------------------------------------>
    <TABLE cellSpacing=0>
    <TBODY>
        <TR >
            <TD id="footer" >
<%
    if(selType.compareTo("checkbox") == 0)
    {
        out.print("<input  name=allchoose onClick='allChoose()'class='b_foot' style='cursor:hand' type=button value=全选>&nbsp");
        out.print("<input  name=cancelAll onClick='cancelChoose()' class='b_foot' style='cursor:hand' type=button value=取消全选>&nbsp");
    }
%>

<%
                if(selType.compareTo("") != 0)
                {
%>
                <input  name=commit onClick="saveTo()" class='b_foot' style="cursor:hand" type=button value=确认>&nbsp;
<%
                }
%>
                <input  name=back onClick="window.close()" class='b_foot' style="cursor:hand" type=button value=返回>&nbsp;
            </TD>
        </TR>
    </TBODY>
    </TABLE>  

  <!------------------------>
  <input type="hidden" name="retFieldNum" value=<%=fieldNum%>>
  <input type="hidden" name="retQuence" value=<%=retQuence%>>
  <!------------------------>
<%@ include file="/npage/include/footer_pop.jsp" %> 
</FORM>
</BODY></HTML>
