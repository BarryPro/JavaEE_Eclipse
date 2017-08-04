<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<% 
    String opCode="7421";
    String opName="业务包子产品查询";
    String workno = (String)session.getAttribute("workNo");
    
    String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
    String motive_code=request.getParameter("motive_code")==null?"":request.getParameter("motive_code");
    System.out.println("# motive_code = "+motive_code);
    //String sqlStr  = "select MOTIVE_CODE,PRODUCT_CODE,PRODUCT_NAME,PRODUCT_NOTE,PRODUCT_SMCODE,PRODUCT_LEVEL from SMOTIVEPRODDETCFG where ";
    String sqlStr = "select a.MOTIVE_CODE,a.PRODUCT_CODE,a.PRODUCT_NAME,a.PRODUCT_NOTE,a.PRODUCT_SMCODE,a.PRODUCT_LEVEL ,b.sm_name from SMOTIVEPRODDETCFG a,ssmcode b where a.product_smcode = b.sm_code and b.region_code = '"+regionCode+"' "
                  + " and MOTIVE_CODE='"+motive_code+"'";
    System.out.println("# sqlStr = "+sqlStr);
%>	
<html xmlns="http://www.w3.org/1999/xhtml"> 
<HEAD>
<TITLE><%=opName%></TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</HEAD>
<SCRIPT type=text/javascript>
var ret =new Array();
ret[0]=new Array();

function saveto(){
    var t_table = document.getElementById('tmp_table');
    if (t_table.rows.length >2){
        for (var i=2;i<t_table.rows.length;i++){
            var j=i-1;
            var checkbox = document.getElementById("OperationSubTypeIDRadio"+j);
            if(checkbox.checked){
                ret[i-1]=new Array();
                ret[i-1][5]="1"; 
            }else{
                continue;
            }
            ret[i-1][0]=document.forms[0].prcd0[i-2].value;
            ret[i-1][1]=document.forms[0].prcdsm0[i-2].value;					
            ret[i-1][2]=document.forms[0].qw_flag[i-2].value;
            ret[i-1][3]=document.forms[0].sm_name[i-2].value;
            ret[i-1][4]=document.forms[0].prcdname[i-2].value.trim();
        }	
    }	
    
    if (t_table.rows.length<3){	 
        window.returnValue='';
    }
    var motive_code='<%=motive_code%>';
    window.returnValue=ret;
    
    window.opener.set_Attribute(ret,motive_code);	
    window.close();	
}		
	
</script>
<BODY>
<%@ include file="/npage/include/header_pop.jsp" %>
<FORM action="" method="POST" name="form1" >
<div class="title">
	<div id="title_zi">业务包子产品列表</div>
</div>
<TABLE id="tmp_table" name="tmp_table" cellspacing="0" width="60" border="0" cellpadding="0" >
    <TR>
        <TH>子产品名称</TH>	
        <TH>子产品注释</TH> 
        <TH>子产品类型</th>        
        <TH>子产品选择</th>
        <!--TH>子产品套餐信息<TH-->
    </TR>
    <wtc:pubselect name="sPubSelect" outnum="7" routerKey="region" routerValue="<%=regionCode%>">
    <wtc:sql><%=sqlStr%></wtc:sql>	
    </wtc:pubselect>
    <wtc:array id="rows"  scope="end" />
    <%
        System.out.println("9999999="+rows.length);
        for(int i=0; i<rows.length;i++){
            System.out.println("rows[i][5]="+rows[i][5]);
            System.out.println("rows[i][1]="+rows[i][1]);
            
            String qwSql = "select count(*) from dPospecInfo where pospec_number = '"+rows[i][1]+"'";
            String qwFlag = "N";
            %>
                <wtc:pubselect name="sPubSelect" outnum="1" routerKey="region" routerValue="<%=regionCode%>">
                    <wtc:sql><%=qwSql%></wtc:sql>			
                </wtc:pubselect>
                <wtc:array id="qwrows" scope="end" />
            <%
                if(Integer.parseInt(qwrows[0][0]) == 0){
                    qwFlag = "N";   //不是全网产品
                }else{
                    qwFlag = "Y";   //是全网产品
                }
            %>
            <TR>
                <TD><%=rows[i][2]%></TD>
                <TD><%=rows[i][3]%></TD>
                <%
                if(rows[i][5].equals("0")){
                %>
                    <TD>主产品</TD>
                <%}else{
                %>
                    <TD>附属产品</TD>
                <%}%>
                <TD>
                <%
                    String flag="";
                    String stopflag="";
                    if(rows[i][5].equals("0"))
                    {
                        flag="checked";
                        stopflag="disabled";
                    }else{
                        flag="";
                        stopflag="";
                    }
                %>
                    <input type="checkbox" id="OperationSubTypeIDRadio<%=i+1%>" value="0" onclick="" <%=flag%> <%=stopflag%>>
                </TD>			 	
                <input type="hidden"  name="prcd0" id="prcd0" value="<%=rows[i][1]%>">
                <input type="hidden"  name="prcdsm0" id="prcdsm0" value="<%=rows[i][4]%>"">
                <input type="hidden"  name="prcdname" id="prcdname" value="<%=rows[i][2]%>"">
                <input type='hidden' id='qw_flag' name='qw_flag' value='<%=qwFlag%>' />
                <input type='hidden' id='sm_name' name='sm_name' value='<%=rows[i][6]%>' />
            </TR>	
        <%}%>	
        <TR>
            <TD colspan="12" align="center" id="footer" >
                <input class="b_foot" type=button name="b_save" value="确定" onClick="saveto()" >
                <input class="b_foot" type=button name=qryPage value="关闭" onClick=" window.close()">
            </TD>
        </TR>			
</TABLE>	
<%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>	
</BODY>	
</HTML>	

